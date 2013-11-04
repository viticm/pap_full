--圣水

--MisDescBegin
x215004_g_ScriptId = 215004
--x215004_g_MissionIdPre =40
x215004_g_MissionId = 135
x215004_g_MissionKind = 14
x215004_g_MissionLevel = 55
x215004_g_ScriptIdNext = {ScriptId = 215005 ,LV = 1 }
x215004_g_Name	="老牧师" 
x215004_g_noDemandItem ={{id=13010027,num=1}}
--x215004_g_noDemandKill ={{id=301,num=1}}	

x215004_g_MissionName="圣水"
x215004_g_MissionInfo="        我闻到了一股血腥的味道，真主啊，何时才能让这个疯狂的世界安静下来！\n \n    哥疾宁目前已被前来投靠扎兰丁的军队占据，城里的百姓成了他们的发泄对象，那些女人们……！\n \n    唉！主啊，请原谅他们的罪过吧！\n \n    这些人的既不是保护城市的安全，也不是为了振兴花剌子模帝国，而是害怕蒙军的屠杀，前来寻找庇佑的。\n \n    我向真主求来了这瓶圣水，它可以帮他们克制住自己的欲念，你将它撒在城市中心吧，让仁爱散播在任何一个角落。"  --任务描述
x215004_g_MissionTarget="    圣水可以却出邪念，#G老牧师#W要你把圣水洒在城市的中间。"		
x215004_g_MissionComplete="    神爱世人！"					--完成任务npc说话的话
x215004_g_ContinueInfo="    圣洁的圣水，一定会让他们苏醒的！"
--任务奖励
x215004_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x215004_g_ItemBonus={}

--可选物品奖励，最多8种
x215004_g_RadioItemBonus={}

--MisDescEnd
x215004_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x215004_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	misIndex = GetMissionIndexByID(sceneId,selfId,x215004_g_MissionId)
	if x215004_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x215004_g_MissionId) > 0 then
		if x215004_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     	BeginEvent(sceneId)
                     	AddText(sceneId,"#Y"..x215004_g_MissionName)
		     	AddText(sceneId,x215004_g_MissionComplete)
		     	EndEvent()
                     	DispatchMissionContinueInfo(sceneId, selfId, targetId, x215004_g_ScriptId, x215004_g_MissionId)
                elseif x215004_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                	BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x215004_g_MissionName)
			AddText(sceneId,x215004_g_ContinueInfo)
			AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x215004_g_MissionTarget) 
			AddText(sceneId,format("    播撒圣水   %d/1", GetMissionParam(sceneId,selfId,misIndex,0) ))
		     	EndEvent()
			DispatchEventList(sceneId, selfId, targetId)	
                end

        elseif x215004_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,x215004_g_MissionName)
                AddText(sceneId,x215004_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x215004_g_MissionTarget) 
		AddMoneyBonus(sceneId, x215004_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x215004_g_ScriptId, x215004_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x215004_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x215004_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x215004_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x215004_g_ScriptId, x215004_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x215004_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x215004_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x215004_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==15) then
        	            	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x215004_OnAccept(sceneId, selfId)

	                                                  
	BeginAddItem(sceneId)                                                    
	AddItem( sceneId,x215004_g_noDemandItem[1].id, x215004_g_noDemandItem[1].num )             
		ret = EndAddItem(sceneId,selfId)                                 
	        if ret > 0 then                                                  
	        	BeginEvent(sceneId)
			AddMission( sceneId, selfId, x215004_g_MissionId, x215004_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x215004_g_MissionName) 
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

function x215004_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x215004_g_MissionId)
	for i, item in x215004_g_noDemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x215004_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x215004_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == 1 then
			    		return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x215004_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x215004_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x215004_g_MissionId)
		AddExp(sceneId, selfId, x215004_g_ExpBonus)
		AddMoney(sceneId, selfId, x215004_g_MoneyBonus)
		for i, item in x215004_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end
		CallScriptFunction( x215004_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x215004_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x215004_OnEnterArea(sceneId, selfId, zoneId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x215004_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,1,1)
	
end

function x215004_OnLeaveArea(sceneId, selfId )
	misIndex = GetMissionIndexByID(sceneId,selfId,x215004_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,1,0)
end

function x215004_OnTimer(sceneId, selfId )

end



--**********************************

--道具改变

--**********************************

function x215004_OnItemChanged(sceneId, selfId, itemdataId)

end

