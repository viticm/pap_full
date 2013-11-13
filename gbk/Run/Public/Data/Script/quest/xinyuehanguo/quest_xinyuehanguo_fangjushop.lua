--功能：防具店
--NPC：防具店老板

x211020_g_ScriptId = 211020
x211020_g_MissionName="防具商店"
x211020_g_ShopList={4}
--**********************************

--任务入口函数

--**********************************

function x211020_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	DispatchShopItem( sceneId, selfId, targetId, x211020_g_ShopList[1] )
end



--**********************************

--列举事件

--**********************************

function x211020_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x211020_g_ScriptId, x211020_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x211020_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x211020_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x211020_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211020_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211020_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211020_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211020_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211020_OnItemChanged(sceneId, selfId, itemdataId)

end