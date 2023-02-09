#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Copyright (c) 2020-2021 Enrico Sorichetti
#   Distributed under the Boost Software License, Version 1.0.
#   (See accompanying file BOOST_LICENSE_1_0.txt or copy at
#   http://www.boost.org/LICENSE_1_0.txt)

include_guard( GLOBAL )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
include( GNUInstallDirs )

if( NOT WELL_KNOWN_PREFIX )
  set( WELL_KNOWN_PREFIX_LIST  /usr /usr/local /opt /opt/local $ENV{HOME}/GNULayout )
  vsnap( WELL_KNOWN_PREFIX_LIST )
  if( "${CMAKE_INSTALL_PREFIX}" IN_LIST WELL_KNOWN_PREFIX_LIST )
    set( WELL_KNOWN_PREFIX 1 )
  endif( )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
set( INST_PREFIX  "${CMAKE_INSTALL_PREFIX}" )

set( INST_BIN_DIR "${CMAKE_INSTALL_BINDIR}" )
set( INST_BINDIR  "${CMAKE_INSTALL_BINDIR}" )

set( INST_INC_DIR "${CMAKE_INSTALL_INCLUDEDIR}" )
set( INST_INCLUDEDIR "${CMAKE_INSTALL_INCLUDEDIR}" )

if( WELL_KNOWN_PREFIX )
  set( INST_LIB_DIR "${CMAKE_INSTALL_LIBDIR}" )
  set( INST_LIBDIR  "${CMAKE_INSTALL_LIBDIR}" )
else()
  set( INST_LIB_DIR "lib" )
  set( INST_LIBDIR  "lib" )
endif()

set( INST_MOD_DIR "${INST_LIB_DIR}" )

set( INST_PKGCONF "${INST_LIB_DIR}/pkgconfig" )

set( INST_LIBEXEC_DIR "${CMAKE_INSTALL_LIBEXECDIR}" )

set( INST_DATADIR "${CMAKE_INSTALL_DATADIR}" )
vsnap( CMAKE_INSTALL_DATADIR INST_DATADIR )

if( WELL_KNOWN_PREFIX )
  set( INST_DATADIR "${CMAKE_INSTALL_DATADIR}/${PROJECT}" )
endif()
vsnap( CMAKE_INSTALL_DATADIR INST_DATADIR )

if( WELL_KNOWN_PREFIX )
  set( INST_DOC_DIR "${CMAKE_INSTALL_DOCDIR}" )
else()
  set( INST_DOC_DIR "${CMAKE_INSTALL_DATADIR}/doc" )
endif()
vsnap( CMAKE_INSTALL_DOCDIR  INST_DOC_DIR )

set( INST_MAN_DIR "${CMAKE_INSTALL_MANDIR}" )

