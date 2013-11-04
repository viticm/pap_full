--功能：炼化装备

x500005_g_ScriptId = 500005
x500005_g_MissionName="炼化装备"
--**********************************

--任务入口函数

--**********************************

function x500005_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
--	DismantleSouXiaItem( sceneId, selfId, targetId)
end



--**********************************

--列举事件

--**********************************

function x500005_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x500005_g_ScriptId, x500005_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x500005_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x500005_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x500005_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x500005_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x500005_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x500005_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x500005_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x500005_OnItemChanged(sceneId, selfId, itemdataId)

end

