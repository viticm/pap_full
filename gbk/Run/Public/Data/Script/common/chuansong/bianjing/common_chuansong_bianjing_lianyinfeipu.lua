--功能：中心传送
--NPC：中心传送使者

x300451_g_ScriptId = 300451
x300451_g_MissionName="练银飞瀑"
x300451_g_TransScriptId = 800019
x300451_g_TransPos="lianyinfeipu"

--**********************************

--任务入口函数

--**********************************

function x300451_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	CallScriptFunction(x300451_g_TransScriptId, "TransferToWorld",sceneId,selfId,x300451_g_TransPos)
end



--**********************************

--列举事件

--**********************************

function x300451_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x300451_g_ScriptId, x300451_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x300451_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x300451_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x300451_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x300451_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x300451_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x300451_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x300451_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x300451_OnItemChanged(sceneId, selfId, itemdataId)

end