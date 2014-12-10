%{
	#include<stdio.h>
	#include<stdlib.h>
	#include"ast.h"
	using namespace std;
	PROGRAM *main_program_root;
	extern FILE *yyin;
	void yyerror(const char*);
	extern int yylex();
	extern int line;

	#include "llvm/IR/DerivedTypes.h"
	#include "llvm/IR/IRBuilder.h"
	#include "llvm/IR/LLVMContext.h"
	#include "llvm/IR/Module.h"


%}


%token PROG BREAK CLLOUT CLASS CONTINUE ELSE FOR IF RETURN 
%union{
	int int_val;
	char char_val;
	char *str_val;
	bool bool_val;
	PROGRAM *program_node;
	DECLARATION *declaration_node;
	VARIABLE_DECLARATION *variable_declaration_node;
	VARIABLE_DECLARATION_LIST *variable_declaration_list_node;
	FIELD *field_node;
	FIELD_DECLARATION_LIST *field_declaration_list_node;
	FIELD_NUM *field_num_node;
	FIELD_ARR *field_arr_node;
	FIELD_LIST *field_list_node;
	FIELD_DECLARATION *field_declaration_node;
	METHOD_DECLARATION *method_declaration_node;
	METHOD_DECLARATION_LIST *method_declaration_list_node;
	METHOD_VARIABLE_DECLARATION *method_variable_declaration_node;
	METHOD_VARIABLE_DECLARATION_LIST *method_variable_declaration_list_node;
	EXPRESSION *expression_node;
	EXPRESSION_LIST *expression_list_node;
	CALLOUT_LIST *callout_list_node;
	CALLOUT *callout_node;
	CALLOUT_EXPR *callout_expr_node;
	CALLOUT_LITERAL *callout_literal_node;
	METHOD_CALL *method_call_node;
	METHOD_CALL_ID *method_call_id_node;
	METHOD_CALL_CALLOUT *method_call_callout_node;
	LOCATION *location_node;
	LOCATION_ID *location_id_node;
	LOCATION_EXPR *location_expr_node;
	EXPRESSION_OPERATION *expression_operation;
	EXPRESSION_MINUS *expression_minus_node;
	EXPRESSION_NOT	*expresson_not_node;
	EXPRESSION_BRACKET *expression_bracket_node;
	EXPRESSION_METHOD_CALL *expression_method_call_node;
	EXPRESSION_LOCATION *expression_location_node;
	STATEMENT *statement_node;
	STATEMENT_LIST *statement_list_node;
	BLOCK *block_node;
	STATEMENT_ASSIGN *statement_assing_node;
	STATEMENT_METHOD_CALL *statement_method_call_node;
	STATEMENT_IF_ELSE *statement_is_else_node;
	STATEMENT_FOR *statement_for_node;
	STATEMENT_RETURN *statement_return_node;
	STATEMENT_BREAK *statement_break_node;
	STATEMENT_CONTINUE *statement_continue_node;
	STATEMENT_BLOCK *statement_block_node;
	TYPES *types_node;
	OPERATIONS *operations_node;
	ARITHMETIC_OP *arithmetic_op_node;
	RELATIONAL_OP *relational_op_node;
	EQUALITY_OP *equality_op_node;
	CONDITIONAL_OP *conditional_op_node;
	ID *id_node;
	ID_LIST *id_list_node;
	STRING_LITERAL *string_literal_node;
	LITERAL *literal_node;
	CHARACTER *character_node;
	BOOLEAN *boolean_node;


}

