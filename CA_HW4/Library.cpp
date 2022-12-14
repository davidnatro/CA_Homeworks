#include "Library.h"

std::ostream &operator<<(std::ostream &stream, const Library &library) {
    stream << "Библиотека:\n";
    for (int i = 0; i < library.data.size(); ++i) {
        stream << "Ряд №" << i + 1 << ": { ";
        for (int j = 0; j < library.data[i].size(); ++j) {
            stream << "{ ";
            for (int k = 0; k < library.data[i][j].size(); ++k) {
                stream << library.data[i][j][k];
                if (k != library.data[i][j].size() - 1) {
                    stream << ", ";
                } else {
                    stream << " ";
                }
            }
            if (j != library.data[i].size() - 1) {
                stream << "}, ";
            } else {
                stream << "}";
            }
        }

        stream << " }\n";
    }
    return stream;
}

Library::Library(int rows, int shelves, int books) {
    this->rows = rows;
    this->shelves = shelves;
    this->books = books;

    data.resize(rows);
    for (int i = 0; i < data.capacity(); ++i) {
        data[i] = std::vector<std::vector<int>>(shelves, std::vector<int>(books, 0));
    }
}

Library::Coordinates Library::getNextBook() {
    auto lib = getLibrary();
    for (int i = 0; i < lib.size(); ++i) {
        for (int j = 0; j < lib[i].size(); ++j) {
            for (int k = 0; k < lib[i][j].size(); ++k) {
                if (lib[i][j][k] == 0) {
                    return Coordinates{i, j, k};
                }
            }
        }
    }
    return Coordinates{-1, -1, -1};
}

int &Library::get(const int row, const int shelf, const int book) {
    return data[row][shelf][book];
}

int Library::get(const int row, const int shelf, const int book) const {
    return data[row][shelf][book];
}

void Library::set(const int row, const int shelf, const int book, const int value) {
    data[row][shelf][book] = value;
}

std::vector<std::vector<std::vector<int>>> &Library::getLibrary() {
    return data;
}