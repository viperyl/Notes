cmake_minimum_required(VERSION 3.21)
project(SLAM14)
set(CMAKE_CXX_STANDARD 17)

add_executable(SLAM14 main.cpp)

find_package(OpenCV REQUIRED )
find_package(Eigen3 REQUIRED)
find_package(PCL 1.3 REQUIRED COMPONENTS common io)

include_directories(${PCL_INCLUDE_DIRS})
include_directories("/usr/include/eigen3")
include_directories( ${OpenCV_INCLUDE_DIRS} )

link_directories(${PCL_LIBRARY_DIRS})
link_directories(${Eigen_INCLUDE_DIRS})

target_link_libraries(SLAM14 ${OpenCV_LIBS} )
target_link_libraries(SLAM14 ${PCL_LIBRARIES})
add_definitions(${PCL_DEFINITIONS})

