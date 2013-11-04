--功能：中心传送
--NPC：中心传送使者

x300445_g_ScriptId = 300445
x300445_g_MissionName="连城寨"
x300445_g_TransScriptId = 800019
x300445_g_TransPos="lianchengzhai"

--**********************************

--任务入口函数

--**********************************

function x300445_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	CallScriptFunction(x300445_g_TransScriptId, "TransferToWorld",sceneId,selfId,x300445_g_TransPos)
end



--**********************************

--列举事件

--**********************************

function x300445_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x300445_g_ScriptId, x300445_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x300445_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x300445_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x300445_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x300445_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x300445_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x300445_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x300445_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x300445_OnItemChanged(sceneId, selfId, itemdataId)

end