--功能：药店
--NPC：药店老板

x211024_g_ScriptId = 211024
x211024_g_MissionName="药品商店"
x211024_g_ShopList={1}
--**********************************

--任务入口函数

--**********************************

function x211024_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	DispatchShopItem( sceneId, selfId, targetId, x211024_g_ShopList[1] )
end



--**********************************

--列举事件

--**********************************

function x211024_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x211024_g_ScriptId, x211024_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x211024_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x211024_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x211024_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211024_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211024_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211024_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211024_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211024_OnItemChanged(sceneId, selfId, itemdataId)

end