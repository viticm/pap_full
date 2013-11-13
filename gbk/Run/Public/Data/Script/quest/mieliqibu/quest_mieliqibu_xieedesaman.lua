--邪恶的萨满

--MisDescBegin
x201004_g_ScriptId = 201004
x201004_g_MissionIdPre =84
x201004_g_MissionId = 86
x201004_g_MissionKind = 2
x201004_g_MissionLevel = 10
x201004_g_ScriptIdNext = {ScriptId = 201012 ,LV = 1 }
x201004_g_Name	="博尔术" 
x201004_g_DemandItem ={}
x201004_g_DemandKill ={{id=341,num=15}}

x201004_g_MissionName="邪恶的萨满"
x201004_g_MissionInfo="    萨满能够跟天神共语，传达天神的旨意，他们拥有长生天赐予的无穷能量，预知未来。\n \n    但是，蔑里乞的萨满已经入魔了，在他们的内心除了贪婪，便是欲望。\n \n    恩……这就是为什么我不敢鲁莽突围的原因，那些邪恶的萨满让我闻到了危险的气息，我一定要确保孛儿帖的绝对安全。    "  --任务描述
x201004_g_MissionInfo2="，附近那些邪恶的萨满是我们的隐患，不要对他们手下留情。"
x201004_g_MissionTarget="    杀死15名#G马场#W东面的#R邪恶的萨满#W，然后回去告诉#G博尔术#W。"		                                                                                               
x201004_g_MissionComplete="    做得好，你为我解决了很大的难题。"					--完成任务npc说话的话
x201004_g_ContinueInfo="    那些萨满很邪恶，不杀了他们我无法突围。"
--任务奖励
x201004_g_MoneyBonus = 2
--固定物品奖励，最多8种
x201004_g_ItemBonus={}

--可选物品奖励，最多8种
x201004_g_RadioItemBonus={}

--MisDescEnd
x201004_g_ExpBonus = 80
--**********************************

--任务入口函数

--**********************************

function x201004_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x201004_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x201004_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x201004_g_MissionId)
		if x201004_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x201004_g_MissionName)
			AddText(sceneId,x201004_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x201004_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死邪恶的萨满   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x201004_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x201004_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x201004_g_MissionName)
		     AddText(sceneId,x201004_g_MissionComplete)
		     AddMoneyBonus(sceneId, x201004_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x201004_g_ScriptId, x201004_g_MissionId)
                end

        elseif x201004_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x201004_g_MissionName)
                AddText(sceneId,x201004_g_MissionInfo..GetName(sceneId, selfId)..x201004_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x201004_g_MissionTarget) 
		AddMoneyBonus(sceneId, x201004_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x201004_g_ScriptId, x201004_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x201004_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x201004_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x201004_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x201004_g_ScriptId, x201004_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x201004_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x201004_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x201004_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==1) then
		if IsMissionHaveDone(sceneId, selfId, x201004_g_MissionIdPre) > 0 then
        	    	return 1
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x201004_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x201004_g_MissionId, x201004_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x201004_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x201004_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x201004_g_MissionId)
	for i, item in pairs(x201004_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x201004_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x201004_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x201004_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x201004_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x201004_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x201004_g_MissionId)
		AddExp(sceneId, selfId, x201004_g_ExpBonus)
		AddMoney(sceneId, selfId, x201004_g_MoneyBonus)
		for i, item in pairs(x201004_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x201004_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x201004_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x201004_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x201004_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x201004_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x201004_g_DemandKill[1].id then 
       		    if num < x201004_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死邪恶的萨满   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x201004_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x201004_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x201004_OnItemChanged(sceneId, selfId, itemdataId)

end

