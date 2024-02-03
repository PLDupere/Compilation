%{
#include <stdio.h>

int lineCount = 0; // Counter to count lines in comments
%}

%%

"//".* {
    printf("Single-line comment (Line %d): %s\n", ++lineCount, yytext);
}

"/*"([^*]|"*"+[^*/])*"*/" {
    char* newlinePos = strchr(yytext, '\n');
    while (newlinePos != NULL) {
        lineCount++;
        newlinePos = strchr(newlinePos + 1, '\n');
    }
    printf("Multi-line comment (Line %d): %s\n", ++lineCount, yytext);
}

. {
    /* Ignore all other characters */
}

%%

int main(int argc, char** argv) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <file>\n", argv[0]);
        return 1;
    }

    FILE* file = fopen(argv[1], "r");
    if (file == NULL) {
        perror("Error opening file");
        return 1;
    }

    yyin = file;
    yylex();

    fclose(file);

    printf("Total number of lines in comments: %d\n", lineCount);

    return 0;
}
