#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Copyright (c) 2020-2023 Enrico Sorichetti
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file BOOST_LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt)

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
message( STATUS "CMake version  '${CMAKE_VERSION}'" )
message( STATUS "Processing     '${CMAKE_CURRENT_LIST_FILE}'" )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if( CMAKE_VERSION VERSION_LESS  3.25 )
  message( FATAL_ERROR "
 CMake '3.25' or higher is required,
 You are running '${CMAKE_VERSION}'" )
endif()
cmake_minimum_required( VERSION ${CMAKE_VERSION} )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if( NOT DEFINED ENV{CMTK} )
  message( FATAL_ERROR "
 unable to locate the cmToolKit directory" )
endif()

set( CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR} )
list( APPEND CMAKE_MODULE_PATH "$ENV{CMTK}/cmake/Modules" )
set( TEMPL_SOURCE_PATH ${CMAKE_SOURCE_DIR} )
list( APPEND TEMPL_SOURCE_PATH "$ENV{CMTK}/cmake/Templates" )

include( vDump )
include( vDrop )
include( vSnap )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# deprecate 'in-source' builds ( source directory/subdirectories )
# if You accidentally try an 'in-source' build
# You will have to manually clean up the leftovers :
# file 'CMakeCache.txt' and directory 'CMakeFiles'

set( CMAKE_DISABLE_IN_SOURCE_BUILD ON )
set( CMAKE_DISABLE_SOURCE_CHANGES  ON )

get_filename_component( _s "${CMAKE_SOURCE_DIR}" REALPATH )
string( TOLOWER "${_s}" _s )

get_filename_component( _b "${CMAKE_BINARY_DIR}" REALPATH )
string( TOLOWER "${_b}" _b )

if( ( "${_b}" STREQUAL "${_s}" ) OR
    ( "${_b}" MATCHES  "${_s}/" ) )
  message( FATAL_ERROR "
 binary directory '${CMAKE_BINARY_DIR}'
 source directory '${CMAKE_SOURCE_DIR}'
 builds that modify the source directory/subdirectories are not allowed,
 remove file 'CMakeCache.txt' and directory 'CMakeFiles' " )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# must come before the project command
# lowest macOS supported 10.13.6 High Sierra
if( APPLE AND BUILD_UNIVERSAL_BINARIES )
  set( CMAKE_OSX_DEPLOYMENT_TARGET 10.13.6 CACHE STRING  "" FORCE)
  add_compile_options( -Wunguarded-availability )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
set( PROJECT cmToolKit )

set( VERSION_TRIPLET 1.0.0 )
set( DESCRIPTION "cmToolKit" )
set( VARIANT )
set( PROVIDES )
set( REQUIRES )
set( SOVERSION )

set( SRCDIR src )
set( INCDIR c )

project( ${PROJECT}
  VERSION ${VERSION_TRIPLET}
  LANGUAGES C CXX
)
set( VERSION_STRING "${VERSION_TRIPLET}" )
set( VERSION_STRING "${VERSION_STRING}-${CMAKE_SYSTEM_PROCESSOR}" )

include( rcsInfo)
set( VERSION_STRING "${VERSION_STRING} ${RCS_WC_REVISION_STRING}" )

string( TIMESTAMP BUILD_DATE  %Y/%m/%d )
string( TIMESTAMP BUILD_TIME  %H:%M:%S )
string( TIMESTAMP BUILD_TIMESTAMP %Y/%m/%d-%H:%M:%S )
set( VERSION_STRING "${VERSION_STRING} ${BUILD_TIMESTAMP}" )

message( STATUS "Building ${PROJECT} ${VERSION_STRING}" )
add_compile_definitions(
  VERSION_STRING="${VERSION_STRING}" )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
OPTION( WITH_IPO      ""  ON )
option( WITH_CCACHE   ""  ON )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if( APPLE AND BUILD_UNIVERSAL_BINARIES )
  set( CMAKE_OSX_ARCHITECTURES arm64 x86_64 )
  set( VERSION_STRING "${VERSION_STRING}-universal++" )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
set( CMAKE_C_STANDARD 11 )
set( CMAKE_C_STANDARD_REQUIRED YES )
set( CMAKE_CXX_STANDARD 11 )
set( CMAKE_CXX_STANDARD_REQUIRED YES )

set( CMAKE_POSITION_INDEPENDENT_CODE ON )
set( CMAKE_EXPORT_COMPILE_COMMANDS  ON )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
set( SYSTEM_NAME "${CMAKE_HOST_SYSTEM_NAME}" )
string( TOUPPER "${SYSTEM_NAME}" SYSTEM_NAME_UC  )
set( "${SYSTEM_NAME_UC}" 1 )
add_compile_definitions(
  ${SYSTEM_NAME_UC}
)

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# setup the install paths according to the GNU standards
include( installDirectories )

set( CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/${INST_BIN_DIR}" )
set( CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/${INST_LIB_DIR}" )
set( CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/${INST_LIB_DIR}" )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# the compiler flags
include( defaultCompilerFlags )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# rpath handling
set( CMAKE_SKIP_BUILD_RPATH  FALSE )
set( CMAKE_BUILD_WITH_INSTALL_RPATH FALSE )
set( CMAKE_INSTALL_RPATH "@executable_path/../${INST_LIB_DIR}" )
set( CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
option( BUILD_SHARED  ""  ON )
option( BUILD_STATIC  ""  ON )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
option( WITH_CCACHE   ""  ON )
if( WITH_CCACHE )
  include( ccache )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
option( WITH_IPO      ""  ON )
if( WITH_IPO )
  include( CheckIPOSupported )
  check_ipo_supported( RESULT HAVE_IPO_SUPPORT )
  if ( HAVE_IPO_SUPPORT )
    message( STATUS "IPO is Supported and Enabled" )
  endif()
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
include( CheckIncludeFile )
include( checkHeader )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# we assume that the system has the ISO/IEC headers and terminate if not
include( isoHeaders )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# check for __int128_t
include( checkType )
type_is_defined( __int128_t )
# type_get_size( __int128_t )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# functions
include( CheckFunctionExists )
include( checkFunction )

# the builtins
include( __builtin_bswap )
include( __builtin_clz )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# attributes
include( inlineAttr )
include( threadLocalAttr )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include( CheckTypeSize )
check_type_size( __int128 INT128_T )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include_directories(
  ${CMAKE_BINARY_DIR}
  ${CMAKE_SOURCE_DIR}
  ${CMAKE_SOURCE_DIR}/${INCDIR}
)

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   platform.h
if( EXISTS ${CMAKE_SOURCE_DIR}/platform.h.in )
  configure_file( ${CMAKE_SOURCE_DIR}/platform.h.in
    ${CMAKE_BINARY_DIR}/platform.h
  )
  add_compile_definitions(
    HAVE_PLATFORM_H
  )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# sources
include( ${PACKAGE}_SRCS )

# headers
include( ${PACKAGE}_HDRS )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   the libraries ( SHARED/STATIC )
include( buildLibraries )

build_object( ${PACKAGE} )

if( BUILD_SHARED )
  build_shared_library( ${PACKAGE} )
endif()

if( BUILD_STATIC )
  build_static_library( ${PACKAGE} )
endif()

add_library( ${PACKAGE}_IFACE INTERFACE
  ${${PACKAGE}_HDRS}
)
set_property( TARGET ${PACKAGE}_IFACE
  PROPERTY
  PUBLIC_HEADER ${${PACKAGE}_HDRS}
)
install( TARGETS ${PACKAGE}_IFACE
  PUBLIC_HEADER DESTINATION ${INST_INC_DIR}
)

if( TRUE )
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# ${PACKAGE}.pc ( extra locations )
macro( install_pc pkg )
  if( EXISTS ${CMAKE_BINARY_DIR}/${pkg}.pc )
    set( PKG_CONFIG_PATH "$ENV{PKG_CONFIG_PATH}" )
    if( PKG_CONFIG_PATH )
      string( REGEX REPLACE "[:]" ";" PKG_CONFIG_PATH "${PKG_CONFIG_PATH}")
      list( GET PKG_CONFIG_PATH 0 PKG_CONFIG_PATH )
      if( IS_DIRECTORY  ${PKG_CONFIG_PATH} )
        install( FILES ${CMAKE_BINARY_DIR}/${pkg}.pc
          DESTINATION ${PKG_CONFIG_PATH}
        )
      endif()
    endif()
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    #
    get_filename_component( _root ${CMAKE_SOURCE_DIR} DIRECTORY )
    install( FILES ${CMAKE_BINARY_DIR}/${pkg}.pc
      DESTINATION ${_root}/${INST_LIB_DIR}/pkgconfig
    )
  endif()
endmacro()

if( BUILD_SHARED )
  install_pc( ${PACKAGE} )
endif()
if( BUILD_STATIC )
  install_pc( ${PACKAGE}_STATIC )
endif()

endif( TRUE )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   the uninstaller
configure_file( cmake_uninstall.cmake.in
  ${CMAKE_BINARY_DIR}/cmake_uninstall.cmake
  IMMEDIATE @ONLY )
add_custom_target( uninstall
  COMMAND ${CMAKE_COMMAND} -P ${CMAKE_BINARY_DIR}/cmake_uninstall.cmake )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include( configurationReport )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
vdump( "main" "exit" )
