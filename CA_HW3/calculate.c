#include <math.h>
#include <stdio.h>

int factorial(int num) {
    int result = 1;

    for (int i = num; i >= 1; --i)
        result *= i;

    return result;
}

double numerator(double pow, int num) {
    double result = pow;

    for (int i = 1; i <= num; ++i)
        result *= (pow - i);


    return result;
}

double calculate(double x) {
    double m = 0.5;
    double result = 1 + m * x;
    double previous = result;

    int i = 1;
    int fact = 2;

    while (1) {
        result += numerator(m, i++) / factorial(fact) * pow(x, fact);
        ++fact;
        double chr = round(result * 100000.0) / 100000.0;
        double chp = round(previous * 100000.0) / 100000.0;
        if (!isfinite(chr)) {
            printf("Превышен лимит ожидания!");
            return 0;
        }
        if (fabs(chp - chr) < 0.005) {
            break;
        }
        previous = result;
    }

    return result;
}
