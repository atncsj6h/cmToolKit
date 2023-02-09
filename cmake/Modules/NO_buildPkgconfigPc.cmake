#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Copyright (c) 2020-2021 Enrico Sorichetti
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file BOOST_LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt)
#
include_guard( GLOBAL )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
function( build_pkgconfig_pc )
  set( args "${ARGV}" )
  list( SORT args )
  list( REMOVE_DUPLICATES args )
  foreach( argv ${args} )
    find_file (
      PKGCONFIG_PC_IN
      pkgconfig.pc.in
      ${TEMPL_SOURCE_PATH}
    )

    if( PKGCONFIG_PC_IN )
      configure_file( ${PKGCONFIG_PC_IN}
      ${CMAKE_BINARY_DIR}/${argv}.pc @ONLY )

      install( FILES ${CMAKE_BINARY_DIR}/${argv}.pc
        DESTINATION ${INST_LIB_DIR}/pkgconfig )

      # extra location based on the environment variable PKG_CONFIG_PATH
      set( PKG_CONFIG_PATH "$ENV{PKG_CONFIG_PATH}" )
      if( PKG_CONFIG_PATH )
        string( REGEX REPLACE "[:]" ";" PKG_CONFIG_PATH "${PKG_CONFIG_PATH}")
        list( GET PKG_CONFIG_PATH 0 PKG_CONFIG_PATH )
        if( IS_DIRECTORY ${PKG_CONFIG_PATH} )
          install( FILES ${CMAKE_BINARY_DIR}/${argv}.pc
            DESTINATION ${PKG_CONFIG_PATH} )
        endif()
      endif()
    endif( PKGCONFIG_PC_IN )
  endforeach()
endfunction()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
function( build_pkgconfig_sh )
  set( args "${ARGV}" )
  list( SORT args )
  list( REMOVE_DUPLICATES args )
  foreach( argv ${args} )
    find_file (
      PKGCONFIG_SH_IN
      pkgconfig.sh.in
      ${TEMPL_SOURCE_PATH}
    )
    if( PKGCONFIG_SH_IN )
      configure_file( ${PKGCONFIG_SH_IN}
        ${CMAKE_BINARY_DIR}/${argv}-config @ONLY )

      install( FILES ${CMAKE_BINARY_DIR}/${argv}-config
        PERMISSIONS OWNER_WRITE
        OWNER_READ  OWNER_EXECUTE
        GROUP_READ  GROUP_EXECUTE
        WORLD_READ  WORLD_EXECUTE
        DESTINATION ${INST_BIN_DIR}
      )
    endif( PKGCONFIG_SH_IN )
  endforeach()
endfunction()
