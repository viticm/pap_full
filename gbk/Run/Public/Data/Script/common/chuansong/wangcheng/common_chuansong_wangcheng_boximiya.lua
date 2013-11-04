--功能：中心传送
--NPC：中心传送使者

x300429_g_ScriptId = 300429
x300429_g_MissionName="波西米亚"
x300429_g_TransScriptId = 800019
x300429_g_TransPos="boximiya"

--**********************************

--任务入口函数

--**********************************

function x300429_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	CallScriptFunction(x300429_g_TransScriptId, "TransferToWorld",sceneId,selfId,x300429_g_TransPos)
end



--**********************************

--列举事件

--**********************************

function x300429_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x300429_g_ScriptId, x300429_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x300429_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x300429_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x300429_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x300429_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x300429_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x300429_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x300429_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x300429_OnItemChanged(sceneId, selfId, itemdataId)

end