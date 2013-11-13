--功能：炼化装备

x500011_g_ScriptId = 500011
x500011_g_MissionName="装备退魔"
--**********************************

--任务入口函数

--**********************************

function x500011_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
--	DismantleSouXiaItem( sceneId, selfId, targetId)
end



--**********************************

--列举事件

--**********************************

function x500011_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x500011_g_ScriptId, x500011_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x500011_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x500011_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x500011_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x500011_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x500011_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x500011_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x500011_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x500011_OnItemChanged(sceneId, selfId, itemdataId)

end

