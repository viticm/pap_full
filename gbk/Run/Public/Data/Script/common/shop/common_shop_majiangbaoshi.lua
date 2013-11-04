--功能：麻将相关宝石商店

x300346_g_ScriptId = 300346
x300346_g_MissionName="麻将相关宝石"
x300346_g_ShopList={1101}
--**********************************

--任务入口函数

--**********************************

function x300346_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	DispatchShopItem( sceneId, selfId, targetId, x300346_g_ShopList[1] )
end



--**********************************

--列举事件

--**********************************

function x300346_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x300346_g_ScriptId, x300346_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x300346_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x300346_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x300346_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x300346_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x300346_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x300346_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x300346_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x300346_OnItemChanged(sceneId, selfId, itemdataId)

end