cmake_minimum_required(VERSION 3.15)

# ==================================================
# Project

project(
    AyBin
    VERSION 0.1.0
    LANGUAGES CXX
)

# Module: namespace::name
set(MODULE_NAME aybin)
set(MODULE_NS ayin)

# ==================================================

# Project options
include(cmake/Options.cmake)
# Utils 
include(cmake/Utils.cmake)
# Init cmake environment
include(cmake/Init.cmake)

# ==================================================
# Module library

if(${PROJECT_NAME}_BUILD_SHARED)
    add_library(${MODULE_NAME} SHARED IMPORTED GLOBAL)
else()
    add_library(${MODULE_NAME} STATIC IMPORTED)
endif()

target_include_directories(
    ${MODULE_NAME}
    PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include
)

add_library(${MODULE_NS}::${MODULE_NAME} ALIAS ${MODULE_NAME})
message(STATUS "Build library `${MODULE_NS}::${MODULE_NAME}`")

# ==================================================
# Project development environment 

if(${PROJECT_NAME}_IS_MAIN)
    # Main
    add_subdirectory(main)
endif()

