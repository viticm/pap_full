--功能：骑乘商店
--NPC：骑乘店老板

--MisDescBegin
x211025_g_ScriptId = 211025

x211025_g_MissionName = "骑乘商店"
--MisDescEnd
--**********************************

--任务入口函数

--**********************************

function x211025_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	DispatchShopItem( sceneId, selfId, targetId, 7 )
end



--**********************************

--列举事件

--**********************************

function x211025_OnEnumerate(sceneId, selfId, targetId)
	AddNumText(sceneId, x211025_g_ScriptId, x211025_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x211025_CheckAccept(sceneId, selfId, targetId)

end



--**********************************

--接受

--**********************************

function x211025_OnAccept(sceneId, selfId)
    
end



--**********************************

--放弃

--**********************************

function x211025_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211025_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211025_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211025_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211025_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211025_OnItemChanged(sceneId, selfId, itemdataId)

end