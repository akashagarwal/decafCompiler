%option noyywrap
%{
#include<stdio.h>
#include<string.h>
#include "syntax_analyser.tab.hh"
using namespace std;
int line=1;
%}

WS [ \t]+
NUM [0-9]+
HEX 0x[0-9a-fA-F]
ID [a-zA-Z_][0-9a-zA-Z]*
COMMENTS //[0-9a-zA-Z]*
%%	
"Program" 	{return PROG;}

"void" |
"boolean" |	
"int"		{
		yylval.str_val=strdup(yytext);
		return VAR_TYPE;} 
"break"		{return BREAK;}
"callout"	{return CLLOUT;}
"class"		{return CLASS;}
"continue" 	{return CONTINUE;}
"else" 		{return ELSE;}
"for" 		{return FOR;}
"if"		{return IF;}
"return"	{return RETURN;}
"true"		{
		yylval.bool_val=true;
		return BOOL_LIT;}
"false"		{
		yylval.bool_val=false;
		return BOOL_LIT;}

"\n" 	{
		/*NO ACTION TO BE TAKEN FOR NEWLINE*/
		printf("line -- %d \n",line);
		line++;
		}
COMMENTS	{/*NO ACTION TO BE TAKEN FOR COMMENTS*/}
WS		{/*NO ACTION TO BE TAKEN FOR WHITESPACES*/}

{HEX}		{
			/*yylval.int_val=(int)strtol(yytext,NULL,16);*/
			return HEX_LIT;
		}
{NUM}		{
		/*	yylval.int_val=(int)strtol(yytext,NULL,10);*/
			printf("ahem ahem %s\n",yytext);
			/*yylval.int_val=(int)atoi(yytext);*/
			yylval.int_val=0;
			return INT_LIT;
		}
{ID}		{
			yylval.str_val=strdup(yytext);
			return IDENTIFIER;
		}
\'(.)\' 	{
			yylval.char_val=yytext[0];
			return CHAR_LIT;
		}
\"[^\"']*\" 	{
			yylval.str_val=strdup(yytext);
			printf("hoo hoo %s\n",yytext);
			return STR_LIT;
		}

">"  |	
"<"  |
"<=" |
">="		{
		yylval.str_val=strdup(yytext);
		return REL_OP;}

"==" |
"!="		{
		yylval.str_val=strdup(yytext);
		return EQ_OP;}
"&&" |
"||"		{
		yylval.str_val=strdup(yytext);
		return COND_OP;}

"="  |
"+=" |
"-="		{
		yylval.str_val=strdup(yytext);
		return ASS_OP;}


"+" |
"-" |
"*" |
"/" |
"%" 		{
		yylval.str_val=strdup(yytext);
		return ARITH_OP;
		}
"(" |
")" |
"[" |
"]" |
"{" |
"}" |
";" |
"," |
"~" |
"!"		{
			/*yylvL.c=yytext[0];*/
			//printf("%c",yytext[0]);
			return yytext[0];
		}


%%
