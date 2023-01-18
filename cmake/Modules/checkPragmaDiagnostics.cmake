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

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
function( check_pragma_diagnostics )
  cmake_push_check_state( RESET )
  set( CMAKE_REQUIRED_FLAGS "-Wall -Werror" )

  set( args "${ARGV}" )
  list( REMOVE_DUPLICATES args )
  foreach( argv ${args} )
    string( REGEX REPLACE "[^a-zA-Z0-9_]" "_" flag "have_diag_${argv}" )
    string( TOUPPER "${flag}" flag )
    unset( "${flag}"  )
    unset( "${flag}"  CACHE )
    check_c_source_compiles( "
      int main()
      {
        #pragma GCC diagnostic ignored \"-W${argv}\"
        return (0);
      }"
      "${flag}" )
  endforeach()

  cmake_pop_check_state()
endfunction()
