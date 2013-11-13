--西夏大将

--MisDescBegin
x212002_g_ScriptId = 212002
x212002_g_MissionIdPre =248
x212002_g_MissionId = 249
x212002_g_MissionKind = 17
x212002_g_MissionLevel = 70
x212002_g_ScriptIdNext = {ScriptId = 212003 ,LV = 1 }
x212002_g_Name	="成吉思汗" 
x212002_g_DemandItem ={}
x212002_g_DemandKill ={{id=422,num=1}}

x212002_g_MissionName="西夏大将"
x212002_g_MissionInfo="    西夏有一个叫#R阿沙#W的狂妄将军，他自持有贺兰山为营地，有西凉，兴庆为后方，兵马多于我军六倍，对我们蒙军不屑一顾。\n \n    我想看看，说出这样狂妄的话语的人，是否真有本事。\n \n    "  --任务描述
x212002_g_MissionInfo2="，把西夏的将军阿沙给我捉来！"
x212002_g_MissionTarget="    打败在#G恶狼堤#W东处的#R阿沙#W，并回去告诉#G成吉思汗#W。"		                                                                                               
x212002_g_MissionComplete="    我们蒙古军无敌于天下。"					--完成任务npc说话的话
x212002_g_ContinueInfo="    西夏的将军阿沙呢？"
--任务奖励
x212002_g_MoneyBonus = 500
--固定物品奖励，最多8种
x212002_g_ItemBonus={}

--可选物品奖励，最多8种
x212002_g_RadioItemBonus={}
--MisDescEnd
x212002_g_ExpBonus = 4000

--**********************************

--任务入口函数

--**********************************

function x212002_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x212002_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x212002_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x212002_g_MissionId)
		if x212002_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x212002_g_MissionName)
			AddText(sceneId,x212002_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x212002_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死阿沙   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x212002_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x212002_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x212002_g_MissionName)
		     AddText(sceneId,x212002_g_MissionComplete)
		     AddMoneyBonus(sceneId, x212002_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x212002_g_ScriptId, x212002_g_MissionId)
                end

        elseif x212002_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x212002_g_MissionName)
                AddText(sceneId,x212002_g_MissionInfo..GetName(sceneId, selfId)..x212002_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x212002_g_MissionTarget) 
		AddMoneyBonus(sceneId, x212002_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x212002_g_ScriptId, x212002_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x212002_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x212002_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x212002_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x212002_g_ScriptId, x212002_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x212002_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x212002_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x212002_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==12) then
		if IsMissionHaveDone(sceneId, selfId, x212002_g_MissionIdPre) > 0 then
        	    	return 1
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x212002_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x212002_g_MissionId, x212002_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x212002_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x212002_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x212002_g_MissionId)
	for i, item in pairs(x212002_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x212002_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x212002_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x212002_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x212002_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x212002_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x212002_g_MissionId)
		AddExp(sceneId, selfId, x212002_g_ExpBonus)
		AddMoney(sceneId, selfId, x212002_g_MoneyBonus)
		for i, item in pairs(x212002_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x212002_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x212002_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x212002_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x212002_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x212002_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x212002_g_DemandKill[1].id then 
       		    if num < x212002_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死阿沙   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x212002_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x212002_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x212002_OnItemChanged(sceneId, selfId, itemdataId)

end

