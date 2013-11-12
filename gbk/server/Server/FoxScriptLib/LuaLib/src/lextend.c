//---------------------------------------------------------------------------
// Modify by viticm<viticm@126.com> 
// PAP Engine(c) 2013-2013
// File:	lextend.c
// Date:	2001-9-27 15:46:40
// Code:	Romandou
// Desc:	扩展的LuaAPI函数
//---------------------------------------------------------------------------
#include "lua.h"
#include "string.h"
#include <stdio.h>
#include <stdarg.h>

//---------------------------------------------------------------------------
// 函数:	lua_settable
// 功能:	修改Lua table中的某个成员的值
// 参数:	lua_State * L
// 参数:	int nIndex 数组在堆中的index
// 参数:	const char * szMemberName 以字符串表示成员的名称
// 参数:	double Number 成员的数值
// 返回:	int 
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//                   lua_settableMember
//    该函数体由若干的函数组成，以实现改变Lua Table中的某个变量的值
//    Lua的Table的表现形式有两种，一种是以数字形式表示如 Table[1],而另一
//	  种是以字符串的形式表示，如Table.Member。	
//	  同时，变量值还包括Number、String、CFun等
//	 	  nIndex为数组在堆栈中的位置。
//---------------------------------------------------------------------------
int lua_settable_DoubleFromName(lua_State * L, int nIndex, const char * szMemberName, double Number)
{
	if (! lua_istable(L, nIndex))
		return 0;
	lua_pushstring(L, szMemberName);
	lua_pushnumber(L, Number);
	lua_settable(L, nIndex);
	return 1;
}


//---------------------------------------------------------------------------
// 函数:	lua_settable_IntFromName
// 功能:	
// 参数:	lua_State * L
// 参数:	int nIndex
// 参数:	const char * szMemberName
// 参数:	int Number
// 返回:	int 
//---------------------------------------------------------------------------
int lua_settable_IntFromName(lua_State * L, int nIndex, const char * szMemberName, int Number)
{

	if (! lua_istable(L, nIndex))
		return 0;
	lua_pushstring(L, szMemberName);
	lua_pushnumber(L, (double)Number);
	lua_settable(L, nIndex);
	return 1;
	
}


//---------------------------------------------------------------------------
// 函数:	lua_settable_StringFromName
// 功能:	
// 参数:	lua_State * L
// 参数:	int nIndex
// 参数:	const char * szMemberName
// 参数:	char * szString
// 返回:	int 
//---------------------------------------------------------------------------
int lua_settable_StringFromName(lua_State * L ,int nIndex, const char * szMemberName, char * szString)
{
	
	if (! lua_istable(L, nIndex))
		return 0;
	lua_pushstring(L, szMemberName);
	lua_pushstring(L, szString);
	lua_settable(L, nIndex);
	return 1;
	
}

//---------------------------------------------------------------------------
// 函数:	lua_settable_StringFromId
// 功能:	
// 参数:	lua_State * L
// 参数:	int nIndex
// 参数:	int Id
// 参数:	const char * szString
// 返回:	int 
//---------------------------------------------------------------------------
int lua_settable_StringFromId(lua_State * L, int nIndex, int Id, const char * szString)
{
	if (! lua_istable(L, nIndex))
		return 0;
	lua_pushnumber(L, (double)Id);
	lua_pushstring(L, szString);
	lua_settable(L, nIndex);
	return 1;
}


//---------------------------------------------------------------------------
// 函数:	lua_settable_DoubleFromId
// 功能:	
// 参数:	lua_State * L
// 参数:	int nIndex
// 参数:	int Id
// 参数:	double nNumber
// 返回:	int 
//---------------------------------------------------------------------------
int lua_settable_DoubleFromId(lua_State * L , int nIndex, int Id, double nNumber)
{
	if (! lua_istable(L, nIndex))
		return 0;
	lua_pushnumber(L, (double) Id);
	lua_pushnumber(L, nNumber);
	lua_settable(L, nIndex);
	return 1;
}

