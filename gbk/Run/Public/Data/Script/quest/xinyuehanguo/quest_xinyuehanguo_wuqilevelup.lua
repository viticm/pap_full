--功能：武器强化功能
--NPC：武器强化大师

--MisDescBegin
x211026_g_ScriptId = 211026

x211026_g_MissionName = "强化材料商店"

x211026_g_ShopList ={6}
--MisDescEnd
--**********************************

--任务入口函数

--**********************************

function x211026_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	DispatchShopItem( sceneId, selfId, targetId, x211026_g_ShopList[1] )
end



--**********************************

--列举事件

--**********************************

function x211026_OnEnumerate(sceneId, selfId, targetId)
	AddNumText(sceneId, x211026_g_ScriptId, x211026_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x211026_CheckAccept(sceneId, selfId, targetId)

end



--**********************************

--接受

--**********************************

function x211026_OnAccept(sceneId, selfId)
    
end



--**********************************

--放弃

--**********************************

function x211026_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211026_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211026_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211026_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211026_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211026_OnItemChanged(sceneId, selfId, itemdataId)

end