#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Copyright (c) 2020-2023 Enrico Sorichetti
#   Distributed under the Boost Software License, Version 1.0.
#   (See accompanying file BOOST_LICENSE_1_0.txt or copy at
#   http://www.boost.org/LICENSE_1_0.txt)

include_guard( GLOBAL )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include( CMakePushCheckState )
include( CheckCSourceCompiles )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
set( _ATTRS  "_Thread_local" "__thread" )

cmake_push_check_state( RESET )
set( CMAKE_REQUIRED_FLAGS "-Wall -Werror" )

foreach( _attr ${_ATTRS} )
  unset( HAVE_ATTR  )
  unset( HAVE_ATTR CACHE )
  check_c_source_compiles("
    ${_attr} int i;
    int main()
    {
    return 0;
    }"
    HAVE_ATTR
  )
  if( HAVE_ATTR )
    cmake_pop_check_state()
    set( THREAD_LOCAL_ATTR "${_attr}" )
    return()
  endif()
endforeach()

cmake_pop_check_state()
unset( THREAD_LOCAL_ATTR )
unset( THREAD_LOCAL_ATTR CACHE )

