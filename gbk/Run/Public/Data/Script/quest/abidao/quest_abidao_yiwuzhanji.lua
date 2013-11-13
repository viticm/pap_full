--贻误战机

--MisDescBegin
x203006_g_ScriptId = 203006
--x203006_g_MissionIdPre =40
x203006_g_MissionId = 74
x203006_g_MissionKind = 13
x203006_g_MissionLevel = 50
--x203006_g_ScriptIdNext = {ScriptId = 205005 ,LV = 1 }
x203006_g_Name	="郭靖" 
x203006_g_Name2	="油桐树" 
x203006_g_DemandItem ={{id=13010020,num=5}}
x203006_g_noDemandKill ={}	

x203006_g_MissionName="贻误战机"
x203006_g_MissionInfo="    我家养的大雕刚刚给我把前线的战况稍过来了，那边发生了一些事，让我感到惋惜。\n \n    信里说，术赤王子和察合台王子在攻城的时候发生了矛盾，两个主将意见不统一，影响了将士们的斗志。不过，好在成吉思汗已经派三王子窝阔台去前往，担任主帅。\n \n     窝阔台准备用火油炮强攻，不过火油炮剩下不多了。在西南面有一片油桐树，它的籽可以轧成油，"
x203006_g_MissionInfo2="，你帮我弄点油桐籽来，不过要小心附近的敌人。"  --任务描述
x203006_g_MissionTarget="    收集5袋#c0080C0油桐籽#W，带回来给#G郭靖#W。"		
x203006_g_MissionComplete="    探子来报，有一批士兵暗藏在油桐树附近，我真担心你出事，看到你回来，我终于放心了。"					--完成任务npc说话的话
x203006_g_ContinueInfo="    攻城在即，时间很紧，我们急需油桐籽。"
--任务奖励
x203006_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x203006_g_ItemBonus={}

--可选物品奖励，最多8种
x203006_g_RadioItemBonus={}

--MisDescEnd
x203006_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x203006_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x203006_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x203006_g_MissionId) > 0 then
			if x203006_CheckSubmit(sceneId, selfId, targetId) <= 0 then
	                        BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x203006_g_MissionName)
				AddText(sceneId,x203006_g_ContinueInfo)
			        AddText(sceneId,"#Y任务目标#W") 
				AddText(sceneId,x203006_g_MissionTarget) 
				AddText(sceneId,format("\n    一袋油桐籽   %d/%d", LuaFnGetItemCount(sceneId,selfId,x203006_g_DemandItem[1].id),x203006_g_DemandItem[1].num ))
				EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
			end
	
			     
	                if x203006_CheckSubmit(sceneId, selfId, targetId) > 0 then
	                     BeginEvent(sceneId)
	                     AddText(sceneId,"#Y"..x203006_g_MissionName)
			     AddText(sceneId,x203006_g_MissionComplete)
			     --AddText(sceneId,"#Y需要物品#W") 
		     	     --for i, item in pairs(x203006_g_DemandItem) do  
		     	     --AddItemBonus(sceneId, item.id, item.num)
		     	     --end
		     	     AddMoneyBonus(sceneId, x203006_g_MoneyBonus)
		     	     EndEvent()
		     	     DispatchMissionContinueInfo(sceneId, selfId, targetId, x203006_g_ScriptId, x203006_g_MissionId)
	                end
	        
	elseif x203006_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x203006_g_MissionName)
                AddText(sceneId,x203006_g_MissionInfo..GetName(sceneId, selfId)..x203006_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x203006_g_MissionTarget) 
		AddMoneyBonus(sceneId, x203006_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x203006_g_ScriptId, x203006_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x203006_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x203006_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x203006_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x203006_g_ScriptId, x203006_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x203006_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x203006_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x203006_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==3) then
        	            	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x203006_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x203006_g_MissionId, x203006_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x203006_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x203006_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x203006_g_MissionId)
	for i, item in pairs(x203006_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x203006_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x203006_g_DemandItem[1].id) == x203006_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x203006_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x203006_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x203006_g_MissionId)
		AddExp(sceneId, selfId, x203006_g_ExpBonus)
		AddMoney(sceneId, selfId, x203006_g_MoneyBonus)
		for i, item in pairs(x203006_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x203006_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x203006_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x203006_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x203006_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x203006_OnItemChanged(sceneId, selfId, itemdataId)

end

