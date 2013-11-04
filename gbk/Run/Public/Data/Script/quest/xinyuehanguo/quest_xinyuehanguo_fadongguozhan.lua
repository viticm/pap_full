--功能：国家发动国战
--NPC：中军将军

--MisDescBegin
x211006_g_ScriptId = 211006

x211006_g_MissionName = "发动国战"
--MisDescEnd
--**********************************

--任务入口函数

--**********************************

function x211006_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	BeginEvent(sceneId)
		AddText(sceneId, "#Y发动国战")
		AddText(sceneId, "对于敌人，我们坚决不能示弱。保持国人的战斗热情，我国才能在战争中抢得先机。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end



--**********************************

--列举事件

--**********************************

function x211006_OnEnumerate(sceneId, selfId, targetId)
	AddNumText(sceneId, x211006_g_ScriptId, x211006_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x211006_CheckAccept(sceneId, selfId, targetId)

end



--**********************************

--接受

--**********************************

function x211006_OnAccept(sceneId, selfId)
    
end



--**********************************

--放弃

--**********************************

function x211006_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211006_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211006_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211006_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211006_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211006_OnItemChanged(sceneId, selfId, itemdataId)

end