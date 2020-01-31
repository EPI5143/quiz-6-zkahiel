libname classdat "/folders/myshortcuts/SAS_windows/myfolders/BIG DATA/class_data"; 
/*lib names can only be 8 characters long*/ 
libname ex "/folders/myshortcuts/SAS_windows/myfolders/BIG DATA/class_data/EPI5143 work folder/Data";

proc contents data =  classdat.nhrabstracts;
run;

data ex.abstracts;
set classdat.nhrabstracts;
birth_adm=0;
if hracmgcd in ('601' '602' '603' '604' '606' '607' '608' '609' '610' '611') then birth_adm=1;
year = year(datepart(hraadmdtm));
run;

proc freq data = ex.abstracts order=freq;
/*table /*hracmgcd*/ 
table birth_adm hrafacilitycampus year;
tables birth_adm*hrafacilitycampus*year/nopct nocum nocol; 
run;

data look;
do i=1 to 1000000;
*y=rannorm(1);
y=ranuni(0);
output;
end;run;
*proc print; 
proc contents;
run;

/*or you can do proc contents run and it will look at last dataset. */


/*we don't have a campus lksted for a lot of them. 
the numerator is birth admissions. 
700 occured at general
rest at civic campus*/ 

data ex.sample_abstracts;
set classdat.nhrabstracts;
if ranuni(0)<.1 then ouput; (/*a randomly numbers uniform variate*/)
run;
