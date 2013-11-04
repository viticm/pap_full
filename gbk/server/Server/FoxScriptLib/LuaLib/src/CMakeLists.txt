INCLUDE_DIRECTORIES(baselib)

SET(TF_CURRENT_BINARY_PATH_LIB "../../../../lib")
SET(SRC_LIST lapi.c
             lcode.c
             ldebug.c
             ldo.c
             lfunc.c
             lgc.c
             llex.c
             lmem.c
             lobject.c
             lparser.c
             lstate.c
             lstring.c
             ltable.c
             ltests.c
             ltm.c
             lua.c
             LuaExtend.c
             lundump.c
             lvm.c
             lzio.c
             lapi.h
             lauxlib.h
             lcode.h
             ldebug.h
             ldo.h
             lfunc.h
             lgc.h
             llex.h
             llimits.h
             lmem.h
             lobject.h
             lopcodes.h
             lparser.h
             lstate.h
             lstring.h
             ltable.h
             ltm.h
             lua.h
             luadebug.h
             LuaDef.h
             lualib.h
             lundump.h
             lvm.h
             lzio.h
             )
             
SET(BASELIB_LIST 
             baselib/lauxlib.c
             baselib/lbaselib.c
             baselib/ldblib.c
             baselib/liolib.c
             baselib/lmathlib.c
             baselib/lstrlib.c
             )


if (WIN32)             
  source_group(baselib FILES ${BASELIB_LIST})
  
else()
  if(USE_32BITS)
    SET(CMAKE_C_FLAGS "-Wall -ggdb -pipe -march=i386 -mtune=i686")
    SET(CMAKE_CXX_FLAGS "-Wall -ggdb -pipe -march=i386 -mtune=i686")
  else()
    SET(CMAKE_C_FLAGS "-Wall -ggdb -pipe -march=x86-64 -mtune=i686")
    SET(CMAKE_CXX_FLAGS "-Wall -ggdb -pipe -march=x86-64 -mtune=i686")
  endif(USE_32BITS)
endif()


SET(LIBRARY_OUTPUT_PATH ${TF_CURRENT_BINARY_PATH_LIB})

ADD_LIBRARY(LuaLib SHARED ${SRC_LIST} ${BASELIB_LIST})

IF(CMAKE_SYSTEM MATCHES Windows)
  
ENDIF(CMAKE_SYSTEM MATCHES Windows)


