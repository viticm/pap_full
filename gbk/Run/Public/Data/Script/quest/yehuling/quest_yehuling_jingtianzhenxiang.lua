--惊天真相

--MisDescBegin
x207007_g_ScriptId = 207007
x207007_g_MissionIdPre =7
x207007_g_MissionId = 8
x207007_g_MissionKind = 1
x207007_g_ScriptIdNext = {ScriptId = 207008 ,LV = 1 }
x207007_g_Name	="算命先生" 
x207007_g_Name2	="年轻的射手" 

x207007_g_MissionName="惊天真相"
x207007_g_MissionInfo="    我老了，厌倦了争名夺利的事情，说起来，也是来自这玉佩。#G乌月营#W一战，有一青年能拉九石弓，百步穿杨，从城池上一箭射杀蒙军将领#G拖雷#W。只是，那一箭没射死#G拖雷#W，因为一个叫#G水月#W的女人，用她的身体挡住了那致命的一箭，她在死的时候，紧紧的抱着#G拖雷#W，嘴角露出很幸福的笑……\n \n那一刻，十万多正在交战的人都沉默了，我们的目光都落在了她那芊瘦的尸体上，震天的喊杀声变得寂静了。\n \n#G拖雷#W疯狂了，连续七天七夜攻城，最后屠城！我之所以能活下来，是因为我发现了那百步穿杨的年轻人是蒙古人。！那玉佩，就是#G拖雷#W给#G水月#W的定情之物。至于玉佩是怎么出现的，我也不清楚……，如果你实在要查清楚，只有一个办法，找到那个百步穿杨的年轻人，他很容易辨认，因为他的弓很特别，你要小心了。"  --任务描述
x207007_g_MissionTarget="    寻找射杀#G水月#W的年轻人"		
x207007_g_MissionComplete="    十年生死两茫茫。不思量，自难忘！有些人虽死了，却活着，有些人活着……你知道他，他已经死了！"					--完成任务npc说话的话
--任务奖励
x207007_g_MoneyBonus = 10000

--固定物品奖励，最多8种
x207007_g_ItemBonus={}

--可选物品奖励，最多8种
x207007_g_RadioItemBonus={}

--MisDescEnd


--**********************************

--任务入口函数

--**********************************

function x207007_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207007_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207007_g_MissionId) > 0 then
		if (GetName(sceneId,targetId)==x207007_g_Name2) then
                     	BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x207007_g_MissionName)
			AddText(sceneId,x207007_g_MissionComplete)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x207007_g_MissionTarget) 
			AddMoneyBonus(sceneId, x207007_g_MoneyBonus)	
			EndEvent()
			DispatchMissionContinueInfo(sceneId, selfId, targetId, x207007_g_ScriptId, x207007_g_MissionId)
		end
        elseif x207007_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x207007_g_MissionName)
                AddText(sceneId,x207007_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x207007_g_MissionTarget) 
		AddMoneyBonus(sceneId, x207007_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207007_g_ScriptId, x207007_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207007_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207007_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207007_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207007_g_ScriptId, x207007_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207007_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207007_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207007_CheckPushList(sceneId, selfId, targetId)
        if (GetName(sceneId,targetId)==x207007_g_Name) then
                if IsMissionHaveDone(sceneId, selfId, x207007_g_MissionIdPre) > 0 then
                    if IsHaveMission(sceneId,selfId, x207007_g_MissionId)<= 0 then
                    return 1
                    end
                end
        end
	if (GetName(sceneId,targetId)==x207007_g_Name2) then
		    if IsHaveMission(sceneId,selfId, x207007_g_MissionId) > 0 then
		    return 1
                    end
        end
        return 0
     
end

--**********************************

--接受

--**********************************

function x207007_OnAccept(sceneId, selfId)

	--加入任务到玩家列表
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x207007_g_MissionId, x207007_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x207007_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
end



--**********************************

--放弃

--**********************************

function x207007_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207007_g_MissionId)

end



--**********************************

--检测是否可以提交

--**********************************

function x207007_CheckSubmit( sceneId, selfId, targetId)

	if IsHaveMission(sceneId, selfId, x207007_g_MissionId) >= 0 then
		return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207007_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207007_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207007_g_MissionId)
		AddExp(sceneId, selfId, x207007_g_ExpBonus)
		AddMoney(sceneId, selfId, x207007_g_MoneyBonus)
		for i, item in x207007_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end
	        CallScriptFunction( x207007_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )

	end
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207007_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x207007_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207007_OnItemChanged(sceneId, selfId, itemdataId)

end

