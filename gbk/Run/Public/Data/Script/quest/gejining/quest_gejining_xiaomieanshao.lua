--消灭暗哨

--MisDescBegin
x215011_g_ScriptId = 215011
--x215011_g_MissionIdPre =41
x215011_g_MissionId = 142
x215011_g_MissionKind = 14
x215011_g_MissionLevel = 55
x215011_g_ScriptIdNext = {ScriptId = 215012 ,LV = 1 }
x215011_g_Name	="忽都虎" 
x215011_g_DemandItem ={}
x215011_g_DemandKill ={{id=385,num=20}}

x215011_g_MissionName="消灭暗哨"
x215011_g_MissionInfo="    你来得真巧，大汗刚刚给我来信，如果遇到问题，可以找你帮忙……\n \n    我们跟扎兰丁大战了一天，他们人数远远超过我们，你看看那边!\n \n    <忽都虎指着大营周围那一堆堆的草人>为了镇吓他们，我让士兵编了很多草人来充当人数，在有雾的天气里，他们分不清真假。\n \n    不过，扎兰丁是个很狡猾的人，他派出了一批暗哨来侦查我们的情况。你的任务就是，消灭在我们营地附近的那20名暗哨。"  --任务描述
x215011_g_MissionTarget="    消灭藏在#G忽都虎#W营地附近的20名#R伊拉克暗哨#W。"		                                                                                               
x215011_g_MissionComplete="    这是个好消息。"					--完成任务npc说话的话
x215011_g_ContinueInfo="    那些暗哨你都解决了吗？"
--任务奖励
x215011_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x215011_g_ItemBonus={}

--可选物品奖励，最多8种
x215011_g_RadioItemBonus={}

--MisDescEnd
x215011_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x215011_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x215011_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x215011_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x215011_g_MissionId)
		if x215011_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x215011_g_MissionName)
			AddText(sceneId,x215011_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x215011_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死伊拉克暗哨   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x215011_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x215011_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x215011_g_MissionName)
		     AddText(sceneId,x215011_g_MissionComplete)
		     AddMoneyBonus(sceneId, x215011_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x215011_g_ScriptId, x215011_g_MissionId)
                end

        elseif x215011_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x215011_g_MissionName)
                AddText(sceneId,x215011_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x215011_g_MissionTarget) 
		AddMoneyBonus(sceneId, x215011_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x215011_g_ScriptId, x215011_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x215011_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x215011_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x215011_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x215011_g_ScriptId, x215011_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x215011_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x215011_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x215011_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==15) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x215011_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x215011_g_MissionId, x215011_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x215011_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x215011_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x215011_g_MissionId)
	for i, item in pairs(x215011_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x215011_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x215011_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x215011_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x215011_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x215011_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x215011_g_MissionId)
		AddExp(sceneId, selfId, x215011_g_ExpBonus)
		AddMoney(sceneId, selfId, x215011_g_MoneyBonus)
		for i, item in pairs(x215011_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x215011_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x215011_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x215011_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x215011_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x215011_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x215011_g_DemandKill[1].id then 
       		    if num < x215011_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死伊拉克暗哨   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x215011_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x215011_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x215011_OnItemChanged(sceneId, selfId, itemdataId)

end

