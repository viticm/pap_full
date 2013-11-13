--功能：杂货店
--NPC：杂货店老板

x211018_g_ScriptId = 211018
x211018_g_MissionName="杂货商店"
x211018_g_ShopList={2}
--**********************************

--任务入口函数

--**********************************

function x211018_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	DispatchShopItem( sceneId, selfId, targetId, x211018_g_ShopList[1] )
end



--**********************************

--列举事件

--**********************************

function x211018_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x211018_g_ScriptId, x211018_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x211018_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x211018_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x211018_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211018_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211018_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211018_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211018_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211018_OnItemChanged(sceneId, selfId, itemdataId)

end