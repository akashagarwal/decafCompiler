%{
	#include<stdio.h>
	#include<stdlib.h>
	#include "ast.h"
	using namespace std;
	program *main_program_root;
	extern FILE *yyin;
	void yyerror(const char*);
	extern int yylex();
	extern int line;
%}

%union{
	int int_val;
	char char_val;
	char *str_val;
}

%token PROGRAM BOOLEAN BREAK CALLOUT CLASS CONTINUE ELSE FOR IF INT RETURN TRUE FALSE VOID GT LT GE LE EQ NE AND OR IDENTIFIER PEQ MEQ
%token <hex_val> HEX_LIT
%token <int_val> INT_LIT
%token <char_val> CHAR_LIT
%token <str_val> STR_LIT

%left '+'
%left '-'
%left '*'
%left '/'
%left '%'
%left '<'
%left '>'
%left LE
%left GE
%left EQ
%left NE
%left AND
%left OR

%left '('
%left '['

%right ')'
%right ']'

%%

program: CLASS PROGRAM '{' field_dec1 method_dec1 '}' { printf("Parse Success\n"); }

field_dec1: field_dec1 field_dec { printf("field_dec1-1\n"); }
			| /* empty */ { printf("field_dec1-2\n"); }

method_dec1: method_dec1 method_dec { printf("method_dec1-1\n"); }
			| /* empty */ { printf("method_dec1-2\n"); }
			
field_dec: type field_dec3 ';' { printf("field_dec\n"); }

field_dec3: field_dec3 ',' field_dec2 { printf("field_dec3-1\n"); }
			| field_dec2 { printf("field_dec3-2\n"); }

field_dec2: '{' id '}' { printf("field_dec2-1\n"); }
			| '{' id '[' INT_LIT ']' '}'  { printf("field_dec2-2\n"); }

method_dec: '{' method_dec2 '}' id '(' '[' method_dec4 ']' ')' block  { printf("method_dec\n"); }

method_dec2: type { printf("method_dec2-1\n"); } | VOID  { printf("method_dec2-2\n"); }

method_dec4: method_dec4 ',' method_dec3  { printf("method_dec4-1\n"); }
			| method_dec3  { printf("method_dec4-2\n"); }

method_dec3: '{' type id '}' { printf("method_dec3\n"); }

block : '{' var_decl_x stetement_x '}'  { printf("block\n"); }

var_decl_x : var_decl_x var_decl 
			| /* empty */ ;

var_decl : type id_p ';' { printf("var decleration\n"); }

id_p : id_p ',' id 
		| id ;

type : INT {printf("type-int\n");} |  BOOLEAN {printf("type-boolean\n");}

stetement_x : stetement_x statement 
			| /* empty */ ;

statement : location assign_op expr ';'  {printf("statement-type1\n");}
			| method_call ';' {printf("statement-type2-methodcall\n");}
			| IF '(' expr ')' block '[' else_block ']' {printf("statement-type3-if else\n");}
			| FOR id '=' expr ',' expr block {printf("statement-type4 - for loop\n");}
			| RETURN '[' expr ']' ';' {printf("statement-type5 - return\n");}
			| BREAK ';' {printf("statement-type6 - break\n");}
			| CONTINUE ';' {printf("statement-type7 - continue\n");}
			| block  {printf("statement- type 8 - block\n");}

else_block : ELSE block {printf("else part\n");} | /* empty */ ;

assign_op : '='
			| PEQ 
			| MEQ ;

method_call : id '(' expr_x ')' {printf("method_call-type1\n");}
			| CALLOUT '(' string_literal '['   callout_arg_p  ']' ')'  {printf("method_call-type2\n");}


location : id  {printf("location-type1\n");}
			| id '[' expr ']' {printf("location-type2\n");}

expr_x : expr_x ',' expr  | expr

expr : location {printf("expr-t1\n");}
			| method_call {printf("expr-t2\n");}
			| literal {printf("expr-t3-literal\n");}
			|  '(' expr bin_op expr ')' {printf("expr-t4\n");}
			| '-' '(' expr ')' {printf("expr-t5\n");}
			| '!' '(' expr ')' {printf("expr-t6\n");}
			| '(' expr ')'  {printf("expr-t7\n");}


callout_arg_p : callout_arg_p ',' callout_arg {printf("callout arg p 1\n");}
			|  callout_arg {printf("callout arg p 2\n");}

callout_arg : expr {printf("callout arg-expr\n");} | string_literal {printf("callout arg - string\n");}

bin_op : arith_op | rel_op | eq_op | cond_op ;

arith_op : '+' | '-' | '*' | '/' | '%'  ;

rel_op  : '<' | '>' | "<=" | ">=" ;

eq_op  : "==" | "!=" ;

cond_op : "&&" | "||" ;

literal : int_literal | char_literal | bool_literal ;



id : IDENTIFIER {printf("identifier\n");}

int_literal : decimal_literal {printf("decimal int literal\n");} | hex_literal  {printf("int literal\n");}

decimal_literal : INT_LIT ;

hex_literal : HEX_LIT ;

bool_literal :  TRUE {printf("bool literal\n");} | FALSE  {printf("bool literal\n");}

char_literal : CHAR_LIT  {printf("char literal\n");}

string_literal : STR_LIT   {printf("string literal\n");}



%%

int main(int argc, char **argv)
{
	yyin=fopen(argv[1],"r");
	yyparse();
	fclose(yyin);
	return 0;
}
void yyerror(const char *s)
{
	fprintf(stderr,"Error on line %d\n",line);
	}
