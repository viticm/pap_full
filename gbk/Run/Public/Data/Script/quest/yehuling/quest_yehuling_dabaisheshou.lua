--打败射手

--MisDescBegin
x207008_g_ScriptId = 207008
x207008_g_MissionIdPre =8
x207008_g_MissionId = 9
x207008_g_MissionKind = 1
x207008_g_ScriptIdNext = {ScriptId = 207009 ,LV = 1 }
x207008_g_Name	="年轻的射手" 
x207008_g_DemandItem ={}
x207008_g_DemandKill ={}	

x207008_g_MissionName="打败射手"
x207008_g_MissionInfo="    不要再勾起一些伤心的事情了，有些事，过了十天，有若十年……，我依旧活在痛苦中。如果你能解决我的痛苦，我会告诉你所有的一切……解决我痛苦的方法，就是杀了我！"  --任务描述
x207008_g_MissionTarget="    打败年轻的射手"		                                                                                               
x207008_g_MissionComplete="    好……，好身手！很久没有遇到这样的对手了，这样刺激的交手，让我想通的很多事情！\n \n看你诧异的表情，已经猜出我是谁了吧……哈哈哈！没错，我就是#G哲别#W，神箭手哲别！我已经很久没有回去了……，唉！\n \n一个人在不知道自己做的是对是错的时候，才是最无奈的，那种心情，有坠入深渊之感。我知道你想问什么，只是……别让#G拖雷#W知道。\n \n#G成吉思汗#W是天之骄子，早就想好了攻打#G乌月营#W的方法，其实只需要半天不到的功夫就能破城，他之所以这么做，是为了让#G拖雷#W学到带兵打仗的真谛。只是#G拖雷#W沉迷女色，让大汗非常失望，大汗认为，#G水月#W是成精了的狐狸精，只有杀了#G水月#W，才能挽救#G拖雷#W。"					--完成任务npc说话的话
x207008_g_ContinueInfo="    武器不是这么用的！你的身手不错，只是……光有蛮力是不不能成大事的！请原谅我的直接！嘿！"
--任务奖励
x207008_g_MoneyBonus = 10000

--固定物品奖励，最多8种
x207008_g_ItemBonus={}

--可选物品奖励，最多8种
x207008_g_RadioItemBonus={}

--MisDescEnd
--**********************************

--任务入口函数

--**********************************

function x207008_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207008_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207008_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x207008_g_MissionId)
		if x207008_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x207008_g_MissionName)
			AddText(sceneId,x207008_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x207008_g_MissionTarget) 
			AddText(sceneId,format("\n    打败年轻的射手   %d/1", GetMissionParam(sceneId,selfId,misIndex,0) ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x207008_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x207008_g_MissionName)
		     AddText(sceneId,x207008_g_MissionComplete)
		     AddText(sceneId,"#Y任务目标#W") 
		     AddText(sceneId,x207008_g_MissionTarget) 
		     AddText(sceneId,format("\n    打败年轻的射手   %d/1", GetMissionParam(sceneId,selfId,misIndex,0) ))
                     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x207008_g_ScriptId, x207008_g_MissionId)
                end

        elseif x207008_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x207008_g_MissionName)
                AddText(sceneId,x207008_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x207008_g_MissionTarget) 
		AddMoneyBonus(sceneId, x207008_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207008_g_ScriptId, x207008_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207008_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207008_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207008_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207008_g_ScriptId, x207008_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207008_CheckAccept(sceneId, selfId, targetId)

	if IsHaveMission(sceneId,selfId, x207008_g_MissionId)<= 0 then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207008_CheckPushList(sceneId, selfId, targetId)
	if IsMissionHaveDone(sceneId, selfId, x207008_g_MissionIdPre) > 0 then
                    return 1
        end
	
	
end

--**********************************

--接受

--**********************************

function x207008_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x207008_g_MissionId, x207008_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x207008_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		misIndex = GetMissionIndexByID(sceneId,selfId,x207008_g_MissionId)
		SetMissionByIndex(sceneId,selfId,misIndex,0,1)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x207008_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207008_g_MissionId)

end



--**********************************

--检测是否可以提交

--**********************************

function x207008_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x207008_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == 1 then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207008_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207008_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207008_g_MissionId)
		AddExp(sceneId, selfId, x207008_g_ExpBonus)
		AddMoney(sceneId, selfId, x207008_g_MoneyBonus)
		for i, item in x207008_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x207008_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x207008_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207008_OnKillObject(sceneId, selfId, objdataId)
	

end



--**********************************

--进入区域事件

--**********************************

function x207008_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207008_OnItemChanged(sceneId, selfId, itemdataId)

end

