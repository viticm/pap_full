--绝地陵墓

--MisDescBegin
x212004_g_ScriptId = 212004
--x212004_g_MissionIdPre =41
x212004_g_MissionId = 251
x212004_g_MissionKind = 17
x212004_g_MissionLevel = 70
--x212004_g_ScriptIdNext = {ScriptId = 201001 ,LV = 1 }
x212004_g_Name	="拖雷" 
x212004_g_DemandItem ={}
x212004_g_DemandKill ={{id=424,num=20}}

x212004_g_MissionName="绝地陵墓"
x212004_g_MissionInfo="    父汗要我做点事情……，恩，这是很机密的事情，除了木华黎叔叔，谁都不能说，包括皇后也不能！\n \n    我现在心情很乱，这件事就交给你了！我需要找到一个风水宝地，这个地方一定要很隐秘……，恩，是给父……附近死去的兄弟们下葬的。\n \n    这样的一个绝地，就在#G风陵渡口#W东南处，那里还有一股金兵。"  --任务描述
x212004_g_MissionInfo2="，杀了他们，不要留下任何活口。"
x212004_g_MissionTarget="    #G拖雷#W要你到#G风陵渡口#W东南处杀死#R金国士兵#W，不要留下任何活口。"		                                                                                               
x212004_g_MissionComplete="    请你以长生天的名义发誓，这件事永远不要对外再提。"					--完成任务npc说话的话
x212004_g_ContinueInfo="    机密的事情，不能让太多人知道。"
--任务奖励
x212004_g_MoneyBonus = 500

--固定物品奖励，最多8种
x212004_g_ItemBonus={}

--可选物品奖励，最多8种
x212004_g_RadioItemBonus={}

--MisDescEnd
x212004_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x212004_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x212004_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x212004_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x212004_g_MissionId)
		if x212004_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x212004_g_MissionName)
			AddText(sceneId,x212004_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x212004_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死金国士兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x212004_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x212004_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x212004_g_MissionName)
		     AddText(sceneId,x212004_g_MissionComplete)
		     AddMoneyBonus(sceneId, x212004_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x212004_g_ScriptId, x212004_g_MissionId)
                end

        elseif x212004_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x212004_g_MissionName)
                AddText(sceneId,x212004_g_MissionInfo..GetName(sceneId, selfId)..x212004_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x212004_g_MissionTarget) 
		AddMoneyBonus(sceneId, x212004_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x212004_g_ScriptId, x212004_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x212004_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x212004_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x212004_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x212004_g_ScriptId, x212004_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x212004_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x212004_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x212004_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==12) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x212004_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x212004_g_MissionId, x212004_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x212004_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x212004_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x212004_g_MissionId)
	for i, item in pairs(x212004_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x212004_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x212004_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x212004_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x212004_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x212004_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x212004_g_MissionId)
		AddExp(sceneId, selfId, x212004_g_ExpBonus)
		AddMoney(sceneId, selfId, x212004_g_MoneyBonus)
		for i, item in pairs(x212004_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x212004_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x212004_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x212004_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x212004_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x212004_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x212004_g_DemandKill[1].id then 
       		    if num < x212004_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死金国士兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x212004_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x212004_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x212004_OnItemChanged(sceneId, selfId, itemdataId)

end

