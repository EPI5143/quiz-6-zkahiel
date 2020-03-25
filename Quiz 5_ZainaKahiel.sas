 /*****ASSIGNMENT 5****/
libname quiz5 '/folders/myshortcuts/SAS_windows/myfolders/BIG DATA/class_data';
libname q5 "/folders/myshortcuts/SAS_windows/myfolders/BIG DATA/class_data/EPI5143 work folder/Data";

*QUESTION 1;

data q5.diabetes;
set quiz5.nhrabstracts;
if year (datepart(hraadmdtm)) < 2003 then delete; *will delete anything less than 2003;
if year ((datepart(hraadmdtm))) >2004 then delete; *delets greater than 2004. cuts off at last day;
keep hraadmdtm hraEncWID; *admin dates and unique admission;
run;

*QUESTION 2;
data q5.question2;
set quiz5.nhrdiagnosis; 
/*create a dataset with a flag for diabetes codes*/
if hdgcd in:('250''E10' 'E11') then DM=1; 
	else DM=0;
run; 


*QUESTION 3;
proc sort data=q5.question2 out=q5.flatten2; 
by hdghraEncWID; *must sort by admission;
run;


Proc means data=q5.flatten2 noprint;
class hdghraEncWID;
types hdghraEncWID;/*only output results within encwids (and not overall)*/ 
var DM;
Output out=q5.flatten3 max(DM)=DM n(DM)=count sum(DM)=DM_count;
run;

*QUESTION 4; 

proc sort data=q5.flatten3 out=q5.linked (rename = hdghraencwid=hraEncWID) nodupkey;
*didn't have same name = needed to rename this;
by hdghraEncWID;
run; 
proc sort data=q5.diabetes out=q5.linked2 nodupkey;
by hraEncWID;
run;

data q5.final;
merge q5.linked:(in=a) q5.linked2:(in=b); *merge statement links the datasets;
by hraEncWID;
if b;
if DM=. then DM=0; *remove missing values;
if count=. then count=0;
if DM_count=. then DM_count=0;
run;

*QUESTION 5;
proc freq data=q5.final;
tables DM DM_count count;
run; 
*note: same number of obs found in spine dataset;


The FREQ Procedure

DM	Frequency	Percent	Cumulative  Cumulative
                        Frequency	Percent
0	2147		96.28	2147		96.28
1	83			3.72	2230		100.00

DM_
count Frequency	Percent	Cumulative  Cumulative
                        Frequency	Percent
0	2147	96.28		2147		96.28
1	83		3.72		2230		100.00

Count	Frequency	Percent	Cumulative  Cumulative
                        	Frequency	Percent

0		249			11.17	249			11.17
1		588			26.37	837			37.53
2		392			17.58	1229		55.11
3		287			12.87	1516		67.98
4		236			10.58	1752		78.57
5		156			7.00	1908		85.56
6		107			4.80	2015		90.36
7		67			3.00	2082		93.36
8		39			1.75	2121		95.11
9		33			1.48	2154		96.59
10		22			0.99	2176		97.58
11		13			0.58	2189		98.16
12		15			0.67	2204		98.83
13		8			0.36	2212		99.19
14		3			0.13	2215		99.33
15		3			0.13	2218		99.46
16		1			0.04	2219		99.51
17		2			0.09	2221		99.60
18		4			0.18	2225		99.78
19		3			0.13	2228		99.91
20		1			0.04	2229		99.96
21		1			0.04	2230		100.00


