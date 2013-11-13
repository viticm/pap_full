

x300459_g_ScriptId = 300459
x300459_g_TransScriptId = 800019
x300459_g_TransPos="yangliucun"


--玩家进入一个 area 时触发
function x300459_OnEnterArea( sceneId, selfId )
	CallScriptFunction(x300459_g_TransScriptId, "TransferToWorld",sceneId,selfId,x300459_g_TransPos)
end

--玩家在一个 area 呆了一段时间没走则定时触发
function x300459_OnTimer( sceneId, monsterobjid )

end

--玩家离开一个 area 时触发
function x300459_OnLeaveArea( sceneId, monsterobjid )

end


function x300459_OnDefaultEvent( sceneId, monsterobjid )

end

