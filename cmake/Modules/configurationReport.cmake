#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Copyright (c) 2020-2021 Enrico Sorichetti
#   Distributed under the Boost Software License, Version 1.0.
#   (See accompanying file BOOST_LICENSE_1_0.txt or copy at
#   http://www.boost.org/LICENSE_1_0.txt)

include_guard( GLOBAL )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include( getProgramVersion )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
if( CMAKE_WARNINGS )
  message( "" )
  message( STATUS "" )
  message( STATUS "NOTES / WARNINGS :" )
  foreach( _warn ${CMAKE_WARNINGS} )
    message( STATUS "  ${_warn}" )
  endforeach()
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
message( "" )
message( STATUS "" )
message( STATUS "configuration summary for project   : ${PROJECT}" )
message( STATUS "  version ......................... : ${VERSION}" )
message( STATUS "  version string................... : ${VERSION_STRING}" )

message( STATUS "" )
if( DEFINED RCS_WC_REVISION )
  message( STATUS "  RCS ............................. : ${RCS_NAME} - ${RCS_VERSION}" )
  message( STATUS "  RCS revision (commits count) .... : ${RCS_WC_REVISION}" )
  message( STATUS "  RCS revision timestamp .......... : ${RCS_WC_TIMESTAMP}" )
  if( RCS_WC_DIRTY )
    message( STATUS "  RCS hash ........................ : ${RCS_WC_HASH} dirty" )
  else()
    message( STATUS "  RCS hash ........................ : ${RCS_WC_HASH} clean" )
  endif()
  message( STATUS "" )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
if( REQUIRES_LIBRARIES )
  message( STATUS "  requires libraries .............. : ${REQUIRES}" )
  set( _desc      "    found ......................... :" )
  foreach( _item ${REQUIRES_LIBRARIES} )
    message( STATUS "${_desc} ${_item} - ${${_item}_VERSION}" )
    set( _desc  "                                    :" )
  endforeach()
  message( STATUS "" )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
if( PROVIDES )
  message( STATUS "  provides libraries .............. : ${PROVIDES}" )
  foreach( _item ${PROVIDES} )
  endforeach()
  message( STATUS "" )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
if( PROJECT_TEMPLATES )
  message( STATUS "  templates ....................... : ${PROJECT_TEMPLATES}" )
  message( STATUS "" )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
message( STATUS "  build type ...................... : ${CMAKE_BUILD_TYPE}" )
message( STATUS "  word size ....................... : ${ARCHITECTURE}" )
message( STATUS "  byte order ...................... : ${ENDIANNESS}" )

message( STATUS "  install prefix .................. : ${INST_PREFIX}" )
if( INST_BIN_DIR )
  message( STATUS "    executables ................... : ${INST_BIN_DIR}" )
endif()
if( INST_INC_DIR )
  message( STATUS "    include ....................... : ${INST_INC_DIR}" )
endif()
if( INST_LIB_DIR )
  message( STATUS "    libraries ..................... : ${INST_LIB_DIR}" )
endif()
if( INST_MOD_DIR )
  message( STATUS "    modules ....................... : ${INST_MOD_DIR}" )
  message( STATUS "    modules (qualified) ........... : ${INST_MOD_DIR_QUALIFIED}" )
endif()
if( INST_SHR_DIR )
  message( STATUS "    data .......................... : ${INST_SHR_DIR}" )
  message( STATUS "    data (qualified) .............. : ${INST_SHR_DIR_QUALIFIED}" )
endif()
message( STATUS "" )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
message( STATUS "  CMake version ................... : ${CMAKE_VERSION}" )
set( _desc      "  CMake modules path .............. :" )
foreach( _item ${CMAKE_MODULE_PATH} )
  message( STATUS "${_desc} ${_item}" )
  set( _desc  "                                    :" )
endforeach()
message( STATUS "" )

if( PKG_CONFIG_EXECUTABLE )
  message( STATUS "  pkg-config ...................... : ${PKG_CONFIG_EXECUTABLE} - ${PKG_CONFIG_VERSION_STRING}" )
endif()
if( NOT DEFINED PKG_CONFIG_PATH )
  set( PKG_CONFIG_PATH "$ENV{PKG_CONFIG_PATH}" )
endif()
if( PKG_CONFIG_PATH )
  string( REGEX REPLACE "[:]" ";" PKG_CONFIG_PATH "${PKG_CONFIG_PATH}" )
  set( _desc      "  pkg-config path(s) .............. :" )
  foreach( _item ${PKG_CONFIG_PATH} )
    message( STATUS "${_desc} ${_item}" )
    set( _desc  "                                    :" )
  endforeach()
