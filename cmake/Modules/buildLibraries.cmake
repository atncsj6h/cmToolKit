#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Copyright (c) 2020-2021 Enrico Sorichetti
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file BOOST_LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt)
#
include_guard( GLOBAL )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function( build_headers )
  set( args "${ARGV}" )
  list( SORT args )
  list( REMOVE_DUPLICATES args )

  foreach( targ ${args} )
    add_library( ${targ}_IFACE INTERFACE )

    set_property( TARGET ${targ}_IFACE
      PROPERTY
      PUBLIC_HEADER ${${targ}_HDRS} )

    install( TARGETS ${targ}_IFACE
      PUBLIC_HEADER DESTINATION ${INST_INC_DIR} )

  endforeach()
endfunction()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
function( build_objects )

  set( args "${ARGV}" )
  list( SORT args )
  list( REMOVE_DUPLICATES args )

  foreach( targ ${args} )

    add_library( ${targ}_OBJECTS  OBJECT
      ${${targ}_SRCS} )

    target_include_directories( ${targ}_OBJECTS
      PUBLIC
      ${${targ}_include_DIRS} )

    set_target_properties( ${targ}_OBJECTS
      PROPERTIES
      POSITION_INDEPENDENT_CODE TRUE
      OUTPUT_NAME ${targ} )

    if( HAVE_IPO_SUPPORT )
      set_property( TARGET ${targ}_OBJECTS
        PROPERTY
        INTERPROCEDURAL_OPTIMIZATION TRUE )
    endif()

    foreach( diag ${${targ}_pragma_DIAG} )
      string( MAKE_C_IDENTIFIER "have_diag_${diag}" flag )
      string( TOUPPER "${flag}" flag )
      if( ${flag} )
        target_compile_definitions( ${targ}_OBJECTS PRIVATE
          ${flag} )
      endif()
    endforeach()
  endforeach()
endfunction()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
function( build_shared_library )
  set( args "${ARGV}" )
  list( SORT args )
  list( REMOVE_DUPLICATES args )

  foreach( targ ${args} )
    add_library( ${targ} SHARED
      $<TARGET_OBJECTS:${targ}_OBJECTS> )

    if( SOVERSION )
      set_property( TARGET ${targ}
      PROPERTY
      SOVERSION ${SOVERSION} )
    endif()

    set_property( TARGET ${targ}
      PROPERTY
      POSITION_INDEPENDENT_CODE TRUE
      OUTPUT_NAME ${targ} )

    if( HAVE_IPO_SUPPORT )
      set_property( TARGET ${targ}
        PROPERTY
        INTERPROCEDURAL_OPTIMIZATION TRUE )
    endif()

    target_link_libraries( ${targ}
      ${${targ}_LIBS} )

    install( TARGETS ${targ}
      LIBRARY
      DESTINATION ${INST_LIB_DIR} )

  endforeach()

endfunction()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function( build_static_library)
  set( args "${ARGV}" )
  list( SORT args )
  list( REMOVE_DUPLICATES args )

  foreach( targ ${args} )
    add_library( ${targ}_STATIC STATIC
      $<TARGET_OBJECTS:${targ}_OBJECTS> )

    set_target_properties( ${targ}_STATIC
      PROPERTIES
      POSITION_INDEPENDENT_CODE TRUE
      OUTPUT_NAME ${targ} )

    if( HAVE_IPO_SUPPORT )
      set_property( TARGET ${targ}_STATIC
        PROPERTY
        INTERPROCEDURAL_OPTIMIZATION TRUE )
    endif()

    install( TARGETS ${targ}_STATIC
      ARCHIVE
      DESTINATION ${INST_LIB_DIR} )

  endforeach()

endfunction()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function( build_module)
  set( args "${ARGV}" )
  list( SORT args )
  list( REMOVE_DUPLICATES args )

  foreach( targ ${args} )
    add_library( ${targ} MODULE
      $<TARGET_OBJECTS:${targ}_OBJECTS> )

    set_target_properties( ${targ}
      PROPERTIES
      PREFIX "" )

    set_target_properties( ${targ}
      PROPERTIES
      POSITION_INDEPENDENT_CODE TRUE
      OUTPUT_NAME ${targ} )

    if( HAVE_IPO_SUPPORT )
      set_property( TARGET ${targ}
        PROPERTY
        INTERPROCEDURAL_OPTIMIZATION TRUE )
    endif()

    target_link_libraries( ${targ}
      ${${targ}_LIBS} )

    install( TARGETS ${targ}
      DESTINATION ${INST_MOD_DIR} )

  endforeach()

endfunction()


