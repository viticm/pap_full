--功能：项链商店

x300329_g_ScriptId = 300329
x300329_g_MissionName="项链商店"
x300329_g_ShopList={450}
--**********************************

--任务入口函数

--**********************************

function x300329_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	DispatchShopItem( sceneId, selfId, targetId, x300329_g_ShopList[1] )
end



--**********************************

--列举事件

--**********************************

function x300329_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x300329_g_ScriptId, x300329_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x300329_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x300329_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x300329_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x300329_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x300329_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x300329_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x300329_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x300329_OnItemChanged(sceneId, selfId, itemdataId)

end