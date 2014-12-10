#include<bits/stdc++.h>
//#include "ast_main.h"
using namespace std;

class BLOCK;

class DECLARATION : public AST_MAIN_NODE {
};


/*------------------------------variable declarations ---------------------------*/
class VARIABLE_DECLARATION : public DECLARATION{
	protected:
		string type;
		ID_LIST *id_list;
	public:
		VARIABLE_DECLARATION(string t , ID_LIST *l)
		{
			this->type=t;
			this->id_list=l;
		}
};

class VARIABLE_DECLARATION_LIST : public DECLARATION{
	protected :
		list<VARIABLE_DECLARATION*> *var_dec_list;
	public:
		VARIABLE_DECLARATION_LIST()
		{
			this->var_dec_list=new list<VARIABLE_DECLARATION*>;
		}
		void add(VARIABLE_DECLARATION *v)
		{
			this->var_dec_list->push_back(v);
		}
};
/*------------------------------field declarations ---------------------------*/
class FIELD: public DECLARATION {
};

class FIELD_NUM : public FIELD {
	protected:
		ID *id;
	public:
		FIELD_NUM(ID *i){
			this->id=i;
		}
};

class FIELD_ARR : public FIELD {
	protected :
		ID *id;
		int position;
	public:
		FIELD_ARR(ID *i , int j){
			this->id=i;
			this->position=j;
		}
};

class FIELD_LIST : public DECLARATION {
	protected:
		list<FIELD*> *field_list;
	public:
		FIELD_LIST()
		{
			this->field_list=new list<FIELD*>;
		}
		void add(FIELD *f)
		{
			this->field_list->push_back(f);
		}
};

class FIELD_DECLARATION : public DECLARATION {
	protected:
		string type;
		FIELD_LIST *field_list;
	public:
		FIELD_DECLARATION(string t, FIELD_LIST *l){
			this->type=t;
			this->field_list=l;
		};
};

class FIELD_DECLARATION_LIST : public DECLARATION{
	protected:
		list<FIELD_DECLARATION*> *field_dec_list;
	public:
		FIELD_DECLARATION_LIST()
		{
			this->field_dec_list = new list<FIELD_DECLARATION*>;
		}
		void add(FIELD_DECLARATION *f)
		{
			this->field_dec_list->push_back(f);
		}
};

/*------------------------------method declarations ---------------------------*/
class METHOD_VARIABLE_DECLARATION{
	protected:
		string type;
		ID *id;
	public:
		METHOD_VARIABLE_DECLARATION(string s, ID *i)
		{
			this->type=s;
			this->id=i;
		}
};

class METHOD_VARIABLE_DECLARATION_LIST : public DECLARATION {
	protected :
		list<METHOD_VARIABLE_DECLARATION *> *method_var_dec_list;
	public:
		METHOD_VARIABLE_DECLARATION_LIST()
		{
			method_var_dec_list= new list<METHOD_VARIABLE_DECLARATION*>;
		}
		void add(METHOD_VARIABLE_DECLARATION *m)
		{
			this->method_var_dec_list->push_back(m);
		}
};
class METHOD_DECLARATION : public DECLARATION {
	protected:
		string type;
		ID *method_name;
		METHOD_VARIABLE_DECLARATION_LIST *method_var_dec_list;
		BLOCK * method_block;
	public:
		METHOD_DECLARATION(string s1,ID *i,METHOD_VARIABLE_DECLARATION_LIST *l, BLOCK *b)
		{
			this->type=s1;
			this->method_name=i;
			this->method_var_dec_list=l;
			this->method_block=b;
		}

};


class METHOD_DECLARATION_LIST : public DECLARATION {
	protected:
		list<METHOD_DECLARATION*> *method_dec_list;
	public:
		METHOD_DECLARATION_LIST()
		{
			this->method_dec_list = new list<METHOD_DECLARATION*>;
		}
		void add(METHOD_DECLARATION* m)
		{
			this->method_dec_list->push_back(m);
		}
};
