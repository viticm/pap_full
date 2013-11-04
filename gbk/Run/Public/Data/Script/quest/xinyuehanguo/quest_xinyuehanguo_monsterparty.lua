--功能：怪兽总动员
--NPC：新月汗国 哈伦

x211013_g_ScriptId = 211013
x211013_g_MissionName="怪兽总动员"

--**********************************

--任务入口函数

--**********************************

function x211013_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	BeginEvent(sceneId)
		AddText(sceneId, "#Y怪兽总动员")
		AddText(sceneId, "最近国内豪门流行招揽门客，我手底下也有不少来自各地的人才，你可敢与他们较量较量，我也正好看看他们是不是有真本事。文斗武斗，你来选。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end



--**********************************

--列举事件

--**********************************

function x211013_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x211013_g_ScriptId, x211013_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x211013_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x211013_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x211013_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211013_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211013_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211013_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211013_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211013_OnItemChanged(sceneId, selfId, itemdataId)

end