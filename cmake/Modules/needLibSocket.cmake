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
  #include <sys/types.h>
  #include <sys/socket.h>
  int main() {
    int fd = 0 ;
    struct sockaddr s_a;
    connect(fd, (struct sockaddr *)&s_a, sizeof(s_a)) ;
  } "
  DONT_NEED_LIBSOCKET  )

  if( DONT_NEED_LIBSOCKET )
    unset( LIBSOCKET )
    unset( LIBSOCKET CACHE )
  else()
    set( LIBSOCKET "socket" )
    find_library(HAVE_LIBSOCKET rt)
  endif()

cmake_pop_check_state()

