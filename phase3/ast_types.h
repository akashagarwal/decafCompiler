#include<bits/stdc++.h>
//#include "ast_main.h"
using namespace std;



class TYPES : public AST_MAIN_NODE {

};

/*------------------------operations------------------*/
class OPERATIONS : public TYPES {

};

class ARITHMETIC_OP : public OPERATIONS {
	protected:
		char *op;
	public:
		ARITHMETIC_OP(char *op){
			this->op=op;}
} ;

class RELATIONAL_OP : public OPERATIONS {
	protected:
		char *op;
	public:
		RELATIONAL_OP(char *op){
			this->op=op;}

} ;

class EQUALITY_OP : public OPERATIONS {
	protected:
		char *op;
	public:
		EQUALITY_OP(char *op){
			this->op=op;}
} ;

class CONDITIONAL_OP : public OPERATIONS {
	protected:
		char *op;
	public:
		CONDITIONAL_OP(char *op){
			this->op=op;}
} ;
/*------------------------identifiers------------------*/

class ID : public TYPES {
	protected:
		string id_name;
	public:
		ID(string s){
			this->id_name=s;}
};

class ID_LIST : public TYPES {
	protected:
		list<ID*>  *id_list;
	public:
		ID_LIST()
		{
			this->id_list= new list<ID*>;
		}
		void add(ID *i)
		{
			this->id_list->push_back(i);
		}
	
};
/*------------------------string literals------------------*/
class STRING_LITERAL : public TYPES {
	protected:
		string string_lit;
	public:
		STRING_LITERAL(string s){
			this->string_lit=s;}
};


/*------------------literals-------------------------------*/
class LITERAL : public TYPES {

};



class DECIMAL : public LITERAL {
	protected:
		int decimal_lit;
	public:
		DECIMAL(int i){
			this->decimal_lit=i;}
};

class HEX : public LITERAL {
	protected:
		int hex_lit;
	public:
		HEX(int i){
			this->hex_lit=i;}
};

class CHARACTER : public LITERAL {
	protected:
		char char_lit;
	public:
		CHARACTER(char ch){
			this->char_lit=ch;}
};

class BOOLEAN : public LITERAL {
	protected:
		bool bool_lit;
	public:
		BOOLEAN(bool b){
			this->bool_lit=b;}

};
