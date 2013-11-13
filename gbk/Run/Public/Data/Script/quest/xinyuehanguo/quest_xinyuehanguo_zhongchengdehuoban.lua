--功能：南门传送
--NPC：南门传送使者

x211049_g_ScriptId = 211049
x211049_g_MissionName="汗国广场"
--**********************************

--任务入口函数

--**********************************

function x211049_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	SetPos(sceneId, selfId,108,258)
end



--**********************************

--列举事件

--**********************************

function x211049_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x211049_g_ScriptId, x211049_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x211049_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x211049_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x211049_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211049_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211049_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211049_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211049_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211049_OnItemChanged(sceneId, selfId, itemdataId)

end