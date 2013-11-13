--神箭豁阿歹

--MisDescBegin
x214009_g_ScriptId = 214009
x214009_g_MissionIdPre =115
x214009_g_MissionId = 116
x214009_g_MissionKind = 3
x214009_g_MissionLevel = 15
x214009_g_ScriptIdNext = {ScriptId = 214010 ,LV = 1 }
x214009_g_Name	="者勒蔑" 
x214009_g_DemandItem ={}
x214009_g_DemandKill ={{id=364,num=1}}

x214009_g_MissionName="神箭豁阿歹"
x214009_g_MissionInfo="    <者勒蔑一身光溜溜的，只穿了一件裤衩>"  --任务描述
x214009_g_MissionInfo2="，多亏你给我弄来了通行证。别用这样奇怪的眼光看我，现在已经没有时间跟你解释了，我还需要你帮我一个忙。\n \n    我遇上了一个非常厉害的弓箭手#R豁阿歹#W，他就在C处一带，你一定要打败他。"
x214009_g_MissionTarget="    #G者勒蔑#W让你打败C处的弓箭手#R豁阿歹#W。"		                                                                                               
x214009_g_MissionComplete="    豁阿歹是一个非常厉害的神箭手。"					--完成任务npc说话的话
x214009_g_ContinueInfo="    打败豁阿歹了吗？"
--任务奖励
x214009_g_MoneyBonus = 800
--固定物品奖励，最多8种
x214009_g_ItemBonus={}

--可选物品奖励，最多8种
x214009_g_RadioItemBonus={}

--MisDescEnd
x214009_g_ExpBonus = 6500
--**********************************

--任务入口函数

--**********************************

function x214009_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x214009_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x214009_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x214009_g_MissionId)
		if x214009_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x214009_g_MissionName)
			AddText(sceneId,x214009_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x214009_g_MissionTarget) 
			AddText(sceneId,format("\n    击败豁阿歹   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x214009_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x214009_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x214009_g_MissionName)
		     AddText(sceneId,x214009_g_MissionComplete)
		     AddMoneyBonus(sceneId, x214009_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x214009_g_ScriptId, x214009_g_MissionId)
                end

        elseif x214009_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x214009_g_MissionName)
                AddText(sceneId,x214009_g_MissionInfo..GetName(sceneId, selfId)..x214009_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x214009_g_MissionTarget) 
		AddMoneyBonus(sceneId, x214009_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x214009_g_ScriptId, x214009_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x214009_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x214009_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x214009_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x214009_g_ScriptId, x214009_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x214009_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x214009_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x214009_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==14) then
		if IsMissionHaveDone(sceneId, selfId, x214009_g_MissionIdPre) > 0 then
        	    	return 1
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x214009_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x214009_g_MissionId, x214009_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x214009_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x214009_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x214009_g_MissionId)
	for i, item in pairs(x214009_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x214009_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x214009_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x214009_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x214009_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x214009_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x214009_g_MissionId)
		AddExp(sceneId, selfId, x214009_g_ExpBonus)
		AddMoney(sceneId, selfId, x214009_g_MoneyBonus)
		for i, item in pairs(x214009_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x214009_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x214009_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x214009_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x214009_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x214009_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x214009_g_DemandKill[1].id then 
       		    if num < x214009_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("击败豁阿歹   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x214009_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x214009_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x214009_OnItemChanged(sceneId, selfId, itemdataId)

end

