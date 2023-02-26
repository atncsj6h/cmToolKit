#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Copyright (c) 2020-2021 Enrico Sorichetti
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file BOOST_LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt)
#
include_guard( GLOBAL )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function( configure_template )
  if( ${ARGC} EQUAL 1 )
    set( from ${ARGV0}.in )
    set( dest "${ARGV0}" )
  else()
    set( from ${ARGV0} )
    set( dest "${ARGV1}" )
  endif()
  unset( TEMPL_IN )
  unset( TEMPL_IN CACHE )
  find_file( TEMPL_IN ${from} ${TEMPL_SOURCE_PATH} )
    if( TEMPL_IN )
      configure_file( ${TEMPL_IN}
        ${CMAKE_BINARY_DIR}/${dest} @ONLY)
      set( flag "have_${dest}" )
      string( TOUPPER "${flag}" flag )
      string( MAKE_C_IDENTIFIER "${flag}" flag )
      set( ${flag} 1)
      return( PROPAGATE ${flag} )
    endif( TEMPL_IN )
endfunction()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function( configure_templates )

  set( args "${ARGV}" )
  list( SORT args )
  list( REMOVE_DUPLICATES args )
  set( flags "" )
  foreach( argv ${args} )
    unset( TEMPL_IN )
    unset( TEMPL_IN CACHE )
    find_file( TEMPL_IN ${argv}.in ${TEMPL_SOURCE_PATH} )
    if( TEMPL_IN )
      configure_file( ${TEMPL_IN}
        ${CMAKE_BINARY_DIR}/${argv} @ONLY)
      set( flag "have_${argv}" )
      string( TOUPPER "${flag}" flag )
      string( MAKE_C_IDENTIFIER "${flag}" flag )
      add_compile_definitions( ${flag} )
      set( ${flag} 1 )
      list( APPEND flags ${flag} )
    endif( TEMPL_IN )
  endforeach()
  return( PROPAGATE ${flags} )
endfunction()
