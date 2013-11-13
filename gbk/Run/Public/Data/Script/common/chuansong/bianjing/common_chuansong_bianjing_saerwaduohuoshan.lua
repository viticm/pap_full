--功能：中心传送
--NPC：中心传送使者

x300446_g_ScriptId = 300446
x300446_g_MissionName="萨尔瓦多火山"
x300446_g_TransScriptId = 800019
x300446_g_TransPos="saerwaduohuoshan"

--**********************************

--任务入口函数

--**********************************

function x300446_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	CallScriptFunction(x300446_g_TransScriptId, "TransferToWorld",sceneId,selfId,x300446_g_TransPos)
end



--**********************************

--列举事件

--**********************************

function x300446_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x300446_g_ScriptId, x300446_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x300446_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x300446_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x300446_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x300446_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x300446_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x300446_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x300446_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x300446_OnItemChanged(sceneId, selfId, itemdataId)

end