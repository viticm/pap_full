//---------------------------------------------------------------------------
// Script Engine by FireFox
// Desc:	�ű�����ӿ�
//---------------------------------------------------------------------------
#ifndef FoxScript_H
#define FoxScript_H
//---------------------------------------------------------------------------
class ENGINE_API FoxScript
{
public:
	FoxScript();
	virtual ~FoxScript();
	virtual BOOL Init();
	virtual void Exit();
	virtual BOOL Load(char* FileName);
	virtual	BOOL Compile(char* FileName);
	virtual	BOOL Execute();
	virtual	BOOL CallFunction(LPSTR cFuncName, int nResults, LPCSTR cFormat,...);
	virtual BOOL RegisterFunction(LPSTR FuncName, void* Func);
	
};
//---------------------------------------------------------------------------
#endif  //FoxScript_H
