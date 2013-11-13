--军情密卷

--成吉思汗

--脚本号
x207013_g_ScriptId = 207013

--上一个任务的ID
x207013_g_MissionIdPre =13

--任务号
x207013_g_MissionId = 14

--任务目标npc
x207013_g_Name	="术赤" 
x207013_g_Name2	="赤老温" 

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************

--任务需要的物品
--x207013_g_DemandItem = {{id=10400001,num=1}}

--任务需要提交的物品
--x207013_g_DeleteItem = {{id=10400001,num=1}}

--任务发放的物品
x207013_g_MissionItem = {{id=12090002,num=1}}

--以上是动态**************************************************************

--任务文本描述
x207013_g_MissionName="神秘的面具"
x207013_g_MissionInfo="这面具就是那群神秘人带的？真是恐怖！好像魔鬼一样，我从未见过这样的面具。你把面具拿去赤老温，看看他是否知道这个事情。   "  --任务描述
x207013_g_MissionTarget="问问赤老温关于面具的事情，然后向术赤复命"		--任务目标
x207013_g_ContinueInfo="“鬼仆”两个字到底表示什么呢？赤老温会知道吗？"		--未完成任务的npc对话
x207013_g_ContinueInfo2="难道是……鬼仆！这是鬼仆的标志！半年前，我救了一名被鬼仆追杀的小道士，后来小道士的师父丘处机道长告诉我的。金国皇宫有两拨人，一拨人是大内禁军，另一拨就是鬼仆。我就知道这么多……"
x207013_g_MissionComplete="赤老温见多识广，果真知道他们的事情，丘处机……，我听说过，据说他现在有三百多岁，鬼仆嘛，还是第一次听说，你要有兴趣的话，可以把鬼仆的来历调查清楚。"					--完成任务npc说话的话
x207013_g_MissionAddItem="得到神秘的面具"
x207013_g_ShowMissionTarget="询问赤老温关于面具的事情   1/1"	
x207013_g_szBackageFull = "背包已满！"
--任务奖励
x207013_g_MoneyBonus=200
x207013_g_ItemBonus={}
x207013_g_RadioItemBonus={}
x207013_g_ExpBonus = 1000


--**********************************

--任务入口函数

--**********************************

function x207013_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207013_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207013_g_MissionId) > 0 then
	     misIndex = GetMissionIndexByID(sceneId,selfId,x207013_g_MissionId)
		if (GetName(sceneId,targetId)==x207013_g_Name) then
		    if x207013_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                     BeginEvent(sceneId)
		     AddText(sceneId,x207013_g_ContinueInfo)
		     EndEvent()local bDone = x207013_CheckSubmit(sceneId, selfId, targetId)
		     DispatchMissionDemandInfo(sceneId, selfId, targetId, x207013_g_ScriptId, x207013_g_MissionId, bDone)
		    end
		    if x207013_CheckSubmit(sceneId, selfId, targetId) > 0 then
		     BeginEvent(sceneId)AddText(sceneId, x207013_g_MissionName)
		     AddText(sceneId,x207013_g_MissionComplete)
		     AddMoneyBonus(sceneId, x207013_g_MoneyBonus)
		     EndEvent()
		     DispatchMissionContinueInfo(sceneId, selfId, targetId, x207013_g_ScriptId, x207013_g_MissionId)
		    end

		
                end
		if (GetName(sceneId,targetId)==x207013_g_Name2) then
                     BeginEvent(sceneId)
		     AddText(sceneId,x207013_g_ContinueInfo2)
		     EndEvent()
		     DispatchEventList(sceneId, selfId, targetId)
		     BeginEvent(sceneId)
     		     AddText(sceneId, x207013_g_ShowMissionTarget)
     		     EndEvent()
     		     DispatchMissionTips(sceneId, selfId)
     		     SetMissionByIndex(sceneId,selfId,misIndex,0,2)
                end
        elseif x207013_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			
		x888888_PrintInfo(sceneId, x207013_g_MissionName, x207013_g_MissionInfo, x207013_g_MissionTarget, x207013_g_ItemBonus, x207013_g_MoneyBonus)

		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207013_g_ScriptId, x207013_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207013_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207013_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207013_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207013_g_ScriptId, x207013_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207013_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207013_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207013_CheckPushList(sceneId, selfId, targetId)
        if (GetName(sceneId,targetId)==x207013_g_Name) then
                if IsMissionHaveDone(sceneId, selfId, x207013_g_MissionIdPre) > 0 then
                    return 1
                end
        end
	if (GetName(sceneId,targetId)==x207013_g_Name2) then
		    if IsHaveMission(sceneId,selfId, x207013_g_MissionId) > 0 then
		          misIndex = GetMissionIndexByID(sceneId,selfId,x207013_g_MissionId) 
	                  if (GetMissionParam(sceneId,selfId,misIndex,0)==1) then
                          return 1
                          end
                    end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x207013_OnAccept(sceneId, selfId)

	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x207013_g_MissionId, x207013_g_ScriptId, 1, 0, 0)
	misIndex = GetMissionIndexByID(sceneId,selfId,x207013_g_MissionId)		--添加任务                                           
	SetMissionByIndex(sceneId,selfId,misIndex,0,1)                                                         
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x207013_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207013_g_MissionId)

end



--**********************************

--检测是否可以提交

--**********************************

function x207013_CheckSubmit( sceneId, selfId, targetId)

	if IsHaveMission(sceneId, selfId, x207013_g_MissionId) >= 0 then
	        misIndex = GetMissionIndexByID(sceneId,selfId,x207013_g_MissionId) 
	        if (GetMissionParam(sceneId,selfId,misIndex,0)==2) then
	        return 1
		end
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207013_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207013_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207013_g_MissionId)
		AddExp(sceneId, selfId, x207013_g_ExpBonus)
		AddMoney(sceneId, selfId, x207013_g_MoneyBonus)
		for i, item in pairs(x207013_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		
	end
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207013_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x207013_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207013_OnItemChanged(sceneId, selfId, itemdataId)

end

