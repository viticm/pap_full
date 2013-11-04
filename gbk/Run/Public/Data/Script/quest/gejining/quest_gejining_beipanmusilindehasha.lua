--背叛穆斯林的哈沙

--MisDescBegin
x215000_g_ScriptId = 215000
--x215000_g_MissionIdPre =41
x215000_g_MissionId = 131
x215000_g_MissionKind = 14
x215000_g_MissionLevel = 55
x215000_g_ScriptIdNext = {ScriptId = 215001 ,LV = 1 }
x215000_g_Name	="扎兰丁" 
x215000_g_DemandItem ={}
x215000_g_DemandKill ={{id=378,num=1}}

x215000_g_MissionName="背叛穆斯林的哈沙"
x215000_g_MissionInfo="    欢迎你到哥疾宁，我是哥疾宁的城主扎兰丁！\n \n    这是一个繁荣的小城镇，但是却被一伙军队蹂躏。他们的首领 哈沙 背叛了穆斯林，在城里为非作歹！哈沙必须为数起抢劫，杀人的行径付出代价！"  --任务描述
x215000_g_MissionInfo2="你能帮我解决了他吗？"
x215000_g_MissionTarget="    #G扎兰丁#W把罪恶的#R哈沙#W给杀了。"		                                                                                               
x215000_g_MissionComplete="    哈沙死了！太高兴了，整个哥疾宁都为这件事而兴奋呢。"					--完成任务npc说话的话
x215000_g_ContinueInfo="    吩咐你的事，你办完了吗？"
--任务奖励
x215000_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x215000_g_ItemBonus={}

--可选物品奖励，最多8种
x215000_g_RadioItemBonus={}

--MisDescEnd
x215000_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x215000_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x215000_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x215000_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x215000_g_MissionId)
		if x215000_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x215000_g_MissionName)
			AddText(sceneId,x215000_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x215000_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死哈沙   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x215000_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x215000_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x215000_g_MissionName)
		     AddText(sceneId,x215000_g_MissionComplete)
		     AddMoneyBonus(sceneId, x215000_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x215000_g_ScriptId, x215000_g_MissionId)
                end

        elseif x215000_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x215000_g_MissionName)
                AddText(sceneId,x215000_g_MissionInfo..GetName(sceneId, selfId)..x215000_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x215000_g_MissionTarget) 
		AddMoneyBonus(sceneId, x215000_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x215000_g_ScriptId, x215000_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x215000_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x215000_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x215000_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x215000_g_ScriptId, x215000_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x215000_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x215000_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x215000_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==15) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x215000_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x215000_g_MissionId, x215000_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x215000_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x215000_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x215000_g_MissionId)
	for i, item in x215000_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x215000_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x215000_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x215000_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x215000_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x215000_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x215000_g_MissionId)
		AddExp(sceneId, selfId, x215000_g_ExpBonus)
		AddMoney(sceneId, selfId, x215000_g_MoneyBonus)
		for i, item in x215000_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x215000_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x215000_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x215000_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x215000_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x215000_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x215000_g_DemandKill[1].id then 
       		    if num < x215000_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死哈沙   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x215000_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x215000_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x215000_OnItemChanged(sceneId, selfId, itemdataId)

end

