--军情密卷

--成吉思汗

--脚本号
x207001_g_ScriptId = 207001

--上一个任务的ID
x207001_g_MissionIdPre =1

--任务号
x207001_g_MissionId = 2

--任务目标npc
x207001_g_Name	="成吉思汗" 
x207001_g_Name2	="豁儿赤" 

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************

--任务发放的物品
--x207001_g_MissionItem = {{id=10400001,num=1}}

--以上是动态**************************************************************

--任务文本描述
x207001_g_MissionName="询问病情"
x207001_g_MissionInfo="我们大军出现了怪事，很多士兵都生了病，不得不在此扎营。我们的勇士们从来没有离开过大草原，很有可能是因为水土不服而引起的上吐下泻。不过，一些脸色发青的士兵，倒像是中了瘴气之毒，豁儿赤这人对医术颇有研究，你去看看他有什么办法。"  --任务描述
x207001_g_MissionTarget="询问豁儿赤士兵的病情"		--任务目标
x207001_g_MissionComplete="水土不服而导致上吐下泻，可以用灵狐草来治，中了瘴气之毒而导致脸色发青，浑身无力，可以用金蚕草来治，一个人如果有心病，该怎么治呢？唉！可怜的拖雷……"					--完成任务npc说话的话
--x207001_g_MissionAddItem="得到军情密报"		
--x207001_g_szBackageFull = "背包已满！"
--任务奖励
x207001_g_MoneyBonus=200
x207001_g_ItemBonus={}
x207001_g_RadioItemBonus={}
x207001_g_ExpBonus = 1000


--**********************************

--任务入口函数

--**********************************

function x207001_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207001_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207001_g_MissionId) > 0 then
		if (GetName(sceneId,targetId)==x207001_g_Name2) then
                     BeginEvent(sceneId)
	             AddText(sceneId, x207001_g_MissionName)
                     AddText(sceneId,x207001_g_MissionComplete)
                     AddMoneyBonus(sceneId, x207001_g_MoneyBonus) 
	             EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x207001_g_ScriptId, x207001_g_MissionId)

                end
        elseif x207001_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			
		x888888_PrintInfo(sceneId, x207001_g_MissionName, x207001_g_MissionInfo, x207001_g_MissionTarget, x207001_g_ItemBonus, x207001_g_MoneyBonus)

		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207001_g_ScriptId, x207001_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207001_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207001_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207001_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207001_g_ScriptId, x207001_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207001_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207001_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207001_CheckPushList(sceneId, selfId, targetId)
        if (GetName(sceneId,targetId)==x207001_g_Name) then
                if IsMissionHaveDone(sceneId, selfId, x207001_g_MissionIdPre) > 0 then
                    if IsHaveMission(sceneId,selfId, x207001_g_MissionId)<= 0 then
                    return 1
                    end
                end
        end
	if (GetName(sceneId,targetId)==x207001_g_Name2) then
		    if IsHaveMission(sceneId,selfId, x207001_g_MissionId) > 0 then
		    return 1
                    end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x207001_OnAccept(sceneId, selfId)

	--加入任务到玩家列表
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x207001_g_MissionId, x207001_g_ScriptId, 1, 0, 0)		--添加任务
end



--**********************************

--放弃

--**********************************

function x207001_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207001_g_MissionId)

end



--**********************************

--继续

--**********************************

function x207001_OnContinue(sceneId, selfId, targetId)

	--提交任务时的说明信息
	BeginEvent(sceneId)
	
	AddText(sceneId, x207001_g_MissionName)
        AddText(sceneId,x207001_g_MissionComplete)
        AddMoneyBonus(sceneId, x207001_g_MoneyBonus) 
	EndEvent()

	DispatchMissionContinueInfo(sceneId, selfId, targetId, x207001_g_ScriptId, x207001_g_MissionId)

end


--**********************************

--检测是否可以提交

--**********************************

function x207001_CheckSubmit( sceneId, selfId, targetId)

	if IsHaveMission(sceneId, selfId, x207001_g_MissionId) >= 0 then
		return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207001_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207001_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207001_g_MissionId)
		AddExp(sceneId, selfId, x207001_g_ExpBonus)
		AddMoney(sceneId, selfId, x207001_g_MoneyBonus)
		for i, item in x207001_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

	end
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207001_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x207001_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207001_OnItemChanged(sceneId, selfId, itemdataId)

end

