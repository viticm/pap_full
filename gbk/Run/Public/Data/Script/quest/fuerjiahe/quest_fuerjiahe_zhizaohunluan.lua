--制造混乱

--MisDescBegin
x223007_g_ScriptId = 223007
--x223007_g_MissionIdPre =41
x223007_g_MissionId = 299
x223007_g_MissionKind = 20
x223007_g_MissionLevel = 100
x223007_g_ScriptIdNext = {ScriptId = 223008 ,LV = 1 }
x223007_g_Name	="拔都" 
x223007_g_DemandItem ={}
x223007_g_DemandKill ={{id=444,num=30}}

x223007_g_MissionName="制造混乱"
x223007_g_MissionInfo="    钦察人的领袖八赤蛮已经被我们困在东面的山谷中，他们的部分援军已经到达，这给我们造成了不小的压力。\n \n    我命令你去北面的钦察营地，杀死30个#R钦察士兵#W，给他们造成些混乱，配合蒙哥的包围战。"  --任务描述
x223007_g_MissionTarget="    #G拔都#W命你到北面#G钦察营地#W杀死30个#R钦察士兵#W。"		                                                                                               
x223007_g_MissionComplete="    看到你回来，我很高兴，不过很明显，我们的计划并没有成功，那些钦察士兵非常的冷静，并没有混乱的迹象。"					--完成任务npc说话的话
x223007_g_ContinueInfo="    我们要牵制住北面的钦察人，这样蒙哥才能顺利的歼灭八赤蛮。"
--任务奖励
x223007_g_MoneyBonus = 500

--固定物品奖励，最多8种
x223007_g_ItemBonus={}

--可选物品奖励，最多8种
x223007_g_RadioItemBonus={}

--MisDescEnd
x223007_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x223007_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x223007_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x223007_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x223007_g_MissionId)
		if x223007_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x223007_g_MissionName)
			AddText(sceneId,x223007_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x223007_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死钦察士兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x223007_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x223007_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x223007_g_MissionName)
		     AddText(sceneId,x223007_g_MissionComplete)
		     AddMoneyBonus(sceneId, x223007_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x223007_g_ScriptId, x223007_g_MissionId)
                end

        elseif x223007_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x223007_g_MissionName)
                AddText(sceneId,x223007_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x223007_g_MissionTarget) 
		AddMoneyBonus(sceneId, x223007_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x223007_g_ScriptId, x223007_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x223007_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x223007_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x223007_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x223007_g_ScriptId, x223007_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x223007_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x223007_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x223007_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==17) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x223007_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x223007_g_MissionId, x223007_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x223007_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x223007_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x223007_g_MissionId)
	for i, item in x223007_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x223007_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x223007_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x223007_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x223007_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x223007_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x223007_g_MissionId)
		AddExp(sceneId, selfId, x223007_g_ExpBonus)
		AddMoney(sceneId, selfId, x223007_g_MoneyBonus)
		for i, item in x223007_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x223007_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x223007_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x223007_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x223007_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x223007_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x223007_g_DemandKill[1].id then 
       		    if num < x223007_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死钦察士兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x223007_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x223007_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x223007_OnItemChanged(sceneId, selfId, itemdataId)

end

