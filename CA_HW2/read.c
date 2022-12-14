#include <stdio.h>
#include <stdlib.h>

extern char *string;

int read_data(FILE *input) {
    int size;

    fseek(input, 0, SEEK_END);
    size = ftell(input);
    fseek(input, 0, SEEK_SET);

    string = malloc(size);

    fread(string, 1, size, input);
    // printf("%s", string);
    return size;
}
