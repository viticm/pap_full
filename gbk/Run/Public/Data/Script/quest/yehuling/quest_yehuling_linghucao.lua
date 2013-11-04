--军情密卷

--成吉思汗

--脚本号
x207002_g_ScriptId = 207002
x207003_g_ScriptId = 207003

--上一个任务的ID
x207002_g_MissionIdPre =2

--任务号
x207002_g_MissionId = 3

--任务目标npc
x207002_g_Name	="豁儿赤" 
x207002_g_Name3	="灵狐草" 

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************

--任务需要的物品
--x207002_g_DemandItem = {{id=13010002,num=10}}

--任务需要提交的物品
--x207002_g_DeleteItem = {{id=13010002,num=10}}

--任务发放的物品
x207002_g_MissionItem = {{id=12090002,num=10}}

--以上是动态**************************************************************

--任务文本描述
x207002_g_MissionName="灵狐草"
x207003_g_MissionName="采集草药"
x207002_g_MissionInfo="我们需要很多灵狐草，北边不远处就有灵狐草(200,150)，你去采十株来给我。小心附近的敌人"  --任务描述
x207002_g_MissionTarget="帮豁儿赤采集10株灵狐草"		--任务目标
x207002_g_ContinueInfo="找到灵狐草了吗？"		--未完成任务的npc对话
x207002_g_MissionComplete="真诚的向你致谢，看来你是长生天派来帮助我们的。"					--完成任务npc说话的话
--x207002_g_MissionAddItem="得到军情密报"		
--x207002_g_szBackageFull = "背包已满！"
--任务奖励
x207002_g_MoneyBonus=200
x207002_g_ItemBonus={}
x207002_g_RadioItemBonus={}
x207002_g_ExpBonus = 1000


--**********************************

--任务入口函数

--**********************************

function x207002_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
       misIndex = GetMissionIndexByID(sceneId,selfId,x207002_g_MissionId)
       
	--检测列出条件
	if x207002_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207002_g_MissionId) > 0 then
	        if (GetName(sceneId,targetId)==x207002_g_Name) then
	            if  x207002_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                     BeginEvent(sceneId)
		     AddText(sceneId,x207002_g_ContinueInfo)
		     AddText(sceneId,"需要物品") 
                     for i, item in x207002_g_MissionItem do
		     AddItemBonus(sceneId, item.id, item.num)
		     EndEvent()
		     end
		     local bDone = x207002_CheckSubmit(sceneId, selfId, targetId)
		     DispatchMissionDemandInfo(sceneId, selfId, targetId, x207002_g_ScriptId, x207002_g_MissionId, bDone)
		    end
		    if  x207002_CheckSubmit(sceneId, selfId, targetId) > 0 then
		     BeginEvent(sceneId)
		     AddText(sceneId,x207002_g_MissionComplete)
		     AddMoneyBonus(sceneId, x207002_g_MoneyBonus) 
		     EndEvent()
		     DispatchMissionContinueInfo(sceneId, selfId, targetId, x207002_g_ScriptId, x207002_g_MissionId)
		    end
		end
        elseif x207002_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			
		x888888_PrintInfo(sceneId, x207002_g_MissionName, x207002_g_MissionInfo, x207002_g_MissionTarget, x207002_g_ItemBonus, x207002_g_MoneyBonus)

		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207002_g_ScriptId, x207002_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207002_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207002_g_MissionId) > 0 then
		return 
	end
	--如果满足查看条件
	if  x207002_CheckPushList(sceneId, selfId, targetId) > 0 then
	      if (GetName(sceneId,targetId)==x207002_g_Name) then
		AddNumText(sceneId, x207002_g_ScriptId, x207002_g_MissionName)
	      end
	      if (GetName(sceneId,targetId)==x207002_g_Name3) then
		AddNumText(sceneId, x207003_g_ScriptId, x207003_g_MissionName)
	      end
	end
	
end 



--**********************************

--检测接受条件

--**********************************

function x207002_CheckAccept(sceneId, selfId, targetId)

	    if (GetName(sceneId,targetId)==x207002_g_Name) then 
					return 1
	    end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207002_CheckPushList(sceneId, selfId, targetId)
        if (GetName(sceneId,targetId)==x207002_g_Name) then
                if IsMissionHaveDone(sceneId, selfId, x207002_g_MissionIdPre) > 0 then
                    return 1
                end
        end
	if (GetName(sceneId,targetId)==x207002_g_Name3) then
	      if LuaFnGetItemCount(sceneId,selfId,12090002)<10 then
                 if IsHaveMission(sceneId,selfId, x207002_g_MissionId) > 0 then
                 return 1
		 end
	      end
        end
        return 0
	
end

--**********************************
                                    
--接受                              
                                    
--**********************************

function x207002_OnAccept(sceneId, selfId)

	--加入任务到玩家列表
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x207002_g_MissionId, x207002_g_ScriptId, 1, 0, 0)
	
end



--**********************************

--放弃

--**********************************

function x207002_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207002_g_MissionId)

end



--**********************************

--检测是否可以提交

--**********************************

function x207002_CheckSubmit( sceneId, selfId, targetId)
       
	if LuaFnGetItemCount(sceneId,selfId,12090002)==10 then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207002_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207002_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207002_g_MissionId)
		AddExp(sceneId, selfId, x207002_g_ExpBonus)
		AddMoney(sceneId, selfId, x207002_g_MoneyBonus)
		for i, item in x207002_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x207002_g_MissionItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
	end
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207002_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x207002_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207002_OnItemChanged(sceneId, selfId, itemdataId)

end

