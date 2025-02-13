# Init cmake environment
# 

# Check porject is main or sub project
if("${CMAKE_CURRENT_SOURCE_DIR}" STREQUAL "${CMAKE_SOURCE_DIR}")
    set(${PROJECT_NAME}_IS_MAIN 1)
endif()

# Set C++ standard
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
#set(CMAKE_CXX_EXTENSIONS OFF)

# fPIC
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# Init build type
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
endif()

if(${CMAKE_BUILD_TYPE} STREQUAL "Debug")
    # Keep debug macro same as Windows
    add_definitions(-D_DEBUG)
endif()

if(${PROJECT_NAME}_IS_MAIN)
    # Set postfix for debug binary file
    # ex. proj.dll -> proj_d.dll
    set(CMAKE_DEBUG_POSTFIX _d)

    # Set cmake output directory
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}/debug)
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/debug)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/debug)

    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}/release)
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/release)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/release)
endif()

# Init lib suffix
if(${CMAKE_SYSTEM_NAME} MATCHES "Linux" OR ${CMAKE_SYSTEM_NAME} MATCHES "Android")
    set(SHARED_LIB_SUFFIX ".so")
    set(STATIC_LIB_SUFFIX ".a")
elseif(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
    set(SHARED_LIB_SUFFIX ".dll")
    set(STATIC_LIB_SUFFIX ".lib")
elseif(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    set(SHARED_LIB_SUFFIX ".dylib")
    set(STATIC_LIB_SUFFIX ".a")
else()
    message(FATAL_ERROR "Unknown platform: ${CMAKE_SYSTEM_NAME}" )
    set(SHARED_LIB_SUFFIX "")
    set(STATIC_LIB_SUFFIX "")
endif()

if(${PROJECT_NAME}_IS_MAIN)
    message(STATUS "Main project: ${PROJECT_NAME}")
    message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")
endif()
