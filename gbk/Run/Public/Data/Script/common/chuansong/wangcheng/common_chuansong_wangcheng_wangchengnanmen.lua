--功能：中心传送
--NPC：中心传送使者

x300424_g_ScriptId = 300424
x300424_g_MissionName="王城南门"
x300424_g_TransScriptId = 800019
x300424_g_TransPos="wangchengnanmen"

--**********************************

--任务入口函数

--**********************************

function x300424_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	CallScriptFunction(x300424_g_TransScriptId, "TransferToWorld",sceneId,selfId,x300424_g_TransPos)
end



--**********************************

--列举事件

--**********************************

function x300424_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x300424_g_ScriptId, x300424_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x300424_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x300424_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x300424_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x300424_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x300424_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x300424_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x300424_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x300424_OnItemChanged(sceneId, selfId, itemdataId)

end