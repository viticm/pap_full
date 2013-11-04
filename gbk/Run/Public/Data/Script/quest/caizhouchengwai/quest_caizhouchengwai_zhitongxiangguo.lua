--止痛香果

--MisDescBegin
x207005_g_ScriptId = 207005
--x207005_g_MissionIdPre =40
x207005_g_MissionId = 267
x207005_g_MissionKind = 18
x207005_g_MissionLevel = 75
x207005_g_ScriptIdNext = {ScriptId = 207006 ,LV = 1 }
x207005_g_Name	="孛鲁" 
x207005_g_DemandItem ={{id=13010051,num=10}}
x207005_g_noDemandKill ={}	

x207005_g_MissionName="止痛香果"
x207005_g_MissionInfo="    父亲大人的唯一遗愿，就是要我灭了金国！\n \n    我一定不会让他失望，即使再打上六个月，我也不会撤军！\n \n    我非常需要一些止痛的草药，这样会让我的伤舒服一点！在镇龙台处的#c0080C0香果#W就能止痛，帮我去采十株吧。"  --任务描述
x207005_g_MissionTarget="    #G孛鲁#W要你为他去镇龙台处采集十株#c0080C0香果#W。"		
x207005_g_MissionComplete="    谢谢你为我解决了痛楚。"					--完成任务npc说话的话
x207005_g_ContinueInfo="    我要的香果呢？"
--任务奖励
x207005_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x207005_g_ItemBonus={}

--可选物品奖励，最多8种
x207005_g_RadioItemBonus={}

--MisDescEnd
x207005_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x207005_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207005_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207005_g_MissionId) > 0 then
			if x207005_CheckSubmit(sceneId, selfId, targetId) <= 0 then
	                        BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x207005_g_MissionName)
				AddText(sceneId,x207005_g_ContinueInfo)
			        AddText(sceneId,"#Y任务目标#W") 
				AddText(sceneId,x207005_g_MissionTarget) 
				AddText(sceneId,format("\n    香果   %d/%d", LuaFnGetItemCount(sceneId,selfId,x207005_g_DemandItem[1].id),x207005_g_DemandItem[1].num ))
				EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
			end
	
			     
	                if x207005_CheckSubmit(sceneId, selfId, targetId) > 0 then
	                     BeginEvent(sceneId)
	                     AddText(sceneId,"#Y"..x207005_g_MissionName)
			     AddText(sceneId,x207005_g_MissionComplete)
			     --AddText(sceneId,"#Y需要物品#W") 
		     	     --for i, item in x207005_g_DemandItem do  
		     	     --AddItemBonus(sceneId, item.id, item.num)
		     	     --end
		     	     AddMoneyBonus(sceneId, x207005_g_MoneyBonus)
		     	     EndEvent()
	                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x207005_g_ScriptId, x207005_g_MissionId)
	                end
	     

        elseif x207005_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x207005_g_MissionName)
                AddText(sceneId,x207005_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x207005_g_MissionTarget) 
		AddMoneyBonus(sceneId, x207005_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207005_g_ScriptId, x207005_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207005_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207005_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207005_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207005_g_ScriptId, x207005_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207005_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207005_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207005_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==7) then
        	            	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x207005_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x207005_g_MissionId, x207005_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x207005_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x207005_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207005_g_MissionId)
	for i, item in x207005_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x207005_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x207005_g_DemandItem[1].id) == x207005_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207005_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207005_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207005_g_MissionId)
		AddExp(sceneId, selfId, x207005_g_ExpBonus)
		AddMoney(sceneId, selfId, x207005_g_MoneyBonus)
		for i, item in x207005_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x207005_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x207005_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207005_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x207005_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207005_OnItemChanged(sceneId, selfId, itemdataId)

end

