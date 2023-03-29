#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Copyright (c) 2020-2023 Enrico Sorichetti
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file BOOST_LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt)

include_guard( GLOBAL )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
macro( check_RCS _rcs)
  string( TOUPPER "${_rcs}_REPOSITORY" RCS_flag )
  set( "${RCS_flag}" TRUE )
  set( RCS_path "${CMAKE_SOURCE_DIR}" )
  vsnap( RCS_path )

  while( NOT ( ${RCS_path} STREQUAL "/" ) )
    message( "xx ${RCS_path}/.${_rcs} ")
    if( EXISTS "${RCS_path}/.${_rcs}" )
      vsnap( RCS_path )
      set( "${RCS_flag}" TRUE )
      return()
    endif()

    get_filename_component( RCS_path "${RCS_path}" DIRECTORY )
    vsnap( RCS_path )
    if( RCS_path STREQUAL "/" )
      set( "${RCS_flag}" FALSE )
      return()
    endif()

  endwhile()
  vsnap( RCS_path )
  set( "${RCS_flag}" FALSE )
  return()

endmacro()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
macro( check_RC _rcs )
  if( "${_res}" STREQUAL 0 )
  else()
    message( "@@  RETCODE (${_res}) " )
    message( "@@  ERROR   '${_err}' " )
    message( FATAL_ERROR "" )
  endif()
endmacro()

check_RCS( git )

return()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# the commands should be executed with the C locale,
# otherwise the messages (which are parsed) might be translated
# set( _lc_all "$ENV{LC_ALL}" )
# set( ENV{LC_ALL} "C" )
# execute_process ... ...
# set( ENV{LC_ALL} "${_lc_all}" )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
unset( RCS_NAME )
unset( RCS_VERSION )
unset( RCS_WC_REVISION )
unset( RCS_WC_HASH )
unset( RCS_WC_DIRTY )
unset( RCS_WC_TIMESTAMP)
unset( RCS_WC_REVISION_STRING )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
#message( ">> checking for Git " )
#if( EXISTS ${CMAKE_SOURCE_DIR}/.git )
if( 1 )
  set( GIT_REPOSITORY TRUE )

  find_program( GIT_EXECUTABLE git )
  if( GIT_EXECUTABLE )

    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # git version
    set( _lc_all "$ENV{LC_ALL}" )
    set( ENV{LC_ALL} "C" )
    execute_process( COMMAND ${GIT_EXECUTABLE} --version
      WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
      RESULT_VARIABLE _res
      ERROR_VARIABLE  _err
      OUTPUT_VARIABLE _out
      OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    set( ENV{LC_ALL} "${_lc_all}" )
    check_RC( "${GIT_EXECUTABLE}" )
    string( REGEX REPLACE "^(.*\n)?git version ([.0-9]+).*"
      "\\2" GIT_VERSION_STRING "${_out}"
    )

    set( RCS_NAME "Git" )
    set( RCS_VERSION "${GIT_VERSION_STRING}" )

    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # WC revision count
    set( _lc_all "$ENV{LC_ALL}" )
    set( ENV{LC_ALL} "C" )
    execute_process( COMMAND ${GIT_EXECUTABLE}
      rev-list HEAD --count
      WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
      RESULT_VARIABLE _res
      ERROR_VARIABLE  _err
      OUTPUT_VARIABLE _out
      OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    set( ENV{LC_ALL} "${_lc_all}" )
    check_RC( "${GIT_EXECUTABLE}" )
    set( RCS_WC_REVISION "${_out}" )

    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # the dirty flag
    set( _lc_all "$ENV{LC_ALL}" )
    set( ENV{LC_ALL} "C" )
    execute_process( COMMAND ${GIT_EXECUTABLE} status --porcelain
      WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
      RESULT_VARIABLE _res
      ERROR_VARIABLE  _err
      OUTPUT_VARIABLE _out
      OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    set( ENV{LC_ALL} "${_lc_all}" )
    check_RC( "${GIT_EXECUTABLE}" )
    if( "${_out}" STREQUAL "" )
      set( RCS_WC_DIRTY FALSE)
    else()
      set( RCS_WC_DIRTY TRUE )
    endif()


    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # the hash
    set( _lc_all "$ENV{LC_ALL}" )
    set( ENV{LC_ALL} "C" )
    execute_process( COMMAND ${GIT_EXECUTABLE} log -1 --pretty=format:%h
      WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
      RESULT_VARIABLE _res
      ERROR_VARIABLE  _err
      OUTPUT_VARIABLE _out
      OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    set( ENV{LC_ALL} "${_lc_all}" )
    check_RC( "${GIT_EXECUTABLE}" )
    set( RCS_WC_HASH "${_out}")

    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # the revision string
    set( RCS_WC_REVISION_STRING "G" )
    if( RCS_WC_DIRTY )
      set( RCS_WC_REVISION_STRING "${RCS_WC_REVISION_STRING}[${RCS_WC_HASH}+]" )
    else()
      set( RCS_WC_REVISION_STRING "${RCS_WC_REVISION_STRING}[${RCS_WC_HASH}]" )
    endif()

    # message( ">> endif GIT_FOUND  " )
    return()
  endif( GIT_EXECUTABLE )

  message( ">> endif GIT_REPOSITORY " )
  return()
endif()

set( RCS_WC_REVISION "0" )
