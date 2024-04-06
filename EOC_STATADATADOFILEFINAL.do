use "/Users/macy/Downloads/EOC_STATADATA.dta"

sum n_attempt, detail 
***75%=137, 25%=71 ; IQR = 137-71 = 66
***Lowerfence = 71-66(1.5)= -28, Higherfence = 137+1.5(66) = 236
gen n_attemptval = n_attempt if n_attempt<=236 

sum n_possible, detail
***75%=99, 25% = 61 ; IQR = 99-61 = 57
***Lowerfence = 61-57 = 4 ; Higherfence = 99+57=156
gen n_possibleval = n_possible if 4<=n_possible<=156

***Find percentage correct (aka eoc value)
gen perccor = n_correct/n_possible 

*** Find correlation between the number of questions the student engaged with versus their score, controlled for their total attempts of questions and the chapter number, both of which have negative correlations with scores
reg perccor n_possibleval n_attemptval chapter_number
*** One question increase in possible score (aka how many different questions students are exposed to) is correlated with a .0040101 unit increase in the students score
avplots, ytitle("%Correct (EOC Questions)") ymtick(0(.05)1) xtitle("e(# of Possible Questions)")

************************************************
*STUDENT PERFORMANCE BASED ON LEVEL OF COURSE*
************************************************
encode book, gen(book_numeric)
***Find correlation between the course level and student performance (book_numeric: 1=College Advanced, 2=College Normal, 3=Highschool)
reg perccor book_numeric
***Lower course levels are associated with a decrease in performance 
graph box perccor, over(book, relabel(1"Advanced College" 2"College" 3"Highschool")) 

***
