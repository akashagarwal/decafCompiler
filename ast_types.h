#include<bits/stdc++.h>
#include "ast_main.h"
using namespace std;



class types : public ast_main_node {

};

/*------------------------operations------------------*/
class operations : public types {

};

class arithmetic_op : public operations {
	protected:
		char op;
	public:
		arithmetic_op(char op){
			this->op=op;}
} ;

class relational_op : public operations {
	protected:
		char op;
	public:
		relational_op(char op){
			this->op=op;}

} ;

class equality_op : public operations {
	protected:
		char op;
	public:
		equality_op(char op){
			this->op=op;}
} ;

class conditional_op : public operations {
	protected:
		char op;
	public:
		conditional_op(char op){
			this->op=op;}
} ;
/*------------------------identifiers------------------*/

class id : public types {
	protected:
		string id_name;
	public:
		id(string s){
			this->id_name=s;}
};
/*------------------------string literals------------------*/
class string_literal : public types {
	protected:
		string string_lit;
	public:
		string_literal(string s){
			this->string_lit=s;}
};


/*------------------literals-------------------------------*/
class literal : public types {

};


class int_literal : public literal {
};

class decimal : public int_literal {
	protected:
		int decimal_lit;
	public:
		decimal(int i){
			this->decimal_lit=i;}
};

class hex : public int_literal {
	protected:
		int hex_lit;
	public:
		hex(int i){
			this->hex_lit=i;}
};

class character : public literal {
	protected:
		char char_lit;
	public:
		character(char ch){
			this->char_lit=ch;}
};

class boolean : public literal {
	protected:
		bool bool_lit;
	public:
		boolean(bool b){
			this->bool_lit=b;}

};
