options ls = 79 nodate;

data;
input e4 ad count;
cards;
1  1  308
1  0  1296
0  1  262
0  0  3096
;;

proc sort;
by descending e4 descending ad;
run;

proc freq order = data;
exact fisher or;
tables e4*ad / riskdiff relrisk;
weight count;
run;