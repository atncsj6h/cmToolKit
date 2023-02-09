#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include_guard( GLOBAL )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include( CheckIncludeFile )
include( checkHeader )

check_header( required
  # ISO/IEC 9899:1990 (C89, C90) headers
  assert.h  ctype.h errno.h   float.h   limits.h
  locale.h  math.h  setjmp.h  signal.h  stdarg.h
  stddef.h  stdio.h stdlib.h  string.h  time.h

  # ISO/IEC 9899:1990/Amd.1:1995 headers
  iso646.h  wchar.h wctype.h

  # ISO/IEC 9899:1999 (C99) headers
  complex.h fenv.h  inttypes.h  stdbool.h stdint.h
  tgmath.h
)

check_header(
  # ISO/IEC 9899:2011 (C11) headers
  stdalign.h
  stdatomic.h
  stdnoreturn.h
  threads.h
  uchar.h
)

if( 0 )
  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # configure isoHeaders.h
  if( EXISTS ${TMPL_SOURCE_DIR}/isoHeaders.h.in )
    configure_file( ${TMPL_SOURCE_DIR}/isoHeaders.h.in
      ${CMAKE_BINARY_DIR}/isoHeaders.h
    )
    add_compile_definitions(
      HAVE_ISOHDRS_H
     )
  endif()
endif()
