#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Copyright (c) 2020-2023 Enrico Sorichetti
#   Distributed under the Boost Software License, Version 1.0.
#   (See accompanying file BOOST_LICENSE_1_0.txt or copy at
#   http://www.boost.org/LICENSE_1_0.txt)

include_guard( GLOBAL )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include( CMakePushCheckState )
include( CheckCSourceCompiles )

cmake_push_check_state( RESET )
set( CMAKE_REQUIRED_FLAGS "-Wall -Werror" )

check_c_source_compiles( "
  #include <pthread.h>
  void * thread(void *ptr)
  {
    return NULL;
  }
  int main(){
    pthread_t p __attribute__((unused)) ;
    pthread_create(&p, NULL, *thread, NULL );
    return 0;
  } "
  DONT_NEED_LIBPTHREAD )

  if( DONT_NEED_LIBPTHREAD )
    unset( LIBPTHREAD )
    unset( LIBPTHREAD CACHE )
  else()
    set( LIBPTHREAD "pthread" )
    find_library(HAVE_LIBPTHREAD pthread)
  endif()

cmake_pop_check_state()
