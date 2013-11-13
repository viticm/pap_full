--功能：武器店
--NPC：武器店老板

x211062_g_ScriptId = 211062
x211062_g_MissionName="骑乘商店二"
x211062_g_ShopList={12}
--**********************************

--任务入口函数

--**********************************

function x211062_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	DispatchShopItem( sceneId, selfId, targetId, x211062_g_ShopList[1] )
end



--**********************************

--列举事件

--**********************************

function x211062_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x211062_g_ScriptId, x211062_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x211062_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x211062_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x211062_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211062_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211062_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211062_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211062_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211062_OnItemChanged(sceneId, selfId, itemdataId)

end