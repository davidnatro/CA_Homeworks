#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

extern void print_data(char *path, double data);

extern double read_data(char *path);

extern double calculate(double x);

double getRandomNumber() {
    return ((double) rand()) / RAND_MAX;
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
    double data;

    struct timespec start, end;
    int64_t elapsed_ns;

    srand(time(NULL));

    if (argc == 3) {
        if (strcmp(argv[1], "-random") == 0) {
            data = getRandomNumber();
            printf("Random value is: ");
            printf("%.5f\n", data);
        } else {
            data = read_data(argv[1]);
        }
        if (fabs(data) >= 1) {
            printf("На данном интервале степенной ряд расходится! Введите значение от -1 (не включительно) до 1 (не включительно)!\n");
            return 0;
        }
        data = round(data * 100000.0) / 100000.0;// Округление до 5 знаков после запятой
        clock_gettime(CLOCK_MONOTONIC, &start);
        data = calculate(data);
        clock_gettime(CLOCK_MONOTONIC, &end);
        print_data(argv[2], data);
    } else {
        printf("./main.exe <-random> <input file> <output file>\n");
        return 0;
    }

    elapsed_ns = timespecDiff(end, start);
    printf("Elapsed: %ld ns\n", elapsed_ns);

    return 0;
}
