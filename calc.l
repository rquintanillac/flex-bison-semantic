/* Mini Calculator */
/* calc.lex */

%{
#include "heading.h"
//#include "y.tab.h"
#include "tok.h"
extern "C" int yylex();
int yyerror(char *s);


// enum yytokentype {
//     MULT,
//     PLUS,
//     BOOL,
//     INT,
//     DIGIT,
//     EOS,
//     ASSIGN,
//     ID
// };

// union yylval_t{
//   int		int_val;
//   string*	op_val;
//   int       digit_val;
//   string*	id_val;
// };

// union yylval_t yylval;

%}

digit		[0-9]
int_const	{digit}+

%%

"bool" { return BOOL; }
"int"  { return INT;  }

{digit} { yylval.digit_val = atoi(yytext); return DIGIT; }
[a-zA-Z]+ { yylval.id_val = new std::string(yytext); return ID; }

"*"		{ yylval.op_val = new std::string(yytext); return MULT; }
"+"		{ yylval.op_val = new std::string(yytext); return PLUS; }
";"		{ yylval.op_val = new std::string(yytext); return EOS; }
"="   { yylval.op_val = new std::string(yytext); return ASSIGN; }

[ \t]*		{}
[\n]		{ yylineno++;	}

.		{ std::cerr << "SCANNER "; yyerror(""); exit(1);	}

%%

//////////////////////////////////////////////////

// 
bool a; //noop
// int b; //+, *

// b = 1+1;
// c = 3; //error c no está definido
// a = 0; //ok
// a = b+3; //ok sintacticamente, error de tipo por la asignacion
// 3 = 4+b; //error sintactico
// a; //imprimir valor de a
// d; //error d no está definido

// // bool 0 1
// bool c;
// c=2;