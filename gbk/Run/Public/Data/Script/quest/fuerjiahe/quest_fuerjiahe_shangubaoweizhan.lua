--山谷包围战

--MisDescBegin
x223000_g_ScriptId = 223000
--x223000_g_MissionIdPre =83
x223000_g_MissionId = 292
x223000_g_MissionKind = 20
x223000_g_MissionLevel = 100
--x223000_g_ScriptIdNext = {ScriptId = 205002 ,LV = 1 }
x223000_g_Name	="拔都"
x223000_g_Name2	="蒙哥" 
x223000_g_DemandItem ={}
--x223000_g_noDemandKill ={{id=301,num=1}}	

x223000_g_MissionName="山谷包围战"
x223000_g_MissionInfo="    我们的使命，便是征服整个钦察国，让这条伏尔加河成为我大蒙古国畜牧的河流。\n \n    我以西征统帅的身份，任命#G蒙哥#W为攻打钦察的先锋，他用巧妙的手段把钦察国的军队分割包围，钦察人的酋长八赤蛮被包围在东面的山谷中，"  --任务描述
x223000_g_MissionInfo2="，用你最快的速度去蒙哥那里报道！！"
x223000_g_MissionTarget="    到#G蒙哥#W处报道。"		
x223000_g_MissionComplete="    勇士，我听说过你，我的父亲拖雷给我讲过你的故事！寒暄的话我们留到杀光敌人之后吧。目前我们三面开战，需要更多像你这样的勇士，这是你大展手脚的时候。"					--完成任务npc说话的话
--x223000_g_ContinueInfo="    不管付出多大代价，也要把那件东西给拿回来。"
--任务奖励
x223000_g_MoneyBonus = 200
--固定物品奖励，最多8种
x223000_g_ItemBonus={}

--可选物品奖励，最多8种
x223000_g_RadioItemBonus={}

--MisDescEnd
x223000_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x223000_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x223000_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x223000_g_MissionId) > 0 then
		
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x223000_g_MissionName)
		     AddText(sceneId,x223000_g_MissionComplete)
		     AddMoneyBonus(sceneId, x223000_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x223000_g_ScriptId, x223000_g_MissionId)
                

        elseif x223000_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x223000_g_MissionName)
                AddText(sceneId,x223000_g_MissionInfo..GetName(sceneId, selfId)..x223000_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x223000_g_MissionTarget) 
		AddMoneyBonus(sceneId, x223000_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x223000_g_ScriptId, x223000_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x223000_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x223000_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x223000_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x223000_g_ScriptId, x223000_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x223000_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x223000_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x223000_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==17) then
        		if (GetName(sceneId,targetId)==x223000_g_Name) then
	        	        if IsHaveMission(sceneId,selfId, x223000_g_MissionId)<= 0 then
	        	            	return 1
	        	        end
	        	end
			if (GetName(sceneId,targetId)==x223000_g_Name2) then
				    if IsHaveMission(sceneId,selfId, x223000_g_MissionId) > 0 then
				    	return 1
	        	            end
	        	end
	end
        return 0
	
end

--**********************************

--接受

--**********************************

function x223000_OnAccept(sceneId, selfId)

	                                                  
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x223000_g_MissionId, x223000_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x223000_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
	     	                                    
	     
end



--**********************************

--放弃

--**********************************

function x223000_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x223000_g_MissionId)
	for i, item in x223000_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x223000_CheckSubmit( sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x223000_g_Name2) then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x223000_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x223000_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x223000_g_MissionId)
		AddExp(sceneId, selfId, x223000_g_ExpBonus)
		AddMoney(sceneId, selfId, x223000_g_MoneyBonus)
		for i, item in x223000_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x223000_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x223000_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x223000_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x223000_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x223000_OnItemChanged(sceneId, selfId, itemdataId)

end

