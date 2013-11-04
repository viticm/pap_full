--功能：国家税收任务
--NPC：大司马

--MisDescBegin
x211003_g_ScriptId = 211003

x211003_g_MissionName = "税收"
--MisDescEnd
--**********************************

--任务入口函数

--**********************************

function x211003_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	BeginEvent(sceneId)
		AddText(sceneId, "#Y税收")
		AddText(sceneId, "有了充足的税收，国家就可以发展科技，建设工程。但是过重的税收也会导致民怨，所以慎之慎之啊！")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end



--**********************************

--列举事件

--**********************************

function x211003_OnEnumerate(sceneId, selfId, targetId)
	AddNumText(sceneId, x211003_g_ScriptId, x211003_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x211003_CheckAccept(sceneId, selfId, targetId)

end



--**********************************

--接受

--**********************************

function x211003_OnAccept(sceneId, selfId)
    
end



--**********************************

--放弃

--**********************************

function x211003_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211003_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211003_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211003_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211003_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211003_OnItemChanged(sceneId, selfId, itemdataId)

end