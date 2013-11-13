

x300457_g_ScriptId = 300457
x300457_g_TransScriptId = 800019
x300457_g_TransPos="bianjingtongwangdadu"


--玩家进入一个 area 时触发
function x300457_OnEnterArea( sceneId, selfId )
	CallScriptFunction(x300457_g_TransScriptId, "TransferToWorld",sceneId,selfId,x300457_g_TransPos)
end

--玩家在一个 area 呆了一段时间没走则定时触发
function x300457_OnTimer( sceneId, monsterobjid )

end

--玩家离开一个 area 时触发
function x300457_OnLeaveArea( sceneId, monsterobjid )

end


function x300457_OnDefaultEvent( sceneId, monsterobjid )

end

