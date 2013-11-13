--艰巨的任务

--MisDescBegin
x226010_g_ScriptId = 226010
x226010_g_MissionIdPre =337
x226010_g_MissionId = 346
x226010_g_MissionKind = 23
x226010_g_MissionLevel = 115
x226010_g_ScriptIdNext = {ScriptId = 226002 ,LV = 1 }
x226010_g_Name	="重骑兵指挥官" 
x226010_g_DemandItem ={}
x226010_g_DemandKill ={{id=485,num=30}}

x226010_g_MissionName="艰巨的任务"
x226010_g_MissionInfo="    在这次战斗中，我们重骑兵的任务是最艰巨的。亨利为了突围一定会全力向我冲击。好在我蒙古重骑兵训练有素，完全可以抵挡住敌人的冲击。\n \n    勇士没有时间跟你细说了，战士们的压力很大，去杀些#R波兰重骑兵#W吧，缓解一下我们的压力。"  --任务描述
x226010_g_MissionTarget="    杀死30个#R波兰重骑兵#W缓解#G重骑兵指挥官#W的压力。"		                                                                                               
x226010_g_MissionComplete="    谢谢你勇士，确实减少了很多压力。"					--完成任务npc说话的话
x226010_g_ContinueInfo="    虽然能顶住，但是压力还是很大的，希望海都那边能快些歼灭亨利。"
--任务奖励
x226010_g_MoneyBonus = 500

--固定物品奖励，最多8种
x226010_g_ItemBonus={}

--可选物品奖励，最多8种
x226010_g_RadioItemBonus={}

--MisDescEnd
x226010_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x226010_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x226010_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x226010_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x226010_g_MissionId)
		if x226010_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x226010_g_MissionName)
			AddText(sceneId,x226010_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x226010_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死波兰重骑兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x226010_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x226010_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x226010_g_MissionName)
		     AddText(sceneId,x226010_g_MissionComplete)
		     AddMoneyBonus(sceneId, x226010_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x226010_g_ScriptId, x226010_g_MissionId)
                end

        elseif x226010_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x226010_g_MissionName)
                AddText(sceneId,x226010_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x226010_g_MissionTarget) 
		AddMoneyBonus(sceneId, x226010_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x226010_g_ScriptId, x226010_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x226010_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x226010_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x226010_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x226010_g_ScriptId, x226010_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x226010_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x226010_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x226010_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==22) then
		--if IsMissionHaveDone(sceneId, selfId, x226010_g_MissionIdPre) > 0 then
        	    	return 1
       -- end
  end
        return 0
	
end

--**********************************

--接受

--**********************************

function x226010_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x226010_g_MissionId, x226010_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x226010_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x226010_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x226010_g_MissionId)
	for i, item in pairs(x226010_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x226010_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x226010_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x226010_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x226010_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x226010_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x226010_g_MissionId)
		AddExp(sceneId, selfId, x226010_g_ExpBonus)
		AddMoney(sceneId, selfId, x226010_g_MoneyBonus)
		--CallScriptFunction( x226010_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x226010_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x226010_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x226010_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x226010_g_DemandKill[1].id then 
       		    if num < x226010_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死波兰重骑兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x226010_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x226010_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x226010_OnItemChanged(sceneId, selfId, itemdataId)

end

