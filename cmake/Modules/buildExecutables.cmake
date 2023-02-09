#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Copyright (c) 2020-2021 Enrico Sorichetti
#   Distributed under the Boost Software License, Version 1.0.
#   (See accompanying file BOOST_LICENSE_1_0.txt or copy at
#   http://www.boost.org/LICENSE_1_0.txt)
#
include_guard( GLOBAL )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
function( build_executable )
  set( args "${ARGV}" )
  list( SORT args )
  list( REMOVE_DUPLICATES args )

  foreach( targ ${args} )
    add_executable( ${targ}${SUFF}
      ${${targ}${SUFF}_SRCS}
    )
    target_include_directories( ${targ}${SUFF}
      PUBLIC
      ${${targ}${SUFF}_include_DIRS}
    )
    set_target_properties( ${targ}${SUFF}
      PROPERTIES
      OUTPUT_NAME ${targ}
    )
    if( HAVE_IPO_SUPPORT )
      set_property( TARGET ${targ}${SUFF}
        PROPERTY
        INTERPROCEDURAL_OPTIMIZATION TRUE )
    endif()
    foreach( diag ${${targ}${SUFF}_pragma_DIAG} )
      string( MAKE_C_IDENTIFIER "have_diag_${diag}" flag )
      string( TOUPPER "${flag}" flag )
      if( ${flag} )
        target_compile_definitions( ${targ}${SUFF} PRIVATE
          ${flag} )
      endif()
    endforeach()
    target_link_libraries( ${targ}${SUFF}
      ${${targ}${SUFF}_LIBS}
    )
    install( TARGETS ${targ}${SUFF}
      LIBRARY
      DESTINATION ${INST_LIB_DIR}
    )
  endforeach()
endfunction()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
function( create_symlink target alias)
  add_custom_command(
    TARGET ${target}
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E chdir ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
      ln -sf ${target} ${alias}
      DEPENDS ${target}
  )

  install( FILES ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${alias}
    DESTINATION ${INST_BIN_DIR}
  )
endfunction( create_symlink )

