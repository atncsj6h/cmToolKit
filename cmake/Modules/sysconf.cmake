#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Copyright (c) 2020-2023 Enrico Sorichetti
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file BOOST_LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt)

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include_guard( GLOBAL )
include( CMakePushCheckState )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
function( sysconf confvar )
  set( _s "
    #include <unistd.h>
    #include <stdio.h>
    int main()  {
    int rc = sysconf( ${confvar} );
    printf( \"%d\", rc );
    return (1) ;
    } "
  )
  file( WRITE "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/src.c"
    "${_s}\n" )

  cmake_push_check_state( RESET )
  set( CMAKE_REQUIRED_FLAGS "-Wall -Werror" )

  try_run( run_rc compile_rc
    ${CMAKE_BINARY_DIR}
    ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/src.c
    RUN_OUTPUT_VARIABLE run_out
    COMPILE_OUTPUT_VARIABLE compile_out
  )
  cmake_pop_check_state()

  # vsnap( _s compile_rc run_rc compile_out run_out )
  if( compile_rc AND  run_rc )
    string( MAKE_C_IDENTIFIER "${confvar}" cmakevar )
    string( TOUPPER "${cmakevar}" cmakevar )
    string( REPLACE "_" " " cmakevar "${cmakevar}" )
    string( STRIP "${cmakevar}" cmakevar )
    string( REPLACE " " "_" cmakevar "${cmakevar}" )
    set( "${cmakevar}" "${run_out}"  PARENT_SCOPE )
  else()
    message( FATAL_ERROR "
 unable to process sysconf request for '${confvar}' " )
  endif()

endfunction()
