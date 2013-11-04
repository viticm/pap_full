

x300460_g_ScriptId = 300460
x300460_g_TransScriptId = 800019
x300460_g_TransPos="xinshoucun_02"


--玩家进入一个 area 时触发
function x300460_OnEnterArea( sceneId, selfId )
	CallScriptFunction(x300460_g_TransScriptId, "TransferToWorld",sceneId,selfId,x300460_g_TransPos)
end

--玩家在一个 area 呆了一段时间没走则定时触发
function x300460_OnTimer( sceneId, monsterobjid )

end

--玩家离开一个 area 时触发
function x300460_OnLeaveArea( sceneId, monsterobjid )

end


function x300460_OnDefaultEvent( sceneId, monsterobjid )

end

