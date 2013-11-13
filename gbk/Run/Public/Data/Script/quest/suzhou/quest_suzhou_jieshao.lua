
x199999_g_ScriptId = 199999
x199999_g_MissionName="门派简介"
--**********************************

--任务入口函数

--*********************************
function x199999_OnDefaultEvent(sceneId, selfId, targetId)
	BeginEvent(sceneId)
		AddText(sceneId, "#Y门派简介")
		AddText(sceneId,  "#{quest_ditaohua}")
		AddText(sceneId,  "#{quest_yintaohua}")		
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************

--列举事件

--**********************************

function x199999_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x199999_g_ScriptId, x199999_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x199999_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x199999_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x199999_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x199999_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x199999_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x199999_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x199999_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x199999_OnItemChanged(sceneId, selfId, itemdataId)

end