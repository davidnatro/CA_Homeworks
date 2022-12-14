#include "stdio.h"

extern int InputArray[];
extern int ResultArray[];

void read_data(int arr_size, FILE *input) {
    int input_data;
    for (int i = 0; i < arr_size; ++i) {
        fscanf(input, "%d", &input_data);
        InputArray[i] = input_data;
    }

    // Так как переменная input_data больше не пригодится будем использовать её
    // в качестве флага wasNegative для экономии места на стеке.
    input_data = 0;
    for (int i = 0; i < arr_size; ++i) {
        if (InputArray[i] < 0) {
            input_data = 1;
        }
        if (input_data) {
            ResultArray[i] = InputArray[i];

        } else {
            if (InputArray[i] == 0) {
                ResultArray[i] = 1;
            } else {
                ResultArray[i] = InputArray[i];
            }
        }
    }
}
