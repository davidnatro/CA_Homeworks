#include "stdio.h"

extern int ResultArray[];

void print_data(int arr_size, FILE *output) {
    fprintf(output, "Result: ");
    for (int i = 0; i < arr_size; ++i) {
        fprintf(output, "%d", ResultArray[i]);
        fprintf(output, " ");
    }
    fprintf(output, "\n");
}
