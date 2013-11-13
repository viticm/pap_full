--蒙古战旗

--MisDescBegin
x208002_g_ScriptId = 208002
--x208002_g_MissionIdPre =40
x208002_g_MissionId = 56
x208002_g_MissionKind = 12
x208002_g_MissionLevel = 60
x208002_g_ScriptIdNext = {ScriptId = 208003 ,LV = 1 }
x208002_g_Name	="成吉思汗" 
x208002_g_Name2	="术赤" 
--x208002_g_DemandItem ={{id=13010003,num=1}}
--x208002_g_noDemandKill ={{id=301,num=1}}	

x208002_g_MissionName="蒙古战旗"
x208002_g_MissionInfo="    我对他们的投降书已经没有任何兴趣，我要让他们付出惨重的代价，血洗花剌子模国。我的大儿子术赤将会代表我蒙古大军，把我们的战旗插在他们的皇城上！\n \n    速不台将军和哲别将军向我提起过你，恩，就由你和术赤一起去吧！你到#G术赤#W那里去报道。"  --任务描述
x208002_g_MissionTarget="    到#G术赤#W那里报道。"		
x208002_g_MissionComplete="    父汗派你来的吗？我正在等你。"					--完成任务npc说话的话
--x208002_g_ContinueInfo="    不管付出多大代价，也要把那件东西给拿回来。"
--任务奖励
x208002_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x208002_g_ItemBonus={}

--可选物品奖励，最多8种
x208002_g_RadioItemBonus={}

--MisDescEnd
x208002_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x208002_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x208002_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x208002_g_MissionId) > 0 then
		
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x208002_g_MissionName)
		     AddText(sceneId,x208002_g_MissionComplete)
		     AddMoneyBonus(sceneId, x208002_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x208002_g_ScriptId, x208002_g_MissionId)
                

        elseif x208002_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x208002_g_MissionName)
                AddText(sceneId,x208002_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x208002_g_MissionTarget) 
		AddMoneyBonus(sceneId, x208002_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x208002_g_ScriptId, x208002_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x208002_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x208002_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x208002_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x208002_g_ScriptId, x208002_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x208002_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x208002_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x208002_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==8) then
        	if (GetName(sceneId,targetId)==x208002_g_Name) then
        	        if IsHaveMission(sceneId,selfId, x208002_g_MissionId)<= 0 then
        	            	return 1
        	        end
        	end
		if (GetName(sceneId,targetId)==x208002_g_Name2) then
			    if IsHaveMission(sceneId,selfId, x208002_g_MissionId) > 0 then
			    	return 1
        	            end
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x208002_OnAccept(sceneId, selfId)

	                                                  
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x208002_g_MissionId, x208002_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x208002_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
	     	                                    
	     
end



--**********************************

--放弃

--**********************************

function x208002_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x208002_g_MissionId)
	for i, item in pairs(x208002_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x208002_CheckSubmit( sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x208002_g_Name2) then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x208002_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x208002_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x208002_g_MissionId)
		AddExp(sceneId, selfId, x208002_g_ExpBonus)
		AddMoney(sceneId, selfId, x208002_g_MoneyBonus)
		for i, item in pairs(x208002_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		
		CallScriptFunction( x208002_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x208002_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x208002_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x208002_OnItemChanged(sceneId, selfId, itemdataId)

end

