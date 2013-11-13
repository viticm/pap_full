--功能：中心传送
--NPC：中心传送使者

x300430_g_ScriptId = 300430
x300430_g_MissionName="勃兰登堡"
x300430_g_TransScriptId = 800019
x300430_g_TransPos="bolandengbao"

--**********************************

--任务入口函数

--**********************************

function x300430_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	CallScriptFunction(x300430_g_TransScriptId, "TransferToWorld",sceneId,selfId,x300430_g_TransPos)
end



--**********************************

--列举事件

--**********************************

function x300430_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x300430_g_ScriptId, x300430_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x300430_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x300430_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x300430_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x300430_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x300430_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x300430_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x300430_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x300430_OnItemChanged(sceneId, selfId, itemdataId)

end