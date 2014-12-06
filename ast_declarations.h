#include<bits/stdc++.h>
#include "ast_main.h"
using namespace std;

class declaration : public ast_main_node{
	
};

class variable_declaration : public declaration{
	protected:
		string type;
		list <string> *id_list;
	public:
		variable_declaration(string t , list<string> *l){
			this->type=t;
			this->id_list=l;}
};

class variable_declaration_list : public declaration{
	protected :
		list<variable_declaration*> *var_dec_list;
	public:
		variable_declaration_list()
		{
			this->var_dec_list=new list<variable_declaration*>;
		}
		void add_variable_declaration(variable_declaration *v)
		{
			this->var_dec_list->push_back(v);
		}
};
class field: public declaration {
};

class field_num : public field {
	protected:
		string id;
	public:
		field_num(string s){
			this->id=s;
		}
};

class field_arr : public field {
	protected :
		string id;
		int position;
	public:
		field_arr(string s , int i){
			this->id=s;
			this->position=i;
		}
};

class field_declaration : public declaration {
	protected:
		string type;
		list<field*> *field_list;
	public:
		field_declaration(string t, list<field*> *l){
			this->type=t;
			this->field_list=l;
		};
};

class field_declaration_list : public declaration{
	protected:
		list<field_declaration*> *field_dec_list;
	public:
		field_declaration_list()
		{
			this->field_dec_list = new list<field_declaration*>;
		}
		void add_field_declaration(field_declaration *f)
		{
			this->field_dec_list->push_back(f);
		}
};

class method_declaration : public declaration {
	protected:
		string type;
		string method_name;
		variable_declaration_list *method_var_dec_list;
//		block * method_block;
};

class method_declaration_list : public declaration {
	protected:
		list<method_declaration*> *method_dec_list;
	public:
		method_declaration_list()
		{
			this->method_dec_list = new list<method_declaration*>;
		}
		void add_method_declaration(method_declaration* m)
		{
			this->method_dec_list->push_back(m);
		}
};
