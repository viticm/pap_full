--装水的葫芦

--MisDescBegin
x215006_g_ScriptId = 215006
x215006_g_MissionIdPre =136
x215006_g_MissionId = 137
x215006_g_MissionKind = 14
x215006_g_MissionLevel = 55
--x215006_g_ScriptIdNext = {ScriptId = 204003 ,LV = 1 }
x215006_g_Name	="木华花小姐"
x215006_g_Name2	="老牧师" 
--x215006_g_DemandItem ={{id=13010003,num=1}}
--x215006_g_noDemandKill ={{id=301,num=1}}	

x215006_g_MissionName="装水的葫芦"
x215006_g_MissionInfo="你就是用圣水洗涤那些罪恶的人的灵魂吗，这是一件值得让人赞叹的事。\n \n    水源给人下了泻药？这是有点奇怪，就算胆子再大的人，也不敢在王子的脚下放毒，除非是王子他本人……\n \n    我说的王子，就是那个刚刚从阿碧岛回来的扎兰丁，魔诃魔国王死后，传位给了他，不过，这人太小气，做不得大事！……\n \n    时间不早了，你把这些装满水的葫芦拿去给老牧师吧。"  --任务描述
x215006_g_MissionTarget="    把装满水的葫芦拿去给#G老牧师#W吧。"		
x215006_g_MissionComplete="    你终于回来了……，老天保佑，这下毒的事情跟扎兰丁别扯上关系。"					--完成任务npc说话的话
--x215006_g_ContinueInfo="    不管付出多大代价，也要把那件东西给拿回来。"
--任务奖励
x215006_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x215006_g_ItemBonus={}

--可选物品奖励，最多8种
x215006_g_RadioItemBonus={}

--MisDescEnd
x215006_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x215006_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x215006_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x215006_g_MissionId) > 0 then
		
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x215006_g_MissionName)
		     AddText(sceneId,x215006_g_MissionComplete)
		     AddMoneyBonus(sceneId, x215006_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x215006_g_ScriptId, x215006_g_MissionId)
                

        elseif x215006_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x215006_g_MissionName)
                AddText(sceneId,x215006_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x215006_g_MissionTarget) 
		AddMoneyBonus(sceneId, x215006_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x215006_g_ScriptId, x215006_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x215006_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x215006_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x215006_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x215006_g_ScriptId, x215006_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x215006_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x215006_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x215006_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==15) then
        	if IsMissionHaveDone(sceneId,selfId, x215006_g_MissionIdPre) > 0 then
        		if (GetName(sceneId,targetId)==x215006_g_Name) then
	         	        if IsHaveMission(sceneId,selfId, x215006_g_MissionId)<= 0 then
	        	            	return 1
	        	        end
	        	end
			if (GetName(sceneId,targetId)==x215006_g_Name2) then
				    if IsHaveMission(sceneId,selfId, x215006_g_MissionId) > 0 then
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

function x215006_OnAccept(sceneId, selfId)

	                                                  
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x215006_g_MissionId, x215006_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x215006_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
	     	                                    
	     
end



--**********************************

--放弃

--**********************************

function x215006_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x215006_g_MissionId)
	for i, item in pairs(x215006_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x215006_CheckSubmit( sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x215006_g_Name2) then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x215006_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x215006_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x215006_g_MissionId)
		AddExp(sceneId, selfId, x215006_g_ExpBonus)
		AddMoney(sceneId, selfId, x215006_g_MoneyBonus)
		for i, item in pairs(x215006_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x215006_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x215006_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x215006_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x215006_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x215006_OnItemChanged(sceneId, selfId, itemdataId)

end

