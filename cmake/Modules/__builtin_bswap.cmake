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

cmake_push_check_state( RESET )

set( cmake_required_flags "-Wall -Werror" )
check_c_source_compiles( "
  int main(){
    short hw    = 0x1234;
    int   fw    = 0x12345678;
    long  dw    = 0x1234567812345678;
    short hw_s  = 0x1234;
    int   fw_s  = 0x12345678;
    long  dw_s  = 0x1234567812345678;
    hw_s = __builtin_bswap16(hw);
    fw_s = __builtin_bswap32(fw);
    dw_s = __builtin_bswap64(dw);
    return (0);
  }"
  HAVE_BUILTIN_BSWAP )

cmake_pop_check_state()
