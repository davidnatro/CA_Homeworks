#include <stdio.h>

double read_data(char *path) {
    FILE *file = fopen(path, "r");
    double result;
    fscanf(file, "%lf", &result);
    return result;
}
