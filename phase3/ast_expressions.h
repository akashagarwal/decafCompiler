#include<bits/stdc++.h>
//#include "ast_main.h"
using namespace std;

class OPERATIONS;

class EXPRESSION: public AST_MAIN_NODE {

};

class EXPRESSION_LIST : public AST_MAIN_NODE {
	protected:
		list<EXPRESSION*> *expr_list;
	public:
		EXPRESSION_LIST()
		{
			this->expr_list = new list<EXPRESSION*>;
		}
		void add(EXPRESSION *e)
		{
			this->expr_list->push_back(e);
		}
};

/*----------------------------callout declarations--------------------------------*/
class CALLOUT : public AST_MAIN_NODE {
};

class CALLOUT_LIST : public AST_MAIN_NODE{
	protected:
		list<CALLOUT*> *callout_list;
	public :
		CALLOUT_LIST()
		{
			this->callout_list = new list<CALLOUT*>;
		}
		void add(CALLOUT *c)
		{
			this->callout_list->push_back(c);
		}
};

class CALLOUT_EXPR : public CALLOUT {
	protected :
		EXPRESSION *expr;
	public:
		CALLOUT_EXPR(EXPRESSION *e)
		{
			this->expr=e;
		}
};
class CALLOUT_LITERAL : public CALLOUT {
	protected :
		STRING_LITERAL *str_literal;
	public:
		CALLOUT_LITERAL(STRING_LITERAL *s)
		{
			this->str_literal=s;
		}
};

/*----------------------------method call  declarations--------------------------------*/
class METHOD_CALL : public AST_MAIN_NODE {
};

class METHOD_CALL_ID : public METHOD_CALL {
	protected:
		ID *id;
		EXPRESSION_LIST *expr_list;
	public:
		METHOD_CALL_ID(ID *i , EXPRESSION_LIST *l)
		{
			this->id=i;
			this->expr_list=l;
		}
};
class METHOD_CALL_CALLOUT : public METHOD_CALL {
	protected:
		STRING_LITERAL *str_literal;
		CALLOUT_LIST *callout_list;
	public:
		METHOD_CALL_CALLOUT(STRING_LITERAL *s , CALLOUT_LIST *l)
		{
			this->str_literal=s;
			this->callout_list=l;
		}
};

/*-------------------------------location declarations ------------------------------------*/
class LOCATION : public AST_MAIN_NODE {

};

class LOCATION_ID : public LOCATION {
	protected:
		ID *id;
	public:
		LOCATION_ID(ID* i)
		{
			this->id=i;
		}
};
class LOCATION_EXPR : public LOCATION {
	protected:
		ID *id;
		EXPRESSION *expr;
	public:
		LOCATION_EXPR(ID *i,EXPRESSION *e)
		{
			this->id=i;
			this->expr=e;
		}
};


/*---------------------------------------types of expressions ----------------------------------*/

class EXPRESSION_OPERATION : public EXPRESSION {
	protected:
		OPERATIONS *op;
		EXPRESSION *expr_left;
		EXPRESSION *expr_right;
	public:
		EXPRESSION_OPERATION(EXPRESSION *e1 , OPERATIONS *oper , EXPRESSION *e2)
		{
			this->expr_left=e1;
			this->expr_right=e2;
			this->op=oper;
		}
};

class EXPRESSION_MINUS : public EXPRESSION {
	protected :
		EXPRESSION *expr;
	public:
		EXPRESSION_MINUS(EXPRESSION *e)
		{
			this->expr=e;
		}
};

class EXPRESSION_NOT : public EXPRESSION {
	protected:
		EXPRESSION *expr;
	public:
		EXPRESSION_NOT(EXPRESSION *e)
		{
			this->expr=e;
		}
};

class EXPRESSION_BRACKET : public EXPRESSION {
	protected:
		EXPRESSION *expr;
	public:
		EXPRESSION_BRACKET(EXPRESSION *e)
		{
			this->expr=e;
		}
};

class EXPRESSION_METHOD_CALL : public EXPRESSION {
	protected:
		METHOD_CALL *method;
	public:
		EXPRESSION_METHOD_CALL(METHOD_CALL *m)
		{
			this->method=m;
		}
};
class EXPRESSION_LOCATION : public EXPRESSION {
	protected:
		LOCATION *loc;
	public:
		EXPRESSION_LOCATION(LOCATION *l)
		{
			this->loc=l;
		}
};
class EXPRESSION_LITERAL : public EXPRESSION {
	protected:
		LITERAL *lit;
	public:
		EXPRESSION_LITERAL(LITERAL *l)
		{
			this->lit=l;
		}
};
