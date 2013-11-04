--叛军的踪迹

--MisDescBegin
x206002_g_ScriptId = 206002
x206002_g_MissionIdPre =28
x206002_g_MissionId = 29
x206002_g_MissionKind = 8
x206002_g_MissionLevel = 40
x206002_g_ScriptIdNext = {ScriptId = 206003 ,LV = 1 }
x206002_g_Name	="木华黎" 
x206002_g_DemandItem ={}
x206002_g_DemandKill ={}	

x206002_g_MissionName="叛军的踪迹"
x206002_g_MissionInfo="    豁儿赤那小子，真想把我气死，我的儿子孛鲁才十二岁，他就带着我儿子去小狼沟找女人，到现在还没有回来，偏偏在这个时候，大汗要召开塔里台大会，如果缺席，这可是大罪，"
x206002_g_MissionInfo2="，你不如帮我去小狼沟看看，到底出了什么事！"  --任务描述
x206002_g_MissionTarget="    #G木华黎#W命你去小狼沟查看叛军的踪迹。"		                                                                                               
x206002_g_MissionComplete="    哈儿真？你确定是他吗？如果是豁儿赤说的，那可当真奇怪！这人臂力惊人，两把斧头有如闪电！ \n \n    我儿子孛鲁在他手上？他……他们想干什么？"					--完成任务npc说话的话
x206002_g_ContinueInfo="    豁儿赤这小子，脑子里就只有女人！"
--任务奖励
x206002_g_MoneyBonus = 10000

--固定物品奖励，最多8种
x206002_g_ItemBonus={}

--可选物品奖励，最多8种
x206002_g_RadioItemBonus={}

--MisDescEnd
x206002_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x206002_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x206002_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x206002_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x206002_g_MissionId)
		if x206002_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x206002_g_MissionName)
			AddText(sceneId,x206002_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x206002_g_MissionTarget) 
			AddText(sceneId,format("\n    探索小狼沟   %d/1", GetMissionParam(sceneId,selfId,misIndex,0) ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x206002_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x206002_g_MissionName)
		     AddText(sceneId,x206002_g_MissionComplete)
		     AddMoneyBonus(sceneId, x206002_g_MoneyBonus)
                     EndEvent()
		     DispatchMissionContinueInfo(sceneId, selfId, targetId, x206002_g_ScriptId, x206002_g_MissionId)
                end

        elseif x206002_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x206002_g_MissionName)
                AddText(sceneId,x206002_g_MissionInfo..LuaFnGetName(sceneId, selfId)..x206002_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x206002_g_MissionTarget) 
		AddMoneyBonus(sceneId, x206002_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x206002_g_ScriptId, x206002_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x206002_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x206002_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x206002_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x206002_g_ScriptId, x206002_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x206002_CheckAccept(sceneId, selfId, targetId)

	if IsHaveMission(sceneId,selfId, x206002_g_MissionId)<= 0 then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x206002_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==6) then
		if IsMissionHaveDone(sceneId, selfId, x206002_g_MissionIdPre) > 0 then
                    return 1
        	end
        end
	return 0
	
end

--**********************************

--接受

--**********************************

function x206002_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x206002_g_MissionId, x206002_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x206002_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		misIndex = GetMissionIndexByID(sceneId,selfId,x206002_g_MissionId)
		                                              
	     
end



--**********************************

--放弃

--**********************************

function x206002_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x206002_g_MissionId)

end



--**********************************

--检测是否可以提交

--**********************************

function x206002_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x206002_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == 1 then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x206002_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x206002_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x206002_g_MissionId)
		AddExp(sceneId, selfId, x206002_g_ExpBonus)
		AddMoney(sceneId, selfId, x206002_g_MoneyBonus)
		for i, item in x206002_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x206002_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x206002_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x206002_OnKillObject(sceneId, selfId, objdataId)
	
end



--**********************************

--进入区域事件

--**********************************

function x206002_OnEnterArea(sceneId, selfId, zoneId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x206002_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == 0 then
		if IsHaveMission(sceneId,selfId, x206002_g_MissionId)> 0 then
			SetMissionByIndex(sceneId,selfId,misIndex,0,1)
			BeginEvent(sceneId)
			AddText(sceneId,"    探索小狼沟   1/1") 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)
			BeginEvent(sceneId)
			AddText(sceneId,"    远远看去，有很多叛军在小狼沟集结。在人群中发现了孛鲁的踪迹，他与哈儿真呆在一起。") 
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end
	end


end

function x206002_OnTimer(sceneId, selfId )

end
function x206002_OnLeaveArea(sceneId, selfId )

end


--**********************************

--道具改变

--**********************************

function x206002_OnItemChanged(sceneId, selfId, itemdataId)

end

