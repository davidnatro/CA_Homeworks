#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

char *string;

extern int read_data(FILE *input);

extern void print_result(char *path, int size);

int getRandomNumber(int min, int max) {
    return rand() % (max + 1 - min) + min;
}

int64_t timespecDiff(struct timespec timeA, struct timespec timeB) {
    int64_t nsecA, nsecB;

    nsecA = timeA.tv_sec;
    nsecA *= 1000000000;
    nsecA += timeA.tv_nsec;


    nsecB = timeB.tv_sec;
    nsecB *= 1000000000;
    nsecB += timeB.tv_nsec;

    return nsecA - nsecB;
}

int main(int argc, char **argv) {
    int size;
    FILE *input;

    struct timespec start;
    struct timespec end;
    int64_t elapsed_ns;

    srand(time(NULL));

    if (argc == 3) {
        if (strcmp(argv[1], "-random") == 0) {
            size = getRandomNumber(10000, 500000);
            string = malloc(size * sizeof(char));
            for (int i = 0; i < size; ++i) {
                string[i] = (char) getRandomNumber(48, 126);
            }
            clock_gettime(CLOCK_MONOTONIC, &start);
            print_result(argv[2], size);
            clock_gettime(CLOCK_MONOTONIC, &end);
        } else {
            input = fopen(argv[1], "rb");
            if (!input) {
                printf("Input file doesn't exist!\n");
                return 0;
            }
            size = read_data(input);
            clock_gettime(CLOCK_MONOTONIC, &start);
            print_result(argv[2], size);
            clock_gettime(CLOCK_MONOTONIC, &end);
        }
    } else {
        printf("./main.exe <-random> <input file> <output file>\n");
        return 0;
    }

    elapsed_ns = timespecDiff(end, start);
    printf("Elapsed: %ld ns\n", elapsed_ns);

    free(string);

    return 0;
}
