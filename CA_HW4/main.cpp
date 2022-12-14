#include "DataReader.h"
#include "Library.h"
#include "Utils.h"
#include "constants.h"
#include "pthread_barrier.h"
#include <iostream>
#include <list>
#include <pthread.h>
#include <string>
#include <unistd.h>

using std::cin;
using std::cout;

pthread_mutex_t mutex;
pthread_barrier_t barrier;

void *start(void *args) {
    Library *library = ((Library *) args);

    Library::Coordinates coordinates{0, 0, 0};

    while (coordinates.row != -1) {
        pthread_mutex_lock(&mutex);
        if (library->get(coordinates.row, coordinates.shelf, coordinates.book) == 0) {
            library->set(coordinates.row, coordinates.shelf, coordinates.book, library->index);
            library->index += 1;
        }
        coordinates = library->getNextBook();
        pthread_mutex_unlock(&mutex);
        sleep(0);
    }

    pthread_barrier_wait(&barrier);
    pthread_exit(nullptr);
}

int main(int argc, char **argv) {
    int rows, shelves, books;

    cout << MENU;

    int menuChoice;
    cin >> menuChoice;
    if (!Utils::isCorrectMenuChoice(menuChoice)) {
        cout << INCORRECT_INPUT;
        return 0;
    }

    std::string outputPath;

    if (menuChoice == 1) {
        int code = DataReader::readFromConsole(rows, shelves, books);
        if (code == 1) {
            cout << INVALID_VALUE;
            return 0;
        }
    } else if (menuChoice == 2) {
        int code = DataReader::readFromFile(rows, shelves, books);
        if (code == 1) {
            cout << FILE_NOT_FOUND;
            return 0;
        } else if (code == 2) {
            cout << INVALID_VALUE;
            return 0;
        }
        cout << "Введите путь до выходного файла: ";
        cin >> outputPath;
        std::ofstream  f_out(outputPath);
        if (!f_out.is_open()) {
            cout << FILE_NOT_FOUND;
            return 0;
        }
        f_out.close();
    } else if (menuChoice == 3) {
        DataReader::readFromRandom(rows, shelves, books);
    }

    Library *library = new Library(rows, shelves, books);

    pthread_mutex_init(&mutex, nullptr);
    pthread_barrier_init(&barrier, nullptr, 6);

    pthread_t threads[5];
    for (pthread_t &thread: threads) {
        pthread_create(&thread, nullptr, start, (void *) library);
    }

    pthread_barrier_wait(&barrier);
    pthread_barrier_destroy(&barrier);

    pthread_mutex_destroy(&mutex);

    std::ofstream f_out(outputPath);
    if (outputPath.empty()) {
        cout << *library;
    } else {
        f_out << *library;
    }

    delete library;

    return 0;
}
