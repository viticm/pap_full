--千家奴弓箭手

--MisDescBegin
x217012_g_ScriptId = 217012
--x217012_g_MissionIdPre =41
x217012_g_MissionId = 184
x217012_g_MissionKind = 6
x217012_g_MissionLevel = 30
--x217012_g_ScriptIdNext = {ScriptId = 217001 ,LV = 1 }
x217012_g_Name	="百户长" 
x217012_g_DemandItem ={}
x217012_g_DemandKill ={{id=458,num=15}}

x217012_g_MissionName="千家奴弓箭手"
x217012_g_MissionInfo="    真是惊讶，金国守边关的将军是千家奴，这是一个非常著名的将军，我曾经化妆成金人去刺探，得到了一些天大的秘密。\n \n    千家奴是一个非常诡异的人，见过他面目的人都已经去了地狱，即使他面见他们的皇帝，也带着面罩。\n \n    更离奇的是，他带领的士兵都带有野性，我需要找一些精锐为我解决千家奴的弓箭手。\n \n    年轻的勇士，你要小心#R千家奴弓箭手#W，那些弓箭比金国精锐的专业弓手更具有震慑力，他们就在敌人的#G小粮仓#W附近！一切都靠你了。"  --任务描述
x217012_g_MissionTarget="    替#G百户长#W消灭#G小粮仓#W处的15名#R千家奴弓箭手#W。"		                                                                                               
x217012_g_MissionComplete="    谢谢你帮我们解决难题，我会弄清楚千家奴这个人。"					--完成任务npc说话的话
x217012_g_ContinueInfo="    只有像你这样的精锐战士才能解决千家奴的弓箭手。"
--任务奖励
x217012_g_MoneyBonus = 500

--固定物品奖励，最多8种
x217012_g_ItemBonus={}

--可选物品奖励，最多8种
x217012_g_RadioItemBonus={}

--MisDescEnd
x217012_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x217012_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x217012_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x217012_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x217012_g_MissionId)
		if x217012_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x217012_g_MissionName)
			AddText(sceneId,x217012_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x217012_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死千家奴弓箭手   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x217012_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x217012_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x217012_g_MissionName)
		     AddText(sceneId,x217012_g_MissionComplete)
		     AddMoneyBonus(sceneId, x217012_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x217012_g_ScriptId, x217012_g_MissionId)
                end

        elseif x217012_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x217012_g_MissionName)
                AddText(sceneId,x217012_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x217012_g_MissionTarget) 
		AddMoneyBonus(sceneId, x217012_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x217012_g_ScriptId, x217012_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x217012_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x217012_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x217012_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x217012_g_ScriptId, x217012_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x217012_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x217012_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x217012_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==20) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x217012_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x217012_g_MissionId, x217012_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x217012_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x217012_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x217012_g_MissionId)
	for i, item in pairs(x217012_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x217012_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x217012_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x217012_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x217012_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x217012_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x217012_g_MissionId)
		AddExp(sceneId, selfId, x217012_g_ExpBonus)
		AddMoney(sceneId, selfId, x217012_g_MoneyBonus)
		for i, item in pairs(x217012_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x217012_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x217012_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x217012_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x217012_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x217012_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x217012_g_DemandKill[1].id then 
       		    if num < x217012_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死千家奴弓箭手   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x217012_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x217012_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x217012_OnItemChanged(sceneId, selfId, itemdataId)

end

