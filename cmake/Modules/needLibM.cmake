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
  #include <math.h>
  int main()
  {
    double r __attribute__((unused)) ;
    r = sqrt( 2.0 );
    return 0;
  } "
  DONT_NEED_LIBM )

  if( DONT_NEED_LIBM )
    unset( LIBM )
    unset( LIBM CACHE )
  else()
    set( LIBM "m" )
    find_library(HAVE_LIBM m )
  endif()

cmake_pop_check_state()
