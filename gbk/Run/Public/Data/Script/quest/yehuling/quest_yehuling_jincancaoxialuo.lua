

--脚本号
x207004_g_ScriptId = 207004

--上一个任务的ID
x207004_g_MissionIdPre =2

--任务号
x207004_g_MissionId = 5

--任务目标npc
x207004_g_Name	="豁儿赤" 
x207004_g_Name2	="阔阔出" 

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************


--任务发放的物品
--x207004_g_MissionItem = {{id=10400001,num=1}}

--以上是动态**************************************************************

--任务文本描述
x207004_g_MissionName="金蚕草下落"
x207004_g_MissionInfo="只有西夏国才产金蚕草，这种草药非常稀奇。阔阔出对西夏的事情很熟，你去问问他关于金蚕草的事情。"  --任务描述
x207004_g_MissionTarget="询问阔阔出找到金蚕草的方法"		--任务目标
x207004_g_MissionComplete="大汗在南征之前，就让汪古部的阿刺乌做内应。阿刺乌已经准备好了解瘴气毒的金蚕草。"					--完成任务npc说话的话
--x207004_g_MissionAddItem="得到军情密报"		
--x207004_g_szBackageFull = "背包已满！"
--任务奖励
x207004_g_MoneyBonus=200
x207004_g_ItemBonus={}
x207004_g_RadioItemBonus={}
x207004_g_ExpBonus = 1000


--**********************************

--任务入口函数

--**********************************

function x207004_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
        if x207004_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207004_g_MissionId) > 0 then
	
		if (GetName(sceneId,targetId)==x207004_g_Name2) then
                     BeginEvent(sceneId)
                     AddText(sceneId, x207004_g_MissionName)
                     AddText(sceneId,x207004_g_MissionComplete)
                     AddMoneyBonus(sceneId, x207004_g_MoneyBonus)
                     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x207004_g_ScriptId, x207004_g_MissionId)
		end
        elseif x207004_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			
		x888888_PrintInfo(sceneId, x207004_g_MissionName, x207004_g_MissionInfo, x207004_g_MissionTarget, x207004_g_ItemBonus, x207004_g_MoneyBonus)

		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207004_g_ScriptId, x207004_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207004_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207004_g_MissionId) > 0 then
		return 
	end
	--如果满足查看条件
	if  x207004_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207004_g_ScriptId, x207004_g_MissionName)
	end
	
end 



--**********************************

--检测接受条件

--**********************************

function x207004_CheckAccept(sceneId, selfId, targetId)

	    if (GetName(sceneId,targetId)==x207004_g_Name) then 
					return 1
	    end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207004_CheckPushList(sceneId, selfId, targetId)
        if (GetName(sceneId,targetId)==x207004_g_Name) then
                if IsMissionHaveDone(sceneId, selfId, x207004_g_MissionIdPre) > 0 then
                    if IsHaveMission(sceneId,selfId, x207004_g_MissionId)<= 0 then
                    return 1
                    end
                end
        end
	if (GetName(sceneId,targetId)==x207004_g_Name2) then
		    if IsHaveMission(sceneId,selfId, x207004_g_MissionId) > 0 then
		    return 1
                    end
        end
        return 0
	
end

--**********************************
                                    
--接受                              
                                    
--**********************************

function x207004_OnAccept(sceneId, selfId)

	--加入任务到玩家列表
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x207004_g_MissionId, x207004_g_ScriptId, 1, 0, 0)
	
end



--**********************************

--放弃

--**********************************

function x207004_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207004_g_MissionId)

end



--**********************************

--检测是否可以提交

--**********************************

function x207004_CheckSubmit( sceneId, selfId, targetId)
        if IsHaveMission(sceneId, selfId, x200101_g_MissionId) >= 0 then
		return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207004_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207004_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207004_g_MissionId)
		AddExp(sceneId, selfId, x207004_g_ExpBonus)
		AddMoney(sceneId, selfId, x207004_g_MoneyBonus)
		for i, item in x207004_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

	end
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207004_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x207004_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207004_OnItemChanged(sceneId, selfId, itemdataId)

end

