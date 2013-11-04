--袭击援军

--MisDescBegin
x207007_g_ScriptId = 207007
--x207007_g_MissionIdPre =41
x207007_g_MissionId = 269
x207007_g_MissionKind = 18
x207007_g_MissionLevel = 75
x207007_g_ScriptIdNext = {ScriptId = 207008 ,LV = 1 }
x207007_g_Name	="速不台" 
x207007_g_DemandItem ={}
x207007_g_DemandKill ={{id=411,num=20}}

x207007_g_MissionName="袭击援军"
x207007_g_MissionInfo="    不需要再跟金国人谈议和，他们死到临头，还敢杀了我们的使臣，灭了他们，让他们看不到明天的太阳！\n \n    我们要袭击他们的援军，孤立蔡州城！"  --任务描述
x207007_g_MissionInfo2="，龙骨坡处的那批#R金国援军#W就交给你了"
x207007_g_MissionTarget="    替#G速不台#W杀死20名龙骨坡处的#R金国援军#W。"		                                                                                               
x207007_g_MissionComplete="    这次金国再也无力回天了。"					--完成任务npc说话的话
x207007_g_ContinueInfo="    袭击援军，让蔡州城孤立无援。"
--任务奖励
x207007_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x207007_g_ItemBonus={}

--可选物品奖励，最多8种
x207007_g_RadioItemBonus={}

--MisDescEnd
x207007_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x207007_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207007_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207007_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x207007_g_MissionId)
		if x207007_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x207007_g_MissionName)
			AddText(sceneId,x207007_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x207007_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死金国援军   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x207007_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x207007_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x207007_g_MissionName)
		     AddText(sceneId,x207007_g_MissionComplete)
		     AddMoneyBonus(sceneId, x207007_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x207007_g_ScriptId, x207007_g_MissionId)
                end

        elseif x207007_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x207007_g_MissionName)
                AddText(sceneId,x207007_g_MissionInfo..GetName(sceneId, selfId)..x207007_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x207007_g_MissionTarget) 
		AddMoneyBonus(sceneId, x207007_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207007_g_ScriptId, x207007_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207007_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207007_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207007_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207007_g_ScriptId, x207007_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207007_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207007_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207007_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==7) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x207007_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x207007_g_MissionId, x207007_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x207007_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x207007_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207007_g_MissionId)
	for i, item in x207007_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x207007_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x207007_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x207007_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207007_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207007_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207007_g_MissionId)
		AddExp(sceneId, selfId, x207007_g_ExpBonus)
		AddMoney(sceneId, selfId, x207007_g_MoneyBonus)
		for i, item in x207007_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x207007_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x207007_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207007_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x207007_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x207007_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x207007_g_DemandKill[1].id then 
       		    if num < x207007_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死金国援军   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x207007_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x207007_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207007_OnItemChanged(sceneId, selfId, itemdataId)

end

