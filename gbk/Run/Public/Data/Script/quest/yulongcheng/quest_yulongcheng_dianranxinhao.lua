--点燃信号

--MisDescBegin
x208007_g_ScriptId = 208007
--x208007_g_MissionIdPre =40
x208007_g_MissionId = 61
x208007_g_MissionKind = 12
x208007_g_MissionLevel = 60
--x208007_g_ScriptIdNext = {ScriptId = 208005 ,LV = 1 }
x208007_g_Name	="速不台" 
x208007_g_noDemandItem ={{id=13010015,num=1}}
--x208007_g_noDemandKill ={{id=301,num=1}}	

x208007_g_MissionName="点燃信号"
x208007_g_MissionInfo="，我真是为你高兴，看你最近的表现，跟几年前比，进步了很多！\n \n    我们攻下了玉龙城，但是还没拿下魔诃魔这个恶魔，还有他的儿子扎兰丁。我必须防止他们逃走，这是我们联络用的烟花，请到（117，122）处去，为我点燃它，各路将军就会把守住关口，只许进不许出，活捉魔诃魔父子！"  --任务描述
x208007_g_MissionTarget="    到高地处把#G速不台#W给你的烟花点燃"		
x208007_g_MissionComplete="    一路辛苦了！"					--完成任务npc说话的话
x208007_g_ContinueInfo="    魔诃魔父子狡猾得紧，要尽快通知各路将军。"
--任务奖励
x208007_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x208007_g_ItemBonus={}

--可选物品奖励，最多8种
x208007_g_RadioItemBonus={}

--MisDescEnd
x208007_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x208007_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	misIndex = GetMissionIndexByID(sceneId,selfId,x208007_g_MissionId)
	if x208007_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x208007_g_MissionId) > 0 then
		if x208007_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     	BeginEvent(sceneId)
                     	AddText(sceneId,"#Y"..x208007_g_MissionName)
		     	AddText(sceneId,x208007_g_MissionComplete)
		     	AddMoneyBonus(sceneId, x208007_g_MoneyBonus)
		     	EndEvent()
                     	DispatchMissionContinueInfo(sceneId, selfId, targetId, x208007_g_ScriptId, x208007_g_MissionId)
                elseif x208007_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                	BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x208007_g_MissionName)
			AddText(sceneId,x208007_g_ContinueInfo)
			AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x208007_g_MissionTarget) 
			AddText(sceneId,format("\n    点燃信号   %d/1", GetMissionParam(sceneId,selfId,misIndex,0) ))
		     	EndEvent()
			DispatchEventList(sceneId, selfId, targetId)	
                end

        elseif x208007_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x208007_g_MissionName)
                AddText(sceneId,"    <速不台上下打量了一番，把锦盒给打开，递给了你>"..GetName(sceneId, selfId)..x208007_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x208007_g_MissionTarget) 
		AddMoneyBonus(sceneId, x208007_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x208007_g_ScriptId, x208007_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x208007_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x208007_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x208007_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x208007_g_ScriptId, x208007_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x208007_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x208007_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x208007_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==8) then
        	            	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x208007_OnAccept(sceneId, selfId)

	                                                  
	BeginAddItem(sceneId)                                                    
	AddItem( sceneId,x208007_g_noDemandItem[1].id, x208007_g_noDemandItem[1].num )             
		ret = EndAddItem(sceneId,selfId)                                 
	        if ret > 0 then                                                  
	        	BeginEvent(sceneId)
			AddMission( sceneId, selfId, x208007_g_MissionId, x208007_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x208007_g_MissionName) 
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

function x208007_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x208007_g_MissionId)
	for i, item in pairs(x208007_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x208007_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x208007_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == 1 then
			    		return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x208007_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x208007_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x208007_g_MissionId)
		AddExp(sceneId, selfId, x208007_g_ExpBonus)
		AddMoney(sceneId, selfId, x208007_g_MoneyBonus)
		for i, item in pairs(x208007_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end
		--CallScriptFunction( x208007_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x208007_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x208007_OnEnterArea(sceneId, selfId, zoneId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x208007_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,1,1)
	
end

function x208007_OnLeaveArea(sceneId, selfId )

	misIndex = GetMissionIndexByID(sceneId,selfId,x208007_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,1,0)
end

function x208007_OnTimer(sceneId, selfId )

end



--**********************************

--道具改变

--**********************************

function x208007_OnItemChanged(sceneId, selfId, itemdataId)

end

