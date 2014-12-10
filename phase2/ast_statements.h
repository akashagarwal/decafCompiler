#include<bits/stdc++.h>
//#include "ast_main.h"
using namespace std;



class EXPRESSION;
class LOCATION;
class METHOD_CALL;
class VARIABLE_DECLARATION;
class VARIABLE_DECLARATION_LIST;
class ID;

class STATEMENT : public AST_MAIN_NODE {
};

class STATEMENT_LIST : public AST_MAIN_NODE{
	protected:
		list<STATEMENT*> *stat_list;
	public:
		STATEMENT_LIST()
		{
			this->stat_list =  new list<STATEMENT *>;
		}
		void add(STATEMENT *stat)
		{
			this->stat_list->push_back(stat);
		}
};
/*------------------block declarations----------------------------------*/
class BLOCK : public AST_MAIN_NODE {
	protected:
		VARIABLE_DECLARATION_LIST *var_dec_list;
		STATEMENT_LIST *stat_dec_list;
	public:
		BLOCK(VARIABLE_DECLARATION_LIST *v , STATEMENT_LIST *d)
		{
			this->var_dec_list=v;
			this->stat_dec_list=d;
		}
};

/*-----------------types of statements------------------------------------*/
class STATEMENT_ASSIGN : public STATEMENT {
	protected:
		LOCATION *stat_location;
		char *assign_operator;
		EXPRESSION *expr;
	public:
		STATEMENT_ASSIGN(LOCATION *l,char *ch, EXPRESSION *e)
		{
			this->stat_location=l;
			this->assign_operator=ch;
			this->expr=e;
		}
};

class STATEMENT_METHOD_CALL : public STATEMENT {
	protected:
		METHOD_CALL *m_call;
	public:
		STATEMENT_METHOD_CALL(METHOD_CALL *m)
		{
			this->m_call=m;
		}
};

class STATEMENT_IF_ELSE : public STATEMENT {
	protected:
		EXPRESSION *expr;
		BLOCK *if_block;
		BLOCK *else_block;
	public:
		STATEMENT_IF_ELSE(EXPRESSION *e, BLOCK *b1 , BLOCK *b2)
		{
			this->expr=e;
			this->if_block=b1;
			this->else_block=b2;
		}
};

class STATEMENT_FOR : public STATEMENT {
	protected:
		ID *identifier;
		char *assign_operator;
		EXPRESSION *for_expr1,*for_expr2;
		BLOCK *for_block;
	public:
		STATEMENT_FOR(ID *i, char *ch,EXPRESSION *e1, EXPRESSION *e2, BLOCK *b)
		{
			this->identifier=i;
			this->assign_operator=ch;
			this->for_expr1=e1;
			this->for_expr2=e2;
			this->for_block=b;
		}
};

class STATEMENT_RETURN : public STATEMENT {
	protected :
		EXPRESSION *expr;
	public:
		STATEMENT_RETURN(EXPRESSION *e)
		{
			this->expr=e;
		}
};

class STATEMENT_BREAK : public STATEMENT{
};

class STATEMENT_CONTINUE: public STATEMENT {
};

class STATEMENT_BLOCK : public STATEMENT {
	protected:
		BLOCK *stat_block;
	public:
		STATEMENT_BLOCK(BLOCK *b)
		{
			this->stat_block=b;
		}
};
