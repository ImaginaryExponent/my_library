cmake_minimum_required(VERSION 3.13 FATAL_ERROR)

project(my_library VERSION 0.1)

enable_testing()

add_library(my_library INTERFACE)
target_compile_features(my_library INTERFACE cxx_std_23)
target_compile_options(my_library INTERFACE $<$<CXX_COMPILER_ID:MSVC>:/Za>)
target_include_directories(my_library INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include> $<INSTALL_INTERFACE:include>)

target_sources(my_library INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/include/my_library/my_template.hpp)

add_subdirectory(tests)