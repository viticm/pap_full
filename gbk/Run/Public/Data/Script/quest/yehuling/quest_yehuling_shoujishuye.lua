--军情密卷

--成吉思汗

--脚本号
x207014_g_ScriptId = 207014
x207015_g_ScriptId = 207015

--上一个任务的ID
x207014_g_MissionIdPre =24

--任务号
x207014_g_MissionId = 15

--任务目标npc
x207014_g_Name	="豁儿赤" 
x207014_g_Name3	="黄檀叶" 

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************

--任务需要的物品
x207014_g_DemandItem = {{id=12090006,num=15}}

--任务需要提交的物品
x207014_g_DeleteItem = {{id=12090006,num=15}}

--任务发放的物品
--x207014_g_MissionItem = {{id=10400001,num=1}}

--以上是动态**************************************************************

--任务文本描述
x207014_g_MissionName="收集树叶"
x207015_g_MissionName="采集黄檀叶"
x207014_g_MissionInfo="很快我就可以在这城里挑三十个美丽的女人做老婆，这是成吉思汗称汗之前给我的承诺。在野狐岭深处(65,40)有一种树叫黄檀，这种树的叶子搅碎之后，流出的液体和雾色很接近。木华黎将军已经部署好了攻城方案，把这些液体都涂在身上和火炮上，借着雾气全力攻城。"  --任务描述
x207014_g_MissionTarget="给豁儿赤带回15片黄檀叶"		--任务目标
x207014_g_ContinueInfo="想到三十个老婆，真是让人兴奋啊，你赶紧去找黄檀叶，我们好攻城。"		--未完成任务的npc对话
x207014_g_MissionComplete="真是感激不尽啊，以后我有了三十个老婆，我会告诉你一个让你天大的秘密。我们即将攻打野狐岭，你是大汗的那可儿，要早点会大汗身边。"					--完成任务npc说话的话
--x207014_g_MissionAddItem="得到军情密报"		
--x207014_g_szBackageFull = "背包已满！"
--任务奖励
x207014_g_MoneyBonus=200
x207014_g_ItemBonus={}
x207014_g_RadioItemBonus={}
x207014_g_ExpBonus = 1000


--**********************************

--任务入口函数

--**********************************

function x207014_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
       misIndex = GetMissionIndexByID(sceneId,selfId,x207014_g_MissionId)
       
	--检测列出条件
	if x207014_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207014_g_MissionId) > 0 then
	        if (GetName(sceneId,targetId)==x207014_g_Name) then
	           if x207014_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                     BeginEvent(sceneId)
		     AddText(sceneId,x207014_g_ContinueInfo) 
                     AddText(sceneId,"需要物品")  
                     for i, item in pairs(x207014_g_DeleteItem) do
		     AddItemBonus(sceneId, item.id, item.num)
		     EndEvent()
		     end
		     local bDone = x207014_CheckSubmit(sceneId, selfId, targetId)
		     DispatchMissionDemandInfo(sceneId, selfId, targetId, x207014_g_ScriptId, x207014_g_MissionId, bDone)
		   end
		   if x207014_CheckSubmit(sceneId, selfId, targetId) > 0 then
		      BeginEvent(sceneId)
		      AddText(sceneId,x207014_g_MissionComplete) 
		      AddMoneyBonus(sceneId, x207014_g_MoneyBonus)
		      EndEvent()
		      DispatchMissionContinueInfo(sceneId, selfId, targetId, x207014_g_ScriptId, x207014_g_MissionId)
		   end
		end
                if (GetName(sceneId,targetId)==x207014_g_Name3) then
                     BeginEvent(sceneId)
                     AddNumText(sceneId, x207015_g_ScriptId, x207015_g_MissionName)
                     EndEvent()
		     DispatchEventList(sceneId, selfId, targetId)
		end
        elseif x207014_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			
		x888888_PrintInfo(sceneId, x207014_g_MissionName, x207014_g_MissionInfo, x207014_g_MissionTarget, x207014_g_ItemBonus, x207014_g_MoneyBonus)

		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207014_g_ScriptId, x207014_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207014_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207014_g_MissionId) > 0 then
		return 
	end
	--如果满足查看条件
	if  x207014_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207014_g_ScriptId, x207014_g_MissionName)
	end
	
end 



--**********************************

--检测接受条件

--**********************************

function x207014_CheckAccept(sceneId, selfId, targetId)

	    if (GetName(sceneId,targetId)==x207014_g_Name) then 
					return 1
	    end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207014_CheckPushList(sceneId, selfId, targetId)
        if (GetName(sceneId,targetId)==x207014_g_Name) then
                if IsMissionHaveDone(sceneId, selfId, x207014_g_MissionIdPre) > 0 then
                    return 1
                end
        end
	if (GetName(sceneId,targetId)==x207014_g_Name3) then
	      if LuaFnGetItemCount(sceneId,selfId,12090006)<15 then
                 if IsHaveMission(sceneId,selfId, x207014_g_MissionId) > 0 then
                 return 1
		 end
	      end
        end
        return 0
	
end

--**********************************
                                    
--接受                              
                                    
--**********************************

function x207014_OnAccept(sceneId, selfId)

	--加入任务到玩家列表
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x207014_g_MissionId, x207014_g_ScriptId, 1, 0, 0)
	
end



--**********************************

--放弃

--**********************************

function x207014_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207014_g_MissionId)

end



--**********************************

--检测是否可以提交

--**********************************

function x207014_CheckSubmit( sceneId, selfId, targetId)
	if LuaFnGetItemCount(sceneId,selfId,12090006)==15 then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207014_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207014_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207014_g_MissionId)
		AddExp(sceneId, selfId, x207014_g_ExpBonus)
		AddMoney(sceneId, selfId, x207014_g_MoneyBonus)
		for i, item in pairs(x207014_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x207014_g_DeleteItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
	end
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207014_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x207014_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207014_OnItemChanged(sceneId, selfId, itemdataId)

end

