--功能：中心传送
--NPC：中心传送使者

x300448_g_ScriptId = 300448
x300448_g_MissionName="追思台"
x300448_g_TransScriptId = 800019
x300448_g_TransPos="zhuisitai"

--**********************************

--任务入口函数

--**********************************

function x300448_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	CallScriptFunction(x300448_g_TransScriptId, "TransferToWorld",sceneId,selfId,x300448_g_TransPos)
end



--**********************************

--列举事件

--**********************************

function x300448_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x300448_g_ScriptId, x300448_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x300448_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x300448_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x300448_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x300448_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x300448_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x300448_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x300448_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x300448_OnItemChanged(sceneId, selfId, itemdataId)

end