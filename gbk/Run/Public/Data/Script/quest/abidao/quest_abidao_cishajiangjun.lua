--刺杀将军

--MisDescBegin
x203011_g_ScriptId = 203011
--x203011_g_MissionIdPre =72
x203011_g_MissionId = 79
x203011_g_MissionKind = 13
x203011_g_MissionLevel = 50
--x203011_g_ScriptIdNext = {ScriptId = 208009 ,LV = 1 }
x203011_g_Name	="速不台" 
x203011_g_DemandItem ={}
x203011_g_DemandKill ={{id=333,num=1}}

x203011_g_MissionName="刺杀将军"
x203011_g_MissionInfo="     花剌子模一个叫#R多盖#W的将军，离开了魔诃魔的营地，鬼鬼祟祟的在岛的西面处出现。这个人我也略有所闻，这人有勇有谋，他们溃败之后逃跑的路线，能成功的躲避我们的追击，躲在这个岛上，就是多盖的主意。\n \n    他是魔诃魔国王左右臂，我们一定要杀了他，断了魔诃魔的臂膀。 "  --任务描述
x203011_g_MissionTarget="    #G速不台#W命令你杀了魔诃魔的得力将军#R多盖#W。"		                                                                                               
x203011_g_MissionComplete="    杀了多盖后，我们的事情就简单多了。"					--完成任务npc说话的话
x203011_g_ContinueInfo="    多盖可是魔诃魔的得力将军，你要小心。"
--任务奖励
x203011_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x203011_g_ItemBonus={}

--可选物品奖励，最多8种
x203011_g_RadioItemBonus={}

--MisDescEnd
x203011_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x203011_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x203011_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x203011_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x203011_g_MissionId)
		if x203011_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x203011_g_MissionName)
			AddText(sceneId,x203011_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x203011_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死多盖   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x203011_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x203011_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x203011_g_MissionName)
		     AddText(sceneId,x203011_g_MissionComplete)
		     AddMoneyBonus(sceneId, x203011_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x203011_g_ScriptId, x203011_g_MissionId)
                end

        elseif x203011_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x203011_g_MissionName)
                AddText(sceneId,x203011_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x203011_g_MissionTarget) 
		AddMoneyBonus(sceneId, x203011_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x203011_g_ScriptId, x203011_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x203011_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x203011_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x203011_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x203011_g_ScriptId, x203011_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x203011_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x203011_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x203011_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==3) then
		--if IsMissionHaveDone(sceneId, selfId, x203011_g_MissionIdPre) > 0 then
		    	return 1
		--end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x203011_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x203011_g_MissionId, x203011_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x203011_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x203011_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x203011_g_MissionId)
	for i, item in pairs(x203011_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x203011_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x203011_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x203011_g_DemandKill[1].num then
			return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x203011_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x203011_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x203011_g_MissionId)
		AddExp(sceneId, selfId, x203011_g_ExpBonus)
		AddMoney(sceneId, selfId, x203011_g_MoneyBonus)
		for i, item in pairs(x203011_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x203011_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x203011_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x203011_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x203011_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x203011_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x203011_g_DemandKill[1].id then 
       		    if num < x203011_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死多盖   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x203011_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
        
      end  

end



--**********************************

--进入区域事件

--**********************************

function x203011_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x203011_OnItemChanged(sceneId, selfId, itemdataId)

end

