options ls = 79 nodate;

data;
input jobsat income1 income2 count;
cards;
1  0  3     20
1  1  10.5  22
1  2  20    13
1  3  30    7
2  0  3     24
2  1  10.5  38
2  2  20    28
2  3  30    18
3  0  3     80
3  1  10.5  104
3  2  20    81
3  3  30    54
4  0  3     82
4  1  10.5  125
4  2  20    113
4  3  30    92
;;
proc format;
value satlev 1 = 'Very Dis'
             2 = 'Little Dis'
			 3 = 'Some Sat'
			 4 = 'Very Sat';
run;
proc freq order = data;
format jobsat satlev.;
tables jobsat*income1 / chisq cmh1;
weight count;
run;
proc freq order = data;
format jobsat satlev.;
tables jobsat*income2 / chisq cmh1;
weight count;
run;