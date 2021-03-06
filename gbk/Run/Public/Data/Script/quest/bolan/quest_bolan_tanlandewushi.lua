--贪婪的巫师

--MisDescBegin
x226011_g_ScriptId = 226011
x226011_g_MissionIdPre =341
x226011_g_MissionId = 347
x226011_g_MissionKind = 23
x226011_g_MissionLevel = 115
--x226011_g_ScriptIdNext = {ScriptId = 205002 ,LV = 1 }
x226011_g_Name	="重骑兵指挥官" 
x226011_g_Name2	="贝达尔" 
x226011_g_DemandItem ={}
--x226011_g_noDemandKill ={{id=301,num=1}}	

x226011_g_MissionName="贪婪的巫师"
x226011_g_MissionInfo="     #G贝达尔#W应该还不知道亨利被杀的消息，要尽快让他知道这个消息，这对他歼灭波兰的步兵会有很大帮助。帮我把这个捷报带给他吧。"  --任务描述
x226011_g_MissionTarget="    告诉#G贝达尔#W亨利被杀的消息。"		
x226011_g_MissionComplete="    没有这个消息，我一样会歼灭波兰的步兵，不过这依旧是一个好消息。"					--完成任务npc说话的话
--x226011_g_ContinueInfo="    不管付出多大代价，也要把那件东西给拿回来。"
--任务奖励
x226011_g_MoneyBonus = 0
--固定物品奖励，最多8种
x226011_g_ItemBonus={}

--可选物品奖励，最多8种
x226011_g_RadioItemBonus={}
--MisDescEnd
x226011_g_ExpBonus = 22
--**********************************

--任务入口函数

--**********************************

function x226011_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x226011_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x226011_g_MissionId) > 0 then
		
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x226011_g_MissionName)
		     AddText(sceneId,x226011_g_MissionComplete)
		     --AddMoneyBonus(sceneId, x201001_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x226011_g_ScriptId, x226011_g_MissionId)
                

        elseif x226011_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x226011_g_MissionName)
                AddText(sceneId,x226011_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x226011_g_MissionTarget) 
		--AddMoneyBonus(sceneId, x226011_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x226011_g_ScriptId, x226011_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x226011_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x226011_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x226011_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x226011_g_ScriptId, x226011_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x226011_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x226011_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x226011_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==22) then
        	--if IsMissionHaveDone(sceneId, selfId, x226011_g_MissionIdPre) > 0 then
	        	if (GetName(sceneId,targetId)==x226011_g_Name) then
	        	        if IsHaveMission(sceneId,selfId, x226011_g_MissionId)<= 0 then
	        	            	return 1
	        	        end
	        	end
			if (GetName(sceneId,targetId)==x226011_g_Name2) then
				    if IsHaveMission(sceneId,selfId, x226011_g_MissionId) > 0 then
				    	return 1
	        	            end
	        	end
	       -- end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x226011_OnAccept(sceneId, selfId)

	                                                  
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x226011_g_MissionId, x226011_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x226011_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
	     	                                    
	     
end



--**********************************

--放弃

--**********************************

function x226011_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x226011_g_MissionId)
	for i, item in pairs(x226011_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x226011_CheckSubmit( sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x226011_g_Name2) then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x226011_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x226011_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x226011_g_MissionId)
		AddExp(sceneId, selfId, x226011_g_ExpBonus)
		AddMoney(sceneId, selfId, x226011_g_MoneyBonus)
		for i, item in pairs(x226011_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x226011_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x226011_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end

	
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x226011_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x226011_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x226011_OnItemChanged(sceneId, selfId, itemdataId)

end

