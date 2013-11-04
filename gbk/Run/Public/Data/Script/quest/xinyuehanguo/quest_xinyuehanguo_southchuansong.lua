--功能：南门传送
--NPC：南门传送使者

x211032_g_ScriptId = 211032
x211032_g_MissionName="汗国广场"
--**********************************

--任务入口函数

--**********************************

function x211032_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	SetPos(sceneId, selfId,108,258)
end



--**********************************

--列举事件

--**********************************

function x211032_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x211032_g_ScriptId, x211032_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x211032_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x211032_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x211032_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211032_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211032_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211032_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211032_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211032_OnItemChanged(sceneId, selfId, itemdataId)

end