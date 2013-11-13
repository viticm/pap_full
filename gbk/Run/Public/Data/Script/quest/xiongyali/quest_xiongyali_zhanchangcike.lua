--战场刺客

--MisDescBegin
x213011_g_ScriptId = 213011
--x213011_g_MissionIdPre =41
x213011_g_MissionId = 156
x213011_g_MissionKind = 24
x213011_g_MissionLevel = 125
--x213011_g_ScriptIdNext = {ScriptId = 213001 ,LV = 1 }
x213011_g_Name	="速不台" 
x213011_g_DemandItem ={}
x213011_g_DemandKill ={{id=397,num=10}}

x213011_g_MissionName="战场刺客"
x213011_g_MissionInfo="    听说贝拉手下有一支部队，专门用来刺杀敌人官员的。我猜碰见我大蒙古，他应该会把这支部队派出来刺杀我们的官员。\n \n    需要小心了。勇士，你去中桥附近看看，如果发现这些刺客就杀死他们，不能让他们刺杀我们的官员。"  --任务描述
x213011_g_MissionTarget="    杀死10名#R战场刺客#W后向#G速不台#W复命。"		                                                                                               
x213011_g_MissionComplete="    果然他们派出了这些刺客，多亏了你，否则我们会蒙受很大损失的，谢谢了勇士！"					--完成任务npc说话的话
x213011_g_ContinueInfo="    发现这些刺客的踪迹了吗？他们很会伪装的。"
--任务奖励
x213011_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x213011_g_ItemBonus={}

--可选物品奖励，最多8种
x213011_g_RadioItemBonus={}

--MisDescEnd
x213011_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x213011_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x213011_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x213011_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x213011_g_MissionId)
		if x213011_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x213011_g_MissionName)
			AddText(sceneId,x213011_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x213011_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死战场刺客   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x213011_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x213011_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x213011_g_MissionName)
		     AddText(sceneId,x213011_g_MissionComplete)
		     AddMoneyBonus(sceneId, x213011_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x213011_g_ScriptId, x213011_g_MissionId)
                end

        elseif x213011_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x213011_g_MissionName)
                AddText(sceneId,x213011_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x213011_g_MissionTarget) 
		AddMoneyBonus(sceneId, x213011_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x213011_g_ScriptId, x213011_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x213011_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x213011_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x213011_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x213011_g_ScriptId, x213011_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x213011_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x213011_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x213011_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==13) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x213011_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x213011_g_MissionId, x213011_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x213011_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x213011_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x213011_g_MissionId)
	for i, item in pairs(x213011_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x213011_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x213011_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x213011_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x213011_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x213011_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x213011_g_MissionId)
		AddExp(sceneId, selfId, x213011_g_ExpBonus)
		AddMoney(sceneId, selfId, x213011_g_MoneyBonus)
		for i, item in pairs(x213011_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x213011_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x213011_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x213011_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x213011_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x213011_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x213011_g_DemandKill[1].id then 
       		    if num < x213011_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死战场刺客   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x213011_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x213011_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x213011_OnItemChanged(sceneId, selfId, itemdataId)

end

