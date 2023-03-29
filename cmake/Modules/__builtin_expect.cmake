#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Copyright (c) 2020-2023 Enrico Sorichetti
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file BOOST_LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt)

include_guard( GLOBAL )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include( CMakePushCheckState )
include( CheckCSourceCompiles )

cmake_push_check_state( RESET )

set( cmake_required_flags "-Wall -Werror" )
check_c_source_compiles( "
  int main() {
    unsigned char a=1;
    return __builtin_expect(a,1);
  }"
  HAVE_BUILTIN_EXPECT )

cmake_pop_check_state()
