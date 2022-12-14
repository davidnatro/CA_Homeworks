#ifndef CSA_HW4_LIBRARY_H
#define CSA_HW4_LIBRARY_H

#include <iostream>
#include <vector>

class Library {
public:
    struct Coordinates {
        int row;
        int shelf;
        int book;
    };

private:
    std::vector<std::vector<std::vector<int>>> data;

    int rows;
    int shelves;
    int books;

public:
    int index = 1;

    Library(int rows, int shelves, int books);

    /**
     * Получение вектора библиотеки.
     * @return Библиотека.
     */
    std::vector<std::vector<std::vector<int>>> &getLibrary();

    /**
     * Получение книги по ссылке.
     * @param row Номер столбца.
     * @param shelf Номер полки.
     * @param book Номер книги.
     * @return Ссылка на книгу.
     */
    int &get(int row, int shelf, int book);

    /**
     * Получение книги по значению
     * @param row Номер столбца.
     * @param shelf Номер полки.
     * @param book Номер книги.
     * @return Книга.
     */
    int get(int row, int shelf, int book) const;

    /**
     * Устанавливает книгу на полку.
     * @param row Номер ряда.
     * @param shelf Номер полки.
     * @param book Номер книги.
     * @param value Книга.
     * @return
     */
    void set(int row, int shelf, int book, int value);

    Coordinates getNextBook();

    friend std::ostream &operator<<(std::ostream &stream, const Library &library);
};


#endif//CSA_HW4_LIBRARY_H
