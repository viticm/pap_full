--功能：首饰店
--NPC：首饰店老板

x211021_g_ScriptId = 211021
x211021_g_MissionName="首饰商店"
x211021_g_ShopList={5}
--**********************************

--任务入口函数

--**********************************

function x211021_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	DispatchShopItem( sceneId, selfId, targetId, x211021_g_ShopList[1] )
end



--**********************************

--列举事件

--**********************************

function x211021_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x211021_g_ScriptId, x211021_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x211021_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x211021_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x211021_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211021_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211021_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211021_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211021_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211021_OnItemChanged(sceneId, selfId, itemdataId)

end