--功能：销毁捜侠录

x500004_g_ScriptId = 500004
x500004_g_MissionName="销毁捜侠录"
--**********************************

--任务入口函数

--**********************************

function x500004_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
--	DestroySouXiaItem( sceneId, selfId, targetId)
end



--**********************************

--列举事件

--**********************************

function x500004_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x500004_g_ScriptId, x500004_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x500004_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x500004_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x500004_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x500004_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x500004_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x500004_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x500004_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x500004_OnItemChanged(sceneId, selfId, itemdataId)

end
