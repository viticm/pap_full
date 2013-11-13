--歼灭西夏步兵

--MisDescBegin
x212006_g_ScriptId = 212006
--x212006_g_MissionIdPre =41
x212006_g_MissionId = 253
x212006_g_MissionKind = 17
x212006_g_MissionLevel = 70
x212006_g_ScriptIdNext = {ScriptId = 212007 ,LV = 1 }
x212006_g_Name	="速不台" 
x212006_g_DemandItem ={}
x212006_g_DemandKill ={{id=426,num=20}}

x212006_g_MissionName="歼灭西夏步兵"
x212006_g_MissionInfo="    我们西征花剌子模的时候，西夏国不但不出兵相助，还联合金国，组成抗蒙大军。\n \n    大汗已经下令，歼灭西夏的主力军，让他们失去反叛的能力。\n \n    杀死困在黄河冰面上的#R西夏步兵#W！让所有人都知道，我们蒙古铁骑是天下无敌！"  --任务描述
x212006_g_MissionTarget="    杀死20名困在黄河冰面上的#R西夏步兵#W，并向#G速不台#W复命。"		                                                                                               
x212006_g_MissionComplete="    做的好，长生天会护佑每一位勇士！"					--完成任务npc说话的话
x212006_g_ContinueInfo="    作为蒙军的精英，你一定要尽快完成你的任务。"
--任务奖励
x212006_g_MoneyBonus = 500

--固定物品奖励，最多8种
x212006_g_ItemBonus={}

--可选物品奖励，最多8种
x212006_g_RadioItemBonus={}

--MisDescEnd
x212006_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x212006_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x212006_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x212006_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x212006_g_MissionId)
		if x212006_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x212006_g_MissionName)
			AddText(sceneId,x212006_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x212006_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死西夏步兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x212006_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x212006_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x212006_g_MissionName)
		     AddText(sceneId,x212006_g_MissionComplete)
		     AddMoneyBonus(sceneId, x212006_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x212006_g_ScriptId, x212006_g_MissionId)
                end

        elseif x212006_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x212006_g_MissionName)
                AddText(sceneId,x212006_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x212006_g_MissionTarget) 
		AddMoneyBonus(sceneId, x212006_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x212006_g_ScriptId, x212006_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x212006_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x212006_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x212006_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x212006_g_ScriptId, x212006_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x212006_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x212006_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x212006_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==12) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x212006_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x212006_g_MissionId, x212006_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x212006_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x212006_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x212006_g_MissionId)
	for i, item in pairs(x212006_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x212006_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x212006_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x212006_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x212006_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x212006_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x212006_g_MissionId)
		AddExp(sceneId, selfId, x212006_g_ExpBonus)
		AddMoney(sceneId, selfId, x212006_g_MoneyBonus)
		for i, item in pairs(x212006_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x212006_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x212006_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x212006_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x212006_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x212006_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x212006_g_DemandKill[1].id then 
       		    if num < x212006_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死西夏步兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x212006_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x212006_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x212006_OnItemChanged(sceneId, selfId, itemdataId)

end

