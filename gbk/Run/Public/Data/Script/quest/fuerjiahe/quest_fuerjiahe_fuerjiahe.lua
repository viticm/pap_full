--伏尔加河

--MisDescBegin
x223005_g_ScriptId = 223005
--x223005_g_MissionIdPre =322
x223005_g_MissionId = 297
x223005_g_MissionKind = 20
x223005_g_MissionLevel = 100
x223005_g_ScriptIdNext = {ScriptId = 223006 ,LV = 1 }
x223005_g_Name	="贵由" 
x223005_g_DemandItem ={}
x223005_g_DemandKill ={}	

x223005_g_MissionName="伏尔加河"
x223005_g_MissionInfo="    我们为同一个目标而战斗，必须征服他们，消灭他们。说心里话，拔都作为主帅，他的表现并不足以让我信服。\n \n    仅仅是抓一个八赤蛮，拔都居然能吃紧到这个地步。如果换成我指挥的话，钦察的女人早就躺在我的帐篷中了！\n \n    有情报说敌人正在伏尔加河边集结，但是不知道他们在做什么。你给我去河边看一下，他们到底要干什么。年轻人，你要小心他们的弓箭手，我可不希望你还没到河边就成了刺猬！"
x223005_g_MissionTarget="    到#G伏尔加河#W边去#G替贵#W由查看敌人的营地，小心那些弓箭手。"		                                                                                               
x223005_g_MissionComplete="    你带回来的消息非常重要，看来他们打算要逃走。"					--完成任务npc说话的话
x223005_g_ContinueInfo="    我们需要你到河边探索一下，看能不能找到敌人集结河边的原因。"
--任务奖励
x223005_g_MoneyBonus = 10000

--固定物品奖励，最多8种
x223005_g_ItemBonus={}

--可选物品奖励，最多8种
x223005_g_RadioItemBonus={}

--MisDescEnd
x223005_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x223005_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x223005_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x223005_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x223005_g_MissionId)
		if x223005_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x223005_g_MissionName)
			AddText(sceneId,x223005_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x223005_g_MissionTarget) 
			AddText(sceneId,format("\n    到伏尔加河查看敌人营地   %d/1", GetMissionParam(sceneId,selfId,misIndex,0) ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x223005_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x223005_g_MissionName)
		     AddText(sceneId,x223005_g_MissionComplete)
		     AddMoneyBonus(sceneId, x223005_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x223005_g_ScriptId, x223005_g_MissionId)
                end

        elseif x223005_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x223005_g_MissionName)
                AddText(sceneId,x223005_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x223005_g_MissionTarget) 
		AddMoneyBonus(sceneId, x223005_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x223005_g_ScriptId, x223005_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x223005_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x223005_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x223005_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x223005_g_ScriptId, x223005_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x223005_CheckAccept(sceneId, selfId, targetId)

	if IsHaveMission(sceneId,selfId, x223005_g_MissionId)<= 0 then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x223005_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==17) then
		--if IsMissionHaveDone(sceneId, selfId, x223005_g_MissionIdPre) > 0 then
                    return 1
        	--end
        end
	return 0
	
end

--**********************************

--接受

--**********************************

function x223005_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x223005_g_MissionId, x223005_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x223005_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		misIndex = GetMissionIndexByID(sceneId,selfId,x223005_g_MissionId)
		                                              
	     
end



--**********************************

--放弃

--**********************************

function x223005_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x223005_g_MissionId)

end



--**********************************

--检测是否可以提交

--**********************************

function x223005_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x223005_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == 1 then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x223005_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x223005_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x223005_g_MissionId)
		AddExp(sceneId, selfId, x223005_g_ExpBonus)
		AddMoney(sceneId, selfId, x223005_g_MoneyBonus)
		for i, item in x223005_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x223005_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x223005_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x223005_OnKillObject(sceneId, selfId, objdataId)
	
end



--**********************************

--进入区域事件

--**********************************

function x223005_OnEnterArea(sceneId, selfId, zoneId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x223005_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == 0 then
		if IsHaveMission(sceneId,selfId, x223005_g_MissionId)> 0 then
		SetMissionByIndex(sceneId,selfId,misIndex,0,1)
		BeginEvent(sceneId)
		AddText(sceneId,"    到伏尔加河查看敌人营地   1/1") 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		BeginEvent(sceneId)
		AddText(sceneId,"    在伏尔加河上，有一些小船。在河畔，一些船夫在做着准备工作。看起来他们想要逃跑了，要快些把这个消息带给贵由。") 
		EndEvent()
		DispatchEventList(sceneId, selfId, targetId)
		end
	end


end

function x223005_OnTimer(sceneId, selfId )

end
function x223005_OnLeaveArea(sceneId, selfId )

end


--**********************************

--道具改变

--**********************************

function x223005_OnItemChanged(sceneId, selfId, itemdataId)

end

