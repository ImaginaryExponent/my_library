include( ${CMAKE_CURRENT_SOURCE_DIR}/cmake/MakeEasyTest.cmake)

set(MY_LIBRARY my_library)
set(MAIN_TEMPLATE ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp.in)

make_easy_test(FILENAME ${CMAKE_CURRENT_SOURCE_DIR}/my_test.cpp FUNCTION test_my_template_basic_types)
make_easy_test(FILENAME ${CMAKE_CURRENT_SOURCE_DIR}/my_test.cpp FUNCTION test_my_template_custom_types)