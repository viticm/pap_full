--师爷的话

--MisDescBegin
x205013_g_ScriptId = 205013
--x205013_g_MissionIdPre =40
x205013_g_MissionId = 53
x205013_g_MissionKind = 11
x205013_g_MissionLevel = 55
--x205013_g_ScriptIdNext = {ScriptId = 205002 ,LV = 1 }
x205013_g_Name	="花剌子模师爷" 
x205013_g_Name2	="速不台" 
--x205013_g_DemandItem ={{id=13010003,num=1}}
--x205013_g_noDemandKill ={{id=301,num=1}}	

x205013_g_MissionName="师爷的话"
x205013_g_MissionInfo="    我们扎兰丁王子，是摩诃魔国王最疼爱的王子，他是我们花剌子模帝国的继承者！在花剌子模帝国之上，一切的女人和财宝，都属于扎兰丁王子的，包括你们口袋里面的东西。请把我的话带去给你们的领头，把你们的女人和财宝留下，归顺于我们的国王——，哦不是，归顺于我们的王子，信奉真主！不然……，嘿嘿！"  --任务描述
x205013_g_MissionTarget="    把师爷的话带给#G速不台#W将军。"		
x205013_g_MissionComplete="    狼子野心！他们只是在窥视我们带来的这些财宝！贪婪的花剌子模人，一定会尝到我们铁骑的手段。"					--完成任务npc说话的话
--x205013_g_ContinueInfo="    不管付出多大代价，也要把那件东西给拿回来。"
--任务奖励
x205013_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x205013_g_ItemBonus={}

--可选物品奖励，最多8种
x205013_g_RadioItemBonus={}

--MisDescEnd
x205013_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x205013_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x205013_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x205013_g_MissionId) > 0 then
		
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x205013_g_MissionName)
		     AddText(sceneId,x205013_g_MissionComplete)
		     AddMoneyBonus(sceneId, x205013_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x205013_g_ScriptId, x205013_g_MissionId)
                

        elseif x205013_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x205013_g_MissionName)
                AddText(sceneId,x205013_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x205013_g_MissionTarget) 
		AddMoneyBonus(sceneId, x205013_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x205013_g_ScriptId, x205013_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x205013_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x205013_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x205013_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x205013_g_ScriptId, x205013_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x205013_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x205013_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x205013_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==5) then
        	if (GetName(sceneId,targetId)==x205013_g_Name) then
        	        if IsHaveMission(sceneId,selfId, x205013_g_MissionId)<= 0 then
        	            	return 1
        	        end
        	end
		if (GetName(sceneId,targetId)==x205013_g_Name2) then
			    if IsHaveMission(sceneId,selfId, x205013_g_MissionId) > 0 then
			    	return 1
        	            end
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x205013_OnAccept(sceneId, selfId)

	                                                  
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x205013_g_MissionId, x205013_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x205013_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
	     	                                    
	     
end



--**********************************

--放弃

--**********************************

function x205013_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x205013_g_MissionId)
	for i, item in pairs(x205013_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x205013_CheckSubmit( sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x205013_g_Name2) then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x205013_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x205013_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x205013_g_MissionId)
		AddExp(sceneId, selfId, x205013_g_ExpBonus)
		AddMoney(sceneId, selfId, x205013_g_MoneyBonus)
		for i, item in pairs(x205013_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x205013_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x205013_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x205013_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x205013_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x205013_OnItemChanged(sceneId, selfId, itemdataId)

end

