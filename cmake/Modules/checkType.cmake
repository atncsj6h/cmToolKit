#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Copyright (c) 2020-2021 Enrico Sorichetti
#   Distributed under the Boost Software License, Version 1.0.
#   (See accompanying file BOOST_LICENSE_1_0.txt or copy at
#   http://www.boost.org/LICENSE_1_0.txt)

include_guard( GLOBAL )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include( CheckTypeSize )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
macro( type_get_size )
  set( args "${ARGV}" )
  list( SORT args )
  list( REMOVE_DUPLICATES args )
  foreach( argv ${args} )
    set( flag "${argv}" )
    string( REPLACE "*" "p"   flag "${flag}" )
    string( REPLACE "_" " "   flag "${flag}" )
    string( STRIP   "${flag}" flag )
    string( REPLACE " " "_"   flag "${flag}" )
    string( TOUPPER "${flag}" flag )
    string( MAKE_C_IDENTIFIER "SIZEOF_${flag}" flag )
    check_type_size( ${argv} ${flag} )
    # unset some variables
    # unset( HAVE_${flag} )
    # unset( HAVE_${flag} CACHE )
    # unset( ${flag}_CODE )
  endforeach()
endmacro()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
macro( type_is_defined )
  set( args "${ARGV}" )
  list( SORT args )
  list( REMOVE_DUPLICATES args )
  foreach( argv ${args} )
    set( flag "${argv}" )
    string( REPLACE "*" "p"   flag "${flag}" )
    string( REPLACE "_" " "   flag "${flag}" )
    string( STRIP   "${flag}" flag )
    string( REPLACE " " "_"   flag "${flag}" )
    string( TOUPPER "${flag}" flag )
    string( MAKE_C_IDENTIFIER "${flag}" flag )
    check_type_size( ${argv} ${flag} )
    # unset some variables
    # unset( ${flag} )
    # unset( ${flag} CACHE )
    # unset( ${flag}_CODE )
  endforeach()
endmacro()


