function(make_easy_test)
  if (NOT DEFINED MAIN_TEMPLATE)
    message(FATAL_ERROR "Must have full path to the main.cpp.in specified in the MAIN_TEMPLATE")
  endif()

  if (NOT DEFINED MY_LIBRARY OR NOT TARGET ${MY_LIBRARY})
    message(FATAL_ERROR "Must have my_library as an available target")
  endif()

  cmake_parse_arguments(EASY_TEST "" "FILENAME;FUNCTION" "" ${ARGN})
  
  if (NOT DEFINED EASY_TEST_FILENAME)
    message(FATAL_ERROR "Must have test source file provided")
  endif()
  
  if (NOT DEFINED EASY_TEST_FUNCTION)
    message(FATAL_ERROR "Must have test function name provided")
  endif()

  get_filename_component(FILENAME ${EASY_TEST_FILENAME} NAME_WLE)
  set(TARGET test_${FILENAME}_${EASY_TEST_FUNCTION})
  set(TARGET_MAIN_CPP ${TARGET}_main.cpp)
  set(TEST_FUNCTION ${EASY_TEST_FUNCTION})
  configure_file(${MAIN_TEMPLATE} ${TARGET_MAIN_CPP} @ONLY)
  
  add_executable(${TARGET})
  target_sources(${TARGET} PRIVATE ${TARGET_MAIN_CPP})
  target_sources(${TARGET} PRIVATE ${EASY_TEST_FILENAME})
  target_link_libraries(${TARGET} PRIVATE ${MY_LIBRARY}) 
  
  add_test(${TARGET} ${TARGET})
endfunction()