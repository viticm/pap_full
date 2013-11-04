--国之根本

--MisDescBegin
x208012_g_ScriptId = 208012
--x208012_g_MissionIdPre =40
x208012_g_MissionId = 66
x208012_g_MissionKind = 12
x208012_g_MissionLevel = 60
--x208012_g_ScriptIdNext = {ScriptId = 208003 ,LV = 1 }
x208012_g_Name	="耶律楚材" 
x208012_g_Name2	="成吉思汗" 
--x208012_g_DemandItem ={{id=13010003,num=1}}
--x208012_g_noDemandKill ={{id=301,num=1}}	

x208012_g_MissionName="国之根本"
x208012_g_MissionInfo="    这是正义之战，师出有名，我们蒙古军是世界上最强大的军队，伊斯兰教长老为了救全城百姓，打开了城门，他们只有一个要求，就是放过全城的百姓，我已经应予了。\n \n    百姓乃国之根本，而且，这些百姓没有抵抗我们大军，"  --任务描述
x208012_g_MissionInfo2="，我看大汗对你另眼相看，所以想请你出马，劝告大汗，让他善待百姓。"
x208012_g_MissionTarget="    耶律楚材希望你能劝说#G成吉思汗#W，放过无辜的百姓。"		
x208012_g_MissionComplete="    我明白耶律楚材的心思，他的话有道理，我会让他出一份告示，让那些百姓放心。"					--完成任务npc说话的话
--x208012_g_ContinueInfo="    不管付出多大代价，也要把那件东西给拿回来。"
--任务奖励
x208012_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x208012_g_ItemBonus={}

--可选物品奖励，最多8种
x208012_g_RadioItemBonus={}

--MisDescEnd
x208012_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x208012_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x208012_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x208012_g_MissionId) > 0 then
		
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x208012_g_MissionName)
		     AddText(sceneId,x208012_g_MissionComplete)
		     AddMoneyBonus(sceneId, x208012_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x208012_g_ScriptId, x208012_g_MissionId)
                

        elseif x208012_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x208012_g_MissionName)
                AddText(sceneId,x208012_g_MissionInfo..GetName(sceneId, selfId)..x208012_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x208012_g_MissionTarget) 
		AddMoneyBonus(sceneId, x208012_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x208012_g_ScriptId, x208012_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x208012_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x208012_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x208012_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x208012_g_ScriptId, x208012_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x208012_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x208012_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x208012_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==8) then
        	if (GetName(sceneId,targetId)==x208012_g_Name) then
        	        if IsHaveMission(sceneId,selfId, x208012_g_MissionId)<= 0 then
        	            	return 1
        	        end
        	end
		if (GetName(sceneId,targetId)==x208012_g_Name2) then
			    if IsHaveMission(sceneId,selfId, x208012_g_MissionId) > 0 then
			    	return 1
        	            end
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x208012_OnAccept(sceneId, selfId)

	                                                  
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x208012_g_MissionId, x208012_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x208012_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
	     	                                    
	     
end



--**********************************

--放弃

--**********************************

function x208012_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x208012_g_MissionId)
	for i, item in x208012_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x208012_CheckSubmit( sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x208012_g_Name2) then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x208012_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x208012_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x208012_g_MissionId)
		AddExp(sceneId, selfId, x208012_g_ExpBonus)
		AddMoney(sceneId, selfId, x208012_g_MoneyBonus)
		for i, item in x208012_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		
		--CallScriptFunction( x208012_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x208012_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x208012_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x208012_OnItemChanged(sceneId, selfId, itemdataId)

end

