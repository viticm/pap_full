--兵变

--MisDescBegin
x204011_g_ScriptId = 204011
--x204011_g_MissionIdPre =41
x204011_g_MissionId = 106
x204011_g_MissionKind = 9
x204011_g_MissionLevel = 45
x204011_g_IsMissionOkFail = 2
x204011_g_IfMissionElite = 0
--x204011_g_ScriptIdNext = {ScriptId = 204001 ,LV = 1 }
x204011_g_Name	="速不台" 
x204011_g_DemandItem ={}
x204011_g_DemandKill ={{id=355,num=15}}

x204011_g_MissionName="兵变"
x204011_g_MissionInfo="    战场的变化风云莫测，刚刚就传来了消息，屈出律的军队打算偷袭我们的驻地。\n \n    部分先遣队已经偷偷到彩虹桥附近了，"  --任务描述
x204011_g_MissionInfo2="，你是我们的前骑锋，你的任务就是萧清彩虹桥上的#R西辽精兵#W。"
x204011_g_MissionTarget="    #G速不台#W要你萧清15名彩虹桥上的#R西辽精兵#W。"		                                                                                               
x204011_g_MissionComplete="    做的很好。"					--完成任务npc说话的话
x204011_g_ContinueInfo="    消灭先遣队了吗？"
--任务奖励
x204011_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x204011_g_ItemBonus={}

--可选物品奖励，最多8种
x204011_g_RadioItemBonus={}

--MisDescEnd
x204011_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x204011_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x204011_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x204011_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x204011_g_MissionId)
		if x204011_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x204011_g_MissionName)
			AddText(sceneId,x204011_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x204011_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死西辽精兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x204011_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x204011_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x204011_g_MissionName)
		     AddText(sceneId,x204011_g_MissionComplete)
		     AddMoneyBonus(sceneId, x204011_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x204011_g_ScriptId, x204011_g_MissionId)
                end

        elseif x204011_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x204011_g_MissionName)
                AddText(sceneId,x204011_g_MissionInfo..GetName(sceneId, selfId)..x204011_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x204011_g_MissionTarget) 
		AddMoneyBonus(sceneId, x204011_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x204011_g_ScriptId, x204011_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x204011_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x204011_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x204011_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x204011_g_ScriptId, x204011_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x204011_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x204011_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x204011_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==4) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x204011_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x204011_g_MissionId, x204011_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x204011_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x204011_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x204011_g_MissionId)
	for i, item in x204011_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x204011_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x204011_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x204011_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x204011_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x204011_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x204011_g_MissionId)
		AddExp(sceneId, selfId, x204011_g_ExpBonus)
		AddMoney(sceneId, selfId, x204011_g_MoneyBonus)
		for i, item in x204011_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x204011_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x204011_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x204011_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x204011_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x204011_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x204011_g_DemandKill[1].id then 
       		    if num < x204011_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死西辽精兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x204011_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x204011_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x204011_OnItemChanged(sceneId, selfId, itemdataId)

end

