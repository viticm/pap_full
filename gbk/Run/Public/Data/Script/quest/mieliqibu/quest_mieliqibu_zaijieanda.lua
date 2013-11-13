--再结安答

--MisDescBegin
x201006_g_ScriptId = 201006
x201006_g_MissionIdPre =87
x201006_g_MissionId = 88
x201006_g_MissionKind = 2
x201006_g_MissionLevel = 10
x201006_g_ScriptIdNext = {ScriptId = 201013 ,LV = 1 }
x201006_g_Name	="札木合" 
x201006_g_DemandItem ={}
x201006_g_DemandKill ={{id=473,num=15}}

x201006_g_MissionName="再结安答"
x201006_g_MissionInfo="    等铁木真找到他的妻子后，我要跟他再结一次安答！札木合和铁木真三结安答的佳话，一定会美传草原！\n \n    这是上天的安排，命运注定了我们两兄弟永远在一起！从今以后同生死，共患难，永远不相弃！\n \n    我勇敢的战士，去战胜#G东营#W北面的那些#R蔑里乞巡卫#W。"  --任务描述
x201006_g_MissionTarget="    杀死15名#G东营#W北面的#R蔑里乞巡卫#W，然后回去告诉#G札木合#W。"		                                                                                               
x201006_g_MissionComplete="    做得好，你为我解决了很大的难题。"					--完成任务npc说话的话
x201006_g_ContinueInfo="    那些萨满很邪恶，不杀了他们我无法突围。"
--任务奖励
x201006_g_MoneyBonus = 1
--固定物品奖励，最多8种
x201006_g_ItemBonus={}

--可选物品奖励，最多8种
x201006_g_RadioItemBonus={}

--MisDescEnd
x201006_g_ExpBonus = 60
--**********************************

--任务入口函数

--**********************************

function x201006_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x201006_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x201006_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x201006_g_MissionId)
		if x201006_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x201006_g_MissionName)
			AddText(sceneId,x201006_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x201006_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死蔑里乞巡卫   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x201006_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x201006_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x201006_g_MissionName)
		     AddText(sceneId,x201006_g_MissionComplete)
		     AddMoneyBonus(sceneId, x201006_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x201006_g_ScriptId, x201006_g_MissionId)
                end

        elseif x201006_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x201006_g_MissionName)
                AddText(sceneId,x201006_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x201006_g_MissionTarget) 
		AddMoneyBonus(sceneId, x201006_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x201006_g_ScriptId, x201006_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x201006_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x201006_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x201006_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x201006_g_ScriptId, x201006_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x201006_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x201006_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x201006_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==1) then
		if IsMissionHaveDone(sceneId, selfId, x201006_g_MissionIdPre) > 0 then
        	    	return 1
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x201006_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x201006_g_MissionId, x201006_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x201006_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x201006_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x201006_g_MissionId)
	for i, item in pairs(x201006_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x201006_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x201006_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x201006_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x201006_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x201006_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x201006_g_MissionId)
		AddExp(sceneId, selfId, x201006_g_ExpBonus)
		AddMoney(sceneId, selfId, x201006_g_MoneyBonus)
		for i, item in pairs(x201006_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x201006_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x201006_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x201006_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x201006_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x201006_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x201006_g_DemandKill[1].id then 
       		    if num < x201006_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死蔑里乞巡卫   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x201006_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x201006_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x201006_OnItemChanged(sceneId, selfId, itemdataId)

end

