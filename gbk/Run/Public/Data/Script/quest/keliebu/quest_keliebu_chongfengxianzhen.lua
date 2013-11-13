--冲锋陷阵

--MisDescBegin
x202005_g_ScriptId = 202005
x202005_g_MissionIdPre =123
x202005_g_MissionId = 124
x202005_g_MissionKind = 4
x202005_g_MissionLevel = 20
x202005_g_ScriptIdNext = {ScriptId = 202006 ,LV = 1 }
x202005_g_Name	="术赤"
x202005_g_DemandItem ={}
x202005_g_DemandKill ={{id=371,num=10}}

x202005_g_MissionName="冲锋陷阵"
x202005_g_MissionInfo="    作为草原的勇士，长生天庇护的战士，我们从来不吝啬弓箭！桑昆的狂妄，王汗的无情，一定会付出代价！\n \n    我们的战士从来都不畏惧他们人多，真正的英雄是来自地狱和战火的！冲杀吧，让冰冷的刀锋砍进他们的骨头！让弓箭射穿他们的心脏，让我们的火枪打爆他们的头颅！\n \n    "  --任务描述
x202005_g_MissionInfo2="，长生天已经赐给你健壮的身体和矫健的身手，给了你智慧和胆量，现在，跟我一起，杀到黑林去，把克烈部那些#R邪恶的巫师#W给杀死，为大军开路。"
x202005_g_MissionTarget="    带着你的怒火，到黑林去杀死10名#R邪恶的巫师#W，然后向#G术赤#W复命。"		                                                                                               
x202005_g_MissionComplete="    世界终于安静了。"					--完成任务npc说话的话
x202005_g_ContinueInfo="    请到黑林去，那里需要你。"
--任务奖励
x202005_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x202005_g_ItemBonus={}

--可选物品奖励，最多8种
x202005_g_RadioItemBonus={}

--MisDescEnd
x202005_g_ExpBonus = 6500
--**********************************

--任务入口函数

--**********************************

function x202005_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x202005_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x202005_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x202005_g_MissionId)
		if x202005_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x202005_g_MissionName)
			AddText(sceneId,x202005_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x202005_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死邪恶的巫师   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x202005_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x202005_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x202005_g_MissionName)
		     AddText(sceneId,x202005_g_MissionComplete)
		     AddMoneyBonus(sceneId, x202005_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x202005_g_ScriptId, x202005_g_MissionId)
                end

        elseif x202005_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x202005_g_MissionName)
                AddText(sceneId,x202005_g_MissionInfo..GetName(sceneId, selfId)..x202005_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x202005_g_MissionTarget) 
		AddMoneyBonus(sceneId, x202005_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x202005_g_ScriptId, x202005_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x202005_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x202005_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x202005_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x202005_g_ScriptId, x202005_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x202005_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x202005_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x202005_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==2) then
		if IsMissionHaveDone(sceneId, selfId, x202005_g_MissionIdPre) > 0 then
					return 1
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x202005_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x202005_g_MissionId, x202005_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x202005_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x202005_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x202005_g_MissionId)
	for i, item in pairs(x202005_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x202005_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x202005_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x202005_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x202005_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x202005_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x202005_g_MissionId)
		AddExp(sceneId, selfId, x202005_g_ExpBonus)
		AddMoney(sceneId, selfId, x202005_g_MoneyBonus)
		for i, item in pairs(x202005_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x202005_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x202005_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x202005_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x202005_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x202005_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x202005_g_DemandKill[1].id then 
       		    if num < x202005_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死邪恶的巫师   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x202005_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x202005_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x202005_OnItemChanged(sceneId, selfId, itemdataId)

end

