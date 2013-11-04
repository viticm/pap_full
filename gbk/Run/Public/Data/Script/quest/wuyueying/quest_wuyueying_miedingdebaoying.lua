--灭丁的报应

--MisDescBegin
x217005_g_ScriptId = 217005
x217005_g_MissionIdPre =176
x217005_g_MissionId = 177
x217005_g_MissionKind = 6
x217005_g_MissionLevel = 30
x217005_g_ScriptIdNext = {ScriptId = 217006 ,LV = 1 }
x217005_g_Name	="哈撒儿" 
x217005_g_DemandItem ={}
x217005_g_DemandKill ={{id=453,num=10}}

x217005_g_MissionName="灭丁的报应"
x217005_g_MissionInfo="    曾经对我们的灭丁政策，让我们大草原的男儿每三年被屠杀一次，这种惨无人道的行径，早就应该受到惩罚！\n \n    <他愤怒的吼着，赤红的双眼变得异常的疯狂>死亡是这些金兵最好的归宿，他们不应该埋怨任何人，因为他们没有资格……\n \n    "  --任务描述
x217005_g_MissionInfo2="，看到我们前方的那些猥琐的#R金兵队长#W了吗？就是他们杀我们子民，抢我们女人的时候，他们那张驴脸，我永远也不会忘记，杀了他们，一个也别让他们跑了！"
x217005_g_MissionTarget="    消灭#G中隅#W一带的10名#R金兵队长#W回来向#G哈撒儿#W复命。"		                                                                                               
x217005_g_MissionComplete="    大快人心，真是大快人心啊！"					--完成任务npc说话的话
x217005_g_ContinueInfo="    不要放过那些金兵队长，杀了他们，再来找我。"
--任务奖励
x217005_g_MoneyBonus = 500

--固定物品奖励，最多8种
x217005_g_ItemBonus={}

--可选物品奖励，最多8种
x217005_g_RadioItemBonus={}

--MisDescEnd
x217005_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x217005_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x217005_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x217005_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x217005_g_MissionId)
		if x217005_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x217005_g_MissionName)
			AddText(sceneId,x217005_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x217005_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死金兵队长   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x217005_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x217005_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x217005_g_MissionName)
		     AddText(sceneId,x217005_g_MissionComplete)
		     AddMoneyBonus(sceneId, x217005_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x217005_g_ScriptId, x217005_g_MissionId)
                end

        elseif x217005_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x217005_g_MissionName)
                AddText(sceneId,x217005_g_MissionInfo..GetName(sceneId, selfId)..x217005_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x217005_g_MissionTarget) 
		AddMoneyBonus(sceneId, x217005_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x217005_g_ScriptId, x217005_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x217005_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x217005_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x217005_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x217005_g_ScriptId, x217005_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x217005_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x217005_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x217005_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==20) then
		if IsMissionHaveDone(sceneId, selfId, x217005_g_MissionIdPre) > 0 then
        	    	return 1
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x217005_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x217005_g_MissionId, x217005_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x217005_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x217005_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x217005_g_MissionId)
	for i, item in x217005_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x217005_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x217005_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x217005_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x217005_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x217005_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x217005_g_MissionId)
		AddExp(sceneId, selfId, x217005_g_ExpBonus)
		AddMoney(sceneId, selfId, x217005_g_MoneyBonus)
		for i, item in x217005_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x217005_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x217005_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x217005_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x217005_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x217005_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x217005_g_DemandKill[1].id then 
       		    if num < x217005_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死金兵队长   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x217005_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x217005_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x217005_OnItemChanged(sceneId, selfId, itemdataId)

end

