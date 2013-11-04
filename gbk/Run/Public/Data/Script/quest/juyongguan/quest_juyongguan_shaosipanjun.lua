--杀死叛军

--MisDescBegin
x206003_g_ScriptId = 206003
x206003_g_MissionIdPre =29
x206003_g_MissionId = 30
x206003_g_MissionKind = 8
x206003_g_MissionLevel = 40
x206003_g_ScriptIdNext = {ScriptId = 206004 ,LV = 1 }
x206003_g_Name	="木华黎" 
x206003_g_DemandItem ={}
x206003_g_DemandKill ={{id=402,num=20},{id=403,num=1}}

x206003_g_MissionName="杀死叛军"
x206003_g_MissionInfo="    我们是成吉思汗的军队，不允许有任何影响军心、有阻南征的事，大汗已经下令，烧死这些叛军，并活捉叛军首领#R哈儿真#W！"  --任务描述
x206003_g_MissionTarget="    杀掉20个#R巡逻的叛军#W和#哈儿真#W后向#G木华黎#W复命。"		                                                                                               
x206003_g_MissionComplete="     当年我们跟随成吉思汗踏平太阳汗的时候，哈尔真是第一个来降大汗的人，后来跟随在赤老温身边，屡立战功，乌沙堡能攻破，还是他出的点子！\n \n    孛鲁负气出走，看来跟哈儿真有很大原因，不过，这孩子……"					--完成任务npc说话的话
x206003_g_ContinueInfo="    杀死哈儿真了吗？"
--任务奖励
x206003_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x206003_g_ItemBonus={}

--可选物品奖励，最多8种
x206003_g_RadioItemBonus={}

--MisDescEnd
x206003_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x206003_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x206003_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x206003_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x206003_g_MissionId)
		if x206003_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x206003_g_MissionName)
			AddText(sceneId,x206003_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x206003_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死巡逻的叛军   %d/%d\n    杀死哈儿真   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x206003_g_DemandKill[1].num,GetMissionParam(sceneId,selfId,misIndex,1),x206003_g_DemandKill[2].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x206003_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x206003_g_MissionName)
		     AddText(sceneId,x206003_g_MissionComplete)
		     EndEvent()
		     AddMoneyBonus(sceneId, x206003_g_MoneyBonus)
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x206003_g_ScriptId, x206003_g_MissionId)
                end

        elseif x206003_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x206003_g_MissionName)
                AddText(sceneId,x206003_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x206003_g_MissionTarget) 
		AddMoneyBonus(sceneId, x206003_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x206003_g_ScriptId, x206003_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x206003_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x206003_g_MissionId) > 0 then
		return 0
	end
	--如果已接此任务
	if  x206003_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x206003_g_ScriptId, x206003_g_MissionName)
	end
	return 0
	
end



--**********************************

--检测接受条件

--**********************************

function x206003_CheckAccept(sceneId, selfId, targetId)
	if IsMissionHaveDone(sceneId, selfId, x206003_g_MissionIdPre) > 0 then
		return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x206003_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==6) then
        	if IsMissionHaveDone(sceneId, selfId, x206003_g_MissionIdPre) > 0 then
                	return 1
                end
        end
        return 0
		
end

--**********************************

--接受

--**********************************

function x206003_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x206003_g_MissionId, x206003_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x206003_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x206003_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x206003_g_MissionId)
	for i, item in x206003_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x206003_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x206003_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x206003_g_DemandKill[1].num then
		if GetMissionParam(sceneId,selfId,misIndex,1) == x206003_g_DemandKill[2].num then
	        	return 1
	        end
	end
	return 0

end



--**********************************

--提交

--**********************************

function x206003_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x206003_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x206003_g_MissionId)
		AddExp(sceneId, selfId, x206003_g_ExpBonus)
		AddMoney(sceneId, selfId, x206003_g_MoneyBonus)
		for i, item in x206003_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x206003_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x206003_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x206003_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x206003_g_MissionId) >= 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x206003_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0)
	 num2 = GetMissionParam(sceneId,selfId,misIndex,1)  
		 if objdataId == x206003_g_DemandKill[1].id then 
       		    if num < x206003_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死巡逻的叛军   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x206003_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 if objdataId == x206003_g_DemandKill[2].id then 
       		    if num2 < x206003_g_DemandKill[2].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,1,num2+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死哈儿真   %d/%d", GetMissionParam(sceneId,selfId,misIndex,1),x206003_g_DemandKill[2].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x206003_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x206003_OnItemChanged(sceneId, selfId, itemdataId)

end

