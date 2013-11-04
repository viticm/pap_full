--青年布科夫

--MisDescBegin
x225006_g_ScriptId = 225006
x225006_g_MissionIdPre =327
x225006_g_MissionId = 328
x225006_g_MissionKind = 22
x225006_g_MissionLevel = 110
--x225006_g_ScriptIdNext = {ScriptId = 225005 ,LV = 1 }
x225006_g_Name	="蒙哥" 
x225006_g_DemandItem ={}
x225006_g_DemandKill ={{id=438,num=1}}

x225006_g_MissionName="青年布科夫"
x225006_g_MissionInfo="    这次去袭击#G贵族区#W，有几个勇士阵亡了。听说是被一个叫布科夫的贵族青年杀死了。\n \n    我不能允许这种事情再发生。你是精锐中的精锐，你去给我杀了#R布科夫#W，为阵亡的勇士复仇。"  --任务描述
x225006_g_MissionTarget="    杀死#R布科夫#W，给#G蒙哥#W的手下报仇。"		                                                                                               
x225006_g_MissionComplete="    我就知道你会顺利完成任务的，选择你的奖励吧，这是你应得的。"					--完成任务npc说话的话
x225006_g_ContinueInfo="    他是一个难缠的对手，你要小心！"
--任务奖励
x225006_g_MoneyBonus = 500

--固定物品奖励，最多8种
x225006_g_ItemBonus={}

--可选物品奖励，最多8种
x225006_g_RadioItemBonus={}

--MisDescEnd
x225006_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x225006_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x225006_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x225006_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x225006_g_MissionId)
		if x225006_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x225006_g_MissionName)
			AddText(sceneId,x225006_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x225006_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死布科夫   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x225006_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x225006_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x225006_g_MissionName)
		     AddText(sceneId,x225006_g_MissionComplete)
		     AddMoneyBonus(sceneId, x225006_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x225006_g_ScriptId, x225006_g_MissionId)
                end

        elseif x225006_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x225006_g_MissionName)
                AddText(sceneId,x225006_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x225006_g_MissionTarget) 
		AddMoneyBonus(sceneId, x225006_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x225006_g_ScriptId, x225006_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x225006_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x225006_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x225006_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x225006_g_ScriptId, x225006_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x225006_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x225006_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x225006_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==16) then
		if IsMissionHaveDone(sceneId, selfId, x225006_g_MissionIdPre) > 0 then
        	    	return 1
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x225006_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x225006_g_MissionId, x225006_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x225006_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x225006_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x225006_g_MissionId)
	for i, item in x225006_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x225006_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x225006_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x225006_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x225006_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x225006_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x225006_g_MissionId)
		AddExp(sceneId, selfId, x225006_g_ExpBonus)
		AddMoney(sceneId, selfId, x225006_g_MoneyBonus)
		for i, item in x225006_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x225006_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x225006_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x225006_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x225006_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x225006_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x225006_g_DemandKill[1].id then 
       		    if num < x225006_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死布科夫   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x225006_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x225006_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x225006_OnItemChanged(sceneId, selfId, itemdataId)

end

