%{ 
#include <ctype.h>
%}

%%

[A-Z]   { printf("Lettre majuscule => %c\n", tolower(yytext[0])); }
[a-z]   { printf("Lettre minuscule => %c\n", toupper(yytext[0])); }
[0-9]+  { 
            int num = atoi(yytext); 
            if (num > 0) 
                printf("Entier positif: %d\n", num); 
            else if (num < 0) 
                printf("Entier négatif: %d\n", num); 
            else 
                printf("Entier nul: %d\n", num); 
        }
-?[0-9]+ { 
            int num = atoi(yytext); 
            printf("Entier négatif: %d\n", num); 
        }
.       { printf("Caractère non pris en charge: %c\n", yytext[0]); }

%%

int yywrap() {
    return 1;  // Indicates end of input
}

int main() {
    yylex();
    return 0;
}
