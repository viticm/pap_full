--大汗的洗礼二

--MisDescBegin
x212010_g_ScriptId = 212010
x212010_g_MissionIdPre =256
x212010_g_MissionId = 257
x212010_g_MissionKind = 17
x212010_g_MissionLevel = 70
x212010_g_ScriptIdNext = {ScriptId = 212011 ,LV = 1 }
x212010_g_Name	="丘处机"
x212010_g_Name2	="成吉思汗" 
x212010_g_DemandItem ={}
--x212010_g_noDemandKill ={{id=301,num=1}}	

x212010_g_MissionName="大汗的洗礼二"
x212010_g_MissionInfo="    从大汗的眼里，我看到了他的忧心！请你去告诉大汗，只要能珍惜身边辅佐他的那些将士，蒙古国国运会更加昌盛，他的继承人会让蒙古的疆土更加的辽广！"  --任务描述
x212010_g_MissionTarget="    把#G丘处机#W的话告诉#G成吉思汗#W，解除他的忧心。"		
x212010_g_MissionComplete="    辛苦你了。"
x212010_g_ContinueInfo="    把我的话转告给大汗了吗？"
x212010_g_ContinueInfo2="    丘真人这么说，我就放心了。"
--任务奖励
x212010_g_MoneyBonus = 200
--固定物品奖励，最多8种
x212010_g_ItemBonus={}

--可选物品奖励，最多8种
x212010_g_RadioItemBonus={}

--MisDescEnd
x212010_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x212010_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x212010_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x212010_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x212010_g_MissionId)
		if (GetName(sceneId,targetId)==x212010_g_Name) then
			if x212010_CheckSubmit(sceneId, selfId, targetId) <= 0 then
				BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x212010_g_MissionName)
				AddText(sceneId,x212010_g_ContinueInfo)
				AddText(sceneId,"#Y任务目标#W") 
				AddText(sceneId,x212010_g_MissionTarget) 
				AddText(sceneId,format("\n    告诉大汗丘处机的话   %d/1", GetMissionParam(sceneId,selfId,misIndex,0) ))
		     		EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
			end
			if x212010_CheckSubmit(sceneId, selfId, targetId) > 0 then
				BeginEvent(sceneId)
                     		AddText(sceneId,"#Y"..x212010_g_MissionName)
		     		AddText(sceneId,x212010_g_MissionComplete)
		     		AddMoneyBonus(sceneId, x212010_g_MoneyBonus)
		     		EndEvent()
                     		DispatchMissionContinueInfo(sceneId, selfId, targetId, x212010_g_ScriptId, x212010_g_MissionId)    			
			end
	        elseif (GetName(sceneId,targetId)==x212010_g_Name2) then
	        	BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x212010_g_MissionName)
			AddText(sceneId,x212010_g_ContinueInfo2)
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
			SetMissionByIndex(sceneId,selfId,misIndex,0,1)
			BeginEvent(sceneId)
			AddText(sceneId,format("告诉大汗丘处机的话   %d/1", GetMissionParam(sceneId,selfId,misIndex,0) ))
		     	EndEvent()
		     	DispatchMissionTips(sceneId, selfId)
		end
		
                    
                

        elseif x212010_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x212010_g_MissionName)
                AddText(sceneId,x212010_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x212010_g_MissionTarget) 
		AddMoneyBonus(sceneId, x212010_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x212010_g_ScriptId, x212010_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x212010_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x212010_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x212010_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x212010_g_ScriptId, x212010_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x212010_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x212010_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x212010_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==12) then
        	if IsMissionHaveDone(sceneId, selfId, x212010_g_MissionIdPre) > 0 then
        	misIndex = GetMissionIndexByID(sceneId,selfId,x212010_g_MissionId)
        		if (GetName(sceneId,targetId)==x212010_g_Name) then
	        	            	return 1
	        	end
			if (GetName(sceneId,targetId)==x212010_g_Name2) then
				    if IsHaveMission(sceneId,selfId, x212010_g_MissionId) > 0 then
				    		if GetMissionParam(sceneId,selfId,misIndex,0) == 0 then
				    			return 1
				    		end
	        	            end
	        	end
	        end
	end
        return 0
	
end

--**********************************

--接受

--**********************************

function x212010_OnAccept(sceneId, selfId)

	                                                  
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x212010_g_MissionId, x212010_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x212010_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
	     	                                    
	     
end



--**********************************

--放弃

--**********************************

function x212010_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x212010_g_MissionId)
	for i, item in x212010_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x212010_CheckSubmit( sceneId, selfId, targetId)

	misIndex = GetMissionIndexByID(sceneId,selfId,x212010_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == 1 then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x212010_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x212010_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x212010_g_MissionId)
		AddExp(sceneId, selfId, x212010_g_ExpBonus)
		AddMoney(sceneId, selfId, x212010_g_MoneyBonus)
		for i, item in x212010_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x212010_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x212010_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x212010_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x212010_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x212010_OnItemChanged(sceneId, selfId, itemdataId)

end

