--孛儿帖被困

--MisDescBegin
x201002_g_ScriptId = 201002
x201002_g_MissionIdPre =83
x201002_g_MissionId = 84
x201002_g_MissionKind = 2
x201002_g_MissionLevel = 10
--x201002_g_ScriptIdNext = {ScriptId = 205002 ,LV = 1 }
x201002_g_Name	="铁木真" 
x201002_g_Name2	="博尔术" 
x201002_g_DemandItem ={}
--x201002_g_noDemandKill ={{id=301,num=1}}	

x201002_g_MissionName="孛儿帖被困"
x201002_g_MissionInfo="     我勇敢的伙伴--博尔术安答找到了孛儿帖，但是被困在罕难河下郡的营地里，似乎有点麻烦，我很担心！你尽快赶去跟#G博尔术#W会合！"  --任务描述
x201002_g_MissionTarget="    到#R罕难河下郡#W处的营地和#G博尔术#aB{博尔术_1}[226,39]#aE#W会合。"		
x201002_g_MissionComplete="    太好了，我们终于等到你们了！"					--完成任务npc说话的话
--x201002_g_ContinueInfo="    不管付出多大代价，也要把那件东西给拿回来。"

--自动寻路的定义
x201002_g_AutoFindPath =  {{sid=1,x=226,z=39,speak=1}}

--任务奖励
x201002_g_MoneyBonus = 0
--固定物品奖励，最多8种
x201002_g_ItemBonus={}

--可选物品奖励，最多8种
x201002_g_RadioItemBonus={}
--MisDescEnd
x201002_g_ExpBonus = 22
--**********************************

--任务入口函数

--**********************************

function x201002_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x201002_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x201002_g_MissionId) > 0 then
		
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x201002_g_MissionName)
		     AddText(sceneId,x201002_g_MissionComplete)
		     --AddMoneyBonus(sceneId, x201001_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x201002_g_ScriptId, x201002_g_MissionId)
                

        elseif x201002_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x201002_g_MissionName)
                AddText(sceneId,x201002_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x201002_g_MissionTarget) 
		--AddMoneyBonus(sceneId, x201002_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x201002_g_ScriptId, x201002_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x201002_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x201002_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x201002_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x201002_g_ScriptId, x201002_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x201002_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x201002_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x201002_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==1) then
        	if IsMissionHaveDone(sceneId, selfId, x201002_g_MissionIdPre) > 0 then
	        	if (GetName(sceneId,targetId)==x201002_g_Name) then
	        	        if IsHaveMission(sceneId,selfId, x201002_g_MissionId)<= 0 then
	        	            	return 1
	        	        end
	        	end
			if (GetName(sceneId,targetId)==x201002_g_Name2) then
				    if IsHaveMission(sceneId,selfId, x201002_g_MissionId) > 0 then
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

function x201002_OnAccept(sceneId, selfId)

	                                                  
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x201002_g_MissionId, x201002_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x201002_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
	     	                                    
	     
end



--**********************************

--放弃

--**********************************

function x201002_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x201002_g_MissionId)
	for i, item in x201002_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x201002_CheckSubmit( sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x201002_g_Name2) then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x201002_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x201002_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x201002_g_MissionId)
		AddExp(sceneId, selfId, x201002_g_ExpBonus)
		AddMoney(sceneId, selfId, x201002_g_MoneyBonus)
		for i, item in x201002_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x201002_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x201002_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end

	
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x201002_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x201002_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x201002_OnItemChanged(sceneId, selfId, itemdataId)

end

