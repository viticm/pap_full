

x300458_g_ScriptId = 300458
x300458_g_TransScriptId = 800019
x300458_g_TransPos="bianjingtongwangwangcheng"


--玩家进入一个 area 时触发
function x300458_OnEnterArea( sceneId, selfId )
	CallScriptFunction(x300458_g_TransScriptId, "TransferToWorld",sceneId,selfId,x300458_g_TransPos)
end

--玩家在一个 area 呆了一段时间没走则定时触发
function x300458_OnTimer( sceneId, monsterobjid )

end

--玩家离开一个 area 时触发
function x300458_OnLeaveArea( sceneId, monsterobjid )

end


function x300458_OnDefaultEvent( sceneId, monsterobjid )

end

