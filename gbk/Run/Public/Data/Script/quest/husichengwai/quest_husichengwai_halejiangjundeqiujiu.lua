--哈勒将军的求救

--MisDescBegin
x204004_g_ScriptId = 204004
--x204004_g_MissionIdPre =84
x204004_g_MissionId = 99
x204004_g_MissionKind = 9
x204004_g_MissionLevel = 45
x204004_g_ScriptIdNext = {ScriptId = 204005 ,LV = 1 }
x204004_g_Name	="哲别"
x204004_g_Name2	="达拉皇后"  
x204004_g_DemandItem ={}
x204004_g_DemandKill ={{id=350,num=20}}

x204004_g_MissionName="哈勒将军的求救"
x204004_g_MissionInfo="    我左手拿着的这封信，是来自西辽哈勒大将军的信。\n \n    这位将军需要我们帮忙，国王耶律直被囚禁在皇宫，郁郁而终，他不相信这事实，希望我们能帮他找出真相，推翻屈出律政权，西辽和蒙古永世修好。\n \n    "  --任务描述
x204004_g_MissionInfo2="我需要你这样精明的人帮我去做这件事，西辽国王的达拉皇后就居住在剑岭处，她身上也许会有线索！\n \n    不过，你可能不能这么容易就见到她，一定要解决了守护她的那20名#R宫廷侍卫#W。"
x204004_g_MissionTarget="    杀死20名剑岭处的#R宫廷侍卫#W，然后问问#G达拉皇后#W，看看有没有关于西辽国王耶律直之死的线索。"		                                                                                               
x204004_g_MissionComplete="    一年了，终于有人来了！"					--完成任务npc说话的话
x204004_g_ContinueInfo="    那些侍卫还在旁边。"
--任务奖励
x204004_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x204004_g_ItemBonus={}

--可选物品奖励，最多8种
x204004_g_RadioItemBonus={}

--MisDescEnd
x204004_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x204004_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x204004_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x204004_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x204004_g_MissionId)
		if x204004_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x204004_g_MissionName)
			AddText(sceneId,x204004_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x204004_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死宫廷侍卫   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x204004_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x204004_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x204004_g_MissionName)
		     AddText(sceneId,x204004_g_MissionComplete)
		     AddMoneyBonus(sceneId, x204004_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x204004_g_ScriptId, x204004_g_MissionId)
                end

        elseif x204004_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x204004_g_MissionName)
                AddText(sceneId,x204004_g_MissionInfo..GetName(sceneId, selfId)..x204004_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x204004_g_MissionTarget) 
		AddMoneyBonus(sceneId, x204004_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x204004_g_ScriptId, x204004_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x204004_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x204004_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x204004_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x204004_g_ScriptId, x204004_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x204004_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x204004_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x204004_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==4) then
			if (GetName(sceneId,targetId)==x204004_g_Name) then 
				if IsHaveMission(sceneId,selfId, x204004_g_MissionId) <= 0 then
        	    			return 1
        	    		end
        	    	end
        	    	if (GetName(sceneId,targetId)==x204004_g_Name2) then 
				if IsHaveMission(sceneId,selfId, x204004_g_MissionId) > 0 then
        	    			return 1
        	    		end
        	    	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x204004_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x204004_g_MissionId, x204004_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x204004_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x204004_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x204004_g_MissionId)
	for i, item in x204004_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x204004_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x204004_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x204004_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x204004_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x204004_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x204004_g_MissionId)
		AddExp(sceneId, selfId, x204004_g_ExpBonus)
		AddMoney(sceneId, selfId, x204004_g_MoneyBonus)
		for i, item in x204004_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x204004_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x204004_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x204004_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x204004_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x204004_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x204004_g_DemandKill[1].id then 
       		    if num < x204004_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死宫廷侍卫   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x204004_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x204004_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x204004_OnItemChanged(sceneId, selfId, itemdataId)

end

