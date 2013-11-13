--一个都别想走

--MisDescBegin
x202011_g_ScriptId = 202011
--x202011_g_MissionIdPre =41
x202011_g_MissionId = 130
x202011_g_MissionKind = 4
x202011_g_MissionLevel = 20
--x202011_g_ScriptIdNext = {ScriptId = 202001 ,LV = 1 }
x202011_g_Name	="木华黎" 
x202011_g_DemandItem ={}
x202011_g_DemandKill ={{id=373,num=15}}

x202011_g_MissionName="一个都别想走"
x202011_g_MissionInfo="    叛逃的将士，灵魂是最肮脏的，王汗作为铁木真汗的义父，就不应该收留阿勒坛等三人，可是，我们得到了消息，王汗收留了他们三人。\n \n    我估计，因为我们的势力逐渐壮大，让王汗感觉到了危机，他已经把我们当成了敌人。\n \n    "  --任务描述
x202011_g_MissionInfo2="，铁木真汗是一个心胸宽广，坦荡无比的君王，他还相信王汗会对付他，可是，我们却不能不防。\n \n    有人传来消息，在我们营地周围，有一群暗哨在观察着我们，可能就是王汗的人，你替我去解决了他们。"
x202011_g_MissionTarget="    #G木华黎#W很担心营地周围的暗哨，你要去找到15个#R草原暗哨#W，杀了他们。"		                                                                                               
x202011_g_MissionComplete="    做的很好。"					--完成任务npc说话的话
x202011_g_ContinueInfo="    那些暗哨时时刻刻关注着我们的动静，一个也不能留。"
--任务奖励
x202011_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x202011_g_ItemBonus={}

--可选物品奖励，最多8种
x202011_g_RadioItemBonus={}

--MisDescEnd
x202011_g_ExpBonus = 6500
--**********************************

--任务入口函数

--**********************************

function x202011_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x202011_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x202011_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x202011_g_MissionId)
		if x202011_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x202011_g_MissionName)
			AddText(sceneId,x202011_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x202011_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死草原暗哨   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x202011_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x202011_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x202011_g_MissionName)
		     AddText(sceneId,x202011_g_MissionComplete)
		     AddMoneyBonus(sceneId, x202011_g_MoneyBonus)
                     EndEvent()
		     DispatchMissionContinueInfo(sceneId, selfId, targetId, x202011_g_ScriptId, x202011_g_MissionId)
                end

        elseif x202011_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x202011_g_MissionName)
                AddText(sceneId,x202011_g_MissionInfo..GetName(sceneId, selfId)..x202011_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x202011_g_MissionTarget) 
		AddMoneyBonus(sceneId, x202011_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x202011_g_ScriptId, x202011_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x202011_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x202011_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x202011_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x202011_g_ScriptId, x202011_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x202011_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x202011_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x202011_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==2) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x202011_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x202011_g_MissionId, x202011_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x202011_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x202011_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x202011_g_MissionId)
	for i, item in pairs(x202011_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x202011_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x202011_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x202011_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x202011_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x202011_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x202011_g_MissionId)
		AddExp(sceneId, selfId, x202011_g_ExpBonus)
		AddMoney(sceneId, selfId, x202011_g_MoneyBonus)
		for i, item in pairs(x202011_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x202011_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x202011_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x202011_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x202011_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x202011_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x202011_g_DemandKill[1].id then 
       		    if num < x202011_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死草原暗哨   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x202011_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x202011_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x202011_OnItemChanged(sceneId, selfId, itemdataId)

end

