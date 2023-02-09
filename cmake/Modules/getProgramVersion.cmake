#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Copyright (c) 2020-2021 Enrico Sorichetti
#   Distributed under the Boost Software License, Version 1.0.
#   (See accompanying file BOOST_LICENSE_1_0.txt or copy at
#   http://www.boost.org/LICENSE_1_0.txt)

include_guard( GLOBAL )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
function( get_program_version )
  set( args "${ARGV}" )
  list( REMOVE_DUPLICATES args )
  set( OPTVlist "--version" "-V" "-v" "-x" )
  foreach( argv ${args} )
    foreach( optv ${OPTVlist} )
      execute_process( COMMAND ${argv} ${optv}
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        RESULT_VARIABLE _result
        ERROR_VARIABLE  _error
        OUTPUT_VARIABLE _output
        OUTPUT_STRIP_TRAILING_WHITESPACE
      )
      if( ${_result} EQUAL 0 )
        string( REGEX REPLACE "[\n]" ";" lines "${_output}" )
        list( GET lines 0 line0 )
        string( REGEX REPLACE "[\ ?]" ";" version "${line0}")
        list( GET version -1 version )
        get_filename_component( name "${argv}" NAME_WE)
        set( flag "${name}_VERSION_STRING" )
        string( TOUPPER "${flag}" flag )
        set( "${flag}" "${version}" PARENT_SCOPE )
        break()
      endif()
    endforeach()
  endforeach()
endfunction()

