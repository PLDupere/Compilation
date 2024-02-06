%{
#include <stdio.h>

int wordCount = 0;
int lineCount = 1;
%}

%%
[a-zA-ZàáâãäåÀÁÂÃÄÅèéêëÈÉÊËìíîïÌÍÎÏòóôõöùúûüÒÓÔÕÖçÇ]+ {
    // Counting words
    wordCount++;
}

\n {
    // Counting lines
    lineCount++;
}

. ; // Ignore other characters

%%

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (file == NULL) {
        perror("Error opening the file");
        return 1;
    }

    yyin = file;
    yylex();
    fclose(file);

    int totalWordCount = wordCount;
    int totalLineCount = lineCount;

    printf("The sum of words and lines: %d\n", totalWordCount + totalLineCount);

    return 0;
}
