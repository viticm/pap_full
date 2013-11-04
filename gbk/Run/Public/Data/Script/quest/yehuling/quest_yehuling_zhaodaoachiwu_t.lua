
x207007_g_ScriptId = 207007
x207005_g_MissionId= 6


x207007_g_MissionId = 8
x207005_g_MissionComplete="比我安答还亲的勇士，你终于了，这里常有金兵来抓间谍，我不能不小心，请原谅我的冒昧。"	
x207005_g_MoneyBonus=200



function x207007_OnDefaultEvent(sceneId, selfId, targetId)
       
	BeginEvent(sceneId)
	AddText(sceneId,x207005_g_MissionComplete)
        AddMoneyBonus(sceneId, x207005_g_MoneyBonus) 
	EndEvent()

	DispatchMissionContinueInfo(sceneId, selfId, targetId, x207005_g_ScriptId, x207005_g_MissionId)
	     
end

function x207007_OnEnumerate(sceneId, selfId, targetId)
       
       
     --如果玩家完成过这个任务
     if IsMissionHaveDone(sceneId, selfId, x207007_g_MissionId) > 0 then
     	return 
     end
     --如果已接此任务
     if IsHaveMission(sceneId,selfId, x207005_g_MissionId) > 0 then
         
         
         
                    end
     	
end
	       