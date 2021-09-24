Data Crime;
infile 'Corruption 2019.csv' dlm=',' firstobs=2 dsd;
input Category$ State$ Pending ReportedCases Reopenedcases StateTransfered Withdrawnbygov Finalreported
          Chargesheet PendinggatEnd Totalcases;
run;
proc print data=Crime;
run;

/* Create a sql for storing crime details */
proc sql;
create table Crimedetails as
select * from Crime;
quit;
proc print data=Crimedetails;
run;

/* Select total crime details basis of state */
proc sql;
select State,Totalcases
from Crime
;
quit;
/* To check is there any missing values present in table */
proc means data=Crime nmiss;
run;

/* To check the summary of the data */
proc summary data=Crime print n mean median mode stddev min max;
var Pending ReportedCases Reopenedcases Totalcases;
run;

/* To check the correlation between columns */
proc corr data=Crime;
run;

/* To find information of data */
proc contents data=Crime;
run;

/* Visualization */

title "Histogram of Crime data";
proc sgplot data=Crime;
histogram Totalcases;
run;

title "Histogram of Crime data";
proc sgplot data=Crime;
histogram Pending/group=Category transparency=0.5 scale=count;
density Pending/type=normal group=Category;
run;

/* scatter plot between reportedcases and chargesheet 
ellipse showing the finalreported and total cases*/
proc sgplot data=Crime;
scatter x= ReportedCases y= Chargesheet;
ellipse x= Finalreported y= Totalcases;
    title 'Scatter plot';
run;

proc sgplot data=Crime;
     title 'Pending';
     vbar Pending/response = Totalcases group=Pending stat=percent datalabel;
     xaxis display=(nolabel);
     yaxis grid label='Cases';
run;

/* Hbar */
proc sgplot data=Crime;
     hbar Totalcases/response=ReportedCases stat=mean
     datalabel datalabelattrs=(weight=bold) fillattrs=(color=red);
     title 'Total Reportedcases';
run;
     
