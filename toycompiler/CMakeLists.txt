cmake_minimum_required(VERSION 3.16)

project(tcc)

file(GLOB SOURCE *.c)

add_executable(tcc ${SOURCE})