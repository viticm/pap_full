

x300461_g_ScriptId = 300461
x300461_g_TransScriptId = 800019
x300461_g_TransPos="taohuadao"


--玩家进入一个 area 时触发
function x300461_OnEnterArea( sceneId, selfId )
	CallScriptFunction(x300461_g_TransScriptId, "TransferToWorld",sceneId,selfId,x300461_g_TransPos)
end

--玩家在一个 area 呆了一段时间没走则定时触发
function x300461_OnTimer( sceneId, monsterobjid )

end

--玩家离开一个 area 时触发
function x300461_OnLeaveArea( sceneId, monsterobjid )

end


function x300461_OnDefaultEvent( sceneId, monsterobjid )

end

