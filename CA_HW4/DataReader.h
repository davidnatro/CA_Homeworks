#ifndef CSA_HW4_DATAREADER_H
#define CSA_HW4_DATAREADER_H

#include <fstream>
#include <iostream>

/**
 * Класс, отвечающий за чтение данных.
 */
class DataReader {
public:
    /**
     * Чтение значений из консоли.
     * @param rows Количество рядов.
     * @param shelves Количество шкафов.
     * @param books Количество книг.
     */
    static int readFromConsole(int &rows, int &shelves, int &books);

    /**
     * Чтение значений из файла.
     * @param rows Количество рядов.
     * @param shelves Количество шкафов.
     * @param books Количество книг.
     */
    static int readFromFile(int &rows, int &shelves, int &books);

    /**
    * Генерация рандомных значений.
    * @param rows Количество рядов.
    * @param shelves Количество шкафов.
    * @param books Количество книг.
    */
    static int readFromRandom(int &rows, int &shelves, int &books);
};


#endif//CSA_HW4_DATAREADER_H
