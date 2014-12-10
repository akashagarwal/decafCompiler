#include<bits/stdc++.h>
//#include "ast_declarations.h"
//#include "ast_expressions.h"
//#include "ast_statements.h"
//#include "ast_types.h"

using namespace std;

class FIELD_DECLARATION_LIST;
class METHOD_DECLARATION_LIST;


class AST_MAIN_NODE {
	public:
};

class PROGRAM {
	protected:
		FIELD_DECLARATION_LIST *field_dec_list;
		METHOD_DECLARATION_LIST *method_dec_list;
	public:
		PROGRAM(FIELD_DECLARATION_LIST *f, METHOD_DECLARATION_LIST *m)
		{
			this->field_dec_list=f;
			this->method_dec_list=m;
		}
};