%token <hex_val> HEX_LIT
%token <int_val> INT_LIT
%token <char_val> CHAR_LIT
%token <str_val> STR_LIT
%token<bool_val> BOOL_LIT
%token <str_val> IDENTIFIER
%token <str_val> REL_OP
%token <str_val> EQ_OP
%token <str_val> COND_OP
%token <str_val> ARITH_OP
%token <str_val> ASS_OP
%token <str_val> VAR_TYPE
%type<string_literal_node> string_literal
%type<literal_node> literal;
%type<id_node> id;
%type<id_list_node> id_p;
%type<operations_node> bin_op;
%type<callout_node> callout_arg;
%type<callout_list_node> callout_arg_p;
%type<expression_node> expr;
%type<expression_list_node> expr_x;
%type<location_node> location;
%type<method_call_node> method_call;
%type<variable_declaration_node> var_decl;
%type<variable_declaration_list_node> var_decl_x;
%type<block_node> block;
%type<statement_node> statement;
%type<statement_list_node> statement_x;
%type<method_variable_declaration_node> method_var_dec;
%type<method_variable_declaration_list_node> method_var_dec_list;
%type<method_declaration_list_node> method_dec_list;
%type<method_declaration_node> method_dec;
%type<field_node> field_dec_type;
%type<field_list_node> field_dec3;
%type<field_declaration_node> field_dec;
%type<field_declaration_list_node> field_dec_list;
%type<program_node> program;

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

program: CLASS PROG '{' field_dec_list method_dec_list '}' { $$ = new PROGRAM($4,$5);main_program_root=$$; printf("Parse Success\n"); }

field_dec_list: field_dec_list field_dec { $1->add($2); printf("field_dec1-1\n"); }
			| /* empty */ {$$ = new FIELD_DECLARATION_LIST();  printf("field_dec1-2\n"); }

method_dec_list: method_dec_list method_dec { $1->add($2); printf("method_dec1-1\n"); }
			| /* empty */ { $$ = new METHOD_DECLARATION_LIST(); printf("method_dec1-2\n"); }
			
field_dec: VAR_TYPE field_dec3 ';' { $$ = new FIELD_DECLARATION($1,$2); printf("field_dec\n"); }

field_dec3: field_dec3 ',' field_dec_type { $1->add($3); printf("field_dec3-1\n"); }
			| field_dec_type {$$ = new FIELD_LIST(); $$->add($1); printf("field_dec3-2\n"); }

field_dec_type: '{' id '}' { $$ = new FIELD_NUM($2); printf("field_dec2-1\n"); }
			| '{' id '[' INT_LIT ']' '}'  {$$ = new FIELD_ARR($2,$4); printf("field_dec2-2\n"); }

method_dec: '{' VAR_TYPE '}' id '(' '[' method_var_dec_list ']' ')' block  {$$ = new METHOD_DECLARATION($2,$4,$7,$10); printf("method_dec\n"); }


method_var_dec_list: method_var_dec_list ',' method_var_dec  { $1->add($3); printf("method_dec4-1\n"); }
			| method_var_dec  { $$ = new METHOD_VARIABLE_DECLARATION_LIST(); $$->add($1); printf("method_dec4-2\n"); }

method_var_dec: '{' VAR_TYPE id '}' { $$ = new METHOD_VARIABLE_DECLARATION($2,$3); printf("method_dec3\n"); }

block : '{' var_decl_x statement_x '}'  { $$ = new BLOCK($2,$3);printf("block\n"); }

var_decl_x : var_decl_x var_decl {$1->add($2);} 
			| /* empty */ {$$ = new VARIABLE_DECLARATION_LIST();};

var_decl : VAR_TYPE id_p ';' {$$ = new VARIABLE_DECLARATION($1,$2); printf("var decleration\n"); }

id_p : id_p ',' id { $1->add($3);} 
		| id {$$ = new ID_LIST(); $$->add($1);};


statement_x : statement_x statement {$1->add($2);}
			| /* empty */ {$$ = new STATEMENT_LIST();};

