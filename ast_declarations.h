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
		variable_declaration_list(list<variable_declaration*> *l){
			this->var_dec_list=l;}
};

class field_declaration : public declaration {

};

class method_declaration : public declaration {

};
