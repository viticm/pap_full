--杀死赤难

--MisDescBegin
x208008_g_ScriptId = 208008
--x208008_g_MissionIdPre =58
x208008_g_MissionId = 62
x208008_g_MissionKind = 12
x208008_g_MissionLevel = 60
x208008_g_ScriptIdNext = {ScriptId = 208009 ,LV = 1 }
x208008_g_Name	="速不台" 
x208008_g_DemandItem ={}
x208008_g_DemandKill ={{id=313,num=1},{id=314,num=15}}

x208008_g_MissionName="杀死赤难"
x208008_g_MissionInfo="     回来的正好，我刚刚得到一个消息，出谋划策杀死我们商队的人，是一个叫#R亦难#W的胖子，他是一个军政长官，他的姑妈，是秃儿太后。这个人准备坐船逃跑。你要以最快的速度赶到（40，77）处，一个也不能让他们跑了。"  --任务描述
x208008_g_MissionTarget="    赶到（40，77）处杀死#R亦难#W和15个#R赤难的侍卫#W，回来向#G速不台#W复命。"		                                                                                               
x208008_g_MissionComplete="    非常的感谢，你的功劳大家都看到，我会如实禀报大汗的。"					--完成任务npc说话的话
x208008_g_ContinueInfo="    杀了亦难这个灵魂肮脏的人，血债血偿。"
--任务奖励
x208008_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x208008_g_ItemBonus={}

--可选物品奖励，最多8种
x208008_g_RadioItemBonus={}

--MisDescEnd
x208008_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x208008_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x208008_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x208008_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x208008_g_MissionId)
		if x208008_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x208008_g_MissionName)
			AddText(sceneId,x208008_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x208008_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死赤难   %d/%d\n    杀死赤难的侍卫   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x208008_g_DemandKill[1].num, GetMissionParam(sceneId,selfId,misIndex,1),x208008_g_DemandKill[2].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x208008_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x208008_g_MissionName)
		     AddText(sceneId,x208008_g_MissionComplete)
		     AddMoneyBonus(sceneId, x208008_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x208008_g_ScriptId, x208008_g_MissionId)
                end

        elseif x208008_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x208008_g_MissionName)
                AddText(sceneId,x208008_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x208008_g_MissionTarget) 
		AddMoneyBonus(sceneId, x208008_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x208008_g_ScriptId, x208008_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x208008_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x208008_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x208008_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x208008_g_ScriptId, x208008_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x208008_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x208008_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x208008_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==8) then
		    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x208008_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x208008_g_MissionId, x208008_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x208008_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x208008_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x208008_g_MissionId)
	for i, item in x208008_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x208008_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x208008_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x208008_g_DemandKill[1].num then
		if GetMissionParam(sceneId,selfId,misIndex,1) == x208008_g_DemandKill[2].num then
	        	return 1
	        end
	end
	return 0

end



--**********************************

--提交

--**********************************

function x208008_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x208008_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x208008_g_MissionId)
		AddExp(sceneId, selfId, x208008_g_ExpBonus)
		AddMoney(sceneId, selfId, x208008_g_MoneyBonus)
		for i, item in x208008_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x208008_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x208008_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x208008_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x208008_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x208008_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x208008_g_DemandKill[1].id then 
       		    if num < 1 then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死赤难   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x208008_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
        num2 = GetMissionParam(sceneId,selfId,misIndex,1) 
	 	 if objdataId == x208008_g_DemandKill[2].id then 
       		    if num2 < 15 then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,1,num2+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死赤难的侍卫   %d/%d", GetMissionParam(sceneId,selfId,misIndex,1) ,x208008_g_DemandKill[1].num)) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
      end  

end



--**********************************

--进入区域事件

--**********************************

function x208008_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x208008_OnItemChanged(sceneId, selfId, itemdataId)

end

