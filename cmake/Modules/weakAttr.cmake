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
cmake_push_check_state( RESET )
set( CMAKE_REQUIRED_FLAGS "-Wall -Werror" )

check_c_source_compiles( "
  __attribute__((weak))
  void __dummy(void *x) { }
  void f(void *x) {
    __dummy(x);
  }
  int main() {
    int x;
    __dummy(&x);
    return (1) ;
  } "
  HAVE_WEAK_ATTRIBUTE
)
cmake_pop_check_state()

