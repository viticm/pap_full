--以牙还牙

--MisDescBegin
x202000_g_ScriptId = 202000
--x202000_g_MissionIdPre =41
x202000_g_MissionId = 119
x202000_g_MissionKind = 4
x202000_g_MissionLevel = 20
x202000_g_ScriptIdNext = {ScriptId = 202001 ,LV = 1 }
x202000_g_Name	="铁木真" 
x202000_g_DemandItem ={}
x202000_g_DemandKill ={{id=367,num=20}}

x202000_g_MissionName="以牙还牙"
x202000_g_MissionInfo="    乃蛮部集中了人向克烈部进攻，王汗请我出兵相助，但是他们军队却偷偷的走了，想借乃蛮部的手来对付我们。\n \n    我们不能与乃蛮部打下去，他们走，我们也走！"  --任务描述
x202000_g_MissionInfo2="，在真沙陀一带，藏着克烈部的一支兵马，他们在等着看我们和乃蛮部的厮杀呢，这样便宜的事情还轮不到他们，你去把他们杀了。"
x202000_g_MissionTarget="    #G铁木真#W命你杀死在真沙陀的那20名#R克烈士兵#W。"		                                                                                               
x202000_g_MissionComplete="    做得好，你是草原最可爱的勇士。"					--完成任务npc说话的话
x202000_g_ContinueInfo="    西面的那些士兵解决了吗？"
--任务奖励
x202000_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x202000_g_ItemBonus={}

--可选物品奖励，最多8种
x202000_g_RadioItemBonus={}

--MisDescEnd
x202000_g_ExpBonus = 6500
--**********************************

--任务入口函数

--**********************************

function x202000_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x202000_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x202000_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x202000_g_MissionId)
		if x202000_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x202000_g_MissionName)
			AddText(sceneId,x202000_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x202000_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死克烈士兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x202000_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x202000_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x202000_g_MissionName)
		     AddText(sceneId,x202000_g_MissionComplete)
		     AddMoneyBonus(sceneId, x202000_g_MoneyBonus)
                     EndEvent()
		     DispatchMissionContinueInfo(sceneId, selfId, targetId, x202000_g_ScriptId, x202000_g_MissionId)
                end

        elseif x202000_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x202000_g_MissionName)
                AddText(sceneId,x202000_g_MissionInfo..GetName(sceneId, selfId)..x202000_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x202000_g_MissionTarget) 
		AddMoneyBonus(sceneId, x202000_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x202000_g_ScriptId, x202000_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x202000_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x202000_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x202000_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x202000_g_ScriptId, x202000_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x202000_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x202000_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x202000_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==2) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x202000_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x202000_g_MissionId, x202000_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x202000_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x202000_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x202000_g_MissionId)
	for i, item in x202000_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x202000_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x202000_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x202000_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x202000_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x202000_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x202000_g_MissionId)
		AddExp(sceneId, selfId, x202000_g_ExpBonus)
		AddMoney(sceneId, selfId, x202000_g_MoneyBonus)
		for i, item in x202000_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x202000_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x202000_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x202000_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x202000_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x202000_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x202000_g_DemandKill[1].id then 
       		    if num < x202000_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死克烈士兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x202000_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x202000_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x202000_OnItemChanged(sceneId, selfId, itemdataId)

end

