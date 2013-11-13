--不负责的牧师

--MisDescBegin
x225011_g_ScriptId = 225011
--x225011_g_MissionIdPre =41
x225011_g_MissionId = 333
x225011_g_MissionKind = 22
x225011_g_MissionLevel = 110
--x225011_g_ScriptIdNext = {ScriptId = 225001 ,LV = 1 }
x225011_g_Name	="拔都" 
x225011_g_DemandItem ={}
x225011_g_DemandKill ={{id=436,num=20}}

x225011_g_MissionName="不负责的牧师"
x225011_g_MissionInfo="    不知道为什么有一批牧师离开了教堂到了贵族花园里面，他们太不负责任了。\n \n    如果他们一直坚持在教堂中，或许我会放过他们，当然这个几率很小。不过现在他们完全没有机会了。你去贵族花园，把他们都杀了。"  --任务描述
x225011_g_MissionTarget="    #G拔都#W要你杀20个#G贵族花园#W中的#R基辅牧师#W。"		                                                                                               
x225011_g_MissionComplete="    牧师就应该呆在教堂或天国中，既然他们离开了教堂，那么就让他们去天国吧。"					--完成任务npc说话的话
x225011_g_ContinueInfo="    找到那批牧师了吗？"
--任务奖励
x225011_g_MoneyBonus = 500

--固定物品奖励，最多8种
x225011_g_ItemBonus={}

--可选物品奖励，最多8种
x225011_g_RadioItemBonus={}

--MisDescEnd
x225011_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x225011_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x225011_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x225011_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x225011_g_MissionId)
		if x225011_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x225011_g_MissionName)
			AddText(sceneId,x225011_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x225011_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死基辅牧师   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x225011_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x225011_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x225011_g_MissionName)
		     AddText(sceneId,x225011_g_MissionComplete)
		     AddMoneyBonus(sceneId, x225011_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x225011_g_ScriptId, x225011_g_MissionId)
                end

        elseif x225011_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x225011_g_MissionName)
                AddText(sceneId,x225011_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x225011_g_MissionTarget) 
		AddMoneyBonus(sceneId, x225011_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x225011_g_ScriptId, x225011_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x225011_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x225011_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x225011_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x225011_g_ScriptId, x225011_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x225011_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x225011_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x225011_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==16) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x225011_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x225011_g_MissionId, x225011_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x225011_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x225011_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x225011_g_MissionId)
	for i, item in pairs(x225011_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x225011_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x225011_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x225011_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x225011_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x225011_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x225011_g_MissionId)
		AddExp(sceneId, selfId, x225011_g_ExpBonus)
		AddMoney(sceneId, selfId, x225011_g_MoneyBonus)
		for i, item in pairs(x225011_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x225011_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x225011_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x225011_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x225011_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x225011_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x225011_g_DemandKill[1].id then 
       		    if num < x225011_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死基辅牧师   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x225011_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x225011_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x225011_OnItemChanged(sceneId, selfId, itemdataId)

end

