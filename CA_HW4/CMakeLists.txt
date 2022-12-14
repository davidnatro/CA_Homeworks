cmake_minimum_required(VERSION 3.23)
project(CSA_HW4)

set(CMAKE_CXX_STANDARD 17)

add_executable(CSA_HW4 main.cpp constants.h DataReader.cpp DataReader.h Library.cpp Library.h Utils.cpp Utils.h pthread_barrier.cpp pthread_barrier.h)
