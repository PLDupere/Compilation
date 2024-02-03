%{
#include <stdio.h>
#include <string.h>

int max_length = 0;
char longest_word[100]; // Assuming the maximum length of a word is 100 characters
%}

%%
[a-zA-ZàáâãäåÀÁÂÃÄÅèéêëÈÉÊËìíîïÌÍÎÏòóôõöùúûüÒÓÔÕÖçÇ]+ {
    int length = strlen(yytext);
    if (length > max_length) {
        max_length = length;
        strcpy(longest_word, yytext);
        printf("Found longer word: %s (length: %d)\n", longest_word, max_length);
    }
}

.|\n    ; // Ignore characters other than letters

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

    printf("The longest word is \"%s\" and its length is %d\n", longest_word, max_length);

    return 0;
}
