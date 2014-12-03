%{
#include<stdio.h>
#include<string.h>
#include "syntax_analyser.tab.h"
int line=0;
%}

WS [ \t]+
NUM [0-9]+
HEX 0x[0-9a-fA-F]
ID [a-zA-Z_][0-9a-zA-Z]*
COMMENTS //[0-9a-zA-Z]*
NEWLINE \n
%%	
"Program" 	{return PROGRAM;}

"boolean"	{return BOOLEAN;}
"break"		{return BREAK;}
"callout"	{return CALLOUT;}
"class"		{return CLASS;}
"continue" 	{return CONTINUE;}
"else" 		{return ELSE;}
"for" 		{return FOR;}
"if"		{return IF;}
"int"		{return INT;}
"return"	{return RETURN;}
"true"		{return TRUE;}
"false"		{return FALSE;}
"void"		{return VOID;}

NEWLINE 	{
		/*NO ACTION TO BE TAKEN FOR NEWLINE*/
		line++;
		}
COMMENTS	{/*NO ACTION TO BE TAKEN FOR COMMENTS*/}
WS		{/*NO ACTION TO BE TAKEN FOR WHITESPACES*/}

{HEX}		{
			/*yylval.int_val=atoi(NUM);*/
			return HEX_LIT;
		}
{NUM}		{
			/*yylval.int_val=atoi(NUM);*/
			return INT_LIT;
		}
{ID}		{
			/*yylval.str_val=strdup(yytext);*/
			return IDENTIFIER;
		}
\'(.)\' 	{
			/*yylval.char_val=yytext[0];*/
			return CHAR_LIT;
		}
\"[^\"']*\" 	{
			/*yylval.s=strdup(yytext);*/
			return STR_LIT;
		}

">"		{return GT;}
"<"		{return LT;}
"<="		{return LE;}
">="		{return GE;}
"=="		{return EQ;}
"!="		{return NE;}
"&&"		{return AND;}
"||"		{return OR;}

"+" |
"-" |
"*" |
"/" |
"%" |
"(" |
")" |
"[" |
"]" |
"{" |
"}" |
"=" |
"!"		{
			/*yylvL.c=yytext[0];*/
			return yytext[0];
		}


%%
