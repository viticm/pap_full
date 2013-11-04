--火烧连营

--MisDescBegin
x217006_g_ScriptId = 217006
x217006_g_MissionIdPre =177
x217006_g_MissionId = 178
x217006_g_MissionKind = 6
x217006_g_MissionLevel = 30
--x217006_g_ScriptIdNext = {ScriptId = 217006 ,LV = 1 }
x217006_g_Name	="哈撒儿"
--x217006_g_noDemandItem ={{id=13010007,num=1}}
x217006_g_DemandKill ={{id=454,num=10}}	

x217006_g_MissionName="火烧连营"
x217006_g_MissionInfo="    看着你一步一步长大，我很高兴！希望你在今后的路上，能体验到国家和民族的真正意义，为国出力。\n \n    是的，每个人都要为国家出力！\n \n    拿出你的勇气，去为我们大蒙古国而战，消灭他们的#R粮仓士兵#W，烧毁他们的粮草！  "  --任务描述
x217006_g_MissionTarget="    到#G大粮仓#W去消灭10名#R粮仓士兵#W，点燃他们的粮草，回来跟#G哈撒儿#W复命。"		
x217006_g_MissionComplete="    你每次的行动都让我对你另眼相看，能有你这样的猛将在身边，我很欣慰。"					--完成任务npc说话的话
x217006_g_ContinueInfo="    你的任务十分重要，我等着你的消息。"
--任务奖励
x217006_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x217006_g_ItemBonus={}

--可选物品奖励，最多8种
x217006_g_RadioItemBonus={}

--MisDescEnd
x217006_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x217006_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x217006_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x217006_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x217006_g_MissionId)
		if x217006_CheckSubmit(sceneId, selfId, targetId) <= 0 then
			if (GetName(sceneId,targetId)==x217006_g_Name) then
	                        BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x217006_g_MissionName)
				AddText(sceneId,x217006_g_ContinueInfo)
			        AddText(sceneId,"#Y任务目标#W") 
				AddText(sceneId,x217006_g_MissionTarget) 
				AddText(sceneId,format("\n    杀死粮仓士兵   %d/%d\n    烧毁粮仓   %d/1", GetMissionParam(sceneId,selfId,misIndex,0),x217006_g_DemandKill[1].num, GetMissionParam(sceneId,selfId,misIndex,1) ))
				EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
			end
		end

		     
                if x217006_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x217006_g_MissionName)
		     AddText(sceneId,x217006_g_MissionComplete)
		     AddMoneyBonus(sceneId, x217006_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x217006_g_ScriptId, x217006_g_MissionId)
                end

        elseif x217006_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x217006_g_MissionName)
                AddText(sceneId,x217006_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x217006_g_MissionTarget) 
		AddMoneyBonus(sceneId, x217006_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x217006_g_ScriptId, x217006_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x217006_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x217006_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x217006_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x217006_g_ScriptId, x217006_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x217006_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x217006_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x217006_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==20) then
        	 	if IsMissionHaveDone(sceneId, selfId, x217006_g_MissionIdPre) > 0 then
                    			return 1
                    	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x217006_OnAccept(sceneId, selfId)

	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x217006_g_MissionId, x217006_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x217006_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
	
end



--**********************************

--放弃

--**********************************

function x217006_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x217006_g_MissionId)
	for i, item in x217006_g_noDemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x217006_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x217006_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x217006_g_DemandKill[1].num then
		if GetMissionParam(sceneId,selfId,misIndex,1) == 1 then
	        	return 1
	        end
	end
	return 0

end



--**********************************

--提交

--**********************************

function x217006_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x217006_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x217006_g_MissionId)
		AddExp(sceneId, selfId, x217006_g_ExpBonus)
		AddMoney(sceneId, selfId, x217006_g_MoneyBonus)
		for i, item in x217006_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x217006_g_noDemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x217006_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x217006_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x217006_g_MissionId) >= 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x217006_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x217006_g_DemandKill[1].id then 
       		    if num < x217006_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死粮仓士兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x217006_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x217006_OnEnterArea(sceneId, selfId, zoneId)
	

end

function x217006_OnLeaveArea(sceneId, selfId )
	
end

function x217006_OnTimer(sceneId, selfId )

end



--**********************************

--道具改变

--**********************************

function x217006_OnItemChanged(sceneId, selfId, itemdataId)

end
