#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Copyright (c) 2020-2021 Enrico Sorichetti
#   Distributed under the Boost Software License, Version 1.0.
#   (See accompanying file BOOST_LICENSE_1_0.txt or copy at
#   http://www.boost.org/LICENSE_1_0.txt)

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
include_guard( GLOBAL )
include( CMakePushCheckState )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
include( CheckSymbolExists )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function( check_symbol )
  # sym, hdrlist, req
  set( sym "${ARGV0}" )
  set( hdr "${ARGV1}" )

  get_filename_component(nam  ${hdr} NAME_WE )
  set( flag "${nam}_${sym}" )
  string( REPLACE "_" " "   flag "${flag}" )
  string( STRIP   "${flag}" flag )
  string( REPLACE " " "_"   flag "${flag}" )
  string( MAKE_C_IDENTIFIER "have_decl_${flag}" flag )
  string( TOUPPER "${flag}" flag )

  cmake_push_check_state( RESET )
  check_symbol_exists( ${sym} ${hdr} ${flag} )
  if( ( ARGC GREATER 2 ) AND NOT ${flag} )
    message( SEND_ERROR "
 symbol '${sym}' not declared in '${hdr}'" )
  endif()
  cmake_pop_check_state()

endfunction()
