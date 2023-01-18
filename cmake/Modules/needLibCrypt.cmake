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

cmake_push_check_state( RESET )
set( CMAKE_REQUIRED_FLAGS "-Wall -Werror" )

check_c_source_compiles( "
  #include <unistd.h>
  int main()
  {
    char * c __attribute__((unused)) ;
    c = crypt( \"password\", \"user\" );
    return 0;
  } "
  DONT_NEED_LIBCRYPT )

  if( DONT_NEED_LIBCRYPT )
    unset( LIBCRYPT )
    unset( LIBCRYPT CACHE )
  else()
    set( LIBCRYPT "crypt" )
    find_library(HAVE_LIBCRYPT crypt)
  endif()

cmake_pop_check_state()
