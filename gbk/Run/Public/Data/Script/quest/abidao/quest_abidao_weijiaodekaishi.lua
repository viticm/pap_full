--围剿的开始

--MisDescBegin
x203013_g_ScriptId = 203013
--x203013_g_MissionIdPre =41
x203013_g_MissionId = 81
x203013_g_MissionKind = 13
x203013_g_MissionLevel = 50
--x203013_g_ScriptIdNext = {ScriptId = 205003 ,LV = 1 }
x203013_g_Name	="忽必来" 
x203013_g_DemandItem ={}
x203013_g_DemandKill ={{id=335,num=15}}

x203013_g_MissionName="围剿的开始"
x203013_g_MissionInfo="    所有人都听着，西征大将军哲别的军令传来，魔诃魔逃入了西面的岛屿，他是一个非常狡猾的老狐狸，有可能会化妆城贫民，渔民，普通士兵，甚至是……女人！我们遇到这些人的时候一定要看清楚，宁可错杀一千，不可放过一个。阿碧岛上的每一个花剌子模将士都是我们的仇人，让他们从阿碧岛永远消失。围剿已经开始，凡是听到号令的勇士，到西边的岛上去，杀死15名#R阿碧岛守卫#W。"  --任务描述
x203013_g_MissionTarget="    #G忽必来#W让你杀死15名#R阿碧岛守卫#W。"		                                                                                               
x203013_g_MissionComplete="    花剌子模已经彻底的完蛋了！"					--完成任务npc说话的话
x203013_g_ContinueInfo="    勇士你杀了多少守卫？"
--任务奖励
x203013_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x203013_g_ItemBonus={}

--可选物品奖励，最多8种
x203013_g_RadioItemBonus={}

--MisDescEnd
x203013_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x203013_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x203013_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x203013_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x203013_g_MissionId)
		if x203013_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x203013_g_MissionName)
			AddText(sceneId,x203013_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x203013_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死阿碧岛守卫   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x203013_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x203013_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x203013_g_MissionName)
		     AddText(sceneId,x203013_g_MissionComplete)
		     AddMoneyBonus(sceneId, x203013_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x203013_g_ScriptId, x203013_g_MissionId)
                end

        elseif x203013_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x203013_g_MissionName)
                AddText(sceneId,x203013_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x203013_g_MissionTarget) 
		AddMoneyBonus(sceneId, x203013_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x203013_g_ScriptId, x203013_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x203013_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x203013_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x203013_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x203013_g_ScriptId, x203013_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x203013_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x203013_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x203013_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==3) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x203013_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x203013_g_MissionId, x203013_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x203013_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x203013_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x203013_g_MissionId)
	for i, item in x203013_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x203013_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x203013_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x203013_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x203013_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x203013_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x203013_g_MissionId)
		AddExp(sceneId, selfId, x203013_g_ExpBonus)
		AddMoney(sceneId, selfId, x203013_g_MoneyBonus)
		for i, item in x203013_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x203013_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x203013_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x203013_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x203013_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x203013_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x203013_g_DemandKill[1].id then 
       		    if num < x203013_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死阿碧岛守卫   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x203013_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x203013_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x203013_OnItemChanged(sceneId, selfId, itemdataId)

end

