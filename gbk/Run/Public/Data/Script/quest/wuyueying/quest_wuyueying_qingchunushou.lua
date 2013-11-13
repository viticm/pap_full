--清除弩手

--MisDescBegin
x217000_g_ScriptId = 217000
--x217000_g_MissionIdPre =41
x217000_g_MissionId = 172
x217000_g_MissionKind = 6
x217000_g_MissionLevel = 30
x217000_g_ScriptIdNext = {ScriptId = 217001 ,LV = 1 }
x217000_g_Name	="哲别" 
x217000_g_DemandItem ={}
x217000_g_DemandKill ={{id=450,num=15}}

x217000_g_MissionName="清除弩手"
x217000_g_MissionInfo="    我终于等到这一天，大军南下，为的就是血洗多年来的耻辱，我们任何一名战士都需要拿出最强大的力量，以最快的速度占领乌月营，挥军南下。\n \n    远处大军攻城的号声已经响起，我们要尽快踏平这里，去跟那边的大军汇合。\n \n    年轻的勇士，为我们清除营地附近那些放冷箭的#R乌月营弩手#W，回来跟我复命。"  --任务描述
x217000_g_MissionTarget="    解决营地附近的15名#R乌月营弩手#W，然后跟#G哲别#W复命。"		                                                                                               
x217000_g_MissionComplete="    这一危害被铲除，大快人心！"					--完成任务npc说话的话
x217000_g_ContinueInfo="    那些弩手防不胜防，他们的冷箭让我十分头疼，你要先解决了他们。"
--任务奖励
x217000_g_MoneyBonus = 500

--固定物品奖励，最多8种
x217000_g_ItemBonus={}

--可选物品奖励，最多8种
x217000_g_RadioItemBonus={}

--MisDescEnd
x217000_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x217000_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x217000_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x217000_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x217000_g_MissionId)
		if x217000_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x217000_g_MissionName)
			AddText(sceneId,x217000_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x217000_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死乌月营弩手   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x217000_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x217000_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x217000_g_MissionName)
		     AddText(sceneId,x217000_g_MissionComplete)
		     AddMoneyBonus(sceneId, x217000_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x217000_g_ScriptId, x217000_g_MissionId)
                end

        elseif x217000_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x217000_g_MissionName)
                AddText(sceneId,x217000_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x217000_g_MissionTarget) 
		AddMoneyBonus(sceneId, x217000_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x217000_g_ScriptId, x217000_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x217000_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x217000_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x217000_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x217000_g_ScriptId, x217000_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x217000_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x217000_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x217000_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==20) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x217000_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x217000_g_MissionId, x217000_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x217000_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x217000_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x217000_g_MissionId)
	for i, item in pairs(x217000_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x217000_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x217000_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x217000_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x217000_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x217000_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x217000_g_MissionId)
		AddExp(sceneId, selfId, x217000_g_ExpBonus)
		AddMoney(sceneId, selfId, x217000_g_MoneyBonus)
		for i, item in pairs(x217000_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x217000_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x217000_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x217000_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x217000_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x217000_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x217000_g_DemandKill[1].id then 
       		    if num < x217000_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死乌月营弩手   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x217000_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x217000_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x217000_OnItemChanged(sceneId, selfId, itemdataId)

end

