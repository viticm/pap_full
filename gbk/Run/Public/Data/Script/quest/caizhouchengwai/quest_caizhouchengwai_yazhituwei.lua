--压制突围

--MisDescBegin
x207010_g_ScriptId = 207010
--x207010_g_MissionIdPre =41
x207010_g_MissionId = 272
x207010_g_MissionKind = 18
x207010_g_MissionLevel = 75
--x207010_g_ScriptIdNext = {ScriptId = 207008 ,LV = 1 }
x207010_g_Name	="塔察儿" 
x207010_g_DemandItem ={}
x207010_g_DemandKill ={{id=412,num=1}}

x207010_g_MissionName="压制突围"
x207010_g_MissionInfo="    蔡州城被我们攻打了六个月，依然没破，这不得不说是个奇迹。金人宁死不屈，他们所表现出来的勇气令我们钦佩，但是，形式的严峻却是不争的事实。\n \n    蔡州城已断粮三天，屠杀战马也只能解决一时之需。一些宁愿战死也不愿意饿死的女真人已经开始了突围，他们聚集在镇龙台一带。\n \n    "  --任务描述
x207010_g_MissionInfo2="，不要让任何一个人活着离开，特别是女真人的首武将#R阿虎打#W。"
x207010_g_MissionTarget="    完颜思烈带着人突围，聚集在镇龙台处，#G塔察儿#W将军要你杀了金国的将军#R阿虎打#W。"		                                                                                               
x207010_g_MissionComplete="    做得好，阿虎打是一代名将，只可惜为金国卖命。"					--完成任务npc说话的话
x207010_g_ContinueInfo="    解决阿虎打了吗？"
--任务奖励
x207010_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x207010_g_ItemBonus={}

--可选物品奖励，最多8种
x207010_g_RadioItemBonus={}

--MisDescEnd
x207010_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x207010_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207010_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207010_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x207010_g_MissionId)
		if x207010_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x207010_g_MissionName)
			AddText(sceneId,x207010_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x207010_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死阿虎打   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x207010_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x207010_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x207010_g_MissionName)
		     AddText(sceneId,x207010_g_MissionComplete)
		     AddMoneyBonus(sceneId, x207010_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x207010_g_ScriptId, x207010_g_MissionId)
                end

        elseif x207010_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x207010_g_MissionName)
                AddText(sceneId,x207010_g_MissionInfo..GetName(sceneId, selfId)..x207010_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x207010_g_MissionTarget) 
		AddMoneyBonus(sceneId, x207010_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207010_g_ScriptId, x207010_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207010_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207010_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207010_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207010_g_ScriptId, x207010_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207010_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207010_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207010_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==7) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x207010_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x207010_g_MissionId, x207010_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x207010_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x207010_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207010_g_MissionId)
	for i, item in x207010_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x207010_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x207010_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x207010_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207010_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207010_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207010_g_MissionId)
		AddExp(sceneId, selfId, x207010_g_ExpBonus)
		AddMoney(sceneId, selfId, x207010_g_MoneyBonus)
		for i, item in x207010_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x207010_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x207010_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207010_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x207010_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x207010_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x207010_g_DemandKill[1].id then 
       		    if num < x207010_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死阿虎打   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x207010_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x207010_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207010_OnItemChanged(sceneId, selfId, itemdataId)

end

