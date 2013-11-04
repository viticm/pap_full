--功能：北门传送
--NPC：北门传送使者

x211030_g_ScriptId = 211030
x211030_g_MissionName="汗国广场"
--**********************************

--任务入口函数

--**********************************

function x211030_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	SetPos(sceneId, selfId,108,258)
end



--**********************************

--列举事件

--**********************************

function x211030_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x211030_g_ScriptId, x211030_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x211030_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x211030_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x211030_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211030_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211030_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211030_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211030_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211030_OnItemChanged(sceneId, selfId, itemdataId)

end