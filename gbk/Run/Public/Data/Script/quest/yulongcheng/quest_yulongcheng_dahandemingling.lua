--大汗的命令

--MisDescBegin
x208004_g_ScriptId = 208004
--x208004_g_MissionIdPre =40
x208004_g_MissionId = 58
x208004_g_MissionKind = 12
x208004_g_MissionLevel = 60
x208004_g_ScriptIdNext = {ScriptId = 208005 ,LV = 1 }
x208004_g_Name	="哲别" 
x208004_g_Name2	="速不台" 
--x208004_g_DemandItem ={{id=13010003,num=1}}
--x208004_g_noDemandKill ={{id=301,num=1}}	

x208004_g_MissionName="大汗的命令"
x208004_g_MissionInfo="，很高兴再次见到你！很久没有跟你一起大块吃肉，大口喝酒了！\n \n    不过，现在请帮我跑一趟，向#G速不台#W将军传个口信，大汗下了命令，为那450个惨死的商人报仇，为了整戒那些自大和贪婪的人，一定不能不能手软，杀光所有花剌子模男人！\n \n    速去速回，我准备好马奶酒等着你"  --任务描述
x208004_g_MissionTarget="    给#G速不台#W将军传个口信，然后回来跟#G哲别#W复命！"		
x208004_g_MissionComplete="    <哲别把手上的箭袋绑在自己背后，见到你回来，他特别高兴>\n \n    去喝些马奶酒暖暖身子。"					--完成任务npc说话的话
x208004_g_ContinueInfo="    见到速不台将军了吗？"
x208004_g_ContinueInfo2="    谢谢你给我带着个消息。不用大汗发话我也会这么做！"
--任务奖励
x208004_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x208004_g_ItemBonus={}

--可选物品奖励，最多8种
x208004_g_RadioItemBonus={}

--MisDescEnd
x208004_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x208004_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	misIndex = GetMissionIndexByID(sceneId,selfId,x208004_g_MissionId)
	if x208004_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x208004_g_MissionId) > 0 then
		if x208004_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     	BeginEvent(sceneId)
                     	AddText(sceneId,"#Y"..x208004_g_MissionName)
		     	AddText(sceneId,x208004_g_MissionComplete)
		     	AddMoneyBonus(sceneId, x208004_g_MoneyBonus)
		     	EndEvent()
                     	DispatchMissionContinueInfo(sceneId, selfId, targetId, x208004_g_ScriptId, x208004_g_MissionId)
                end
                if x208004_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                	if (GetName(sceneId,targetId)==x208004_g_Name) then
                		BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x208004_g_MissionName)
				AddText(sceneId,x208004_g_ContinueInfo)
				AddText(sceneId,"#Y任务目标#W") 
				AddText(sceneId,x208004_g_MissionTarget) 
				AddText(sceneId,format("\n    给速不台传口信   %d/1", GetMissionParam(sceneId,selfId,misIndex,0) ))
		     		EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
			end
			if (GetName(sceneId,targetId)==x208004_g_Name2) then
                		BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x208004_g_MissionName)
				AddText(sceneId,x208004_g_ContinueInfo2)
				EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
				SetMissionByIndex(sceneId,selfId,misIndex,0,1)
				BeginEvent(sceneId)
				AddText(sceneId,format("给速不台传口信   %d/1", GetMissionParam(sceneId,selfId,misIndex,0) ))
		     		EndEvent()
		     		DispatchMissionTips(sceneId, selfId)
			end
                		
                end

        elseif x208004_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x208004_g_MissionName)
                AddText(sceneId,"    "..GetName(sceneId, selfId)..x208004_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x208004_g_MissionTarget) 
		AddMoneyBonus(sceneId, x208004_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x208004_g_ScriptId, x208004_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x208004_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x208004_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x208004_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x208004_g_ScriptId, x208004_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x208004_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x208004_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x208004_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==8) then
        misIndex = GetMissionIndexByID(sceneId,selfId,x208004_g_MissionId)
        	if (GetName(sceneId,targetId)==x208004_g_Name) then
        	            	return 1
        	end
		if (GetName(sceneId,targetId)==x208004_g_Name2) then
			    if IsHaveMission(sceneId,selfId, x208004_g_MissionId) > 0 then
			    	if GetMissionParam(sceneId,selfId,misIndex,0) == 0 then
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

function x208004_OnAccept(sceneId, selfId)

	                                                  
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x208004_g_MissionId, x208004_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x208004_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
	     	                                    
	     
end



--**********************************

--放弃

--**********************************

function x208004_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x208004_g_MissionId)
	for i, item in x208004_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x208004_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x208004_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == 1 then
			    		return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x208004_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x208004_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x208004_g_MissionId)
		AddExp(sceneId, selfId, x208004_g_ExpBonus)
		AddMoney(sceneId, selfId, x208004_g_MoneyBonus)
		for i, item in x208004_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end
		CallScriptFunction( x208004_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x208004_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x208004_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x208004_OnItemChanged(sceneId, selfId, itemdataId)

end

