#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include_guard( GLOBAL )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
unset( CMAKE_C_FLAGS )
unset( CMAKE_C_FLAGS CACHE )
unset( CMAKE_C_FLAGS_INIT )
unset( CMAKE_C_FLAGS_INIT CACHE )

set( CMAKE_C_FLAGS                "-g0 -O3 -DNDEBUG -fomit-frame-pointer" )
set( CMAKE_C_FLAGS_INIT           "-g0 -O3 -DNDEBUG -fomit-frame-pointer" )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
unset( CMAKE_C_FLAGS_RELEASE )
unset( CMAKE_C_FLAGS_RELEASE CACHE )
unset( CMAKE_C_FLAGS_RELEASE_INIT )
unset( CMAKE_C_FLAGS_RELEASE_INIT CACHE )

set( CMAKE_C_FLAGS_RELEASE        "-g0 -O3 -DNDEBUG -fomit-frame-pointer" )
set( CMAKE_C_FLAGS_RELEASE_INIT   "-g0 -O3 -DNDEBUG -fomit-frame-pointer" )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
unset( CMAKE_C_FLAGS_DEBUG )
unset( CMAKE_C_FLAGS_DEBUG CACHE )
unset( CMAKE_C_FLAGS_DEBUG_INIT )
unset( CMAKE_C_FLAGS_DEBUG_INIT  CACHE )

set( CMAKE_C_FLAGS_DEBUG          "-g3 -ggdb" )
set( CMAKE_C_FLAGS_DEBUG_INIT     "-g3 -ggdb" )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
unset( CMAKE_CXX_FLAGS )
unset( CMAKE_CXX_FLAGS CACHE )
unset( CMAKE_CXX_FLAGS_INIT )
unset( CMAKE_CXX_FLAGS_INIT CACHE )

set( CMAKE_CXX_FLAGS              "-g0 -O3 -DNDEBUG -fomit-frame-pointer" )
set( CMAKE_CXX_FLAGS_INIT         "-g0 -O3 -DNDEBUG -fomit-frame-pointer" )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
unset( CMAKE_CXX_FLAGS_RELEASE )
unset( CMAKE_CXX_FLAGS_RELEASE CACHE )
unset( CMAKE_CXX_FLAGS_RELEASE_INIT )
unset( CMAKE_CXX_FLAGS_RELEASE_INIT CACHE )

set( CMAKE_CXX_FLAGS_RELEASE      "-g0 -O3 -DNDEBUG -fomit-frame-pointer" )
set( CMAKE_CXX_FLAGS_RELEASE_INIT "-g0 -O3 -DNDEBUG -fomit-frame-pointer" )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
unset( CMAKE_CXX_FLAGS_DEBUG )
unset( CMAKE_CXX_FLAGS_DEBUG CACHE )
unset( CMAKE_CXX_FLAGS_DEBUG_INIT )
unset( CMAKE_CXX_FLAGS_DEBUG_INIT  CACHE )

set( CMAKE_CXX_FLAGS_DEBUG        "-g3 -ggdb" )
set( CMAKE_CXX_FLAGS_DEBUG_INIT   "-g3 -ggdb" )
