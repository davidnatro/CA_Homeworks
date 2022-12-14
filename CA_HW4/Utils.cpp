#include "Utils.h"

bool Utils::isCorrectMenuChoice(int input) {
    return input == 1 || input == 2 || input == 3;
}

int Utils::getRandomNumber(int min, int max) {
    return rand() % (max + 1 - min) + min;
}