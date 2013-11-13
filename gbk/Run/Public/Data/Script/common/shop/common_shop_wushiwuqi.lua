--功能：武器商店

x300322_g_ScriptId = 300322
x300322_g_MissionName="武器商店"
x300322_g_ShopList={100}
--**********************************

--任务入口函数

--**********************************

function x300322_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	DispatchShopItem( sceneId, selfId, targetId, x300322_g_ShopList[1] )
end



--**********************************

--列举事件

--**********************************

function x300322_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x300322_g_ScriptId, x300322_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x300322_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x300322_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x300322_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x300322_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x300322_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x300322_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x300322_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x300322_OnItemChanged(sceneId, selfId, itemdataId)

end