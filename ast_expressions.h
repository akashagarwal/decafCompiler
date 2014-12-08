#include<bits/stdc++.h>
#include "ast_main.h"
using namespace std;

class operations;

class expression: public ast_main_node {
	protected:
	public:
};

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
