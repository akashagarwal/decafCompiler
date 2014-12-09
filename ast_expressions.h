#include<bits/stdc++.h>
#include "ast_main.h"
using namespace std;

class operations;

class expression: public ast_main_node {
	protected:
	public:
};

/*----------------------------callout declarations--------------------------------*/
class callout : public ast_main_node {
};

class callout_expr : public callout {
	protected :
		expression *expr;
	public:
		callout_expr(expression *e)
		{
			this->expr=e;
		}
};
class callout_literal : public callout {
	protected :
		string literal;
	public:
		callout_literal(string s)
		{
			this->literal=s;
		}
};

/*----------------------------method call  declarations--------------------------------*/
class method_call : public ast_main_node {
};

class method_call_id : public method_call {
	protected:
		string method_name;
		list<expression*> *expr_list;
	public:
		method_call_id(string s , list<expression*> *l)
		{
			this->method_name=s;
			this->expr_list=l;
		}
};
class method_call_callout : public method_call {
	protected:
		string literal;
		list<callout* > *callout_list;
	public:
		method_call_callout(string s , list<callout*> *l)
		{
			this->literal=s;
			this->callout_list=l;
		}
};

/*-------------------------------location declarations ------------------------------------*/
class location : public ast_main_node {

};

class location_id : public location {
	protected:
		string id;
	public:
		location_id(string s)
		{
			this->id=s;
		}
};
class location_expr : public location {
	protected:
		string id;
		expression *expr;
	public:
		location_expr(string s,expression *e)
		{
			this->id=s;
			this->expr=e;
		}
};


/*---------------------------------------types of expressions ----------------------------------*/

class expression_operation : public expression {
	protected:
		operations *op;
		expression *expr_left;
		expression *expr_right;
	public:
		expression_operation(expression *e1 , operations *oper , expression *e2)
		{
			this->expr_left=e1;
			this->expr_right=e2;
			this->op=oper;
		}
};

class expression_minus : public expression {
	protected :
		expression *expr;
	public:
		expression_minus(expression *e)
		{
			this->expr=e;
		}
};

class expression_not : public expression {
	protected:
		expression *expr;
	public:
		expression_not(expression *e)
		{
			this->expr=e;
		}
};

class expression_bracket : public expression {
	protected:
		expression *expr;
	public:
		expression_bracket(expression *e)
		{
			this->expr=e;
		}
};

class expression_method_call : public expression {
	protected:
		method_call *method;
	public:
		expression_method_call(method_call *m)
		{
			this->method=m;
		}
};


class expression_location : public expression {
	protected:
		location *loc;
	public:
		expression_location(location *l)
		{
			this->loc=l;
		}
};
