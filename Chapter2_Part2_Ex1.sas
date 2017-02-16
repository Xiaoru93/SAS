options ls = 79 nodate;

data;
input eyes hair count;
cards;
0  0  68
0  1  119
0  2  26
0  3  7
1  0  20
1  1  84
1  2  17
1  3  94
2  0  15
2  1  54
2  2  14
2  3  10
3  0  5
3  1  29
3  2  14
3  3  16
;;

proc format;
value eyecol 0 = 'brown'
             1 = 'Blue'
			 2 = 'Hazel'
			 3 = 'Green';
value haircol 0 = 'Black'
              1 = 'Brown'
			  2 = 'Red'
			  3 = 'Blond';
run;
proc sort;
by eyes hair;
run;
proc freq order = data;
format eyes eyecol. hair haircol.;
tables eyes*hair / chisq;
weight count;
run;
proc genmod;
format eyes eyecol. hair haircol.;
class eyes hair;
model count = eyes hair / dist = poi link = log obstats residuals;
run;