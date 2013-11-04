--功能：中心传送
--NPC：中心传送使者

x300422_g_ScriptId = 300422
x300422_g_MissionName="大都"
x300422_g_TransScriptId = 800019
x300422_g_TransPos="dadusuluding"

--**********************************

--任务入口函数

--**********************************

function x300422_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	CallScriptFunction(x300422_g_TransScriptId, "TransferToWorld",sceneId,selfId,x300422_g_TransPos)
end



--**********************************

--列举事件

--**********************************

function x300422_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x300422_g_ScriptId, x300422_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x300422_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x300422_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x300422_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x300422_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x300422_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x300422_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x300422_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x300422_OnItemChanged(sceneId, selfId, itemdataId)

end