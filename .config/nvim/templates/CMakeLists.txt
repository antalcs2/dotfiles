cmake_minimum_required(VERSION 3.28)
project(proj_name)

set(CMAKE_CXX_STANDARD cpp_version)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_executable(${PROJECT_NAME} main.cpp)
