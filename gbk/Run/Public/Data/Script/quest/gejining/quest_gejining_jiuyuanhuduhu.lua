--救援忽都虎

--MisDescBegin
x215007_g_ScriptId = 215007
--x215007_g_MissionIdPre =41
x215007_g_MissionId = 138
x215007_g_MissionKind = 14
x215007_g_MissionLevel = 55
--x215007_g_ScriptIdNext = {ScriptId = 204008 ,LV = 1 }
x215007_g_Name	="哲别" 
x215007_g_DemandItem ={}
x215007_g_DemandKill ={{id=381,num=20}}

x215007_g_MissionName="救援忽都虎"
x215007_g_MissionInfo="    所有的将士听令，忽都虎将军的三万骑兵和扎兰丁大军在巴鲁安作战的时候，乌鲁临阵叛变，我们无敌于天下的铁骑被他们前后夹攻，形势非常险峻！凡是听到这一军令的将士们，立即赶往巴鲁安救援，杀死那些#R阿富汗士兵#W。"  --任务描述
x215007_g_MissionTarget="    响应#G哲别#W的号召到巴鲁安去杀死20名#R阿富汗士兵#W。"		                                                                                               
x215007_g_MissionComplete="    看到你安全回来就好。"					--完成任务npc说话的话
x215007_g_ContinueInfo="    虽然阿富汗士兵很多，但是这任务很艰巨，只有你才能完成，我等你好消息。"
--任务奖励
x215007_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x215007_g_ItemBonus={}

--可选物品奖励，最多8种
x215007_g_RadioItemBonus={}

--MisDescEnd
x215007_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x215007_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x215007_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x215007_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x215007_g_MissionId)
		if x215007_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x215007_g_MissionName)
			AddText(sceneId,x215007_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x215007_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死阿富汗士兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x215007_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x215007_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x215007_g_MissionName)
		     AddText(sceneId,x215007_g_MissionComplete)
		     AddMoneyBonus(sceneId, x215007_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x215007_g_ScriptId, x215007_g_MissionId)
                end

        elseif x215007_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x215007_g_MissionName)
                AddText(sceneId,x215007_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x215007_g_MissionTarget) 
		AddMoneyBonus(sceneId, x215007_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x215007_g_ScriptId, x215007_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x215007_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x215007_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x215007_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x215007_g_ScriptId, x215007_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x215007_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x215007_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x215007_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==15) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x215007_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x215007_g_MissionId, x215007_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x215007_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x215007_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x215007_g_MissionId)
	for i, item in x215007_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x215007_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x215007_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x215007_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x215007_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x215007_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x215007_g_MissionId)
		AddExp(sceneId, selfId, x215007_g_ExpBonus)
		AddMoney(sceneId, selfId, x215007_g_MoneyBonus)
		for i, item in x215007_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x215007_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x215007_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x215007_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x215007_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x215007_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x215007_g_DemandKill[1].id then 
       		    if num < x215007_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死阿富汗士兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x215007_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x215007_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x215007_OnItemChanged(sceneId, selfId, itemdataId)

end

