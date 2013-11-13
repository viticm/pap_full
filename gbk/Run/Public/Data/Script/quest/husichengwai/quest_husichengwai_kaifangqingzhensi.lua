--开放清真寺

--MisDescBegin
x204002_g_ScriptId = 204002
--x204002_g_MissionIdPre =41
x204002_g_MissionId = 97
x204002_g_MissionKind = 9
x204002_g_MissionLevel = 45
--x204002_g_ScriptIdNext = {ScriptId = 201001 ,LV = 1 }
x204002_g_Name	="成吉思汗" 
x204002_g_DemandItem ={}
x204002_g_DemandKill ={{id=348,num=15}}

x204002_g_MissionName="开放清真寺"
x204002_g_MissionInfo="    屈出律抢夺了西辽的皇位，他强迫居民放弃回教而改信其他教派，已经引起了内乱。\n \n    "  --任务描述
x204002_g_MissionInfo2="，你和速不台，哲别等进入西辽境内之后，开放所有被封闭的清真寺，西辽的百姓们都非常的支持我们。在下关一带的清真寺还被封闭着，那里有军队守卫，你去把那些人杀了，开放清真寺。"
x204002_g_MissionTarget="    下关的清真寺被#R西辽守卫#W给封锁了，你到那去消灭15名西辽守卫，才能开放清真寺。#G成吉思汗#W命你开放它。"		                                                                                               
x204002_g_MissionComplete="    我们要尊重每个人的信仰自由。"					--完成任务npc说话的话
x204002_g_ContinueInfo="    清真寺开放了吗？"
--任务奖励
x204002_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x204002_g_ItemBonus={}

--可选物品奖励，最多8种
x204002_g_RadioItemBonus={}

--MisDescEnd
x204002_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x204002_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x204002_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x204002_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x204002_g_MissionId)
		if x204002_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x204002_g_MissionName)
			AddText(sceneId,x204002_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x204002_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死西辽守卫   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x204002_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x204002_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x204002_g_MissionName)
		     AddText(sceneId,x204002_g_MissionComplete)
		     AddMoneyBonus(sceneId, x204002_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x204002_g_ScriptId, x204002_g_MissionId)
                end

        elseif x204002_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x204002_g_MissionName)
                AddText(sceneId,x204002_g_MissionInfo..GetName(sceneId, selfId)..x204002_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x204002_g_MissionTarget) 
		AddMoneyBonus(sceneId, x204002_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x204002_g_ScriptId, x204002_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x204002_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x204002_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x204002_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x204002_g_ScriptId, x204002_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x204002_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x204002_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x204002_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==4) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x204002_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x204002_g_MissionId, x204002_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x204002_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x204002_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x204002_g_MissionId)
	for i, item in pairs(x204002_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x204002_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x204002_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x204002_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x204002_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x204002_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x204002_g_MissionId)
		AddExp(sceneId, selfId, x204002_g_ExpBonus)
		AddMoney(sceneId, selfId, x204002_g_MoneyBonus)
		for i, item in pairs(x204002_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x204002_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x204002_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x204002_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x204002_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x204002_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x204002_g_DemandKill[1].id then 
       		    if num < x204002_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死西辽守卫   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x204002_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x204002_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x204002_OnItemChanged(sceneId, selfId, itemdataId)

end

