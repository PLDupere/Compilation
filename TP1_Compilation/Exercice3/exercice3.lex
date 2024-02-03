%{
#include <stdio.h>
#include <stdlib.h>

int max_int = 0;
int sum = 0;
int wordCount = 0;
int lineCount = 0;
%}

%option noyywrap

%%
[0-9]+ {
    int num = atoi(yytext);
    if (num > max_int) {
        max_int = num;
    }
    sum += num;
}

[a-zA-Z]+ {
    // Counting words
    wordCount++;
}

\n {
    // Counting lines
    lineCount++;
}

. {
    // Ignore other characters
}

%%

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    FILE* file = fopen(argv[1], "r");
    if (file == NULL) {
        perror("Unable to open file");
        return 1;
    }

    yyin = file;
    yylex();
    fclose(yyin);

    printf("The largest integer value is: %d\n", max_int);
    printf("The sum of all integer values is: %d\n", sum);

    return 0;
}
