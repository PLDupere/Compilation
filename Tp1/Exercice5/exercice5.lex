%{
#include <stdio.h>

int currentLineWordCount = 0;
int lineCount = 1;
%}

%%
[a-zA-ZàáâãäåÀÁÂÃÄÅèéêëÈÉÊËìíîïÌÍÎÏòóôõöùúûüÒÓÔÕÖçÇ]+ {
    // Counting words, including those with hyphens
    currentLineWordCount++;
}

[a-zA-ZàáâãäåÀÁÂÃÄÅèéêëÈÉÊËìíîïÌÍÎÏòóôõöùúûüÒÓÔÕÖçÇ]+-[a-zA-ZàáâãäåÀÁÂÃÄÅèéêëÈÉÊËìíîïÌÍÎÏòóôõöùúûüÒÓÔÕÖçÇ]+ {
    // Handling words with a hyphen in the middle (count as one word)
    currentLineWordCount++;
}

\n {
    // Printing the line number and the number of words for the current line
    printf("Line %d: %d words\n", lineCount, currentLineWordCount);
    currentLineWordCount = 0; // Resetting the word count for the next line
    lineCount++; // Incrementing the line count
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

    return 0;
}
