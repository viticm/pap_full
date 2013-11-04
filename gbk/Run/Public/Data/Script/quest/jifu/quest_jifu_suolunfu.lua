--索伦夫

--MisDescBegin
x225010_g_ScriptId = 225010
--x225010_g_MissionIdPre =41
x225010_g_MissionId = 332
x225010_g_MissionKind = 22
x225010_g_MissionLevel = 110
--x225010_g_ScriptIdNext = {ScriptId = 225001 ,LV = 1 }
x225010_g_Name	="拔都" 
x225010_g_DemandItem ={}
x225010_g_DemandKill ={{id=439,num=1}}

x225010_g_MissionName="索伦夫"
x225010_g_MissionInfo="    我听说一个消息，一个叫做#R索伦夫#W的人在帮助基辅人逃跑。说实话，他挺值得敬佩的，但是他对抗大蒙古的做法不能原谅。你去杀了他。"  --任务描述
x225010_g_MissionTarget="    奉#G拔都#W的命令去杀死在#G贫民窟#W的#R索伦夫#W。"		                                                                                               
x225010_g_MissionComplete="    很好，让城里的人绝望吧。"					--完成任务npc说话的话
x225010_g_ContinueInfo="    他以为自己是救世主吗？"
--任务奖励
x225010_g_MoneyBonus = 500

--固定物品奖励，最多8种
x225010_g_ItemBonus={}

--可选物品奖励，最多8种
x225010_g_RadioItemBonus={}

--MisDescEnd
x225010_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x225010_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x225010_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x225010_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x225010_g_MissionId)
		if x225010_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x225010_g_MissionName)
			AddText(sceneId,x225010_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x225010_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死索伦夫   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x225010_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x225010_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x225010_g_MissionName)
		     AddText(sceneId,x225010_g_MissionComplete)
		     AddMoneyBonus(sceneId, x225010_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x225010_g_ScriptId, x225010_g_MissionId)
                end

        elseif x225010_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x225010_g_MissionName)
                AddText(sceneId,x225010_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x225010_g_MissionTarget) 
		AddMoneyBonus(sceneId, x225010_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x225010_g_ScriptId, x225010_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x225010_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x225010_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x225010_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x225010_g_ScriptId, x225010_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x225010_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x225010_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x225010_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==16) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x225010_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x225010_g_MissionId, x225010_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x225010_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x225010_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x225010_g_MissionId)
	for i, item in x225010_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x225010_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x225010_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x225010_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x225010_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x225010_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x225010_g_MissionId)
		AddExp(sceneId, selfId, x225010_g_ExpBonus)
		AddMoney(sceneId, selfId, x225010_g_MoneyBonus)
		for i, item in x225010_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x225010_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x225010_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x225010_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x225010_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x225010_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x225010_g_DemandKill[1].id then 
       		    if num < x225010_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死索伦夫   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x225010_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x225010_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x225010_OnItemChanged(sceneId, selfId, itemdataId)

end

