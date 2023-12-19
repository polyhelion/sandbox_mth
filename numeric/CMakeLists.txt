cmake_minimum_required(VERSION 3.8)
project(numeric)

set(CMAKE_CXX_STANDARD 20)

set(SOURCE_FILES minmaxavg.cxx)

SET(OPTIMIZE_FLAGS "-O2")
# SET(GCC_COVERAGE_COMPILE_FLAGS "-fprofile-arcs -ftest-coverage")
# SET(GCC_COVERAGE_LINK_FLAGS    "-lgcov")

SET(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} ${OPTIMIZE_FLAGS} -pthread -fopenmp")
# SET(CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS} ${GCC_COVERAGE_LINK_FLAGS}")


# set(Boost_USE_STATIC_LIBS OFF)
# set(Boost_USE_MULTITHREADED ON)
# set(Boost_USE_STATIC_RUNTIME OFF)
# find_package(Boost 1.65.1 COMPONENTS thread)

# if(Boost_FOUND)
#     include_directories(${Boost_INCLUDE_DIRS})
# endif

add_executable(minmaxavg ${SOURCE_FILES})

# target_link_libraries(playwpth ${Boost_LIBRARIES})

