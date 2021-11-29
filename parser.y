%{
#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

bool result = false;

int yylex();
void yyerror(const char *msg);

void compare(char* astr, char* bstr, char* cm){
    printf("compare ...\n");

    double a = atof(astr);
    double b = atof(bstr);
    if(cm == "<") {
        result = a < b;
    }
    else if(cm == "<=") {
        result = (a < b) || (a == b);
    }
    else if(cm == ">") {
        result = a > b;
    }
    else if(cm == ">=") {
        result = (a > b) || (a == b);
    }
    else if(cm == "==") {
        result = (a == b);
    }
    else if(cm == "!=") {
        result = (a != b);
    }

    printf("current bool v:%d\n", result);
}

#define YYSTYPE char *
%}

%token T_IntConstant T_FloatConstant T_Identifier T_GeEq T_Eq T_Ne T_LeEq T_And T_Or

%right U_neg

%%

S   :   E ';'                   { printf("\n"); }
    |   S E ';'                 { printf("\n"); }
    ;

E   :   T
    |   E T_And T               { printf("AND "); }
    |   E T_Or T                { printf("OR "); }
    ;

T   :   P
    |   T '<' P                 { printf("< "); }
    |   T '>' P                 { printf("> "); }
    |   T T_Eq P                { printf("== "); }
    |   T T_Ne P                { printf("!= "); }
    |   T T_GeEq P              { printf(">= "); }
    |   T T_LeEq P              { printf("<= "); }
    ;

P   :   T_IntConstant           { printf("%s ", $1); }
    |   T_FloatConstant         { printf("%s ", $1); }
    |   T_Identifier            { printf("%s ", $1); }
    |   '-' P %prec U_neg       { printf("%s ", $1); }
    |   '(' E ')'               { }
    ;

%%


int main() {
    return yyparse();
}