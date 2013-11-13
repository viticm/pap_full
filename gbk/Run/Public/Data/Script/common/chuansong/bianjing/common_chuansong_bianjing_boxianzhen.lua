--功能：中心传送
--NPC：中心传送使者

x300434_g_ScriptId = 300434
x300434_g_MissionName="播仙镇"
x300434_g_TransScriptId = 800019
x300434_g_TransPos="boxianzhen"

--**********************************

--任务入口函数

--**********************************

function x300434_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	CallScriptFunction(x300434_g_TransScriptId, "TransferToWorld",sceneId,selfId,x300434_g_TransPos)
end



--**********************************

--列举事件

--**********************************

function x300434_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x300434_g_ScriptId, x300434_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x300434_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x300434_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x300434_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x300434_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x300434_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x300434_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x300434_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x300434_OnItemChanged(sceneId, selfId, itemdataId)

end