--功能：中心传送
--NPC：中心传送使者

x300314_g_ScriptId = 300314
x300314_g_MissionName="前往古墓"

--**********************************

--任务入口函数

--**********************************

function x300314_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
		NewWorld(sceneId, selfId, 94, 30, 30);
end



--**********************************

--列举事件

--**********************************

function x300314_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x300314_g_ScriptId, x300314_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x300314_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x300314_OnAccept(sceneId, selfId)                                                             
	     
end



--**********************************

--放弃

--**********************************

function x300314_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x300314_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x300314_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x300314_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x300314_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x300314_OnItemChanged(sceneId, selfId, itemdataId)

end