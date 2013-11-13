--乃蛮残部

--MisDescBegin
x204000_g_ScriptId = 204000
--x204000_g_MissionIdPre =41
x204000_g_MissionId = 95
x204000_g_MissionKind = 9
x204000_g_MissionLevel = 45
x204000_g_ScriptIdNext = {ScriptId = 204001 ,LV = 1 }
x204000_g_Name	="成吉思汗" 
x204000_g_DemandItem ={}
x204000_g_DemandKill ={{id=346,num=20}}

x204000_g_MissionName="乃蛮残部"
x204000_g_MissionInfo="    乃蛮残存势力，聚集在北郊一带，他们人数众多，兵强马壮，为首的人蓄谋已久。\n \n    一定不能让这些人存在，我已经决定派速不台大将担任围剿的先锋。\n \n    速不台需要一名能干的副将协助他，"  --任务描述
x204000_g_MissionInfo2="，他点名了让你和他一起作战，就由你去完成这个光荣的任务吧，到北郊一带的东面，把乃蛮的残存势力给消灭。"
x204000_g_MissionTarget="    #G成吉思汗#W命你杀死北郊东面一带的20名#R乃蛮士兵#W。"		                                                                                               
x204000_g_MissionComplete="    看到你回来很高兴。"					--完成任务npc说话的话
x204000_g_ContinueInfo="    看到那些乃蛮残部了吗？"
--任务奖励
x204000_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x204000_g_ItemBonus={}

--可选物品奖励，最多8种
x204000_g_RadioItemBonus={}

--MisDescEnd
x204000_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x204000_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x204000_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x204000_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x204000_g_MissionId)
		if x204000_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x204000_g_MissionName)
			AddText(sceneId,x204000_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x204000_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死乃蛮士兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x204000_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x204000_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x204000_g_MissionName)
		     AddText(sceneId,x204000_g_MissionComplete)
		     AddMoneyBonus(sceneId, x204000_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x204000_g_ScriptId, x204000_g_MissionId)
                end

        elseif x204000_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x204000_g_MissionName)
                AddText(sceneId,x204000_g_MissionInfo..GetName(sceneId, selfId)..x204000_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x204000_g_MissionTarget) 
		AddMoneyBonus(sceneId, x204000_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x204000_g_ScriptId, x204000_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x204000_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x204000_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x204000_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x204000_g_ScriptId, x204000_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x204000_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x204000_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x204000_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==4) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x204000_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x204000_g_MissionId, x204000_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x204000_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x204000_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x204000_g_MissionId)
	for i, item in pairs(x204000_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x204000_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x204000_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x204000_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x204000_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x204000_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x204000_g_MissionId)
		AddExp(sceneId, selfId, x204000_g_ExpBonus)
		AddMoney(sceneId, selfId, x204000_g_MoneyBonus)
		for i, item in pairs(x204000_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x204000_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x204000_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x204000_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x204000_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x204000_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x204000_g_DemandKill[1].id then 
       		    if num < x204000_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死乃蛮士兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x204000_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x204000_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x204000_OnItemChanged(sceneId, selfId, itemdataId)

end

