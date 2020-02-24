cmake_minimum_required(VERSION 3.16)
project(ci-tester VERSION 0.1.0)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED)

set(CMAKE_EXPORT_COMPILE_COMMANDS "ON")

option(STATIC_BUILD "Build static libs and executables" "OFF")
option(ENABLE_CLANG_TIDY "Run clang-tidy against all source files included in the build" "OFF")
option(ENABLE_CLANG_FORMAT "Run clang-format against all source files included in the build" "OFF")

enable_testing()

if(EXISTS "${CMAKE_BINARY_DIR}/conanbuildinfo.cmake")
  include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
  conan_basic_setup()
else()
  set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
endif()


# Code quality cmake modules
if(EXISTS "${CMAKE_SOURCE_DIR}/cmake/unit_test.cmake")
  #include(${CMAKE_SOURCE_DIR}/cmake/unit_test.cmake)
endif()
if(EXISTS "${CMAKE_SOURCE_DIR}/cmake/clang_tools.cmake")
  include(${CMAKE_SOURCE_DIR}/cmake/clang_tools.cmake)
endif()
if(EXISTS "${CMAKE_SOURCE_DIR}/cmake/cppcheck.cmake")
  include(${CMAKE_SOURCE_DIR}/cmake/cppcheck.cmake)
endif()

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wno-sign-compare")

option(WERROR "Turn warnings into errors" OFF)
if (WERROR)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Werror")
endif ()

if(STATIC_BUILD)
  set(CMAKE_EXE_LINKER_FLAGS "-static -static-libstdc++")
  set(CMAKE_LIBRARY_LINKER_FLAGS "-static -static-libstdc++")
endif()

add_subdirectory(src)

