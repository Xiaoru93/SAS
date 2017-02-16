options ls = 79 nodate;

data;
input chd agegrp count;
cards;
1  0  1
1  1  5
1  2  11
1  3  18
1  4  8
0  0  9
0  1  22
0  2  17
0  3  7
0  4  2
;;
proc format;
value yesno 0 = 'No'
            1 = 'Yes';
value agelev 0 = '20 - 29'
             1 = '30 - 39'
			 2 = '40 - 49'
			 3 = '50 - 59'
			 4 = '60+';
			 run;
			 proc sort;
			 by descending chd agegrp;
			 run;
			 proc freq order = data;
			 format chd yesno. agegrp agelev.;
			 exact trend fisher;
			 tables chd*agegrp / chisq;
			 weight count;
			 run;
		 proc freq order = data;
			 format chd yesno. agegrp agelev.;
			 exact trend fisher;
			 tables chd*agegrp / chisq scores = ridit;;
			 weight count;
			 run;