--投石机

--MisDescBegin
x225007_g_ScriptId = 225007
--x225007_g_MissionIdPre =41
x225007_g_MissionId = 329
x225007_g_MissionKind = 22
x225007_g_MissionLevel = 110
--x225007_g_ScriptIdNext = {ScriptId = 225001 ,LV = 1 }
x225007_g_Name	="蒙哥" 
x225007_g_DemandItem ={}
x225007_g_DemandKill ={{id=433,num=30}}

x225007_g_MissionName="投石机"
x225007_g_MissionInfo="    真险啊！刚才一块大石头突然从空中飞来，落到了营地附近。这一定是城里还有残留的投石机。\n \n    一定要把这个隐患清楚，试想如果刚才的石块稍微偏一点落入了我们大帐的话，后果不堪设想。\n \n    听说#G军事区#W那还有一些#R基辅青年军#W，一定是他们干的，你去把他们消灭了。"  --任务描述
x225007_g_MissionTarget="    去#G军营区#W杀死30个#R基辅青年军#W，消灭#G蒙哥#W心中的隐患。"		                                                                                               
x225007_g_MissionComplete="    这下可以安心了，不知道其余地方有没有这种投石机。"					--完成任务npc说话的话
x225007_g_ContinueInfo="    这个投石机务必要除掉。"
--任务奖励
x225007_g_MoneyBonus = 500

--固定物品奖励，最多8种
x225007_g_ItemBonus={}

--可选物品奖励，最多8种
x225007_g_RadioItemBonus={}

--MisDescEnd
x225007_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x225007_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x225007_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x225007_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x225007_g_MissionId)
		if x225007_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x225007_g_MissionName)
			AddText(sceneId,x225007_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x225007_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死基辅青年军   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x225007_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x225007_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x225007_g_MissionName)
		     AddText(sceneId,x225007_g_MissionComplete)
		     AddMoneyBonus(sceneId, x225007_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x225007_g_ScriptId, x225007_g_MissionId)
                end

        elseif x225007_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x225007_g_MissionName)
                AddText(sceneId,x225007_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x225007_g_MissionTarget) 
		AddMoneyBonus(sceneId, x225007_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x225007_g_ScriptId, x225007_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x225007_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x225007_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x225007_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x225007_g_ScriptId, x225007_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x225007_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x225007_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x225007_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==16) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x225007_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x225007_g_MissionId, x225007_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x225007_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x225007_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x225007_g_MissionId)
	for i, item in x225007_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x225007_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x225007_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x225007_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x225007_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x225007_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x225007_g_MissionId)
		AddExp(sceneId, selfId, x225007_g_ExpBonus)
		AddMoney(sceneId, selfId, x225007_g_MoneyBonus)
		for i, item in x225007_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x225007_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x225007_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x225007_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x225007_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x225007_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x225007_g_DemandKill[1].id then 
       		    if num < x225007_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死基辅青年军   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x225007_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x225007_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x225007_OnItemChanged(sceneId, selfId, itemdataId)

end

