--功能：中心医生
--NPC：中心医生

x211023_g_ScriptId = 211023
x211023_g_MissionName="免费治疗"
--**********************************

--任务入口函数

--**********************************

function x211023_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	BeginEvent(sceneId)
		AddText(sceneId, "#Y免费治疗")
		AddText(sceneId, "目前国家正处于不断发展阶段，我这里也相应号召，为大家免费治疗。现在你已经恢复健康了，去做你该做的事吧，不要荒废了光阴。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
	BeginEvent(sceneId)
		strText = "你全身恢复了健康"
		AddText(sceneId,strText);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	RestoreHp(sceneId, selfId)
	RestoreMp(sceneId, selfId)
end



--**********************************

--列举事件

--**********************************

function x211023_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x211023_g_ScriptId, x211023_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x211023_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x211023_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x211023_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211023_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211023_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211023_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211023_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211023_OnItemChanged(sceneId, selfId, itemdataId)

end