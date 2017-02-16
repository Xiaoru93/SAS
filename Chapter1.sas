options ls = 79 nodate;

data faith;
input believe count;
cards;
1  914
0  90
;;

proc sort data = faith;
by descending believe;
run;

proc freq data = faith order = data;
weight count;
exact binomial;
tables believe / binomial (p = 0.5);
run;

proc freq data = faith order = data;
weight count;
exact binomial / alpha = 0.10;
tables believe / binomial (p = 0.5) alpha = 0.10;
run;