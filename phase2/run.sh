bison -d syntax_analyser.yy
flex  lexical_analyser.l
sed -i '1s/^/#include "ast.h"\n/' syntax_analyser.tab.hh
g++ -w lex.yy.c syntax_analyser.tab.cc syntax_analyser.tab.hh -lfl
rm lex.* syntax_analyser.tab*
