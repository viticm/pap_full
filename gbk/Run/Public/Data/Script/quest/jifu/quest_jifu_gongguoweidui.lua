--公国卫队

--MisDescBegin
x225004_g_ScriptId = 225004
--x225004_g_MissionIdPre =41
x225004_g_MissionId = 326
x225004_g_MissionKind = 22
x225004_g_MissionLevel = 110
x225004_g_ScriptIdNext = {ScriptId = 225005 ,LV = 1 }
x225004_g_Name	="蒙哥" 
x225004_g_DemandItem ={}
x225004_g_DemandKill ={{id=431,num=20}}

x225004_g_MissionName="公国卫队"
x225004_g_MissionInfo="    城里还有一些没有逃出去的基辅士兵，我的责任就是清除城内敌人的残余力量。\n \n    #G贫民窟#W处有一群#R公国卫队#W还在负隅顽抗，你帮我去把他们消灭了吧。"  --任务描述
x225004_g_MissionTarget="    替#G蒙哥#W去消灭20个#G贫民窟#W处的#R公国卫队#W。"		                                                                                               
x225004_g_MissionComplete="    这些卫队勉强还有些战士精神，在城破时候还能守在贫民窟保护贫民。不过也有可能是他们被困在哪里了，哈哈。"					--完成任务npc说话的话
x225004_g_ContinueInfo="    在我大蒙古军面前，敌人已经完全丧失斗志了。现在他们只是一群拿着武器的农夫，不值得害怕。"
--任务奖励
x225004_g_MoneyBonus = 500

--固定物品奖励，最多8种
x225004_g_ItemBonus={}

--可选物品奖励，最多8种
x225004_g_RadioItemBonus={}

--MisDescEnd
x225004_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x225004_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x225004_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x225004_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x225004_g_MissionId)
		if x225004_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x225004_g_MissionName)
			AddText(sceneId,x225004_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x225004_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死公国卫队   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x225004_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x225004_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x225004_g_MissionName)
		     AddText(sceneId,x225004_g_MissionComplete)
		     AddMoneyBonus(sceneId, x225004_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x225004_g_ScriptId, x225004_g_MissionId)
                end

        elseif x225004_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x225004_g_MissionName)
                AddText(sceneId,x225004_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x225004_g_MissionTarget) 
		AddMoneyBonus(sceneId, x225004_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x225004_g_ScriptId, x225004_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x225004_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x225004_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x225004_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x225004_g_ScriptId, x225004_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x225004_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x225004_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x225004_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==16) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x225004_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x225004_g_MissionId, x225004_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x225004_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x225004_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x225004_g_MissionId)
	for i, item in x225004_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x225004_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x225004_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x225004_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x225004_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x225004_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x225004_g_MissionId)
		AddExp(sceneId, selfId, x225004_g_ExpBonus)
		AddMoney(sceneId, selfId, x225004_g_MoneyBonus)
		for i, item in x225004_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x225004_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x225004_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x225004_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x225004_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x225004_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x225004_g_DemandKill[1].id then 
       		    if num < x225004_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死公国卫队   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x225004_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x225004_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x225004_OnItemChanged(sceneId, selfId, itemdataId)

end