//---------------------------------------------------------------------------
// 函数:	lua_settable_IntFromId
// 功能:	
// 参数:	lua_State * L
// 参数:	int nIndex
// 参数:	int Id
// 参数:	int nNumber
// 返回:	int 
//---------------------------------------------------------------------------
int lua_settable_IntFromId(lua_State * L, int nIndex, int Id, int nNumber)
{
	if (! lua_istable(L, nIndex))
		return 0;
	lua_pushnumber(L, (double) Id);
	lua_pushnumber(L, (double) nNumber);
	lua_settable(L, nIndex);
	return 1;
}

//---------------------------------------------------------------------------
// 函数:	lua_settable_CFunFromName
// 功能:	
// 参数:	lua_State * L
// 参数:	int nIndex
// 参数:	const char * szMemberName
// 参数:	lua_CFunction CFun
// 返回:	int 
//---------------------------------------------------------------------------
int lua_settable_CFunFromName(lua_State * L, int nIndex, const char * szMemberName, lua_CFunction CFun)
{
	if (! lua_istable(L, nIndex))
		return 0;
	lua_pushstring(L, szMemberName);
	lua_pushcfunction(L, CFun);
	lua_settable(L, nIndex);
	return 1;
}

//---------------------------------------------------------------------------
// 函数:	lua_settable_CFunFromId
// 功能:	
// 参数:	lua_State * L
// 参数:	int nIndex
// 参数:	int nId
// 参数:	lua_CFunction CFun
// 返回:	int 
//---------------------------------------------------------------------------
int lua_settable_CFunFromId(lua_State * L, int nIndex, int nId, lua_CFunction CFun)
{
	if (! lua_istable(L, nIndex))
		return 0;
	lua_pushnumber(L, nId);
	lua_pushcfunction(L, CFun);
	lua_settable(L, nIndex);
	return 1;
}


//---------------------------------------------------------------------------
// 函数:	Lua_GetValuesFromStack
// 功能:	
// 参数:	lua_State * L
// 参数:	char * cFormat
// 参数:	...
// 返回:	int 
//---------------------------------------------------------------------------
int Lua_GetValuesFromStack(lua_State * L, char * cFormat, ...)	
{

	va_list vlist;
	double* pNumber;
	 const char  *pString;
	   const char ** pStrPoint;
	
	int i = 0;
	int nTopIndex = 0;
	int nIndex = 0;
	int nValueNum = 0;//cFormat的字符长度，表示需要取的参数数量
	
	
	if (! L)
		return 0;
	
	nTopIndex = lua_gettop(L);	
	nValueNum = strlen(cFormat);
	
	if (nTopIndex == 0 || nValueNum == 0)//当堆栈中无数据或不取参数是返回FALSE
		return 0;
	
	if (nTopIndex < nValueNum)
		nIndex = 1 ;
	else
		nIndex = nTopIndex - nValueNum +1;
	
	{
		va_start(vlist, cFormat);     
		
		while (cFormat[i] != '\0')
		{
			
			switch(cFormat[i])
			{
			case 'n'://返回值为数值形,Number,此时Lua只传递double形的值
				{
					pNumber = va_arg(vlist, double *);
					
					if (pNumber == NULL)
						return 0;
					
					if (lua_isnumber(L, nIndex ))
					{

						* pNumber = lua_tonumber(L, nIndex++);
						
					}
					else
					{
					//	ScriptError(LUA_SCRIPT_NOT_NUMBER_ERROR);
						return 0;
					}
					
					
				}
				break;
			case 's'://字符串形
				{
					pStrPoint = va_arg(vlist, const char **);
					
					if (pStrPoint == NULL)
						return 0;
					
					if (lua_isstring(L, nIndex))
					{
						pString = lua_tostring(L, nIndex++);
					
						*pStrPoint = pString;
						
					}
					else
					{
					//	ScriptError(LUA_SCRIPT_NOT_STRING_ERROR);
						return 0;
					}
				}
				break;
				
			}
			
			

			i ++;	
		}
		va_end(vlist);     		/* Reset variable arguments.      */
		
	}
	return	1;
}

// output functions
LUA_API void lua_outerrmsg(const char * szerrmsg)
{
    fprintf(stderr, szerrmsg); 
}

LUA_API void lua_outoutmsg(const char * szoutmsg) 
{
    fprintf(stdout, szoutmsg);
}

LUA_API int lua_execute(lua_State *L)
{
    int status;
    status = lua_call(L, 0, LUA_MULTRET);  /* call main */
    return status;
}
