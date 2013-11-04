--功能：新手村医生
--NPC：百夫长

x211042_g_ScriptId = 211042
x211042_g_MissionName="免费治疗"
--**********************************

--任务入口函数

--**********************************

function x211042_OnDefaultEvent(sceneId, selfId, targetId,stateIndex,extraIndex)	--点击该任务后执行此脚本
	if	stateIndex==9 and extraIndex==13 then
		SetPos(sceneId, selfId, 160,60)
		return
	elseif stateIndex==9 and extraIndex==14	then
		SetPos(sceneId, selfId, 77,51)
		return
	end
	
	BeginEvent(sceneId)
		AddText(sceneId, "#Y免费治疗")
		AddText(sceneId, "目前国家正处于不断发展阶段，我这里也相应号召，为大家免费治疗。现在你已经恢复健康了，去做你该做的事吧，不要荒废了光阴。")

		AddNumText(sceneId, x211042_g_ScriptId,"送我进去",9,13);
		AddNumText(sceneId, x211042_g_ScriptId,"送我去大理",9,14);
		
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
	
	--20100414 ModifyCodeBegin 加上了满血满魔不需要恢复的分支处理，改正了原代码满血满魔仍能恢复的错误
	--EndEvent(sceneId)
	--DispatchEventList(sceneId,selfId,targetId)	
	
	local mp = 0;
	local hp = 0;
	
	hp = RestoreHp(sceneId, selfId)
	mp = RestoreMp(sceneId, selfId)
	
	if( hp == 0 or mp == 0 ) then
	BeginEvent(sceneId)
		strText = "你全身恢复了健康"
		AddText(sceneId,strText);
	EndEvent(sceneId)
	else 
	BeginEvent(sceneId)
		strText = "你很健康，不需要恢复"
		AddText(sceneId,strText);
	EndEvent(sceneId)
	end
	DispatchMissionTips(sceneId,selfId)
	--20100414 ModifyCodeEnd
end



--**********************************

--列举事件

--**********************************

function x211042_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x211042_g_ScriptId, x211042_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x211042_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x211042_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x211042_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211042_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211042_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211042_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211042_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211042_OnItemChanged(sceneId, selfId, itemdataId)

end