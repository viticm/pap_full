--郭宝玉将军

--MisDescBegin
x217008_g_ScriptId = 217008
x217008_g_MissionIdPre =179
x217008_g_MissionId = 180
x217008_g_MissionKind = 6
x217008_g_MissionLevel = 30
x217008_g_ScriptIdNext = {ScriptId = 217009 ,LV = 1 }
x217008_g_Name	="拖雷"
x217008_g_Name2	="郭宝玉" 
x217008_g_DemandItem ={}
--x217008_g_noDemandKill ={{id=301,num=1}}	

x217008_g_MissionName="郭宝玉将军"
x217008_g_MissionInfo="    感谢你上次为我们摧毁了他们的投石机，很高兴再见到你。\n \n    恩，我是特地在这里等你的，没有人比你更熟悉器械处的地形，我需要你为我再做一件事情。\n \n    我的探子告诉我，统领器械处的金国将军是一个非常有才华的人，但是却郁郁不得志，我很希望能让这样的人为我们大蒙古国效力。\n \n    为了表示我们的真诚，我要派最英勇的战士去迎接他，这个战士，非你莫属，你要安全的把他给我带回来！"  --任务描述
x217008_g_MissionTarget="    在#G器械处#W找到#G郭宝玉#W将军。"		
x217008_g_MissionComplete="    你有什么事情？"					--完成任务npc说话的话
--x217008_g_ContinueInfo="    不管付出多大代价，也要把那件东西给拿回来。"
--任务奖励
x217008_g_MoneyBonus = 200
--固定物品奖励，最多8种
x217008_g_ItemBonus={}

--可选物品奖励，最多8种
x217008_g_RadioItemBonus={}

--MisDescEnd
x217008_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x217008_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x217008_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x217008_g_MissionId) > 0 then
		
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x217008_g_MissionName)
		     AddText(sceneId,x217008_g_MissionComplete)
		     AddMoneyBonus(sceneId, x217008_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x217008_g_ScriptId, x217008_g_MissionId)
                

        elseif x217008_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x217008_g_MissionName)
                AddText(sceneId,x217008_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x217008_g_MissionTarget) 
		AddMoneyBonus(sceneId, x217008_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x217008_g_ScriptId, x217008_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x217008_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x217008_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x217008_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x217008_g_ScriptId, x217008_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x217008_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x217008_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x217008_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==20) then
        		if (GetName(sceneId,targetId)==x217008_g_Name) then
	        	        if IsHaveMission(sceneId,selfId, x217008_g_MissionId)<= 0 then
	        	            	return 1
	        	        end
	        	end
			if (GetName(sceneId,targetId)==x217008_g_Name2) then
				    if IsHaveMission(sceneId,selfId, x217008_g_MissionId) > 0 then
				    	return 1
	        	            end
	        	end
	end
        return 0
	
end

--**********************************

--接受

--**********************************

function x217008_OnAccept(sceneId, selfId)

	                                                  
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x217008_g_MissionId, x217008_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x217008_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
	     	                                    
	     
end



--**********************************

--放弃

--**********************************

function x217008_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x217008_g_MissionId)
	for i, item in x217008_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x217008_CheckSubmit( sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x217008_g_Name2) then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x217008_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x217008_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x217008_g_MissionId)
		AddExp(sceneId, selfId, x217008_g_ExpBonus)
		AddMoney(sceneId, selfId, x217008_g_MoneyBonus)
		for i, item in x217008_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x217008_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x217008_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x217008_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x217008_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x217008_OnItemChanged(sceneId, selfId, itemdataId)

end

