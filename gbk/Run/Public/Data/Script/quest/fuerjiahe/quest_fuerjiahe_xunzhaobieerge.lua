--寻找别儿哥

--MisDescBegin
x223012_g_ScriptId = 223012
--x223012_g_MissionIdPre =83
x223012_g_MissionId = 304
x223012_g_MissionKind = 20
x223012_g_MissionLevel = 100
x223012_g_ScriptIdNext = {ScriptId = 223013 ,LV = 1 }
x223012_g_Name	="速不台"
x223012_g_Name2	="别儿哥" 
x223012_g_DemandItem ={}
--x223012_g_noDemandKill ={{id=301,num=1}}	

x223012_g_MissionName="寻找别儿哥"
x223012_g_MissionInfo="    被钦察人伏击的先锋已经回到了营地，我们清点了人数，很不幸的是，我们的以为将领失踪在战场上。\n \n    不过，直觉告诉我，他不会被敌人俘虏，依然躲在暗处等待我们的救援，"  --任务描述
x223012_g_MissionInfo2="，你一定要找到他，他叫#G别儿哥#W。"
x223012_g_MissionTarget="    #G别儿哥#W失踪在这个战场上，很有可能躲在某处，你要找到他。"		
x223012_g_MissionComplete="    你，你是速不台将军的勇士？\n \n<一个浑身血渍的人见到你，两眼发出亮光>  终于见到希望了，我以为我会死在这个鬼地方。"					--完成任务npc说话的话
--x223012_g_ContinueInfo="    不管付出多大代价，也要把那件东西给拿回来。"
--任务奖励
x223012_g_MoneyBonus = 200
--固定物品奖励，最多8种
x223012_g_ItemBonus={}

--可选物品奖励，最多8种
x223012_g_RadioItemBonus={}

--MisDescEnd
x223012_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x223012_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x223012_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x223012_g_MissionId) > 0 then
		
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x223012_g_MissionName)
		     AddText(sceneId,x223012_g_MissionComplete)
		     AddMoneyBonus(sceneId, x223012_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x223012_g_ScriptId, x223012_g_MissionId)
                

        elseif x223012_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x223012_g_MissionName)
                AddText(sceneId,x223012_g_MissionInfo..GetName(sceneId, selfId)..x223012_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x223012_g_MissionTarget) 
		AddMoneyBonus(sceneId, x223012_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x223012_g_ScriptId, x223012_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x223012_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x223012_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x223012_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x223012_g_ScriptId, x223012_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x223012_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x223012_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x223012_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==17) then
        		if (GetName(sceneId,targetId)==x223012_g_Name) then
	        	        if IsHaveMission(sceneId,selfId, x223012_g_MissionId)<= 0 then
	        	            	return 1
	        	        end
	        	end
			if (GetName(sceneId,targetId)==x223012_g_Name2) then
				    if IsHaveMission(sceneId,selfId, x223012_g_MissionId) > 0 then
				    	return 1
	        	            end
	        	end
	end
        return 0
	
end

--**********************************

--接受

--**********************************

function x223012_OnAccept(sceneId, selfId)

	                                                  
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x223012_g_MissionId, x223012_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x223012_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
	     	                                    
	     
end



--**********************************

--放弃

--**********************************

function x223012_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x223012_g_MissionId)
	for i, item in pairs(x223012_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x223012_CheckSubmit( sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x223012_g_Name2) then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x223012_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x223012_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x223012_g_MissionId)
		AddExp(sceneId, selfId, x223012_g_ExpBonus)
		AddMoney(sceneId, selfId, x223012_g_MoneyBonus)
		for i, item in pairs(x223012_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x223012_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x223012_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x223012_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x223012_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x223012_OnItemChanged(sceneId, selfId, itemdataId)

end

