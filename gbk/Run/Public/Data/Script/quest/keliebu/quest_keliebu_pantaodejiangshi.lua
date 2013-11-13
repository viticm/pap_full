--叛逃的将士

--MisDescBegin
x202010_g_ScriptId = 202010
--x202010_g_MissionIdPre =41
x202010_g_MissionId = 129
x202010_g_MissionKind = 4
x202010_g_MissionLevel = 20
--x202010_g_ScriptIdNext = {ScriptId = 202001 ,LV = 1 }
x202010_g_Name	="木华黎" 
x202010_g_DemandItem ={}
x202010_g_DemandKill ={{id=374,num=1},{id=375,num=1},{id=376,num=1}}

x202010_g_MissionName="叛逃的将士"
x202010_g_MissionInfo="    阿勒坛和忽察儿，答里台三人带着他们的牛羊，骑着他们的马匹，，连夜离开了我们的帐营，去投奔王汗！\n \n    他们太不像话了，临走的时候，还抢夺了附近牧民的财产。    "  --任务描述
x202010_g_MissionInfo2="，我派你去教训他们三人，让他们吃吃苦，不过，别下手太重，毕竟中阿勒坛是铁木真的叔叔。\n \n    他们三个人刚刚离开营地，估计在营地左侧的高坡处，如果你速度快，还能赶得上他们。"
x202010_g_MissionTarget="    #G木华黎#W命你赶到营地附近的高坡，打败#R阿勒坛#W，#R忽察儿#W和#R答里台#W。   "		                                                                                               
x202010_g_MissionComplete="    打得好，让他们知道，即使是铁木真的叔叔，铁木真也不会偏私的！"					--完成任务npc说话的话
x202010_g_ContinueInfo="    你的速度一定要快，再晚的话他们就走远了。"
--任务奖励
x202010_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x202010_g_ItemBonus={}

--可选物品奖励，最多8种
x202010_g_RadioItemBonus={}

--MisDescEnd
x202010_g_ExpBonus = 6500
--**********************************

--任务入口函数

--**********************************

function x202010_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x202010_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x202010_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x202010_g_MissionId)
		if x202010_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x202010_g_MissionName)
			AddText(sceneId,x202010_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x202010_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死阿勒坛   %d/1\n    杀死忽察儿   %d/1\n    杀死答里台   %d/1", GetMissionParam(sceneId,selfId,misIndex,0), GetMissionParam(sceneId,selfId,misIndex,1), GetMissionParam(sceneId,selfId,misIndex,2) ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x202010_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x202010_g_MissionName)
		     AddText(sceneId,x202010_g_MissionComplete)
		     AddMoneyBonus(sceneId, x202010_g_MoneyBonus)
                     EndEvent()
		     DispatchMissionContinueInfo(sceneId, selfId, targetId, x202010_g_ScriptId, x202010_g_MissionId)
                end

        elseif x202010_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x202010_g_MissionName)
                AddText(sceneId,x202010_g_MissionInfo..GetName(sceneId, selfId)..x202010_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x202010_g_MissionTarget) 
		AddMoneyBonus(sceneId, x202010_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x202010_g_ScriptId, x202010_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x202010_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x202010_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x202010_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x202010_g_ScriptId, x202010_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x202010_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x202010_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x202010_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==2) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x202010_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x202010_g_MissionId, x202010_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x202010_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x202010_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x202010_g_MissionId)
	for i, item in pairs(x202010_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x202010_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x202010_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x202010_g_DemandKill[1].num then
		if GetMissionParam(sceneId,selfId,misIndex,1) == x202010_g_DemandKill[2].num then
			if GetMissionParam(sceneId,selfId,misIndex,2) == x202010_g_DemandKill[3].num then
	        		return 1
			end
		end
	end
	return 0

end



--**********************************

--提交

--**********************************

function x202010_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x202010_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x202010_g_MissionId)
		AddExp(sceneId, selfId, x202010_g_ExpBonus)
		AddMoney(sceneId, selfId, x202010_g_MoneyBonus)
		for i, item in pairs(x202010_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x202010_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x202010_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x202010_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x202010_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x202010_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 num2 = GetMissionParam(sceneId,selfId,misIndex,1)
	 num3 = GetMissionParam(sceneId,selfId,misIndex,2)
	 	 if objdataId == x202010_g_DemandKill[1].id then 
       		    if num < x202010_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死阿勒坛   %d/1", GetMissionParam(sceneId,selfId,misIndex,0) )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 if objdataId == x202010_g_DemandKill[2].id then 
       		    if num2 < x202010_g_DemandKill[2].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,1,num2+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死忽察儿   %d/1", GetMissionParam(sceneId,selfId,misIndex,1) )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 if objdataId == x202010_g_DemandKill[3].id then 
       		    if num3 < x202010_g_DemandKill[3].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,2,num3+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死答里台   %d/1", GetMissionParam(sceneId,selfId,misIndex,2) )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x202010_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x202010_OnItemChanged(sceneId, selfId, itemdataId)

end

