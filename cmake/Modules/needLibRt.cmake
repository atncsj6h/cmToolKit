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

cmake_push_check_state( RESET )
set( CMAKE_REQUIRED_FLAGS "-Wall -Werror" )

check_c_source_compiles( "
  #include <time.h>
  int main() {
    struct timespec tim, tim2;
    tim.tv_sec = 1;
    tim.tv_nsec = 500;
    if( nanosleep(&tim , &tim2) < 0 )
      return -1;
    return 0;
  } "
  DONT_NEED_LIBRT )

  if( DONT_NEED_LIBRT )
    unset( LIBRT )
    unset( LIBRT CACHE )
  else()
    set( LIBRT "rt" )
    find_library(HAVE_LIBRT rt)
  endif()

cmake_pop_check_state()
