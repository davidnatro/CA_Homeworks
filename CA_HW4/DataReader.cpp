#include "DataReader.h"
#include "Utils.h"

int DataReader::readFromConsole(int &rows, int &shelves, int &books) {
    std::cout << "Количество рядов: ";
    std::cin >> rows;
    std::cout << "Количество полок: ";
    std::cin >> shelves;
    std::cout << "Количество книг: ";
    std::cin >> books;

    if ((rows < 1 || rows > 50) || (shelves < 1 || shelves > 50) || (books < 1 || books > 50)) {
        return 1;
    }

    return 0;
}

int DataReader::readFromFile(int &rows, int &shelves, int &books) {
    std::string path;
    std::cout << "Введите путь до входного файла: ";
    std::cin >> path;
    std::ifstream f_in(path);
    if (!f_in.is_open()) {
        return 1;
    }

    f_in >> rows >> shelves >> books;

    if ((rows < 1 || rows > 50) || (shelves < 1 || shelves > 50) || (books < 1 || books > 50)) {
        return 2;
    }
    return 0;
}

int DataReader::readFromRandom(int &rows, int &shelves, int &books) {
    srand(time(nullptr));
    rows = Utils::getRandomNumber(1, 50);
    shelves = Utils::getRandomNumber(1, 50);
    books = Utils::getRandomNumber(1, 50);

    std::cout << "Рядов: " << rows << "\n";
    std::cout << "Шкафов: " << shelves << "\n";
    std::cout << "Книг: " << books << "\n";
}
