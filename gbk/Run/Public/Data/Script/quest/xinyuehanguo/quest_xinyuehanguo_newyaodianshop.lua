--功能：新手村药店
--NPC：新手村药店医生

x211041_g_ScriptId = 211041
x211041_g_MissionName="杂货商店"
x211041_g_ShopList={17}
--**********************************

--任务入口函数

--**********************************

function x211041_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	DispatchShopItem( sceneId, selfId, targetId, x211041_g_ShopList[1] )
end



--**********************************

--列举事件

--**********************************

function x211041_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x211041_g_ScriptId, x211041_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x211041_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x211041_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x211041_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211041_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211041_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211041_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211041_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211041_OnItemChanged(sceneId, selfId, itemdataId)

end