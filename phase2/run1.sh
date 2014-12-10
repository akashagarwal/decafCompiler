bison -d syntax_analyser.yy
flex lexical_analyser.l
clang++ -g -O3 lex.yy.c syntax_analyser.tab.cc syntax_analyser.tab.hh -lfl `llvm-config --cxxflags --ldflags  --libs all`
rm lex.* syntax_analyser.tab*
