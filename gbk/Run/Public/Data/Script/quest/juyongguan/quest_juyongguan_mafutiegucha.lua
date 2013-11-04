--马夫帖古察

--MisDescBegin
x206006_g_ScriptId = 206006
x206006_g_MissionIdPre =32
x206006_g_MissionId = 33
x206006_g_MissionKind = 8
x206006_g_MissionLevel = 40
x206006_g_ScriptIdNext = {ScriptId = 206007 ,LV = 1 }
x206006_g_Name	="孛鲁" 
x206006_g_Name2	="帖古察" 

x206006_g_MissionName="马夫帖古察"
x206006_g_MissionInfo="    哈儿真叔叔小的时候是马夫#G帖古察#W在西辽边境的时候，一个身患重病的倒是交付给他的，帖古察是给成吉思汗养马的。我也想知道哈儿真叔叔为何要叛逃，他不是那种贪生怕死的人！他是英雄！去问问帖木查哈儿真叔叔的事情吧"  --任务描述
x206006_g_MissionTarget="    询问#G帖古察#R哈儿真#W叛逃的事情。"		
x206006_g_MissionComplete="    哈儿真是我一手养大的，就连乃蛮部的太阳汗也很欣赏他，他怎么会叛逃呢？如果没有把他逼到那个份上……哼！\n \n    有些人天生的懦弱，即没有战功，又贪生怕死，整天依靠着溜须拍马的过日子，看到我的哈儿真儿子这么杰出，自然要陷害于他！"					--完成任务npc说话的话
x206006_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x206006_g_ItemBonus={}

--可选物品奖励，最多8种
x206006_g_RadioItemBonus={}

--MisDescEnd
x206006_g_ExpBonus = 1000


--**********************************

--任务入口函数

--**********************************

function x206006_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x206006_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x206006_g_MissionId) > 0 then
		if (GetName(sceneId,targetId)==x206006_g_Name2) then
                     	BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x206006_g_MissionName)
			AddText(sceneId,x206006_g_MissionComplete)
		        AddMoneyBonus(sceneId, x206006_g_MoneyBonus)	
			EndEvent()
			DispatchMissionContinueInfo(sceneId, selfId, targetId, x206006_g_ScriptId, x206006_g_MissionId)
		end
        elseif x206006_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x206006_g_MissionName)
                AddText(sceneId,x206006_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x206006_g_MissionTarget) 
		AddMoneyBonus(sceneId, x206006_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x206006_g_ScriptId, x206006_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x206006_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x206006_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x206006_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x206006_g_ScriptId, x206006_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x206006_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x206006_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x206006_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==6) then
        	if IsMissionHaveDone(sceneId, selfId, x206006_g_MissionIdPre) > 0 then
        		if (GetName(sceneId,targetId)==x206006_g_Name) then
        	        	if IsHaveMission(sceneId,selfId, x206006_g_MissionId)<= 0 then
        	            		return 1
        	        	end
        		elseif (GetName(sceneId,targetId)==x206006_g_Name2) then
			    	if IsHaveMission(sceneId,selfId, x206006_g_MissionId) > 0 then
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

function x206006_OnAccept(sceneId, selfId)

	--加入任务到玩家列表
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x206006_g_MissionId, x206006_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x206006_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
end



--**********************************

--放弃

--**********************************

function x206006_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x206006_g_MissionId)

end



--**********************************

--检测是否可以提交

--**********************************

function x206006_CheckSubmit( sceneId, selfId, targetId)

	if IsHaveMission(sceneId, selfId, x206006_g_MissionId) >= 0 then
		return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x206006_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x206006_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x206006_g_MissionId)
		AddExp(sceneId, selfId, x206006_g_ExpBonus)
		AddMoney(sceneId, selfId, x206006_g_MoneyBonus)
		for i, item in x206006_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end
	        CallScriptFunction( x206006_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )

	end
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x206006_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x206006_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x206006_OnItemChanged(sceneId, selfId, itemdataId)

end

