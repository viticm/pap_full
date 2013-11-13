
x207016_g_ScriptId = 207016
x207014_g_ScriptId = 207014
x207014_g_MissionId= 15
x207014_g_MissionName="接头"
x207014_g_MissionTarget="    跟#G流浪汉#W接头"	

x207016_g_MissionId = 17
x207014_g_MissionComplete="    老虎在山中呆久了，出去打猎了，它披着一张母羊皮。隔壁的#G矮胖子#W最近见过老虎，你去问问他。"	
x207014_g_MoneyBonus=200



function x207016_OnDefaultEvent(sceneId, selfId, targetId)
       
                BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x207014_g_MissionName)
		AddText(sceneId,x207014_g_MissionComplete)
	        AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x207014_g_MissionTarget) 
		AddMoneyBonus(sceneId, x207014_g_MoneyBonus)	
		EndEvent()
		DispatchMissionContinueInfo(sceneId, selfId, targetId, x207014_g_ScriptId, x207014_g_MissionId)
	     
end

function x207016_OnEnumerate(sceneId, selfId, targetId)
       
       
     --如果玩家完成过这个任务
     --如果已接此任务
     
     	
end
	       