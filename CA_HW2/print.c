#include <stdio.h>

extern char *string;

void print_result(char *path, int size) {
    FILE *output = fopen(path, "w+");

    int letters_count = 0, digits_count = 0;
    for (int i = 0; i < size; ++i) {
        char temp = string[i];
        if (temp >= '0' && temp <= '9') {
            ++digits_count;
        } else if (temp >= 'A' && temp <= 'Z' || temp >= 'a' && temp <= 'z') {
            ++letters_count;
        }
    }

    fprintf(output, "Letters: ");
    fprintf(output, "%d", letters_count);
    fprintf(output, "\n");
    fprintf(output, "Digits: ");
    fprintf(output, "%d", digits_count);
    fprintf(output, "\n");
}
