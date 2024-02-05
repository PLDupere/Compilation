%{ 
#include <ctype.h>
%}

%%

[A-Z]   { printf("Uppercase letter => %c\n", tolower(yytext[0])); }
[a-z]   { printf("Lowercase letter => %c\n", toupper(yytext[0])); }
[0-9]+  { 
            int num = atoi(yytext); 
            if (num > 0) 
                printf("Positive integer: %d\n", num); 
            else if (num < 0) 
                printf("Negative integer: %d\n", num); 
            else 
                printf("Null integer: %d\n", num); 
        }
-?[0-9]+ { 
            int num = atoi(yytext); 
            printf("Negative integer: %d\n", num); 
        }
.       { printf("Unsupported character: %c\n", yytext[0]); }

%%

int yywrap() {
    return 1;
}

int main() {
    yylex();
    return 0;
}
