//---------------------------------------------------------------------------
// Script Engine by FireFox
// Desc:	Header File
//---------------------------------------------------------------------------
#ifndef FoxDebug_H
#define FoxDebug_H
//---------------------------------------------------------------------------
#include <string.h>

//---------------------------------------------------------------------------
#define SAFE_FREE(a)	if (a) {g_MemFree(a); (a)=NULL;}
#define SAFE_RELEASE(a)	if (a) {(a)->Release(); (a)=NULL;}
//---------------------------------------------------------------------------
#ifdef _DEBUG
	#define KASSERT(x)	NULL
//	#define KASSERT(x)	if (!(x)) g_AssertFailed(__FILE__, __LINE__)
#else
	#define KASSERT(x)	NULL
#endif
//---------------------------------------------------------------------------
#if defined(__WINDOWS__)
	#if defined(NDEBUG)
		#define __ENTER_FUNCTION {try{
		#define __LEAVE_FUNCTION }catch(...){AssertSpecial(FALSE,__FUNCTION__);}}
	#else
		#define __ENTER_FUNCTION {try{
		#define __LEAVE_FUNCTION }catch(...){AssertSpecial(FALSE,__FUNCTION__);}}
	#endif
    // add by viticm, fast output some debug info 
    #define LERR(...) \
            { \
                char cBuffer[ 2048 ]; sprintf( cBuffer, __VA_ARGS__ ); \
                const char * cStart  = "[ERROR...]"; \
                const char * cEnd    = "[...ERROR]"; \
                size_t iFormatLength = sizeof( cStart ) + sizeof( cBuffer ) + sizeof( cEnd ); \
                char * cFormatStr    = new char[ iFormatLength + 1  ]; \
                strcpy( cFormatStr, cStart ); strcat( cFormatStr, cBuffer ); strcat( cFormatStr, cEnd ); \
                printf( cFormatStr ); \
                delete[] cFormatStr; \
            } 
    // common define
    #define LF "\r\n"
#elif defined(__LINUX__)	//linux
	#define __ENTER_FUNCTION {try{
	#define __LEAVE_FUNCTION }catch(...){AssertSpecial(FALSE,__PRETTY_FUNCTION__);}}
    // add by viticm, fast output some debug info 
    #define LERR(...) \
            { \
                char cBuffer[ 2048 ]; sprintf( cBuffer, __VA_ARGS__ ); \
                const char * cStart  = "\e[0;31;1m"; \
                const char * cEnd    = "\e[0m\n"; \
                size_t iFormatLength = sizeof( cStart ) + sizeof( cBuffer ) + sizeof( cEnd ); \
                char * cFormatStr    = new char[ iFormatLength + 1  ]; \
                strcpy( cFormatStr, cStart ); strcat( cFormatStr, cBuffer ); strcat( cFormatStr, cEnd ); \
                printf( cFormatStr ); \
                delete[] cFormatStr; \
            } 

    // common define
    #define LF "\n"
#endif 

#endif
