--残兵

--MisDescBegin
x203000_g_ScriptId = 203000
--x203000_g_MissionIdPre =41
x203000_g_MissionId = 68
x203000_g_MissionKind = 13
x203000_g_MissionLevel = 50
--x203000_g_ScriptIdNext = {ScriptId = 205003 ,LV = 1 }
x203000_g_Name	="马剌" 
x203000_g_DemandItem ={}
x203000_g_DemandKill ={{id=322,num=10}}

x203000_g_MissionName="残兵"
x203000_g_MissionInfo="    那些被我们打败的#R契丹武士#W，正组织着他们的残兵想突袭我们的营地，他们就聚集在东北方，"  --任务描述
x203000_g_MissionInfo2="，这件事就交给你了，一定要小心。"
x203000_g_MissionTarget="    杀死10名#R契丹武士#W，回来向#G马剌#W复命。"		                                                                                               
x203000_g_MissionComplete="    做得很好！"					--完成任务npc说话的话
x203000_g_ContinueInfo="    杀死契丹武士了吗？"
--任务奖励
x203000_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x203000_g_ItemBonus={}

--可选物品奖励，最多8种
x203000_g_RadioItemBonus={}

--MisDescEnd
x203000_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x203000_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x203000_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x203000_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x203000_g_MissionId)
		if x203000_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x203000_g_MissionName)
			AddText(sceneId,x203000_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x203000_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死契丹武士   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x203000_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x203000_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x203000_g_MissionName)
		     AddText(sceneId,x203000_g_MissionComplete)
		     AddMoneyBonus(sceneId, x203000_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x203000_g_ScriptId, x203000_g_MissionId)
                end

        elseif x203000_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x203000_g_MissionName)
                AddText(sceneId,x203000_g_MissionInfo..GetName(sceneId, selfId)..x203000_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x203000_g_MissionTarget) 
		AddMoneyBonus(sceneId, x203000_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x203000_g_ScriptId, x203000_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x203000_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x203000_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x203000_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x203000_g_ScriptId, x203000_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x203000_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x203000_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x203000_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==3) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x203000_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x203000_g_MissionId, x203000_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x203000_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x203000_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x203000_g_MissionId)
	for i, item in x203000_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x203000_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x203000_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x203000_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x203000_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x203000_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x203000_g_MissionId)
		AddExp(sceneId, selfId, x203000_g_ExpBonus)
		AddMoney(sceneId, selfId, x203000_g_MoneyBonus)
		for i, item in x203000_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x203000_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x203000_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x203000_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x203000_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x203000_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x203000_g_DemandKill[1].id then 
       		    if num < x203000_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死契丹武士   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x203000_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x203000_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x203000_OnItemChanged(sceneId, selfId, itemdataId)

end

