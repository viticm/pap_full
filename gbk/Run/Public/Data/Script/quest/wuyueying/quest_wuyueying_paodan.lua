--炮弹

--MisDescBegin
x217004_g_ScriptId = 217004
--x217004_g_MissionIdPre =41
x217004_g_MissionId = 176
x217004_g_MissionKind = 6
x217004_g_MissionLevel = 30
x217004_g_ScriptIdNext = {ScriptId = 217005 ,LV = 1 }
x217004_g_Name	="哈撒儿" 
x217004_g_DemandItem ={{id=13010068,num=1}}
--x217004_g_DemandKill ={{id=309,num=20}}

x217004_g_MissionName="炮弹"
x217004_g_MissionInfo="    炮弹，我们前线的#c0080C0炮弹#W即将用光！到东面的营地把炮弹给我拿来，我喜欢听到他们的嗥叫，他们肉体被炮弹撕裂的声音，那鲜红的血让我感到复仇的快感！"  --任务描述
x217004_g_MissionTarget="    到东面营地给#G哈撒儿#W拿来#c0080C0炮弹#W"		                                                                                               
x217004_g_MissionComplete="    我们的火器营拥有世界上最先进的武器。"					--完成任务npc说话的话
x217004_g_ContinueInfo="    我需要的炮弹在哪里？"
--任务奖励
x217004_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x217004_g_ItemBonus={}

--可选物品奖励，最多8种
x217004_g_RadioItemBonus={}

--MisDescEnd
x217004_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x217004_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x217004_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x217004_g_MissionId) > 0 then
		if (GetName(sceneId,targetId)==x217004_g_Name) then 
			if x217004_CheckSubmit(sceneId, selfId, targetId) <= 0 then
	                        BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x217004_g_MissionName)
				AddText(sceneId,x217004_g_ContinueInfo)
			        AddText(sceneId,"#Y任务目标#W") 
				AddText(sceneId,x217004_g_MissionTarget) 
				AddText(sceneId,format("\n    炮弹   %d/%d", LuaFnGetItemCount(sceneId,selfId,x217004_g_DemandItem[1].id),x217004_g_DemandItem[1].num ))
				EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
			end
	
			     
	                if x217004_CheckSubmit(sceneId, selfId, targetId) > 0 then
	                     BeginEvent(sceneId)
	                     AddText(sceneId,"#Y"..x217004_g_MissionName)
			     AddText(sceneId,x217004_g_MissionComplete)
			     --AddText(sceneId,"#Y需要物品#W") 
		     	     --for i, item in x217004_g_DemandItem do  
		     	     --AddItemBonus(sceneId, item.id, item.num)
		     	     --end
		     	     AddMoneyBonus(sceneId, x217004_g_MoneyBonus)
		     	     EndEvent()
	                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x217004_g_ScriptId, x217004_g_MissionId)
	                end
	        end
	        

        elseif x217004_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x217004_g_MissionName)
                AddText(sceneId,x217004_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x217004_g_MissionTarget) 
		AddMoneyBonus(sceneId, x217004_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x217004_g_ScriptId, x217004_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x217004_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x217004_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x217004_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x217004_g_ScriptId, x217004_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x217004_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x217004_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x217004_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==20) then
		    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x217004_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x217004_g_MissionId, x217004_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x217004_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x217004_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x217004_g_MissionId)
	for i, item in x217004_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x217004_CheckSubmit( sceneId, selfId, targetId)
	if LuaFnGetItemCount(sceneId,selfId,x217004_g_DemandItem[1].id) == x217004_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x217004_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x217004_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x217004_g_MissionId)
		AddExp(sceneId, selfId, x217004_g_ExpBonus)
		AddMoney(sceneId, selfId, x217004_g_MoneyBonus)
		for i, item in x217004_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x217004_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x217004_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x217004_OnKillObject(sceneId, selfId, objdataId)
	

end



--**********************************

--进入区域事件

--**********************************

function x217004_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x217004_OnItemChanged(sceneId, selfId, itemdataId)

end

