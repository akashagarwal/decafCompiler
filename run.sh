bison -d syntax_analyser.y --debug --verbose
flex lexical_analyser.l
gcc lex.yy.c syntax_analyser.tab.c syntax_analyser.tab.h -lfl
rm lex.yy.c syntax_analyser.tab.c syntax_analyser.tab.h
