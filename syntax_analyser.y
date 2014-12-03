%{
	#include<stdio.h>
	#include<stdlib.h>
	FILE *yyin;
	extern int line;
%}

%union{
	int int_val;
	char char_val;
	char *str_val;
}

%token PROGRAM BOOLEAN BREAK CALLOUT CLASS CONTINUE ELSE FOR IF INT RETURN TRUE FALSE VOID GT LT GE LE EQ NE AND OR IDENTIFIER
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

program: CLASS PROGRAM '{' field_dec1 method_dec1 '}' ;

field_dec1: field_dec1 field_dec
			| /* empty */ ;

method_dec1: method_dec1 method_dec
			| /* empty */ ;
			
field_dec: type field_dec3 ';' 

field_dec3: field_dec3  field_dec2
			| field_dec2 ;

field_dec2: '{' id '}'
			| '{' id '['  ']' '}' ;

method_dec: '{' method_dec2 '}' id '(' '[' method_dec4 ',' ']' ')' block ;

method_dec2: type | VOID ;

method_dec4: method_dec4 method_dec3 
			| method_dec3 ;

method_dec3: '{' type id '}'

block : '{' var_decl_x stetement_x '}' ;

var_decl_x : var_decl_x var_decl 
			| /* empty */ ;

var_decl : type id_p ',' ;

type : INT |  BOOLEAN ;

stetement_x : stetement_x statement 
			| /* empty */ ;

statement : location assign_op expr ';' 
			| method_call ';'
			| IF '(' expr ')' block else_block
			| FOR id '=' expr ',' expr block
			| RETURN '[' expr ']' ;
			| BREAK ';'
			| CONTINUE ';'
			| block ;

else_block : ELSE block | /* empty */ ;

assign_op : '='
			| "+=" 
			| "-=" ;

method_call : id '(' expr_x ')'
			| CALLOUT '(' string_literal '[' ','  callout_arg_p ',' ']' ')' ;


location : id
			| id '[' expr ']' ;

expr_x : expr_r expr  ;
expr_r : expr ',';

expr : location
			| method_call
			| literal
			|  '(' expr bin_op expr ')'
			| '-' '(' expr ')'
			| '!' '(' expr ')'
			| '(' expr ')' ;


callout_arg_p :  callout_arg 
			| ;

callout_arg : expr | string_literal ;

bin_op : arith_op | rel_op | eq_op | cond_op ;

arith_op : '+' | '-' | '*' | '/' | '%'  ;

rel_op  : '<' | '>' | "<=" | ">=" ;

eq_op  : "==" | "!=" ;

cond_op : "&&" | "||" ;

literal : int_literal | char_literal | bool_literal ;

id_p : id_p id 
		| id ;

id : IDENTIFIER ;

int_literal : decimal_literal | hex_literal ;

decimal_literal : INT_LIT ;

hex_literal : HEX_LIT ;

bool_literal :  TRUE | FALSE ;

char_literal : CHAR_LIT ;

string_literal : STR_LIT ;



%%

int main(int argc, char **argv)
{
	yyin=fopen(argv[1],"r");
	yyparse();
	fclose(yyin);
	return 0;
}
yyerror(char *s)
{
	fprintf(stderr,"Error on line %d\n",line);
	}
