--功能：国家收集情报
--NPC：先锋将军

--MisDescBegin
x211005_g_ScriptId = 211005

x211005_g_MissionName = "收集情报"
--MisDescEnd
--**********************************

--任务入口函数

--**********************************

function x211005_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	BeginEvent(sceneId)
		AddText(sceneId, "#Y收集情报")
		AddText(sceneId, "两国交战，情报的收集工作尤为重要。情报人员虽然不在战场上冲锋陷阵杀敌，但是一条重要的情报，往往杀人无数于无形中。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end



--**********************************

--列举事件

--**********************************

function x211005_OnEnumerate(sceneId, selfId, targetId)
	AddNumText(sceneId, x211005_g_ScriptId, x211005_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x211005_CheckAccept(sceneId, selfId, targetId)

end



--**********************************

--接受

--**********************************

function x211005_OnAccept(sceneId, selfId)
    
end



--**********************************

--放弃

--**********************************

function x211005_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211005_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211005_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211005_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211005_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211005_OnItemChanged(sceneId, selfId, itemdataId)

end