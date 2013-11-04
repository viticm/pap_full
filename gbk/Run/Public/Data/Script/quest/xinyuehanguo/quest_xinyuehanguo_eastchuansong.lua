--功能：东门传送
--NPC：东门传送使者

x211028_g_ScriptId = 211028
x211028_g_MissionName="汗国广场"
--**********************************

--任务入口函数

--**********************************

function x211028_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	SetPos(sceneId, selfId,108,258)
end



--**********************************

--列举事件

--**********************************

function x211028_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x211028_g_ScriptId, x211028_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x211028_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x211028_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x211028_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211028_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211028_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211028_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211028_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211028_OnItemChanged(sceneId, selfId, itemdataId)

end