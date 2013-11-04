--迷惑敌军

--MisDescBegin
x226000_g_ScriptId = 226000
--x226000_g_MissionIdPre =40
x226000_g_MissionId = 337
x226000_g_MissionKind = 23
x226000_g_MissionLevel = 115
x226000_g_ScriptIdNext = {ScriptId = 226001 ,LV = 1 }
x226000_g_Name	="贝达尔" 
x226000_g_DemandItem ={}
x226000_g_noDemandKill ={}	

x226000_g_MissionName="迷惑敌军"
x226000_g_MissionInfo="    亨利这个混蛋上当了，他的骑兵全被引诱到我们的包围圈中了，过不了多久这些欧洲重骑兵就会被我们消灭了。\n \n    为了防止后面这些步兵逃跑，我们需要做些手脚，让他们看不到骑兵同伴的下场。\n \n    你去到河岸处把枯草堆都点燃，让烟雾挡住敌人步兵的视线。"  --任务描述
x226000_g_MissionTarget="    为#G贝达尔#W点燃河岸处的5处枯草堆。"		
x226000_g_MissionComplete="    很好，现在敌人的步兵会像傻瓜一样冲到我们的包围圈。"					--完成任务npc说话的话
x226000_g_ContinueInfo="    时间紧迫，一定要在敌人步兵发现之前把草料堆点燃。"
--任务奖励
x226000_g_MoneyBonus = 600
--固定物品奖励，最多8种
x226000_g_ItemBonus={}

--可选物品奖励，最多8种
x226000_g_RadioItemBonus={}

--MisDescEnd
x226000_g_ExpBonus = 6500
--**********************************

--任务入口函数

--**********************************

function x226000_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x226000_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x226000_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x226000_g_MissionId)
			if x226000_CheckSubmit(sceneId, selfId, targetId) <= 0 then
	                        BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x226000_g_MissionName)
				AddText(sceneId,x226000_g_ContinueInfo)
			        AddText(sceneId,"#Y任务目标#W") 
				AddText(sceneId,x226000_g_MissionTarget) 
				AddText(sceneId,format("\n    点燃枯草堆   %d/5", GetMissionParam(sceneId,selfId,misIndex,0) ))
				EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
			end
	
			     
	                if x226000_CheckSubmit(sceneId, selfId, targetId) > 0 then
	                     BeginEvent(sceneId)
	                     AddText(sceneId,"#Y"..x226000_g_MissionName)
			     AddText(sceneId,x226000_g_MissionComplete)
			     AddMoneyBonus(sceneId, x226000_g_MoneyBonus)
			     EndEvent()
	                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x226000_g_ScriptId, x226000_g_MissionId)
	                end
	     

        elseif x226000_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x226000_g_MissionName)
                AddText(sceneId,x226000_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x226000_g_MissionTarget) 
		AddMoneyBonus(sceneId, x226000_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x226000_g_ScriptId, x226000_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x226000_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x226000_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x226000_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x226000_g_ScriptId, x226000_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x226000_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x226000_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x226000_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==22) then
        	            	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x226000_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x226000_g_MissionId, x226000_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x226000_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x226000_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x226000_g_MissionId)
	for i, item in x226000_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x226000_CheckSubmit( sceneId, selfId, targetId)

	misIndex = GetMissionIndexByID(sceneId,selfId,x226000_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == 5 then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x226000_OnSubmit(sceneId, selfId, targetId, selectRadioId)

		DelMission( sceneId, selfId, x226000_g_MissionId ) 
				MissionCom( sceneId,selfId, x226000_g_MissionId )
				AddExp(sceneId, selfId, x226000_g_ExpBonus)   
	      AddMoney(sceneId, selfId, x226000_g_MoneyBonus)
	  CallScriptFunction( x226000_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x226000_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x226000_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x226000_OnItemChanged(sceneId, selfId, itemdataId)

end

