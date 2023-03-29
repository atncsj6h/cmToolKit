#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Copyright (c) 2020-2023 Enrico Sorichetti
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file BOOST_LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt)

include_guard( GLOBAL )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#

set( PKG_CONFIG_EXECUTABLE "$ENV{PKG_CONFIG_EXECUTABLE}" )
if( NOT PKG_CONFIG_EXECUTABLE )
  set( PKG_CONFIG_EXECUTABLE "pkgconf" )
endif()

unset( PKG_CONFIG_FOUND )
unset( PKG_CONFIG_FOUND CACHE )
include( FindPkgConfig )
if( NOT PKG_CONFIG_FOUND )
  message( SEND_ERROR "
 'pkgconf/pkg-config' not available/installed " )
endif()

#[[ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#]]
macro( pkg_config )
  set( args "${ARGV}" )
  list( REMOVE_DUPLICATES args )
  string( TOLOWER "${args}" argw )

  unset( required )
  unset( required CACHE )

  list( FIND argw "required" _X )
  if( _X GREATER_EQUAL 0 )
    list( REMOVE_AT argw "${_X}" )
    list( REMOVE_AT args "${_X}" )
    set( required ON )
  endif()

  foreach( argv ${args} )
    pkg_check_modules( "${argv}" "${argv}" )
    if( required AND NOT ${argv}_FOUND )
      message( SEND_ERROR "
 unable to locate a required '${argv}' component "
      )
    endif()
    # hack to fill the STATIC_LINK_LIBRARIES FULL PATH
    if( ${argv}_FOUND )
      foreach( library ${${argv}_LINK_LIBRARIES} )
        get_filename_component( _dir "${library}" DIRECTORY )
        get_filename_component( _wle "${library}" NAME_WLE )
        get_filename_component( _lxt "${library}" LAST_EXT )
        if( EXISTS "${_dir}/${_wle}.a" )
          list( APPEND ${argv}_STATIC_LINK_LIBRARIES "${_dir}/${_wle}.a" )
        endif()
      endforeach()
    endif()
  endforeach()
endmacro()
