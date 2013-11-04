--警告

--MisDescBegin
x223009_g_ScriptId = 223009
--x223009_g_MissionIdPre =41
x223009_g_MissionId = 301
x223009_g_MissionKind = 20
x223009_g_MissionLevel = 100
x223009_g_ScriptIdNext = {ScriptId = 223010 ,LV = 1 }
x223009_g_Name	="速不台" 
x223009_g_DemandItem ={}
x223009_g_DemandKill ={{id=446,num=20}}

x223009_g_MissionName="警告"
x223009_g_MissionInfo="    长生天赐给了我们生命和力量，我们接受了大汗的传承，征服世界就是我们的使命！\n \n    来势汹汹的酋长库丹带着他那些窝囊的士兵，架着破烂的投石机，试图想进攻我们，他们那些乌合之众，只是想吓唬我们，因为我感觉不到他们的一丝战意。\n \n    "  --任务描述
x223009_g_MissionInfo2="，为我消灭左侧的20个钦察投石机士兵，我要给他们一些警告。"
x223009_g_MissionTarget="    消灭20个左侧的#R钦察投石机士兵#W，回来向#G速不台#W复命。"		                                                                                               
x223009_g_MissionComplete="    什么？他们居然还敢迎战？库丹居然有这种勇气！虽然我们的勇士可以轻易的扯碎这些胆大的敌人，但是暂时还抽不出人手来做这件事。等我们腾出手来，库丹就会边尖叫着边后悔今天的决定！"					--完成任务npc说话的话
x223009_g_ContinueInfo="    他们不是战士，他们是带着武器的婊子，如此而已！"
--任务奖励
x223009_g_MoneyBonus = 500

--固定物品奖励，最多8种
x223009_g_ItemBonus={}

--可选物品奖励，最多8种
x223009_g_RadioItemBonus={}

--MisDescEnd
x223009_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x223009_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x223009_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x223009_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x223009_g_MissionId)
		if x223009_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x223009_g_MissionName)
			AddText(sceneId,x223009_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x223009_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死钦察投石机士兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x223009_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x223009_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x223009_g_MissionName)
		     AddText(sceneId,x223009_g_MissionComplete)
		     AddMoneyBonus(sceneId, x223009_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x223009_g_ScriptId, x223009_g_MissionId)
                end

        elseif x223009_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x223009_g_MissionName)
                AddText(sceneId,x223009_g_MissionInfo..GetName(sceneId, selfId)..x223009_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x223009_g_MissionTarget) 
		AddMoneyBonus(sceneId, x223009_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x223009_g_ScriptId, x223009_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x223009_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x223009_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x223009_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x223009_g_ScriptId, x223009_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x223009_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x223009_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x223009_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==17) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x223009_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x223009_g_MissionId, x223009_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x223009_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x223009_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x223009_g_MissionId)
	for i, item in x223009_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x223009_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x223009_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x223009_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x223009_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x223009_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x223009_g_MissionId)
		AddExp(sceneId, selfId, x223009_g_ExpBonus)
		AddMoney(sceneId, selfId, x223009_g_MoneyBonus)
		for i, item in x223009_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x223009_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x223009_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x223009_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x223009_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x223009_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x223009_g_DemandKill[1].id then 
       		    if num < x223009_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死钦察投石机士兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x223009_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x223009_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x223009_OnItemChanged(sceneId, selfId, itemdataId)

end

