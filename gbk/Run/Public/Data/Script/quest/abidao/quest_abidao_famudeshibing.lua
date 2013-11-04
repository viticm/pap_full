--伐木的士兵

--MisDescBegin
x203008_g_ScriptId = 203008
--x203008_g_MissionIdPre =41
x203008_g_MissionId = 76
x203008_g_MissionKind = 13
x203008_g_MissionLevel = 50
--x203008_g_ScriptIdNext = {ScriptId = 205003 ,LV = 1 }
x203008_g_Name	="哲别" 
x203008_g_DemandItem ={}
x203008_g_DemandKill ={{id=327,num=15}}

x203008_g_MissionName="伐木的士兵"
x203008_g_MissionInfo="    我们一路追了几千里，终于把这万恶的魔诃魔困在这个岛上。速不台将军已经把这岛牢牢包围了。看起来这是瓮中捉鳖，但是我们不能大意，一定要速战速决，绝对不能让他们有时间造船离开。/n /n    探子进入阿碧岛深处，发现了他们大量伐木，堆积在海滩处，我怀疑他们想造船出海，"  --任务描述
x203008_g_MissionInfo2="，你一定要到那去阻止他们。"
x203008_g_MissionTarget="    到西南处的海滩杀死15名#R花剌子模伐木工#W后向哲别复命。"		                                                                                               
x203008_g_MissionComplete="    有任何可能，我都不会让它再发生。"					--完成任务npc说话的话
x203008_g_ContinueInfo="    你成功阻止了他们了吗？"
--任务奖励
x203008_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x203008_g_ItemBonus={}

--可选物品奖励，最多8种
x203008_g_RadioItemBonus={}

--MisDescEnd
x203008_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x203008_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x203008_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x203008_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x203008_g_MissionId)
		if x203008_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x203008_g_MissionName)
			AddText(sceneId,x203008_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x203008_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死花剌子模伐木工   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x203008_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x203008_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x203008_g_MissionName)
		     AddText(sceneId,x203008_g_MissionComplete)
		     AddMoneyBonus(sceneId, x203008_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x203008_g_ScriptId, x203008_g_MissionId)
                end

        elseif x203008_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x203008_g_MissionName)
                AddText(sceneId,x203008_g_MissionInfo..GetName(sceneId, selfId)..x203008_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x203008_g_MissionTarget) 
		AddMoneyBonus(sceneId, x203008_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x203008_g_ScriptId, x203008_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x203008_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x203008_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x203008_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x203008_g_ScriptId, x203008_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x203008_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x203008_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x203008_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==3) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x203008_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x203008_g_MissionId, x203008_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x203008_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x203008_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x203008_g_MissionId)
	for i, item in x203008_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x203008_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x203008_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x203008_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x203008_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x203008_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x203008_g_MissionId)
		AddExp(sceneId, selfId, x203008_g_ExpBonus)
		AddMoney(sceneId, selfId, x203008_g_MoneyBonus)
		for i, item in x203008_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x203008_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x203008_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x203008_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x203008_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x203008_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x203008_g_DemandKill[1].id then 
       		    if num < x203008_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死花剌子模伐木工   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x203008_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x203008_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x203008_OnItemChanged(sceneId, selfId, itemdataId)

end

