--寻求帮助

--MisDescBegin
x207010_g_ScriptId = 207010
x207010_g_MissionIdPre =1
x207010_g_MissionId = 11
x207010_g_MissionKind = 1
x207010_g_ScriptIdNext = {ScriptId = 207011 ,LV = 1 }
x207010_g_Name	="拖雷" 
x207010_g_Name2	="赤老温" 

x207010_g_MissionName="寻求帮助"
x207010_g_MissionInfo="    那些#R神秘人#W躲在暗处伏击我们，人虽然不是很多，但是个个都心狠手辣，身手高超。让他们逃了，是我的遗憾，我希望你能够帮我，把他们都消灭掉，#G野狐岭#W上，凡是超过车轮高的金人，一个不留！不过，你的力量太单薄，不能一个人去冒险，你把这件事告诉#G赤老温#W，他会有办法的。"  --任务描述
x207010_g_MissionTarget="    寻求#G赤老温#W的帮助"		
x207010_g_MissionComplete="    #R神秘人#W？事情越来越复杂了……我在#G野狐岭#W也遇到过一个，脸上戴着恐怖的面具，整个人阴森森的！难道真的跟传说有关？\n \n没猜错的话，这#R神秘人#W就是#R鬼仆#W！嘿嘿，我老赤的弯刀可是遇神杀神，遇鬼杀鬼！恩，是的，我已经闻到了血腥的气息，刀尖挑开了他们的皮肤，我会把他们的筋抽出来作我的缰绳……"					--完成任务npc说话的话
--任务奖励
x207010_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x207010_g_ItemBonus={}

--可选物品奖励，最多8种
x207010_g_RadioItemBonus={}

--MisDescEnd


--**********************************

--任务入口函数

--**********************************

function x207010_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207010_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207010_g_MissionId) > 0 then
		if (GetName(sceneId,targetId)==x207010_g_Name2) then
                     	BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x207010_g_MissionName)
			AddText(sceneId,x207010_g_MissionComplete)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x207010_g_MissionTarget) 
			AddMoneyBonus(sceneId, x207010_g_MoneyBonus)	
			EndEvent()
			DispatchMissionContinueInfo(sceneId, selfId, targetId, x207010_g_ScriptId, x207010_g_MissionId)
		end
        elseif x207010_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x207010_g_MissionName)
                AddText(sceneId,x207010_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x207010_g_MissionTarget) 
		AddMoneyBonus(sceneId, x207010_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207010_g_ScriptId, x207010_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207010_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207010_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207010_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207010_g_ScriptId, x207010_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207010_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207010_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207010_CheckPushList(sceneId, selfId, targetId)
        if (GetName(sceneId,targetId)==x207010_g_Name) then
                if IsHaveMission(sceneId,selfId, x207010_g_MissionId)<= 0 then
                    return 1
                end
        end
	if (GetName(sceneId,targetId)==x207010_g_Name2) then
		    if IsHaveMission(sceneId,selfId, x207010_g_MissionId) > 0 then
		    return 1
                    end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x207010_OnAccept(sceneId, selfId)

	--加入任务到玩家列表
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x207010_g_MissionId, x207010_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x207010_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
end



--**********************************

--放弃

--**********************************

function x207010_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207010_g_MissionId)

end



--**********************************

--检测是否可以提交

--**********************************

function x207010_CheckSubmit( sceneId, selfId, targetId)

	if IsHaveMission(sceneId, selfId, x207010_g_MissionId) >= 0 then
		return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207010_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207010_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207010_g_MissionId)
		AddExp(sceneId, selfId, x207010_g_ExpBonus)
		AddMoney(sceneId, selfId, x207010_g_MoneyBonus)
		CallScriptFunction( x207010_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )

	end
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207010_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x207010_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207010_OnItemChanged(sceneId, selfId, itemdataId)

end

