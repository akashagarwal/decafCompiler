bison -d syntax_analyser.yy
flex lexical_analyser.l
g++ lex.yy.c syntax_analyser.tab.cc syntax_analyser.tab.hh -lfl
rm lex.* syntax_analyser.tab*
