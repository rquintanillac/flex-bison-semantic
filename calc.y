/* Mini Calculator */
/* calc.y */

%{
#include "heading.h"
int yyerror(char *s);
extern "C" int yylex();
struct type_val{
  int type;
  int val;
};

map<string, type_val> tabla;

void insertar_simbolo(string id, type_val val);
bool buscar_simbolo(string id);
void actualizar_simbolo(string, type_val new_val);
%}

%union{
  int		int_val;
  string*	op_val;
  int     digit_val;
  string* id_val;
}

%start	input 

%token EOS

%token <int_val>	DIGIT
%token <op_val> ID
%token <int_val> BOOL
%token <int_val> INT
%token <op_val> ASSIGN
//%type	<int_val>	exp
%left	PLUS
%left	MULT

%%

input:		/* empty */
		| input decl	/*{ cout << "Result: " << $1 << endl; }*/
    | input sent
    | decl
    | sent
		;

decl:
    BOOL ID EOS {
      if(!buscar_simbolo(string(*$2)))
      {
        type_val t;
        t.type=$1;
        insertar_simbolo(string(*$2), t);
      }
      else
      {
        /* Error */
        yyerror("Simbolo ya definido!");
      }
    }
    | INT ID EOS {
      if(!buscar_simbolo(string(*$2)))
      {
        type_val t;
        t.type=$1;
        insertar_simbolo(string(*$2), t);
      }
      else
      {
        /* Error */
        yyerror("Simbolo ya definido!");
      }
    }
    | ID EOS {}

sent:
    ID ASSIGN exp EOS {}

exp:		DIGIT	{ }
    | ID
		| exp PLUS exp	{  }
		| exp MULT exp	{  }
		;

%%

int yyerror(string s)
{
  extern int yylineno;	// defined and maintained in lex.c
  extern char *yytext;	// defined and maintained in lex.c

  cerr << "ERROR: " << s << " at symbol \"" << yytext;
  cerr << "\" on line " << yylineno << endl;
  exit(1);
}

int yyerror(char *s)
{
  return yyerror(string(s));
}

void insertar_simbolo(string id, type_val val){
  tabla[id]=val;
}

bool buscar_simbolo(string id){
  return tabla.find(id)!=tabla.end();
}

void actualizar_simbolo(string, type_val new_val){
  
}