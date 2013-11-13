--功能：中心传送
--NPC：中心传送使者

x300440_g_ScriptId = 300440
x300440_g_MissionName="安宁村"
x300440_g_TransScriptId = 800019
x300440_g_TransPos="anningcun"

--**********************************

--任务入口函数

--**********************************

function x300440_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	CallScriptFunction(x300440_g_TransScriptId, "TransferToWorld",sceneId,selfId,x300440_g_TransPos)
end



--**********************************

--列举事件

--**********************************

function x300440_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x300440_g_ScriptId, x300440_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x300440_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x300440_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x300440_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x300440_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x300440_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x300440_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x300440_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x300440_OnItemChanged(sceneId, selfId, itemdataId)

end