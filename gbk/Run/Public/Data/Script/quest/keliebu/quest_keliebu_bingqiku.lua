--兵器库

--MisDescBegin
x202007_g_ScriptId = 202007
x202007_g_MissionIdPre =125
x202007_g_MissionId = 126
x202007_g_MissionKind = 4
x202007_g_MissionLevel = 20
--x202007_g_ScriptIdNext = {ScriptId = 202006 ,LV = 1 }
x202007_g_Name	="木华黎"
x202007_g_DemandItem ={}
x202007_g_DemandKill ={{id=372,num=10}}

x202007_g_MissionName="兵器库"
x202007_g_MissionInfo="    这是一个好机会，我们一定要看准时机。"  --任务描述
x202007_g_MissionInfo2="，我有一个计划，就是趁着他们喝酒的时候，先把他们兵器库里的武器给偷走。\n \n    我研究过他们的营帐，他们的兵器库在东军驻地处，这不是一件很容易的事情，我们要偷偷的进行。\n \n    要打他们武器的主意，就要先解决那些巡逻的士兵，这种事，我需要像你这样的勇士去进行。替我们解决门口的那10名#R克烈斥候#W。"
x202007_g_MissionTarget="    受#G木华黎#W之命解决东军驻地的10名#R克烈斥候#W。"		                                                                                               
x202007_g_MissionComplete="    做的太好了。"					--完成任务npc说话的话
x202007_g_ContinueInfo="    你解决那些斥候了吗？"
--任务奖励
x202007_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x202007_g_ItemBonus={}

--可选物品奖励，最多8种
x202007_g_RadioItemBonus={}

--MisDescEnd
x202007_g_ExpBonus = 6500
--**********************************

--任务入口函数

--**********************************

function x202007_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x202007_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x202007_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x202007_g_MissionId)
		if x202007_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x202007_g_MissionName)
			AddText(sceneId,x202007_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x202007_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死克烈斥候   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x202007_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x202007_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x202007_g_MissionName)
		     AddText(sceneId,x202007_g_MissionComplete)
		     AddMoneyBonus(sceneId, x202007_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x202007_g_ScriptId, x202007_g_MissionId)
                end

        elseif x202007_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x202007_g_MissionName)
                AddText(sceneId,x202007_g_MissionInfo..GetName(sceneId, selfId)..x202007_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x202007_g_MissionTarget) 
		AddMoneyBonus(sceneId, x202007_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x202007_g_ScriptId, x202007_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x202007_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x202007_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x202007_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x202007_g_ScriptId, x202007_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x202007_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x202007_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x202007_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==2) then
		if IsMissionHaveDone(sceneId, selfId, x202007_g_MissionIdPre) > 0 then
					return 1
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x202007_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x202007_g_MissionId, x202007_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x202007_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x202007_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x202007_g_MissionId)
	for i, item in x202007_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x202007_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x202007_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x202007_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x202007_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x202007_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x202007_g_MissionId)
		AddExp(sceneId, selfId, x202007_g_ExpBonus)
		AddMoney(sceneId, selfId, x202007_g_MoneyBonus)
		for i, item in x202007_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x202007_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x202007_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x202007_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x202007_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x202007_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x202007_g_DemandKill[1].id then 
       		    if num < x202007_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死克烈斥候   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x202007_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x202007_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x202007_OnItemChanged(sceneId, selfId, itemdataId)

end

