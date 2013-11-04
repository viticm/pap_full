--削弱战斗力

--MisDescBegin
x203009_g_ScriptId = 203009
--x203009_g_MissionIdPre =72
x203009_g_MissionId = 77
x203009_g_MissionKind = 13
x203009_g_MissionLevel = 50
x203009_g_ScriptIdNext = {ScriptId = 203010 ,LV = 1 }
x203009_g_Name	="哲别" 
x203009_g_Name2	="速不台" 
x203009_g_DemandItem ={}
x203009_g_DemandKill ={{id=329,num=10},{id=328,num=10}}

x203009_g_MissionName="削弱战斗力"
x203009_g_MissionInfo="     成吉思汗下了军令，抓不到魔诃魔，我和速不台就不用回大草原！我们看来需要冒点险了。\n \n    马匹和粮草是战争中必不可少的，我们要从这里下手。恩，在岛的西面就有他们军队的马厩，你要去杀光他们的军马，顺路把马夫也杀了吧，他们对我们没有用，然后去找#G速不台#W，他会告诉你下一步该怎么做。"  --任务描述
x203009_g_MissionTarget="    杀掉10匹#R花剌子模战马#W和10个#R花剌子模马夫#W，然后问#G速不台#W下一步做什么。"		                                                                                               
x203009_g_MissionComplete="    这样他们骑兵就无法发挥战斗力了。"					--完成任务npc说话的话
x203009_g_ContinueInfo="    找到他们的马厩了吗？"
--任务奖励
x203009_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x203009_g_ItemBonus={}

--可选物品奖励，最多8种
x203009_g_RadioItemBonus={}

--MisDescEnd
x203009_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x203009_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x203009_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x203009_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x203009_g_MissionId)
		if x203009_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x203009_g_MissionName)
			AddText(sceneId,x203009_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x203009_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死花剌子模战马   %d/%d\n    杀死花剌子模马夫   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x203009_g_DemandKill[1].num, GetMissionParam(sceneId,selfId,misIndex,1),x203009_g_DemandKill[2].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x203009_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x203009_g_MissionName)
		     AddText(sceneId,x203009_g_MissionComplete)
		     AddMoneyBonus(sceneId, x203009_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x203009_g_ScriptId, x203009_g_MissionId)
                end

        elseif x203009_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x203009_g_MissionName)
                AddText(sceneId,x203009_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x203009_g_MissionTarget) 
		AddMoneyBonus(sceneId, x203009_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x203009_g_ScriptId, x203009_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x203009_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x203009_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x203009_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x203009_g_ScriptId, x203009_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x203009_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x203009_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x203009_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==3) then
		if (GetName(sceneId,targetId)==x203009_g_Name) then 
			if IsHaveMission(sceneId,selfId, x203009_g_MissionId) <= 0 then
		    		return 1
		    	end
		end
		if (GetName(sceneId,targetId)==x203009_g_Name2) then 
			if IsHaveMission(sceneId,selfId, x203009_g_MissionId) > 0 then
		    		return 1
		    	end
		end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x203009_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x203009_g_MissionId, x203009_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x203009_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x203009_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x203009_g_MissionId)
	for i, item in x203009_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x203009_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x203009_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x203009_g_DemandKill[1].num then
		if GetMissionParam(sceneId,selfId,misIndex,1) == x203009_g_DemandKill[2].num then
	        	return 1
	        end
	end
	return 0

end



--**********************************

--提交

--**********************************

function x203009_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x203009_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x203009_g_MissionId)
		AddExp(sceneId, selfId, x203009_g_ExpBonus)
		AddMoney(sceneId, selfId, x203009_g_MoneyBonus)
		for i, item in x203009_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x203009_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x203009_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x203009_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x203009_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x203009_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x203009_g_DemandKill[1].id then 
       		    if num < x203009_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死花剌子模战马   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x203009_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
        num2 = GetMissionParam(sceneId,selfId,misIndex,1) 
	 	 if objdataId == x203009_g_DemandKill[2].id then 
       		    if num2 < x203009_g_DemandKill[2].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,1,num2+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死花剌子模马夫   %d/%d", GetMissionParam(sceneId,selfId,misIndex,1),x203009_g_DemandKill[2].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
      end  

end



--**********************************

--进入区域事件

--**********************************

function x203009_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x203009_OnItemChanged(sceneId, selfId, itemdataId)

end

