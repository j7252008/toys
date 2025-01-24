%{
#define YYSTYPE char *
#include "y.tab.h"
int cur_line = 1;
void yyerror(const char *msg);
void unrecognized_char(char c);
void unterminate_string();

%}

INTEGER             ([0-9]+)
FLOAT               ([0-9]+\.[0-9]+)
IDENTIFIER          ([_a-zA-Z][_a-zA-Z0-9]*)
OPERATOR            ([<>;()])

%%
[\n]                { cur_line++;                       }
[ \t\r\a]+          { /* ignore all spaces */               }

{OPERATOR}          { return yytext[0]; }

"<="                { return T_LeEq;              }
">="                { return T_GeEq;              }
"=="                { return T_Eq;              }
"!="                { return T_Ne;              }
"AND"               { return T_And;             }
"OR"                { return T_Or;              }

{INTEGER}           { yylval = strdup(yytext); return T_IntConstant;     }
{FLOAT}             { yylval = strdup(yytext); return T_FloatConstant;     }
{IDENTIFIER}        { yylval = strdup(yytext); return T_Identifier;      }

<<EOF>>             { return 0; }

.                   { yyerror("Unrecognized character");        }
%%

int yywrap(void) { 
    return 1;
}

void unrecognized_char(char c) {
    char buf[32] = "Unrecognized character: ?";
    buf[24] = c;
    yyerror(buf);
}

void unterminate_string() {
    yyerror("Unterminate string constant");
}

void yyerror(const char *msg) {
    fprintf(stderr, "Error at line %d:\n\t%s\n", cur_line, msg);
    exit(-1);
}
