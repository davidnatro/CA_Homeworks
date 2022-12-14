#ifndef CSA_HW4_UTILS_H
#define CSA_HW4_UTILS_H

#include <cstdlib>

class Utils {
public:
    /**
     * Проверка ввода на корректность.
     * @param input Ввод.
     * @return true, если ввод корректен, иначе false.
     */
    static bool isCorrectMenuChoice(int input);

    /**
     * Генерация случайно целочисленного значения в диапазоне от min до max.
     * @param min Минимально возможное значение.
     * @param max Максимально возможное значение.
     * @return Случайно целочисленное число из диапазона от min до max.
     */
    static int getRandomNumber(int min, int max);
};


#endif//CSA_HW4_UTILS_H
