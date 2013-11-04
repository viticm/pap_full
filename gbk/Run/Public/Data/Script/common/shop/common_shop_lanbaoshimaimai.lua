--功能：兰宝石商店

x300343_g_ScriptId = 300343
x300343_g_MissionName="兰宝石商店"
x300343_g_ShopList={1004}
--**********************************

--任务入口函数

--**********************************

function x300343_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	DispatchShopItem( sceneId, selfId, targetId, x300343_g_ShopList[1] )
end



--**********************************

--列举事件

--**********************************

function x300343_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x300343_g_ScriptId, x300343_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x300343_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x300343_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x300343_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x300343_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x300343_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x300343_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x300343_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x300343_OnItemChanged(sceneId, selfId, itemdataId)

end