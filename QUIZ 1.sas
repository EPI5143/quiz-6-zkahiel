/*question 1*/ 
*LIBNAME goodies "C:\EPI5143\course_data"; 

*data goodies.stuff;
*set y;
*run;

/*seeing if anything changes*/
/*question 2*/ 
data cars;
set sashelp.cars;
*question b;
disp_per_cylinder = engineSize/cylinders;
*question c;
profit = msrp-invoice;
*question d;
if find(model, "4dr")>0 then four_door = 1; 
	else do four_door=0;
	end;
*question e;
if mean(MPG_highway, MPG_city)<20 then do; 
	gas_guzzler=1;
end;
else do;
	gas_guzzler=0;
end;
run;

/*confirming it was coded correctly*/
proc freq data = cars;
table type;
run;

proc freq data = cars;
table four_door/binomial (level=1);
table gas_guzzler/binomial (level=1);
run; 

proc univariate data = cars;
var profit disp_per_cylinder;
run;


/*question 2a*/
data SUVS;
	set cars; 
	if type = "SUV" then do;
	type = 1;
		end;
	else type = 0;
	run;






	