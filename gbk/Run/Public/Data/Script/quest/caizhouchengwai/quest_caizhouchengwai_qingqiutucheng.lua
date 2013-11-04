--请求屠城

--MisDescBegin
x207008_g_ScriptId = 207008
x207008_g_MissionIdPre =269
x207008_g_MissionId = 270
x207008_g_MissionKind = 18
x207008_g_MissionLevel = 75
x207008_g_ScriptIdNext = {ScriptId = 207009 ,LV = 1 }
x207008_g_Name	="速不台" 
x207008_g_Name2	="耶律楚材" 
x207008_g_noDemandItem ={}
--x207008_g_noDemandKill ={{id=301,num=1}}	

x207008_g_MissionName="请求屠城"
x207008_g_MissionInfo="    我们的铁骑已经冲破了汴京的城门，金西面元帅崔立杀死未及逃走的金国二相，派人向我们请降。\n \n    请你速到汗廷去见#G耶律楚材#W，请求他下令屠城！"  --任务描述
x207008_g_MissionTarget="    #G速不台#W将军要你到汗廷找#G耶律楚材#W，请求他下令屠城。"		
x207008_g_MissionComplete="    我知道了！"					--完成任务npc说话的话
x207008_g_ContinueInfo="    见到耶律楚材了吗？"
x207008_g_ContinueInfo2="     闻得速不台将军请求大汗下令屠城，我连夜赶去奉劝大汗，大汗知晓厉害关系，同意放过汴京的百姓。\n \n    请你立即启程，告诉速不台，只能处死完颜一脉，放过其他百姓，并把请降的金国元帅崔立送到我这来。"
--任务奖励
x207008_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x207008_g_ItemBonus={}

--可选物品奖励，最多8种
x207008_g_RadioItemBonus={}

--MisDescEnd
x207008_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x207008_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	misIndex = GetMissionIndexByID(sceneId,selfId,x207008_g_MissionId)
	if x207008_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207008_g_MissionId) > 0 then
		if x207008_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     	BeginEvent(sceneId)
                     	AddText(sceneId,"#Y"..x207008_g_MissionName)
		     	AddText(sceneId,x207008_g_MissionComplete)
		     	AddMoneyBonus(sceneId, x207008_g_MoneyBonus)
		     	EndEvent()
                     	DispatchMissionContinueInfo(sceneId, selfId, targetId, x207008_g_ScriptId, x207008_g_MissionId)
                end
                if x207008_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                	if (GetName(sceneId,targetId)==x207008_g_Name) then
                		BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x207008_g_MissionName)
				AddText(sceneId,x207008_g_ContinueInfo)
				AddText(sceneId,"#Y任务目标#W") 
				AddText(sceneId,x207008_g_MissionTarget) 
				AddText(sceneId,format("\n    向耶律楚材请求屠城   %d/1", GetMissionParam(sceneId,selfId,misIndex,0) ))
		     		EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
			end
			if (GetName(sceneId,targetId)==x207008_g_Name2) then
                		BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x207008_g_MissionName)
				AddText(sceneId,x207008_g_ContinueInfo2)
				EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
				SetMissionByIndex(sceneId,selfId,misIndex,0,1)
				BeginEvent(sceneId)
				AddText(sceneId,format("向耶律楚材请求屠城   %d/1", GetMissionParam(sceneId,selfId,misIndex,0) ))
		     		EndEvent()
		     		DispatchMissionTips(sceneId, selfId)
			end
                		
                end

        elseif x207008_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x207008_g_MissionName)
                AddText(sceneId,x207008_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x207008_g_MissionTarget) 
		AddMoneyBonus(sceneId, x207008_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207008_g_ScriptId, x207008_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207008_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207008_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207008_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207008_g_ScriptId, x207008_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207008_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207008_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207008_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==7) then
        	if IsMissionHaveDone(sceneId, selfId, x207008_g_MissionIdPre) > 0 then
        	misIndex = GetMissionIndexByID(sceneId,selfId,x207008_g_MissionId)
        		if (GetName(sceneId,targetId)==x207008_g_Name) then
        	            		return 1
        		end
			if (GetName(sceneId,targetId)==x207008_g_Name2) then
			   	 if IsHaveMission(sceneId,selfId, x207008_g_MissionId) > 0 then
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

function x207008_OnAccept(sceneId, selfId)

	                                                  
	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x207008_g_MissionId, x207008_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x207008_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
	
	     	                                    
	     
end



--**********************************

--放弃

--**********************************

function x207008_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207008_g_MissionId)
	for i, item in x207008_g_noDemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x207008_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x207008_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == 1 then
			    		return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207008_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207008_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207008_g_MissionId)
		AddExp(sceneId, selfId, x207008_g_ExpBonus)
		AddMoney(sceneId, selfId, x207008_g_MoneyBonus)
		for i, item in x207008_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end
		CallScriptFunction( x207008_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207008_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x207008_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207008_OnItemChanged(sceneId, selfId, itemdataId)

end

