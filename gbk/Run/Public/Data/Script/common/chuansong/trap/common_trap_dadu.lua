

x300455_g_ScriptId = 300455
x300455_g_TransScriptId = 800019
x300455_g_TransPos="dadutongwangbianjing"


--玩家进入一个 area 时触发
function x300455_OnEnterArea( sceneId, selfId )
	CallScriptFunction(x300455_g_TransScriptId, "TransferToWorld",sceneId,selfId,x300455_g_TransPos)
end

--玩家在一个 area 呆了一段时间没走则定时触发
function x300455_OnTimer( sceneId, monsterobjid )

end

--玩家离开一个 area 时触发
function x300455_OnLeaveArea( sceneId, monsterobjid )

end


function x300455_OnDefaultEvent( sceneId, monsterobjid )

end

