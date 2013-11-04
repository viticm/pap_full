--功能：中心传送
--NPC：中心传送使者

x300433_g_ScriptId = 300433
x300433_g_MissionName="王城"
x300433_g_TransScriptId = 800019
x300433_g_TransPos="wangchengsuluding"

--**********************************

--任务入口函数

--**********************************

function x300433_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	CallScriptFunction(x300433_g_TransScriptId, "TransferToWorld",sceneId,selfId,x300433_g_TransPos)
end



--**********************************

--列举事件

--**********************************

function x300433_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x300433_g_ScriptId, x300433_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x300433_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x300433_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x300433_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x300433_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x300433_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x300433_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x300433_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x300433_OnItemChanged(sceneId, selfId, itemdataId)

end