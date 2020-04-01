/*********QUIZ 6*******************/ 
libname quiz6 '/folders/myshortcuts/SAS_windows/myfolders/BIG DATA/class_data';
libname q6 "/folders/myshortcuts/SAS_windows/myfolders/BIG DATA/class_data/EPI5143 work folder/Data";

*you want to first sort the datsets; 
proc sort data=quiz6.nencounter out = abstracts;
by EncPatWID;
run;

data quiz6.spine;
set abstracts;
if year(datepart(EncStartDtm))<2003 then delete;
if year(datepart(EncStartDtm))>2003 then delete;
keep EncStartDtm EncPatWID EncWID EncVisitTypeCd;
run;

data quiz6.spine2;
set quiz6.spine;
if encVisitTypeCd = "EMERG" then emergenc =1;
	else emergenc = 0;
if encVisitTypeCd = "INPT" then inpat =1;
	else inpat = 0; 
run;

*count the # inpatient(rows) per patient and # of emerg encoutners per patient; 
proc means data = quiz6.spine2 noprint; *no print option is vital. if it's a big dataset;
class EncPatWID; *we want to flatten based off a class variable. meaning we want to flatten by encounterid;
types EncPatWID; *types statement will organize by encounter id ONLY. not for overall; 
var emergenc inpat;
Output out=ex.count max(inpat)=inpat n(inpat)=count1
max(emergenc)=emergenc n(emergenc)=count2
sum(emergenc)=emergenc_count sum(inpat)=inpat_count;
run;
*count dataset now has 2891 rows with each a unique encoutner id; 

proc freq data = ex.count order=freq; 
tables inpat count1 count2 emergenc; *count =0 and one = 1 for number of labtests;
run; 
 
The FREQ Procedure

inpat	Frequency	Percent	Cumulative
Frequency	Cumulative
Percent
0	1817	62.85	1817	62.85
1	1074	37.15	2891	100.00

emergenc	Frequency	Percent	Cumulative
Frequency	Cumulative
Percent
1	1978	68.42	1978	68.42
0	913		31.58	2891	100.00;

proc freq data = ex.count order=freq; 
tables inpat*emergenc; *count =0 and one = 1 for number of labtests;
run; 

data ex.final; 
set ex.count;  
totcount= emergenc_count + inpat_count;
run;

proc printto file='/folders/myshortcuts/SAS_windows/myfolders/BIG DATA/class_data/ex.final.txt' new; 
proc freq data=ex.final order=freq; 
table totcount; 
run;



Using the Nencounter table from the class data;
a) How many patients had at least 1 inpatient encounter that started in 2003?;
*1074;
b) How many patients had at least 1 emergency room encounter that started in 2003?; 
*1978;
c) How many patients had at least 1 visit of either type (inpatient or emergency room encounter) that started in 2003?;
*2891;
d) In patients from c) who had at least 1 visit of either type, create a variable 
that counts the total number encounters (of either type)-for example, a patient 
with one inpatient encounter and one emergency room encounter would have a total encounter
 count of 2. Generate a frequency table of total encounter number for this data set, 
 and paste the (text) table into your assignment
- use the SAS tip from class to make the table output text-friendly;


 The FREQ Procedure

                                                                        Cumulative    Cumulative
                                   totcount    Frequency     Percent     Frequency      Percent
                                   -------------------------------------------------------------
                                          1        2556       88.41          2556        88.41  
                                          2         270        9.34          2826        97.75  
                                          3          45        1.56          2871        99.31  
                                          4          14        0.48          2885        99.79  
                                          5           3        0.10          2888        99.90  
                                          6           1        0.03          2889        99.93  
                                          7           1        0.03          2890        99.97  
                                         12           1        0.03          2891       100.00  

 

