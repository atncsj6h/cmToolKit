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
  #include <dlfcn.h>
  int main()
  {
    void *h __attribute__((unused)) ;
    h = dlopen( \"dummy\", RTLD_LAZY );
    return 0;
  } "
  DONT_NEED_LIBDL )

  if( DONT_NEED_LIBDL )
    unset( LIBDL )
    unset( LIBDL CACHE )
  else()
    set( LIBDL "dl" )
    find_library(HAVE_LIBDL dl)
  endif()

cmake_pop_check_state()
