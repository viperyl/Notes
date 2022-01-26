cmake_minimum_required(VERSION 3.21)
project(Temp)

set(CMAKE_CXX_STANDARD 20)

add_executable(Temp main.cpp)

find_package(OpenCV REQUIRED)

include_directories(${OpenCV_INCLUDE_DIRS})
target_link_libraries(Temp ${OpenCV_LIBS})