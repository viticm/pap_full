--功能：国家建设工程
--NPC：大司空

--MisDescBegin
x211004_g_ScriptId = 211004

x211004_g_MissionName = "建设工程"
--MisDescEnd
--**********************************

--任务入口函数

--**********************************

function x211004_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	BeginEvent(sceneId)
		AddText(sceneId, "#Y建设工程")
		AddText(sceneId, "国家基础建设跟上了，国民的生活质量才有提高。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end



--**********************************

--列举事件

--**********************************

function x211004_OnEnumerate(sceneId, selfId, targetId)
	AddNumText(sceneId, x211004_g_ScriptId, x211004_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x211004_CheckAccept(sceneId, selfId, targetId)

end



--**********************************

--接受

--**********************************

function x211004_OnAccept(sceneId, selfId)
    
end



--**********************************

--放弃

--**********************************

function x211004_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211004_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211004_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211004_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211004_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211004_OnItemChanged(sceneId, selfId, itemdataId)

end