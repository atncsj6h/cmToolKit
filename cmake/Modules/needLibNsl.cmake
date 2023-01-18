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
  #include <arpa/inet.h>
  int main() {
    int retv;
    struct in_addr addrp;
    retv = inet_aton(\"127.0.0.1\", &addrp ) ;
  } "
  DONT_NEED_LIBNSL  )

  if( DONT_NEED_LIBNSL )
    unset( LIBNSL )
    unset( LIBNSL CACHE )
  else()
    set( LIBNSL "nsl" )
    find_library(HAVE_LIBNSL nsl)
  endif()

cmake_pop_check_state()

