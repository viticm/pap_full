
x207006_g_ScriptId = 207006
x207005_g_ScriptId = 207005
x207005_g_MissionId= 6


x207006_g_MissionId = 7
x207005_g_MissionComplete="我们的守城将军威武无比，蒙军注定要失败，请不要在我面前胡言乱语，不然抓你去见官。"	
x207005_g_MoneyBonus=200



function x207006_OnDefaultEvent(sceneId, selfId, targetId)

       
	BeginEvent(sceneId)
	AddText(sceneId,x207005_g_MissionComplete)
        EndEvent()

	DispatchEventList(sceneId, selfId, targetId)
end


function x207006_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207006_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207005_g_MissionId) > 0 then
	    
        end
	
end
	       