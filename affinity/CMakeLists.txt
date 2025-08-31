cmake_minimum_required(VERSION 3.8)
project(affinity)

set(CMAKE_CXX_STANDARD 20)

set(SOURCE_FILES corepin.cxx)

set(OPTIMIZE_FLAGS "-O2")
# SET(GCC_COVERAGE_COMPILE_FLAGS "-fprofile-arcs -ftest-coverage")
# SET(GCC_COVERAGE_LINK_FLAGS    "-lgcov")
# SET(DIAGNOSTIC_FLAGS "-g -static-libasan -Werror=all -Wextra -fsanitize=address,undefined")

set(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} ${OPTIMIZE_FLAGS} -pthread -Wall -Wextra -pedantic")
# SET(CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS} ${GCC_COVERAGE_LINK_FLAGS}")

add_executable(corepin ${SOURCE_FILES})

#target_link_libraries(playwpth ${Boost_LIBRARIES})
