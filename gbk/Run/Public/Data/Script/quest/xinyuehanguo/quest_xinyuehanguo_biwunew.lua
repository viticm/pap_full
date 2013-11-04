--功能：新手阵营
--NPC：新月汗国 苏菲

x211039_g_ScriptId = 211039
x211039_g_MissionName="擂台比武"

--**********************************

--任务入口函数

--**********************************

function x211039_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	BeginEvent(sceneId)
		AddText(sceneId, "#Y新手阵营")
		AddText(sceneId, "你恢复了新手阵营，这样别人就没法找你的茬了！")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
	BeginEvent(sceneId)
		strText = "你变换为新手阵营"
		AddText(sceneId,strText);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	SetCurCamp(sceneId, selfId, 0)
end



--**********************************

--列举事件

--**********************************

function x211039_OnEnumerate(sceneId, selfId, targetId)
	AddNumText(sceneId, x211039_g_ScriptId, "新手阵营")
end



--**********************************

--检测接受条件

--**********************************

function x211039_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x211039_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x211039_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211039_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211039_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211039_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211039_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211039_OnItemChanged(sceneId, selfId, itemdataId)

end