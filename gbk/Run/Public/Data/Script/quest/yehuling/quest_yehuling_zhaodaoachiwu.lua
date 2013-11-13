
--军情密卷

--成吉思汗

--脚本号
x207005_g_ScriptId = 207005
x207006_g_ScriptId = 207006
x207007_g_ScriptId = 207007

--上一个任务的ID
x207005_g_MissionIdPre =5

--任务号
x207005_g_MissionId = 6

--任务目标npc
x207005_g_Name	="阔阔出" 
x207005_g_Name2	="阿刺乌" 

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************

--任务需要的物品
--x207005_g_DemandItem = {{id=10400001,num=1}}

--任务需要提交的物品
--x207005_g_DeleteItem = {{id=10400001,num=1}}

--任务发放的物品
--x207005_g_MissionItem = {{id=10400001,num=1}}

--以上是动态**************************************************************

--任务文本描述
x207005_g_MissionName="找到阿刺乌"
x207006_g_MissionName="芝麻开门"
x207006_g_MissionName2="地虎盖天龙"
x207007_g_MissionName="宝塔镇河妖"
x207005_g_MissionInfo="你需要翻越野狐岭，去跟阿刺乌拿草药。不过，金兵的人很多，即使你化了妆，也要处处小心。你们的接头暗号是：天龙盖地虎，宝塔镇河妖。"  --任务描述
x207005_g_MissionTarget="找到阿刺乌"		--任务目标
x207005_g_ContinueInfo="我是大金的子民，金国和蒙古比，有如……天龙盖地虎。选择："		--未完成任务的npc对话
x207005_g_MissionComplete="比我安答还亲的勇士，你终于了，这里常有金兵来抓间谍，我不能不小心，请原谅我的冒昧。"					--完成任务npc说话的话
--x207005_g_MissionAddItem="得到军情密报"		
--x207005_g_szBackageFull = "背包已满！"
--任务奖励
x207005_g_MoneyBonus=200
x207005_g_ItemBonus={}
x207005_g_RadioItemBonus={}
x207005_g_ExpBonus = 1000


--**********************************

--任务入口函数

--**********************************

function x207005_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207005_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207005_g_MissionId) > 0 then
		if (GetName(sceneId,targetId)==x207005_g_Name2) then
                     BeginEvent(sceneId)
		     AddText(sceneId,x207005_g_ContinueInfo) 
                     EndEvent()
		     local bDone = x207005_CheckSubmit(sceneId, selfId, targetId)
		     DispatchMissionDemandInfo(sceneId, selfId, targetId, x207005_g_ScriptId, x207005_g_MissionId, bDone)
		
                end
        elseif x207005_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			
		x888888_PrintInfo(sceneId, x207005_g_MissionName, x207005_g_MissionInfo, x207005_g_MissionTarget, x207005_g_ItemBonus, x207005_g_MoneyBonus)

		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207005_g_ScriptId, x207005_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207005_OnEnumerate(sceneId, selfId, targetId)
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207005_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207005_CheckPushList(sceneId, selfId, targetId) > 0 then
	
	
	      if (GetName(sceneId,targetId)==x207005_g_Name) then 
		AddNumText(sceneId, x207005_g_ScriptId, x207005_g_MissionName)
	      end
	      if (GetName(sceneId,targetId)==x207005_g_Name2) then 
	         BeginEvent(sceneId)
		 AddText(sceneId,x207005_g_ContinueInfo) 
                 EndEvent()
                 DispatchEventList(sceneId, selfId, targetId)
                 AddNumText(sceneId, x207006_g_ScriptId, x207006_g_MissionName)
	         AddNumText(sceneId, x207006_g_ScriptId, x207006_g_MissionName2)
	         AddNumText(sceneId, x207007_g_ScriptId, x207007_g_MissionName)
	      end
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207005_CheckAccept(sceneId, selfId, targetId)

	if IsMissionHaveDone(sceneId, selfId, x207005_g_MissionIdPre) > 0 then
	    if (GetName(sceneId,targetId)==x207005_g_Name) then 
					return 1
	    end
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207005_CheckPushList(sceneId, selfId, targetId)

        if (GetName(sceneId,targetId)==x207005_g_Name) then
                if IsMissionHaveDone(sceneId, selfId, x207005_g_MissionIdPre) > 0 then
                    if IsHaveMission(sceneId,selfId, x207005_g_MissionId)<= 0 then
                    return 1
                    end
                end
        end
	if (GetName(sceneId,targetId)==x207005_g_Name2) then
		    if IsHaveMission(sceneId,selfId, x207005_g_MissionId) > 0 then
		    return 1
                    end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x207005_OnAccept(sceneId, selfId)

	--加入任务到玩家列表
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x207005_g_MissionId, x207005_g_ScriptId, 1, 0, 0)		--添加任务
end



--**********************************

--放弃

--**********************************

function x207005_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207005_g_MissionId)

end



--**********************************

--继续

--**********************************

function x207005_OnContinue(sceneId, selfId, targetId)

	--提交任务时的说明信息
	BeginEvent(sceneId)
	
	AddText(sceneId, x207005_g_MissionName)
        AddText(sceneId,x207005_g_MissionComplete)
        AddMoneyBonus(sceneId, x207005_g_MoneyBonus) 
	EndEvent()

	DispatchMissionContinueInfo(sceneId, selfId, targetId, x207005_g_ScriptId, x207005_g_MissionId)

end


--**********************************

--检测是否可以提交

--**********************************

function x207005_CheckSubmit( sceneId, selfId, targetId)

	if IsHaveMission(sceneId, selfId, x207005_g_MissionId) >= 0 then
		return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207005_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207005_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207005_g_MissionId)
		AddExp(sceneId, selfId, x207005_g_ExpBonus)
		AddMoney(sceneId, selfId, x207005_g_MoneyBonus)
		for i, item in pairs(x207005_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

	end
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207005_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x207005_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207005_OnItemChanged(sceneId, selfId, itemdataId)

end