endif()
message( STATUS "" )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
get_program_version( "${CMAKE_BUILD_TOOL}" )
get_filename_component( _name "${CMAKE_BUILD_TOOL}" NAME_WE )
string( TOUPPER "${_name}" _name )
message( STATUS "  generator ....................... : ${CMAKE_GENERATOR}" )
message( STATUS "  generator program ............... : ${CMAKE_BUILD_TOOL} - ${${_name}_VERSION_STRING}" )
message( STATUS "" )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
if( CCACHE )
  get_program_version( "${CCACHE}" )
  get_filename_component( _name "${CCACHE}" NAME_WE )
  string( TOUPPER "${_name}" _name )
  message( STATUS "  ccache program .................. : ${CCACHE} - ${${_name}_VERSION_STRING}" )
  message( STATUS "" )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
if( RE2C )
  get_program_version( "${RE2C}" )
  get_filename_component( _name "${RE2C}" NAME_WE )
  string( TOUPPER "${_name}" _name )
  message( STATUS "  re2c ............................ : ${RE2C} - ${${_name}_VERSION_STRING}" )
  message( STATUS "" )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
if( LEMON )
  get_program_version( "${LEMON}" )
  get_filename_component( _name "${LEMON}" NAME_WE )
  string( TOUPPER "${_name}" _name )
  message( STATUS "  lemon ........................... : ${LEMON} - ${${_name}_VERSION_STRING}" )
  message( STATUS "" )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
if( FLEX )
  get_program_version( "${FLEX}" )
  get_filename_component( _name "${FLEX}" NAME_WE )
  string( TOUPPER "${_name}" _name )
  message( STATUS "  flex ............................ : ${FLEX} - ${${_name}_VERSION_STRING}" )
  message( STATUS "" )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
if( YACC )
  get_program_version( "${YACC}" )
  get_filename_component( _name "${YACC}" NAME_WE )
  string( TOUPPER "${_name}" _name )
  message( STATUS "  yacc ............................ : ${YACC} - ${${_name}_VERSION_STRING}" )
  message( STATUS "" )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
if( BISON_EXECUTABLE )
  get_program_version( "${BISON_EXECUTABLE}" )
  get_filename_component( _name "${BISON_EXECUTABLE}" NAME_WE )
  string( TOUPPER "${_name}" _name )
  message( STATUS "  bison ........................... : ${BISON_EXECUTABLE} - ${${_name}_VERSION_STRING}" )
  message( STATUS "" )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
get_property( _languages GLOBAL PROPERTY ENABLED_LANGUAGES )
if( _languages )
  message( STATUS "  enabled languages ............... : ${_languages}" )
  message( STATUS "" )

  message( STATUS "  IPO enabled ...............       : ${HAVE_IPO_SUPPORT}" )
  message( STATUS "" )

  foreach( _lang ${_languages} )
    string( SUBSTRING "${_lang}   " 0 4 _text )
    message( STATUS "  ${_text}compiler .................... : ${CMAKE_${_lang}_COMPILER}" )
    message( STATUS "  ${_text}compiler ID ................. : ${CMAKE_${_lang}_COMPILER_ID}" )
    message( STATUS "  ${_text}compiler VERSION ............ : ${CMAKE_${_lang}_COMPILER_VERSION}" )
    # message( STATUS "" )
    if( "${CMAKE_BUILD_TYPE}" STREQUAL "" )
      string( TOUPPER "CMAKE_${_lang}_FLAGS" _flags )
    else()
      string( TOUPPER "CMAKE_${_lang}_FLAGS_${CMAKE_BUILD_TYPE}" _flags )
    endif()
    message( STATUS "  ${_text}compiler flags .............. : ${${_flags}}" )
    message( STATUS "" )
  endforeach()
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
get_property( _opts DIRECTORY PROPERTY COMPILE_OPTIONS )
if( _opts )
  message( STATUS "  compile options ................. : ${_opts}" )
  message( STATUS "" )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
get_property( _defs DIRECTORY PROPERTY COMPILE_DEFINITIONS )
if( _defs )
  message( STATUS "  compile definitions ............. : ${_defs}" )
  message( STATUS "" )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
get_property( _dirs DIRECTORY PROPERTY INCLUDE_DIRECTORIES )
if( _dirs )
  set( _desc      "  include directories ............. :" )
  foreach( _dir ${_dirs} )
  message( STATUS "${_desc} ${_dir}" )
    set( _desc  "                                    :" )
  endforeach()
  message( STATUS "" )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
get_property( _dirs GLOBAL PROPERTY LINK_DIRECTORIES )
if( _dirs )
  set( _desc      "  link directories ............... :" )
  foreach( _dir ${_dirs} )
    message( STATUS "${_desc} ${_dir}" )
    set( _desc  "                                    :" )
  endforeach()
  message( STATUS "" )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
message( STATUS "  user options .................... :" )
message( STATUS "" )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
message( STATUS "end of configuration summary" )
message( STATUS "" )
message( "" )

