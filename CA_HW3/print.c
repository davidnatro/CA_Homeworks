#include <stdio.h>

void print_data(char *path, double data) {
    FILE *file = fopen(path, "w");

    fprintf(file, "%.5f\n", data);
}
