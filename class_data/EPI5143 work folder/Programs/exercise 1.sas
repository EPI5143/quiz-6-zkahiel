libname classdat "/folders/myshortcuts/SAS_windows/myfolders/BIG DATA/class_data";
/*lib names can only be 8 characters long*/
libname ex "/folders/myshortcuts/SAS_windows/myfolders/BIG DATA/class_data/EPI5143 work folder/Data";
/*program now created in a folder you created and you created a data directory". first one is pointing at the data you downloaded. 
the second one will now allow you to modify it*/

data ex.nencounter; /* puts a copy of the nencouner dataset into the ex dataset*/
	set classdat.nencounter; /*pulling in the master class data version and putting in into 
	exercise folder*/
	run;
	
proc sort data = ex.nencounter; /* will sort the data*/ 
by encwid; /*encounter id*/
run;
/*will sort by the encwid by nencounter id*/

/*note: you cannot modify /sort a datatset that you are already looking at. so you need to
close the sas7bdat file if it is open*/ 

proc contents data =ex.nencounter varnum; /*puts it in the order that it appears in dataset*/
run;

/*watch what happens if i sort classdat..it will give an error becuase classdat ir right protected*/
/* to get around that specify an input/output dataset*/ 

proc sort data=classdat.nencounter out=ex.nencounter;
by encwid;
run;

proc freq data = ex.nencounter;
tables encvisittypecd;
run;
/*output shows two types; inpatient and emerg visits*/ 

proc univariate data = ex.nencounter; /*for continuours = age*/
var encpatageatadm;
histogram;
run;

