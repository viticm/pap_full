--西隅精锐兵

--MisDescBegin
x217001_g_ScriptId = 217001
x217001_g_MissionIdPre =172
x217001_g_MissionId = 173
x217001_g_MissionKind = 6
x217001_g_MissionLevel = 30
x217001_g_ScriptIdNext = {ScriptId = 217002 ,LV = 1 }
x217001_g_Name	="哲别" 
x217001_g_DemandItem ={}
x217001_g_DemandKill ={{id=451,num=20}}

x217001_g_MissionName="西隅精锐兵"
x217001_g_MissionInfo="    我们在乌月营的战役非常的重要，这是金国囤积粮秣的地方，也是攻打乌沙堡唯一的突破口！\n \n    在他们援军来之前，我们要用迅雷不及掩耳的速度占领这个地方。\n \n    "  --任务描述
x217001_g_MissionInfo2="，我们第一步要做的，就是消灭扎驻在#G西隅#W的那队#R乌月营精锐兵#W，我希望你能活着回来。"
x217001_g_MissionTarget="    #G哲别#W要你消灭#G西隅#W的20名#R乌月营精锐兵#W。"		                                                                                               
x217001_g_MissionComplete="    是的，我要的就是像你这样英勇的战士，南征的路上，我们一起并肩杀敌。"					--完成任务npc说话的话
x217001_g_ContinueInfo="    进攻西隅的号声响起，拿起你的武器，去完成你的任务！"
--任务奖励
x217001_g_MoneyBonus = 500

--固定物品奖励，最多8种
x217001_g_ItemBonus={}

--可选物品奖励，最多8种
x217001_g_RadioItemBonus={}

--MisDescEnd
x217001_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x217001_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x217001_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x217001_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x217001_g_MissionId)
		if x217001_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x217001_g_MissionName)
			AddText(sceneId,x217001_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x217001_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死乌月营精锐兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x217001_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x217001_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x217001_g_MissionName)
		     AddText(sceneId,x217001_g_MissionComplete)
		     AddMoneyBonus(sceneId, x217001_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x217001_g_ScriptId, x217001_g_MissionId)
                end

        elseif x217001_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x217001_g_MissionName)
                AddText(sceneId,x217001_g_MissionInfo..GetName(sceneId, selfId)..x217001_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x217001_g_MissionTarget) 
		AddMoneyBonus(sceneId, x217001_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x217001_g_ScriptId, x217001_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x217001_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x217001_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x217001_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x217001_g_ScriptId, x217001_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x217001_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x217001_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x217001_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==20) then
		if IsMissionHaveDone(sceneId, selfId, x217001_g_MissionIdPre) > 0 then
        	    	return 1
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x217001_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x217001_g_MissionId, x217001_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x217001_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x217001_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x217001_g_MissionId)
	for i, item in x217001_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x217001_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x217001_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x217001_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x217001_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x217001_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x217001_g_MissionId)
		AddExp(sceneId, selfId, x217001_g_ExpBonus)
		AddMoney(sceneId, selfId, x217001_g_MoneyBonus)
		for i, item in x217001_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x217001_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x217001_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x217001_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x217001_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x217001_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x217001_g_DemandKill[1].id then 
       		    if num < x217001_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死乌月营精锐兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x217001_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x217001_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x217001_OnItemChanged(sceneId, selfId, itemdataId)

end

