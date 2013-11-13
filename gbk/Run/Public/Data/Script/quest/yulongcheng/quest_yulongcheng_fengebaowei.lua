--分割包围

--MisDescBegin
x208005_g_ScriptId = 208005
x208005_g_MissionIdPre =58
x208005_g_MissionId = 59
x208005_g_MissionKind = 12
x208005_g_MissionLevel = 60
--x208005_g_ScriptIdNext = {ScriptId = 205003 ,LV = 1 }
x208005_g_Name	="哲别" 
x208005_g_DemandItem ={}
x208005_g_DemandKill ={{id=318,num=20}}

x208005_g_MissionName="分割包围"
x208005_g_MissionInfo="     刚刚传来消息，我们成功的把他们这些溃军冲散，现在我们要分割包围！各个歼灭！复仇的时候到了，就从（183，136）处开始吧！请握紧了你的武器，讨回我们的血债！"  --任务描述
x208005_g_MissionTarget="    杀死20名#R玉龙城士兵#W，回来向#G哲别#W复命。"		                                                                                               
x208005_g_MissionComplete="    我们的蒙古军是世界上最强的军队！"					--完成任务npc说话的话
x208005_g_ContinueInfo="    请不要怜悯那些花剌子模人，只有杀了他们才能平息我们仇恨的怒火。"
--任务奖励
x208005_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x208005_g_ItemBonus={}

--可选物品奖励，最多8种
x208005_g_RadioItemBonus={}

--MisDescEnd
x208005_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x208005_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x208005_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x208005_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x208005_g_MissionId)
		if x208005_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x208005_g_MissionName)
			AddText(sceneId,x208005_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x208005_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死玉龙城步兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x208005_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x208005_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x208005_g_MissionName)
		     AddText(sceneId,x208005_g_MissionComplete)
		     AddMoneyBonus(sceneId, x208005_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x208005_g_ScriptId, x208005_g_MissionId)
                end

        elseif x208005_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x208005_g_MissionName)
                AddText(sceneId,x208005_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x208005_g_MissionTarget) 
		AddMoneyBonus(sceneId, x208005_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x208005_g_ScriptId, x208005_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x208005_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x208005_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x208005_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x208005_g_ScriptId, x208005_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x208005_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x208005_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x208005_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==8) then
		if IsMissionHaveDone(sceneId, selfId, x208005_g_MissionIdPre) > 0 then
        	    	return 1
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x208005_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x208005_g_MissionId, x208005_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x208005_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x208005_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x208005_g_MissionId)
	for i, item in pairs(x208005_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x208005_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x208005_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x208005_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x208005_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x208005_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x208005_g_MissionId)
		AddExp(sceneId, selfId, x208005_g_ExpBonus)
		AddMoney(sceneId, selfId, x208005_g_MoneyBonus)
		for i, item in pairs(x208005_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x208005_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x208005_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x208005_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x208005_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x208005_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x208005_g_DemandKill[1].id then 
       		    if num < x208005_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死玉龙城步兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x208005_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x208005_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x208005_OnItemChanged(sceneId, selfId, itemdataId)

end

