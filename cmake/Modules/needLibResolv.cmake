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
  #include <netdb.h>
  int main() {
    struct hostent *he;
    he=gethostbyname(\"hostname\");
    if( he )
      return (1);
    return (0);
  } "
  DONT_NEED_LIBRESOLV )

  if( DONT_NEED_LIBRESOLV )
    unset( LIBRESOLV )
    unset( LIBRESOLV CACHE )
  else()
    set( LIBRESOLV "resolv" )
    find_library(HAVE_LIBRESOLV resolv)
  endif()

cmake_pop_check_state()

