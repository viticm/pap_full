--功能：普通医生


x300411_g_ScriptId = 300411
x300411_g_MissionName="免费治疗"
--**********************************

--任务入口函数

--**********************************

function x300411_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	BeginEvent(sceneId)
		AddText(sceneId, "好了，以后再去冒险的时候，记得要时刻注意自己的安危。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
	
	local hp = 0;
	local mp = 0;
	
	hp = RestoreHp(sceneId, selfId)
	local MenPai= GetMenPai( sceneId, playerId)
	if MenPai~=0 then
		mp = RestoreMp(sceneId, selfId)
	end
	
	if( hp == 0 or mp == 0 ) then 
		strText = "你全身恢复了健康"
	else
		strText = "你很健康，不需要恢复"
	end
	
		BeginEvent(sceneId)
		AddText(sceneId,strText);
		EndEvent(sceneId)	
		DispatchMissionTips(sceneId,selfId)
	
end



--**********************************

--列举事件

--**********************************

function x300411_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x300411_g_ScriptId, x300411_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x300411_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x300411_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x300411_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x300411_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x300411_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x300411_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x300411_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x300411_OnItemChanged(sceneId, selfId, itemdataId)

end