--当归

--MisDescBegin
x208011_g_ScriptId = 208011
--x208011_g_MissionIdPre =40
x208011_g_MissionId = 65
x208011_g_MissionKind = 12
x208011_g_MissionLevel = 60
--x208011_g_ScriptIdNext = {ScriptId = 205005 ,LV = 1 }
x208011_g_Name	="忽兰王妃" 
x208011_g_DemandItem ={{id=13010013,num=10}}
x208011_g_noDemandKill ={}	

x208011_g_MissionName="当归"
x208011_g_MissionInfo="    大汗为了战事，费尽了精力，这几天起来身子有些虚弱，我听当地的百姓说，这附近有#c0080C0当归#W，你去帮我采十株来。"  --任务描述
x208011_g_MissionTarget="    采十株#c0080C0当归#W，拿回来给#G忽兰王妃#W。"		
x208011_g_MissionComplete="    采集当归极为容易，只是小女子要照顾大汗，这些事就靠你了"					--完成任务npc说话的话
x208011_g_ContinueInfo="    很好，很及时！有了当归，就可以做生姜羊肉汤了，能益气补血、温中祛寒的作用。"
--任务奖励
x208011_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x208011_g_ItemBonus={}

--可选物品奖励，最多8种
x208011_g_RadioItemBonus={}

--MisDescEnd
x208011_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x208011_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x208011_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x208011_g_MissionId) > 0 then
			if x208011_CheckSubmit(sceneId, selfId, targetId) <= 0 then
	                        BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x208011_g_MissionName)
				AddText(sceneId,x208011_g_ContinueInfo)
			        AddText(sceneId,"#Y任务目标#W") 
				AddText(sceneId,x208011_g_MissionTarget) 
				AddText(sceneId,format("\n    当归   %d/%d", LuaFnGetItemCount(sceneId,selfId,x208011_g_DemandItem[1].id),x208011_g_DemandItem[1].num ))
				EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
			end
	
			     
	                if x208011_CheckSubmit(sceneId, selfId, targetId) > 0 then
	                     BeginEvent(sceneId)
	                     AddText(sceneId,"#Y"..x208011_g_MissionName)
			     AddText(sceneId,x208011_g_MissionComplete)
			     --AddText(sceneId,"#Y需要物品#W") 
		     	     --for i, item in x208011_g_DemandItem do  
		     	     --AddItemBonus(sceneId, item.id, item.num)
		     	     --end
		     	     AddMoneyBonus(sceneId, x208011_g_MoneyBonus)
		     	     EndEvent()
	                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x208011_g_ScriptId, x208011_g_MissionId)
	                end
	     

        elseif x208011_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x208011_g_MissionName)
                AddText(sceneId,x208011_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x208011_g_MissionTarget) 
		AddMoneyBonus(sceneId, x208011_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x208011_g_ScriptId, x208011_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x208011_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x208011_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x208011_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x208011_g_ScriptId, x208011_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x208011_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x208011_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x208011_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==8) then
        	            	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x208011_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x208011_g_MissionId, x208011_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x208011_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x208011_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x208011_g_MissionId)
	for i, item in x208011_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x208011_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x208011_g_DemandItem[1].id) == x208011_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x208011_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x208011_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x208011_g_MissionId)
		AddExp(sceneId, selfId, x208011_g_ExpBonus)
		AddMoney(sceneId, selfId, x208011_g_MoneyBonus)
		for i, item in x208011_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x208011_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x208011_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x208011_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x208011_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x208011_OnItemChanged(sceneId, selfId, itemdataId)

end

