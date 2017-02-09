libname sas xlsx "D:\sas.xlsx";

data agents;
set sas.agents;
run;

data sales;
set sas.properties;
run;

data rates;
set sas.rates;
run;
proc sort data=sales;
by id;
run;

data payouts;
merge agents sales rates;
by id;
commission=salesprice*rates;
run;

proc sql;
create table p as
    select 
	    agents.id,
		name,
		salesprice,
		salesprice*rates as commission
	from agents,sales,rates
where agents.id=sales.id=rates.id;
quit;

proc means data=payouts; by id ;
var commission;
output out=payout_each
sum=commission;
run;

proc sql;
create table p_each as
    select
	    id,name,sum(commission) as commission
	from payouts group by id,name;
quit;

data rates;
set rates;
if end=. then end=year(today());
run;

proc sql;
create table payouts as
    select 
	    agents.id,
		name,
		salesprice,
		salesprice*rates as commission
	from agents,sales,rates
where agents.id=sales.id=rates.id
    and sales.year between rates.start
	and rates.end;
quit;
