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

# Set library directory
if(${CMAKE_BUILD_TYPE} STREQUAL "Debug")
    set(${MODULE_NAME}_BUILD_DIR debug)
else()
    set(${MODULE_NAME}_BUILD_DIR release)
endif()
set(${MODULE_NAME}_STATIC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/lib/${${MODULE_NAME}_BUILD_DIR})
set(${MODULE_NAME}_SHARED_DIR ${CMAKE_CURRENT_SOURCE_DIR}/bin/${${MODULE_NAME}_BUILD_DIR})
set(${MODULE_NAME}_IMPLIB_DIR ${CMAKE_CURRENT_SOURCE_DIR}/implib/${${MODULE_NAME}_BUILD_DIR})

if(${PROJECT_NAME}_BUILD_SHARED)
    # Add shared library
    add_library(${MODULE_NAME} SHARED IMPORTED GLOBAL)
    # imported location
    file(GLOB ${MODULE_NAME}_IMP_LOC "${${MODULE_NAME}_SHARED_DIR}/*${SHARED_LIB_SUFFIX}")
    if(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
        # imported implib need to be set on Windows
        file(GLOB ${MODULE_NAME}_IMP_LIB "${${MODULE_NAME}_IMPLIB_DIR}/*.lib")
        set_target_properties(
            ${MODULE_NAME}
            PROPERTIES
            IMPORTED_IMPLIB ${${MODULE_NAME}_IMP_LIB}
        )
    endif()
else()
    # Add static library
    add_library(${MODULE_NAME} STATIC IMPORTED)
    # imported location
    file(GLOB ${MODULE_NAME}_IMP_LOC "${${MODULE_NAME}_STATIC_DIR}/*${STATIC_LIB_SUFFIX}")
endif()

set_target_properties(
    ${MODULE_NAME}
    PROPERTIES
    IMPORTED_LOCATION ${${MODULE_NAME}_IMP_LOC}
)

target_include_directories(
    ${MODULE_NAME}
    INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/include
)

add_library(${MODULE_NS}::${MODULE_NAME} ALIAS ${MODULE_NAME})
message(STATUS "Build library `${MODULE_NS}::${MODULE_NAME}`")

# ==================================================
# Project development environment 

if(${PROJECT_NAME}_IS_MAIN)
    # Main
    add_subdirectory(main)
endif()

