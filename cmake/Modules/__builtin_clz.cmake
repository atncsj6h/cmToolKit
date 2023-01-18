#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Copyright (c) 2020-2021 Enrico Sorichetti
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file BOOST_LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt)

include_guard( GLOBAL )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include( CMakePushCheckState )
include( CheckCSourceCompiles )
include( CheckCSourceRuns )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
cmake_push_check_state( RESET )

set( CMAKE_REQUIRED_FLAGS "-Wall -Werror" )
check_c_source_compiles ( "
  int main() {
    int coun;
    unsigned short      int s = 1;
    unsigned            int i = 1;
    unsigned            int l = 1;
    unsigned long long  int L = 1;
    coun = (int)__builtin_clzs  (s);
    coun = (int)__builtin_clz   (i);
    coun = (int)__builtin_clz   (l);
    coun = (int)__builtin_clzll (L);
    return (0);
  }"
  HAVE_BUILTIN_CLZ )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
if( HAVE_BUILTIN_CLZ )

  unset( NEED_BUILTIN_CLZ_TWEAK  )
  unset( NEED_BUILTIN_CLZ_TWEAK CACHE )

  check_c_source_runs( "
    int clz(int z, int i) {
      return( (__builtin_clz(z)!=__builtin_clz(i)) );
    }
    int main() {
      unsigned int z = 0;
      unsigned int i = 1;
      return( clz(z,i) );
    }"
    NEED_BUILTIN_CLZ_TWEAK )
endif()

cmake_pop_check_state()
