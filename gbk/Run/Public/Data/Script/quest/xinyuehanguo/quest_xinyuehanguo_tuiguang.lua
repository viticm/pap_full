--功能：推广员
--NPC：新月汗国 推广员

x211016_g_ScriptId = 211016
x211016_g_MissionName="推广员系统"

--**********************************

--任务入口函数

--**********************************

function x211016_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	BeginEvent(sceneId)
		AddText(sceneId, "#Y推广员系统")
		AddText(sceneId, "只要你能邀请更多的人加入到游戏里来，国家都将给予你相当的奖励。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end



--**********************************

--列举事件

--**********************************

function x211016_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x211016_g_ScriptId, x211016_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x211016_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x211016_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x211016_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211016_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211016_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211016_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211016_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211016_OnItemChanged(sceneId, selfId, itemdataId)

end