--安定民心

--MisDescBegin
x213001_g_ScriptId = 213001
--x213001_g_MissionIdPre =40
x213001_g_MissionId = 146
x213001_g_MissionKind = 24
x213001_g_MissionLevel = 125
x213001_g_ScriptIdNext = {ScriptId = 213002,LV = 1 }
x213001_g_Name	="昔班" 
x213001_g_DemandItem ={}
x213001_g_noDemandKill ={}	

x213001_g_MissionName="安定民心"
x213001_g_MissionInfo="    看见这些巨大的投石机了吗？我在这每发射一块石头就宣布了某些匈牙利认得末日。他们已经熬不住了，最近已经开始有平民逃出城。\n \n    我这有一封告示，内容是，只要匈牙利人来到我大蒙古的营地投降，我们就会赦免他们。\n \n    你去把这告示贴到三个桥头上吧。让这些可怜的匈牙利人安心，停止没有意义的逃亡吧。"  --任务描述
x213001_g_MissionTarget="    把#G昔班#W的告示贴到三个桥头去。"		
x213001_g_MissionComplete="    这几个告示很有效果，这边立刻就挤满了匈牙利的平民。这可省了我们不少麻烦。"					--完成任务npc说话的话
x213001_g_ContinueInfo="    如果这些平民都逃跑了，我们以后怎么找到他们呢？"
--任务奖励
x213001_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x213001_g_ItemBonus={}

--可选物品奖励，最多8种
x213001_g_RadioItemBonus={}

--MisDescEnd
x213001_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x213001_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x213001_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x213001_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x213001_g_MissionId)
			if x213001_CheckSubmit(sceneId, selfId, targetId) <= 0 then
	                        BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x213001_g_MissionName)
				AddText(sceneId,x213001_g_ContinueInfo)
			        AddText(sceneId,"#Y任务目标#W") 
				AddText(sceneId,x213001_g_MissionTarget) 
				AddText(sceneId,format("\n    在马尔基特桥张贴告示   %d/1\n    在伊丽莎白桥张贴告示   %d/1\n    在自由桥张贴告示   %d/1", GetMissionParam(sceneId,selfId,misIndex,0), GetMissionParam(sceneId,selfId,misIndex,1), GetMissionParam(sceneId,selfId,misIndex,2) ))
				EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
			end
	
			     
	                if x213001_CheckSubmit(sceneId, selfId, targetId) > 0 then
	                     BeginEvent(sceneId)
	                     AddText(sceneId,"#Y"..x213001_g_MissionName)
			     AddText(sceneId,x213001_g_MissionComplete)
			     AddMoneyBonus(sceneId, x213001_g_MoneyBonus)
			     EndEvent()
	                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x213001_g_ScriptId, x213001_g_MissionId)
	                end
	     

        elseif x213001_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x213001_g_MissionName)
                AddText(sceneId,x213001_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x213001_g_MissionTarget) 
		AddMoneyBonus(sceneId, x213001_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x213001_g_ScriptId, x213001_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x213001_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x213001_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x213001_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x213001_g_ScriptId, x213001_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x213001_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x213001_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x213001_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==13) then
        	            	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x213001_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x213001_g_MissionId, x213001_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x213001_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x213001_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x213001_g_MissionId)
	for i, item in x213001_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x213001_CheckSubmit( sceneId, selfId, targetId)

	misIndex = GetMissionIndexByID(sceneId,selfId,x213001_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == 1 then
		if GetMissionParam(sceneId,selfId,misIndex,1) == 1 then
			if GetMissionParam(sceneId,selfId,misIndex,2) == 1 then
	        		return 1
	        	end
	        end
	end
	return 0

end



--**********************************

--提交

--**********************************

function x213001_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x213001_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x213001_g_MissionId)
		AddExp(sceneId, selfId, x213001_g_ExpBonus)
		AddMoney(sceneId, selfId, x213001_g_MoneyBonus)
		for i, item in x213001_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x213001_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x213001_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x213001_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x213001_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x213001_OnItemChanged(sceneId, selfId, itemdataId)

end

