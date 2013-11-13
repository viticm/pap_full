--挑战之书

--MisDescBegin
x203007_g_ScriptId = 203007
--x203007_g_MissionIdPre =56
x203007_g_MissionId = 75
x203007_g_MissionKind = 13
x203007_g_MissionLevel = 50
--x203007_g_ScriptIdNext = {ScriptId = 207007 ,LV = 1 }
x203007_g_Name	="哲别" 
x203007_g_Name2	="花剌子模使者" 
x203007_g_noDemandItem ={{id=13010021,num=1}}
x203007_g_MissionName="挑战之书"
x203007_g_MissionInfo="    你知道花剌子模第一个逃兵是谁吗？那就是他们的国王魔诃魔。我们追击他们几千里，终于把魔诃魔和他的败兵围死在这个岛上了，现在，他插翅难飞了。\n \n    围歼的号角已经响起，是我们夺取魔诃魔项上人头的时候了。"
x203007_g_MissionInfo2="，这里有大汗的一封信，你充当我们的使者，把这封信送到#G花剌子模使者#W的手上，魔诃魔会会看到的。"
x203007_g_MissionTarget="    #G哲别#W让你把信送到#G花剌子模使者#W的手上。"		
x203007_g_MissionComplete="    做的好，哈哈哈，魔诃魔那老乌龟如果看到大汗的信，不吓死也气死。"					--完成任务npc说话的话
x203007_g_ContinueInfo = "    把信送到了吗？"
x203007_g_ContinueInfo2 = "    哲别将军说什么呢？"
--任务奖励
--金钱奖励
x203007_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x203007_g_ItemBonus={}

--可选物品奖励，最多8种
x203007_g_RadioItemBonus={}

--MisDescEnd
x203007_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x203007_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	misIndex = GetMissionIndexByID(sceneId,selfId,x203007_g_MissionId)
	if x203007_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x203007_g_MissionId) > 0 then
		if x203007_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     	BeginEvent(sceneId)
                     	AddText(sceneId,"#Y"..x203007_g_MissionName)
		     	AddText(sceneId,x203007_g_MissionComplete)
		     	AddMoneyBonus(sceneId, x203007_g_MoneyBonus)
		     	EndEvent()
                     	DispatchMissionContinueInfo(sceneId, selfId, targetId, x203007_g_ScriptId, x203007_g_MissionId)
                end
                if x203007_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                	if (GetName(sceneId,targetId)==x203007_g_Name) then
                		BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x203007_g_MissionName)
				AddText(sceneId,x203007_g_ContinueInfo)
				AddText(sceneId,"#Y任务目标#W") 
				AddText(sceneId,x203007_g_MissionTarget) 
				AddText(sceneId,format("\n    把哲别的信送给花剌子模使者   %d/1", GetMissionParam(sceneId,selfId,misIndex,0) ))
		     		EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
			end
			if (GetName(sceneId,targetId)==x203007_g_Name2) then
                		BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x203007_g_MissionName)
				AddText(sceneId,x203007_g_ContinueInfo2)
				EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
				SetMissionByIndex(sceneId,selfId,misIndex,0,1)
				BeginEvent(sceneId)
				AddText(sceneId,format("把哲别的信送给花剌子模使者   %d/1", GetMissionParam(sceneId,selfId,misIndex,0) ))
		     		EndEvent()
		     		DispatchMissionTips(sceneId, selfId)
		     		DelItem(sceneId, selfId, x203007_g_noDemandItem[1].id, 1)
			end
                		
                end

        elseif x203007_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x203007_g_MissionName)
                AddText(sceneId,x203007_g_MissionInfo..GetName(sceneId, selfId)..x203007_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x203007_g_MissionTarget) 
		AddMoneyBonus(sceneId, x203007_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x203007_g_ScriptId, x203007_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x203007_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x203007_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x203007_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x203007_g_ScriptId, x203007_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x203007_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x203007_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x203007_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==3) then
        misIndex = GetMissionIndexByID(sceneId,selfId,x203007_g_MissionId)
        	if (GetName(sceneId,targetId)==x203007_g_Name) then
        	            	return 1
        	end
		if (GetName(sceneId,targetId)==x203007_g_Name2) then
			    if IsHaveMission(sceneId,selfId, x203007_g_MissionId) > 0 then
			    	if GetMissionParam(sceneId,selfId,misIndex,0) == 0 then
			    		return 1
			    	end
        	            end
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x203007_OnAccept(sceneId, selfId)

	BeginAddItem(sceneId)                                                    
	AddItem( sceneId,x203007_g_noDemandItem[1].id, x203007_g_noDemandItem[1].num )             
	ret = EndAddItem(sceneId,selfId)                                 
	if ret > 0 then                                                  
	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x203007_g_MissionId, x203007_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x203007_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		AddItemListToHuman(sceneId,selfId)
	else                                                             
		BeginEvent(sceneId)                                      
		AddText(sceneId,"物品栏已满，请整理下再来！")                    
		EndEvent(sceneId)                                        
		DispatchMissionTips(sceneId,selfId)                      
	end     
	     
end



--**********************************

--放弃

--**********************************

function x203007_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x203007_g_MissionId)
	for i, item in pairs(x203007_g_noDemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x203007_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x203007_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == 1 then
			    		return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x203007_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x203007_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x203007_g_MissionId)
		AddExp(sceneId, selfId, x203007_g_ExpBonus)
		AddMoney(sceneId, selfId, x203007_g_MoneyBonus)
		for i, item in pairs(x203007_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end
		--CallScriptFunction( x203007_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x203007_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x203007_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x203007_OnItemChanged(sceneId, selfId, itemdataId)

end

