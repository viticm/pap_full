#ifndef luaextend_h
#define luaextend_h
#include "lua.h"
#include "lauxlib.h"
/*
** ======================================================================
**  Debug API
**  =======================================================================
*/
// 脚本引擎
#define Lua_CFunction                    lua_CFunction
#define Lua_State                        lua_State
#define Lua_Release(L)                    lua_close(L)
#define Lua_GetTopIndex(L)                lua_gettop(L)
#define Lua_SetTopIndex(L,nIndex)        lua_settop(L,nIndex)
#define Lua_PushValue(L,nIndex)            lua_pushvalue(L,nIndex)
#define Lua_RemoveValue(L,nIndex)        lua_remove(L,nIndex)
#define Lua_InsertValue(L,nIndex)        lua_insert(L,nIndex)
#define Lua_GetValueType(L,nIndex)        lua_type(L,nIndex)
#define Lua_GetTypeName(L,Tag)            lua_typename(L,Tag)
#define Lua_IsNumber(L,nIndex)            lua_isnumber(L,nIndex)
#define Lua_IsString(L,nIndex)            lua_isstring(L,nIndex)
#define Lua_IsCFunction(L,nIndex)        lua_iscfunction(L,nIndex)
#define Lua_IsTable(L,nIndex)            lua_istable(L,nIndex)
#define Lua_GetValueTag(L,nIndex)        lua_tag(L,nIndex)
#define Lua_IsEqual(L,index1,index2)    lua_equal(L,index1,index2)
#define Lua_IsLessThan(L,index1,index2)    lua_lessthan(L,index1,index2)
#define Lua_ValueToNumber(L,nIndex)        lua_tonumber(L,nIndex)
#define Lua_ValueToString(L,nIndex)        lua_tostring(L,nIndex)
#define Lua_GetStrLen(L,nIndex)            lua_strlen(L,nIndex)
#define Lua_ValueToCFunction(L,nIndex)    lua_tocfunction(L,nIndex)
#define Lua_ValueToUserData(L,nIndex)    lua_touserdata(L,nIndex)
#define Lua_ValueToPoint(L,nIndex)        lua_topointer(L,nIndex)

/*
** script engine api
*/
#define Lua_PushNil(L)                    lua_pushnil(L)
#define Lua_PushNumber(L,Number)        lua_pushnumber(L,Number)
#define Lua_PushLString(L,LString,Len)    lua_pushlstring(L,LString,Len)
#define Lua_PushString(L,String)        lua_pushstring(L,String)
#define Lua_PushCClosure(L,Fun,N)        lua_pushcclosure(L,Fun,N)
#define lua_PushFunctio

#define Lua_GetGlobal(L,Valuename)        lua_getglobal(L,Valuename)
#define Lua_GetTable(L,nIndex)            lua_gettable(L,nIndex)
#define Lua_RawGet(L,nIndex)              lua_rawget(L,nIndex)
#define Lua_RawGetI(L,nIndex,n)           lua_rawgeti(L,nIndex,n)
#define Lua_NewTable(L)                   lua_newtable(L)


#define Lua_SetGlobal(L,cName)            lua_setglobal(L,cName)
#define Lua_SetTable(L,nIndex)            lua_settable(L,nIndex)
#define Lua_RawSet(L,nIndex)              lua_rawset(L,nIndex)
#define Lua_RawSetI(L,nIndex,nNum)        lua_rawseti(L,nIndex,nNum)

#define Lua_Call(L,nArgs,nResults)        lua_pcall(L,nArgs,nResults,0)

#define Lua_Pop(L,nIndex)                lua_pop(L,nIndex)
#define Lua_Register(L,cfname,pFun)        lua_register(L,cfname,pFun)
#define Lua_PushCFunction(L,pFun)    lua_pushcfunction(L,pFun)

/*
** compatibility macros and functions
*/
#define lua_open()  luaL_newstate()
#define lua_loadbuffer(L,s,sz,n)   luaL_loadbufferx(L,s,sz,n,NULL)

LUA_API void lua_outerrmsg(const char * szerrmsg);
LUA_API void lua_outoutmsg(const char * szoutmsg);

LUA_API int Lua_SetTable_StringFromId(Lua_State * L, int nIndex, int Id, const char * szString);
LUA_API int Lua_SetTable_DoubleFromId(Lua_State * L, int nIndex, int Id, double nNumber);
LUA_API int Lua_SetTable_IntFromId(Lua_State * L, int nIndex, int Id, int nNumber);
LUA_API int Lua_SetTable_CFunFromName(Lua_State * L, int nIndex, const char * szMemberName, Lua_CFunction CFun);
LUA_API int Lua_SetTable_CFunFromId(Lua_State * L, int nIndex, int nId, Lua_CFunction CFun); 
LUA_API int Lua_SetTable_StringFromName(Lua_State * L, int nIndex, const char * szMemberName, char * szString);
LUA_API int Lua_SetTable_IntFromName(Lua_State * L, int nIndex, const char * szMemberName, int Number);
LUA_API int Lua_SetTable_DoubleFromName(Lua_State * L, int nIndex, const char * szMemberName, double Number);
LUA_API int Lua_GetValuesFromStack(Lua_State * L, char * cFormat, ...);
LUA_API void lua_execute(lua_State *L);

#endif

