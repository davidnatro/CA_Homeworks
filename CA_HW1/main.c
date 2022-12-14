#include <stdio.h>

int InputArray[1000];
int ResultArray[1000];

extern void read_data(int arr_size, FILE *input);

extern void print_data(int arr_size, FILE *output);

int main(int argc, char **argv) {
    int arr_size;

    FILE *input, *output;
    if (argc != 3) {
        printf("./main.exe <input file> <output file>!\n");
        return 0;
    }

    input = fopen(argv[1], "r");
    output = fopen(argv[2], "w");

    fscanf(input, "%d", &arr_size);

    if (arr_size <= 0 || arr_size > 999 {
	printf("Wrong array size!\n");
	return 0;
    }

    read_data(arr_size, input);

    print_data(arr_size, output);

    return 0;
}
