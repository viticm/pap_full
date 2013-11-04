--铲除主力

--MisDescBegin
x212000_g_ScriptId = 212000
--x212000_g_MissionIdPre =83
x212000_g_MissionId = 247
x212000_g_MissionKind = 17
x212000_g_MissionLevel = 70
x212000_g_ScriptIdNext = {ScriptId = 212001 ,LV = 1 }
x212000_g_Name	="成吉思汗"
x212000_g_Name2	="速不台" 
x212000_g_DemandItem ={}
--x212000_g_noDemandKill ={{id=301,num=1}}	

x212000_g_MissionName="铲除主力"
x212000_g_MissionInfo="    用不了多久，“西夏国”三个字就会永远从历史上消失。这是他们三次出尔反尔所付出的代价。\n \n    铲除西夏的主力军，他们没有了力量反叛，才会永远臣服于我们。\n \n    #G速不台#W将军征西夏大将军，"  --任务描述
x212000_g_MissionInfo2="，你去找找他，把我这番话一字不漏的告诉他！"
x212000_g_MissionTarget="    成吉思汗要你告诉#G速不台#W，铲除西夏的主力军，速不台就在西夏行营东。"		
x212000_g_MissionComplete="    一路上辛苦了，大汗的命令我已经得知！"					--完成任务npc说话的话
--任务奖励
x212000_g_MoneyBonus = 200
--固定物品奖励，最多8种
x212000_g_ItemBonus={}

--可选物品奖励，最多8种
x212000_g_RadioItemBonus={}

--MisDescEnd
x212000_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x212000_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x212000_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x212000_g_MissionId) > 0 then
		
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x212000_g_MissionName)
		     AddText(sceneId,x212000_g_MissionComplete)
		     AddMoneyBonus(sceneId, x212000_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x212000_g_ScriptId, x212000_g_MissionId)
                

        elseif x212000_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x212000_g_MissionName)
                AddText(sceneId,x212000_g_MissionInfo..GetName(sceneId, selfId)..x212000_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x212000_g_MissionTarget) 
		AddMoneyBonus(sceneId, x212000_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x212000_g_ScriptId, x212000_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x212000_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x212000_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x212000_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x212000_g_ScriptId, x212000_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x212000_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x212000_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x212000_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==12) then
        		if (GetName(sceneId,targetId)==x212000_g_Name) then
	        	        if IsHaveMission(sceneId,selfId, x212000_g_MissionId)<= 0 then
	        	            	return 1
	        	        end
	        	end
			if (GetName(sceneId,targetId)==x212000_g_Name2) then
				    if IsHaveMission(sceneId,selfId, x212000_g_MissionId) > 0 then
				    	return 1
	        	            end
	        	end
	end
        return 0
	
end

--**********************************

--接受

--**********************************

function x212000_OnAccept(sceneId, selfId)

	                                                  
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x212000_g_MissionId, x212000_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x212000_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
	     	                                    
	     
end



--**********************************

--放弃

--**********************************

function x212000_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x212000_g_MissionId)
	for i, item in x212000_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x212000_CheckSubmit( sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x212000_g_Name2) then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x212000_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x212000_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x212000_g_MissionId)
		AddExp(sceneId, selfId, x212000_g_ExpBonus)
		AddMoney(sceneId, selfId, x212000_g_MoneyBonus)
		for i, item in x212000_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x212000_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x212000_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x212000_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x212000_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x212000_OnItemChanged(sceneId, selfId, itemdataId)

end

