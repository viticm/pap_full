--功能：领双相关
--NPC：御林军统领

--MisDescBegin
x211034_g_ScriptId = 211034

--MisDescEnd
--**********************************

--任务入口函数

--**********************************

function x211034_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	--BeginEvent(sceneId)
	--	AddText(sceneId, "你领取了#G一小时#W的双倍经验时间，快去历练吧，提高自己，超越自己！")
	--EndEvent(sceneId)
	--DispatchEventList(sceneId,selfId,targetId)
	--
	--BeginEvent(sceneId)
	--	AddText(sceneId, "你领取了一小时双倍经验时间")
	--EndEvent(sceneId)
	--DispatchMissionTips(sceneId,selfId)
end



--**********************************

--列举事件

--**********************************

function x211034_OnEnumerate(sceneId, selfId, targetId)
	AddNumText(sceneId, 211034, "一小时")
end

--**********************************

--检测接受条件

--**********************************

function x211034_CheckAccept(sceneId, selfId, targetId)
end


--**********************************

--接受

--**********************************

function x211034_OnAccept(sceneId, selfId)
end



--**********************************

--放弃

--**********************************

function x211034_OnAbandon(sceneId, selfId)
end



--**********************************

--检测是否可以提交

--**********************************

function x211034_CheckSubmit( sceneId, selfId, targetId)
end



--**********************************

--提交

--**********************************

function x211034_OnSubmit(sceneId, selfId, targetId, selectRadioId)
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211034_OnKillObject(sceneId, selfId, objdataId)
end



--**********************************

--进入区域事件

--**********************************

function x211034_OnEnterArea(sceneId, selfId, zoneId)
end



--**********************************

--道具改变

--**********************************

function x211034_OnItemChanged(sceneId, selfId, itemdataId)
end