SHELL=bash
a=dictionary

dict: $a.y $a.l
	flex $a.l
	yacc -d -v $a.y
	gcc -o $a y.tab.c
	./$a < dic-finance-en.pt.txt
clean:
	rm -f lex.yy.c y.tab.* y.* 
force-clean:
	rm -f lex.yy.c y.tab.* y.* $a 