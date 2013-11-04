--与宋联军

--MisDescBegin
x207001_g_ScriptId = 207001
--x207001_g_MissionIdPre =124
x207001_g_MissionId = 263
x207001_g_MissionKind = 18
x207001_g_MissionLevel = 75
x207001_g_ScriptIdNext = {ScriptId = 207002 ,LV = 1 }
x207001_g_Name	="窝阔台" 
x207001_g_Name2	="王楫" 
x207001_g_DemandItem ={}
--x207001_g_noDemandKill ={{id=301,num=1}}	

x207001_g_MissionName="与宋联军"
x207001_g_MissionInfo="    蔡州城坚池深，我们围攻蔡州已经六个约月了，久攻不下，粮饷不足。\n \n    我已经决定和位于南方的宋国联手，一起灭了金国。我已任命王楫为我蒙古大使，出使宋国协商，这是我们蒙古国给宋国皇帝的密函，请你把它送到驿站，交给#G王楫#W。"  --任务描述
x207001_g_MissionTarget="    窝阔台让你把信函送到驿站，交给出使宋国的#G王楫#W。"		
x207001_g_MissionComplete="    你辛苦了！"					--完成任务npc说话的话
--x207001_g_ContinueInfo="    不管付出多大代价，也要把那件东西给拿回来。"
--任务奖励
x207001_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x207001_g_ItemBonus={}

--可选物品奖励，最多8种
x207001_g_RadioItemBonus={}

--MisDescEnd
x207001_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x207001_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207001_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207001_g_MissionId) > 0 then
		
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x207001_g_MissionName)
		     AddText(sceneId,x207001_g_MissionComplete)
		     AddMoneyBonus(sceneId, x207001_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x207001_g_ScriptId, x207001_g_MissionId)
                

        elseif x207001_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x207001_g_MissionName)
                AddText(sceneId,x207001_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x207001_g_MissionTarget) 
		AddMoneyBonus(sceneId, x207001_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207001_g_ScriptId, x207001_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207001_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207001_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207001_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207001_g_ScriptId, x207001_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207001_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207001_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207001_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==7) then
        		if (GetName(sceneId,targetId)==x207001_g_Name) then
	        	        if IsHaveMission(sceneId,selfId, x207001_g_MissionId)<= 0 then
	        	            	return 1
	        	        end
	        	end
			if (GetName(sceneId,targetId)==x207001_g_Name2) then
				    if IsHaveMission(sceneId,selfId, x207001_g_MissionId) > 0 then
				    	return 1
	        	            end
	        	end
	end
        return 0
	
end

--**********************************

--接受

--**********************************

function x207001_OnAccept(sceneId, selfId)

	                                                  
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x207001_g_MissionId, x207001_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x207001_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
	     	                                    
	     
end



--**********************************

--放弃

--**********************************

function x207001_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207001_g_MissionId)
	for i, item in x207001_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x207001_CheckSubmit( sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207001_g_Name2) then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207001_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207001_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207001_g_MissionId)
		AddExp(sceneId, selfId, x207001_g_ExpBonus)
		AddMoney(sceneId, selfId, x207001_g_MoneyBonus)
		for i, item in x207001_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x207001_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x207001_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207001_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x207001_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207001_OnItemChanged(sceneId, selfId, itemdataId)

end

