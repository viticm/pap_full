--重要军情

--MisDescBegin
x202006_g_ScriptId = 202006
x202006_g_MissionIdPre =124
x202006_g_MissionId = 125
x202006_g_MissionKind = 4
x202006_g_MissionLevel = 20
x202006_g_ScriptIdNext = {ScriptId = 202007 ,LV = 1 }
x202006_g_Name	="术赤" 
x202006_g_Name2	="木华黎" 
x202006_g_DemandItem ={}
--x202006_g_noDemandKill ={{id=301,num=1}}	

x202006_g_MissionName="重要军情"
x202006_g_MissionInfo="    刚刚传来一个好消息，博尔术大叔在真沙陀一带洋装战败逃走，那自大的王汗高兴得连夜摆百羊宴招待他们的将士。\n \n    他们上当了，这是我们偷袭他们的好机会，请你把这个消息尽快传给#G木华黎#W叔叔。"  --任务描述
x202006_g_MissionTarget="    把术赤的话带去给#G木华黎#W。"		
x202006_g_MissionComplete="    你的消息很重要！"					--完成任务npc说话的话
--x202006_g_ContinueInfo="    不管付出多大代价，也要把那件东西给拿回来。"
--任务奖励
x202006_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x202006_g_ItemBonus={}

--可选物品奖励，最多8种
x202006_g_RadioItemBonus={}

--MisDescEnd
x202006_g_ExpBonus = 6500
--**********************************

--任务入口函数

--**********************************

function x202006_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x202006_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x202006_g_MissionId) > 0 then
		
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x202006_g_MissionName)
		     AddText(sceneId,x202006_g_MissionComplete)
		     AddMoneyBonus(sceneId, x202006_g_MoneyBonus)
                     EndEvent()
		     DispatchMissionContinueInfo(sceneId, selfId, targetId, x202006_g_ScriptId, x202006_g_MissionId)
                

        elseif x202006_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x202006_g_MissionName)
                AddText(sceneId,x202006_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x202006_g_MissionTarget) 
		AddMoneyBonus(sceneId, x202006_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x202006_g_ScriptId, x202006_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x202006_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x202006_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x202006_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x202006_g_ScriptId, x202006_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x202006_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x202006_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x202006_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==2) then
        	if IsMissionHaveDone(sceneId, selfId, x202006_g_MissionIdPre) > 0 then
	        	if (GetName(sceneId,targetId)==x202006_g_Name) then
	        	        if IsHaveMission(sceneId,selfId, x202006_g_MissionId)<= 0 then
	        	            	return 1
	        	        end
	        	end
			if (GetName(sceneId,targetId)==x202006_g_Name2) then
				    if IsHaveMission(sceneId,selfId, x202006_g_MissionId) > 0 then
				    	return 1
	        	            end
	        	end
	        end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x202006_OnAccept(sceneId, selfId)

	                                                  
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x202006_g_MissionId, x202006_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x202006_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
	     	                                    
	     
end



--**********************************

--放弃

--**********************************

function x202006_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x202006_g_MissionId)
	for i, item in x202006_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x202006_CheckSubmit( sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x202006_g_Name2) then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x202006_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x202006_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x202006_g_MissionId)
		AddExp(sceneId, selfId, x202006_g_ExpBonus)
		AddMoney(sceneId, selfId, x202006_g_MoneyBonus)
		for i, item in x202006_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x202006_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x202006_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x202006_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x202006_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x202006_OnItemChanged(sceneId, selfId, itemdataId)

end

