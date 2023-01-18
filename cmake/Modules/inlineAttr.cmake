#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Copyright (c) 2020-2021 Enrico Sorichetti
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
set( _ATTRS "inline" "__inline" "__inline__" "__attribute__((always_inline))"   )

cmake_push_check_state( RESET )
set( CMAKE_REQUIRED_FLAGS "-Wall -Werror" )

foreach( _attr ${_ATTRS} )
  unset( HAVE_ATTR  )
  unset( HAVE_ATTR CACHE )
  check_c_source_compiles("
    ${_attr} int foo()
    {
      return 0;
    }
    static
    ${_attr} int foo_s()
    {
      return 0;
    }
    extern
    ${_attr} int foo_e()
    {
      return 0;
    }

    int main()
    {
      int f, f_s;
      f=foo();
      f_s=foo_s();
      return 0;
    } "
    HAVE_ATTR
  )
  if( HAVE_ATTR )
    cmake_pop_check_state()
    set( INLINE_ATTR "${_attr}" )
    return()
  endif()
endforeach()

cmake_pop_check_state()
unset( INLINE_ATTR )
unset( INLINE_ATTR CACHE )

