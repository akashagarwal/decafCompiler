#include<bits/stdc++.h>
#include "ast_main.h"
using namespace std;


class expression;
class location;
class method_call;
class variable_declaration;
class variable_declaration_list;
class id;

class statement : public ast_main_node {
};

class statement_list : public ast_main_node{
	protected:
		list<statement*> *stat_list;
	public:
		statement_list()
		{
			this->stat_list =  new list<statement *>;
		}
		void add(statement *stat)
		{
			this->stat_list->push_back(stat);
		}
};

class block : public ast_main_node {
	protected:
		variable_declaration_list *var_dec_list;
		statement_list *stat_dec_list;
	public:
		block(variable_declaration_list *v , statement_list *d)
		{
			this->var_dec_list=v;
			this->stat_dec_list=d;
		}
};


class statement_assign : public statement {
	protected:
		char assign_operator;
		expression *expr;
	public:
		statement_assign(char ch, expression *e)
		{
			this->assign_operator=ch;
			this->expr=e;
		}
};

class statement_method_call : public statement {
	protected:
		method_call *m_call;
	public:
		statement_method_call(method_call *m)
		{
			this->m_call=m;
		}
};

class statement_if_else : public statement {
	protected:
		expression *expr;
		block *if_block;
		block *else_block;
	public:
		statement_if_else(expression *e, block *b1 , block *b2)
		{
			this->expr=e;
			this->if_block=b1;
			this->else_block=b2;
		}
};

class statement_for : public statement {
	protected:
		id *identifier;
		expression *for_expr1,*for_expr2;
		block *for_block;
	public:
		statement_for(id *i, expression *e1, expression *e2, block *b)
		{
			this->identifier=i;
			this->for_expr1=e1;
			this->for_expr2=e2;
			this->for_block=b;
		}
};

class statement_return : public statement {
	protected :
		expression *expr;
	public:
		statement_return(expression *e)
		{
			this->expr=e;
		}
};

class statement_break : public statement{
};

class statement_continue: public statement {
};

class statement_block : public statement {
	protected:
		block *stat_block;
	public:
		statement_block(block *b)
		{
			this->stat_block=b;
		}
};
