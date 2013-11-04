--功能：中心传送
--NPC：中心传送使者

x300428_g_ScriptId = 300428
x300428_g_MissionName="苏格兰场"
x300428_g_TransScriptId = 800019
x300428_g_TransPos="sugelanchang"

--**********************************

--任务入口函数

--**********************************

function x300428_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	CallScriptFunction(x300428_g_TransScriptId, "TransferToWorld",sceneId,selfId,x300428_g_TransPos)
end



--**********************************

--列举事件

--**********************************

function x300428_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x300428_g_ScriptId, x300428_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x300428_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x300428_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x300428_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x300428_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x300428_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x300428_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x300428_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x300428_OnItemChanged(sceneId, selfId, itemdataId)

end