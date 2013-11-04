--功能：中心传送
--NPC：中心传送使者

x300449_g_ScriptId = 300449
x300449_g_MissionName="醉花桃林"
x300449_g_TransScriptId = 800019
x300449_g_TransPos="zuihuataolin"

--**********************************

--任务入口函数

--**********************************

function x300449_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	CallScriptFunction(x300449_g_TransScriptId, "TransferToWorld",sceneId,selfId,x300449_g_TransPos)
end



--**********************************

--列举事件

--**********************************

function x300449_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x300449_g_ScriptId, x300449_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x300449_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x300449_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x300449_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x300449_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x300449_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x300449_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x300449_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x300449_OnItemChanged(sceneId, selfId, itemdataId)

end