%{
#include <stdio.h>
#include <stdlib.h>

int wordCount = 0;
int lineCount = 1;
%}

%option noyywrap

%%

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

    printf("Number of words: %d\n", wordCount);
    printf("Number of lines: %d\n", lineCount);

    return 0;
}
