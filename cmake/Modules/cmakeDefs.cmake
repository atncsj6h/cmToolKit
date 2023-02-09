#[[ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    Copyright (c) 2018, 2020 Enrico Sorichetti.
    Distributed under the Boost Software License, Version 1.0.
    (See accompanying file BOOST_LICENSE_1_0.txt or copy at
    http://www.boost.org/LICENSE_1_0.txt)
#]]
include_guard( GLOBAL )

#[[ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#]]
function( header_cmakedef defs this flag )
    set( buff "/* Define to 1 if you have the '<${this}>' header file. */ \n" )
    file( APPEND ${CMAKE_BINARY_DIR}/${defs} "${buff}" )
    set( buff "#cmakedefine ${flag} \n\n" )
    file( APPEND ${CMAKE_BINARY_DIR}/${defs} "${buff}" )
endfunction()

function( function_cmakedef defs this flag )
    set( buff "/* Define to 1 if you have the '<${this}>' function. */ \n" )
    file( APPEND ${CMAKE_BINARY_DIR}/${defs} "${buff}" )
    set( buff "#cmakedefine ${flag} \n\n" )
    file( APPEND ${CMAKE_BINARY_DIR}/${defs} "${buff}" )
endfunction()

function( generic_cmakedef defs flag)
    set( buff "/* Define to 1 if the facility is available. */ \n" )
    file( APPEND ${CMAKE_BINARY_DIR}/${defs} "${buff}" )
    set( buff "#cmakedefine ${flag} \n\n" )
    file( APPEND ${CMAKE_BINARY_DIR}/${defs} "${buff}" )
endfunction()

