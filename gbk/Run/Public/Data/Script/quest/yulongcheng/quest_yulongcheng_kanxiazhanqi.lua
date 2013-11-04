--砍下战旗

--MisDescBegin
x208001_g_ScriptId = 208001
--x208001_g_MissionIdPre =41
x208001_g_MissionId = 55
x208001_g_MissionKind = 12
x208001_g_MissionLevel = 60
--x208001_g_ScriptIdNext = {ScriptId = 205003 ,LV = 1 }
x208001_g_Name	="成吉思汗" 
x208001_g_Name2	="花剌子模战旗" 
x208001_g_DemandItem ={{id=13010011,num=1}}
--x208001_g_DemandKill ={{id=309,num=20}}

x208001_g_MissionName="砍下战旗"
x208001_g_MissionInfo="    花剌子模国藐视我大蒙古国，杀我派去的商团，夺我财物！长生天在上，我决意整顿军马，为被花剌子模过残害致死的450名商团手足报仇，上天若许我报仇，则助我一臂之力，命下界的所有神仙齐助我一战！\n \n    大草原的儿郎们，握紧你手中的马刀，带好你们的弓箭，喂饱你们的战马，向花剌子模国宣战！把他们的战旗给我砍下来！"  --任务描述
x208001_g_MissionTarget="    把东面#c0080C0花剌子模国的战旗#W（196，221）给砍下来，拿回去给#G成吉思汗#W。"		                                                                                               
x208001_g_MissionComplete="    今天，将是狂妄自大的魔诃魔、骄纵的花剌子模将士一生难忘的一天。"					--完成任务npc说话的话
x208001_g_ContinueInfo="    砍下他们的战旗，磨掉他们的骄纵和狂妄。"
--任务奖励
x208001_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x208001_g_ItemBonus={}

--可选物品奖励，最多8种
x208001_g_RadioItemBonus={}

--MisDescEnd
x208001_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x208001_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x208001_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x208001_g_MissionId) > 0 then
		if (GetName(sceneId,targetId)==x208001_g_Name) then 
			if x208001_CheckSubmit(sceneId, selfId, targetId) <= 0 then
	                        BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x208001_g_MissionName)
				AddText(sceneId,x208001_g_ContinueInfo)
			        AddText(sceneId,"#Y任务目标#W") 
				AddText(sceneId,x208001_g_MissionTarget) 
				AddText(sceneId,format("\n    花剌子模的战旗   %d/%d", LuaFnGetItemCount(sceneId,selfId,x208001_g_DemandItem[1].id),x208001_g_DemandItem[1].num ))
				EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
			end
	
			     
	                if x208001_CheckSubmit(sceneId, selfId, targetId) > 0 then
	                     BeginEvent(sceneId)
	                     AddText(sceneId,"#Y"..x208001_g_MissionName)
			     AddText(sceneId,x208001_g_MissionComplete)
			     --AddText(sceneId,"#Y需要物品#W") 
		     	     --for i, item in x208001_g_DemandItem do  
		     	     --AddItemBonus(sceneId, item.id, item.num)
		     	     --end
		     	     AddMoneyBonus(sceneId, x208001_g_MoneyBonus)
		     	     EndEvent()
	                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x208001_g_ScriptId, x208001_g_MissionId)
	                end
	        end
	        

        elseif x208001_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x208001_g_MissionName)
                AddText(sceneId,x208001_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x208001_g_MissionTarget) 
		AddMoneyBonus(sceneId, x208001_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x208001_g_ScriptId, x208001_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x208001_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x208001_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x208001_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x208001_g_ScriptId, x208001_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x208001_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x208001_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x208001_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==8) then
		    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x208001_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x208001_g_MissionId, x208001_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x208001_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x208001_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x208001_g_MissionId)
	for i, item in x208001_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x208001_CheckSubmit( sceneId, selfId, targetId)
	if LuaFnGetItemCount(sceneId,selfId,x208001_g_DemandItem[1].id) == x208001_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x208001_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x208001_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x208001_g_MissionId)
		AddExp(sceneId, selfId, x208001_g_ExpBonus)
		AddMoney(sceneId, selfId, x208001_g_MoneyBonus)
		for i, item in x208001_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x208001_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x208001_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x208001_OnKillObject(sceneId, selfId, objdataId)
	

end



--**********************************

--进入区域事件

--**********************************

function x208001_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x208001_OnItemChanged(sceneId, selfId, itemdataId)

end

