

x300456_g_ScriptId = 300456
x300456_g_TransScriptId = 800019
x300456_g_TransPos="wangchengtongwangbianjing"


--玩家进入一个 area 时触发
function x300456_OnEnterArea( sceneId, selfId )
	CallScriptFunction(x300456_g_TransScriptId, "TransferToWorld",sceneId,selfId,x300456_g_TransPos)
end

--玩家在一个 area 呆了一段时间没走则定时触发
function x300456_OnTimer( sceneId, monsterobjid )

end

--玩家离开一个 area 时触发
function x300456_OnLeaveArea( sceneId, monsterobjid )

end


function x300456_OnDefaultEvent( sceneId, monsterobjid )

end

