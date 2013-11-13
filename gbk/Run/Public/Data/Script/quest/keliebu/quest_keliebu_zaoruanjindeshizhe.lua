--遭软禁的使者

--MisDescBegin
x202004_g_ScriptId = 202004
--x202004_g_MissionIdPre =41
x202004_g_MissionId = 123
x202004_g_MissionKind = 4
x202004_g_MissionLevel = 20
x202004_g_ScriptIdNext = {ScriptId = 202005 ,LV = 1 }
x202004_g_Name	="术赤" 
x202004_g_DemandItem ={}
x202004_g_DemandKill ={{id=370,num=15}}

x202004_g_MissionName="遭软禁的使者"
x202004_g_MissionInfo="    两名使者去了克烈部已经三天了，现在还没有回来，难道真的应了父汗的话，这是个鸿门宴？    "  --任务描述
x202004_g_MissionInfo2="，我们不能不管这两名使者，他们是为了我的亲事而去的，刚刚有消息传来，克烈部的桑昆把他们软禁在合阑湖东面的营地，我想请你走一趟，你只需帮我把那15名#R克烈部红衣守卫#W给杀了。"
x202004_g_MissionTarget="    合阑湖东面的营地是软禁使者的地方，#G术赤#W要你帮忙杀死15名#R克烈部红衣守卫#W。"		                                                                                               
x202004_g_MissionComplete="    我们已经救出了使者。"					--完成任务npc说话的话
x202004_g_ContinueInfo="    杀死那些守卫了吗？"
--任务奖励
x202004_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x202004_g_ItemBonus={}

--可选物品奖励，最多8种
x202004_g_RadioItemBonus={}

--MisDescEnd
x202004_g_ExpBonus = 6500
--**********************************

--任务入口函数

--**********************************

function x202004_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x202004_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x202004_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x202004_g_MissionId)
		if x202004_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x202004_g_MissionName)
			AddText(sceneId,x202004_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x202004_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死克烈部红衣守卫   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x202004_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x202004_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x202004_g_MissionName)
		     AddText(sceneId,x202004_g_MissionComplete)
		     AddMoneyBonus(sceneId, x202004_g_MoneyBonus)
                     EndEvent()
		     DispatchMissionContinueInfo(sceneId, selfId, targetId, x202004_g_ScriptId, x202004_g_MissionId)
                end

        elseif x202004_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x202004_g_MissionName)
                AddText(sceneId,x202004_g_MissionInfo..GetName(sceneId, selfId)..x202004_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x202004_g_MissionTarget) 
		AddMoneyBonus(sceneId, x202004_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x202004_g_ScriptId, x202004_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x202004_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x202004_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x202004_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x202004_g_ScriptId, x202004_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x202004_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x202004_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x202004_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==2) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x202004_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x202004_g_MissionId, x202004_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x202004_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x202004_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x202004_g_MissionId)
	for i, item in pairs(x202004_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x202004_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x202004_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x202004_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x202004_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x202004_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x202004_g_MissionId)
		AddExp(sceneId, selfId, x202004_g_ExpBonus)
		AddMoney(sceneId, selfId, x202004_g_MoneyBonus)
		for i, item in pairs(x202004_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x202004_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x202004_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x202004_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x202004_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x202004_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x202004_g_DemandKill[1].id then 
       		    if num < x202004_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死克烈部红衣守卫   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x202004_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x202004_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x202004_OnItemChanged(sceneId, selfId, itemdataId)

end

