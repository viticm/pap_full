--功能：PK阵营
--NPC：新月汗国 苏菲

x211038_g_ScriptId = 211038
x211038_g_MissionName="擂台比武"

--**********************************

--任务入口函数

--**********************************

function x211038_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	BeginEvent(sceneId)
		AddText(sceneId, "#YPK阵营")
		AddText(sceneId, "你现在已经是PK阵营了，找些高手来挑战挑战，看看自己的势力到底如何！")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
	BeginEvent(sceneId)
		strText = "你变换为PK阵营"
		AddText(sceneId,strText);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	SetCurCamp(sceneId, selfId, 4)
end



--**********************************

--列举事件

--**********************************

function x211038_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x211038_g_ScriptId, "PK阵营")
end



--**********************************

--检测接受条件

--**********************************

function x211038_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x211038_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x211038_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211038_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211038_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211038_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211038_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211038_OnItemChanged(sceneId, selfId, itemdataId)

end