statement : location ASS_OP expr ';'  { $$ = new STATEMENT_ASSIGN($1,$2,$3);printf("statement-type1\n");}
			| method_call ';' { $$ = new STATEMENT_METHOD_CALL($1);printf("statement-type2-methodcall\n");}
			| IF '(' expr ')' block '[' ELSE block ']' { $$ = new STATEMENT_IF_ELSE($3,$5,$8); printf("statement-type3-if else\n");}
			| IF '(' expr ')' block '[' ']' {printf("statement-type3-if\n");}
			| FOR id ASS_OP expr ',' expr block { $$ = new STATEMENT_FOR($2,$3,$4,$6,$7); printf("statement-type4 - for loop\n");}
			| RETURN '[' expr ']' ';' {$$ = new STATEMENT_RETURN($3); printf("statement-type5 - return\n");}
			| BREAK ';' {$$ = new STATEMENT_BREAK() ;printf("statement-type6 - break\n");}
			| CONTINUE ';' {$$ = new STATEMENT_CONTINUE(); printf("statement-type7 - continue\n");}
			| block  {$$ = new STATEMENT_BLOCK($1); printf("statement- type 8 - block\n");}

/*else_block : ELSE block {printf("else part\n");} |  ;*/


method_call : id '(' expr_x ')' { $$ = new METHOD_CALL_ID($1 , $3); printf("method_call-type1\n");}
			| CLLOUT '(' string_literal '['   callout_arg_p  ']' ')'  {$$ = new METHOD_CALL_CALLOUT($3, $5); printf("method_call-type2\n");}


location : id  {$$ = new LOCATION_ID($1); printf("location-type1\n");}
			| id '[' expr ']' {$$= new LOCATION_EXPR($1,$3); printf("location-type2\n");}

expr_x : expr_x ',' expr {$1->add($3);}  | expr {$$ = new EXPRESSION_LIST() ; $$->add($1);}

expr : location {$$ = new EXPRESSION_LOCATION($1); printf("expr-t1\n");}
			| method_call {$$ = new EXPRESSION_METHOD_CALL($1); printf("expr-t2\n");}
			| literal {$$ = new EXPRESSION_LITERAL($1) ; printf("expr-t3-literal\n");}
			|  '(' expr bin_op expr ')' {$$ = new EXPRESSION_OPERATION($2,$3,$4); printf("expr-t4\n");}
			| '~' '(' expr ')' {$$ = new EXPRESSION_MINUS($3); printf("expr-t5\n");}
			| '!' '(' expr ')' {$$ = new EXPRESSION_NOT($3); printf("expr-t6\n");}
			| '(' expr ')'  {$$ = new EXPRESSION_BRACKET($2); printf("expr-t7\n");}


callout_arg_p : callout_arg_p ',' callout_arg { $1->add($3);printf("callout arg p 1\n");}
			|  callout_arg { $$ = new CALLOUT_LIST() ; $$->add($1); printf("callout arg p 2\n");}

callout_arg : expr {$$ = new CALLOUT_EXPR($1);printf("callout arg-expr\n");} | string_literal { $$ = new CALLOUT_LITERAL($1); printf("callout arg - string\n");}

bin_op : ARITH_OP {$$ = new ARITHMETIC_OP($1);}
	| REL_OP {$$ = new RELATIONAL_OP($1);}
	| EQ_OP {$$ = new EQUALITY_OP($1);}
	| COND_OP {$$ = new CONDITIONAL_OP($1); }
	;

literal : INT_LIT  {$$ = new DECIMAL(0); printf("int literal \n"); } 
	| HEX_LIT {$$ = new HEX(0); }
	| CHAR_LIT {$$ = new CHARACTER($1);} 
	| BOOL_LIT {$$ = new BOOLEAN(BOOL_LIT);}

id : IDENTIFIER {$$ = new ID($1); printf("identifier %s\n",$1);}

string_literal : STR_LIT   {$$ = new STRING_LITERAL($1) ;  printf("string literal %s\n",$1);}
%%

int main(int argc, char **argv)
{
     llvm::LLVMContext &Context = llvm::getGlobalContext();
    TheModule = new  llvm::Module("Initializing code generator...\n",  Context);

	yyin=fopen(argv[1],"r");
	yyparse();
	fclose(yyin);

	TheModule->dump();
	return 0;
}
void yyerror(const char *s)
{
	fprintf(stderr,"Error on line %d\n",line);
	}
