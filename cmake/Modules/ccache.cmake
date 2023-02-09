#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Copyright (c) 2020-2021 Enrico Sorichetti
#   Distributed under the Boost Software License, Version 1.0.
#   (See accompanying file BOOST_LICENSE_1_0.txt or copy at
#   http://www.boost.org/LICENSE_1_0.txt)

include_guard( GLOBAL )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
if( WITH_CCACHE )
  set( WELL_KNOWN_GENERATORS "Unix Makefiles" "Ninja" )
  if( "${CMAKE_GENERATOR}" IN_LIST WELL_KNOWN_GENERATORS  )
    find_program( CCACHE ccache)
    if( CCACHE )
      set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE "${CCACHE}")
      message( STATUS "CCACHE is supported and enabled" )
    else()
      message( WARNING "
 CCACHE requested, but 'ccache' program not found " )
    endif()
  else()
    message( WARNING "
 CCACHE requested, but not supported for '${CMAKE_GENERATOR}' " )
  endif()
endif()

