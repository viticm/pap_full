--功能：肩甲商店

x300330_g_ScriptId = 300330
x300330_g_MissionName="肩甲商店"
x300330_g_ShopList={500}
--**********************************

--任务入口函数

--**********************************

function x300330_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	DispatchShopItem( sceneId, selfId, targetId, x300330_g_ShopList[1] )
end



--**********************************

--列举事件

--**********************************

function x300330_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x300330_g_ScriptId, x300330_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x300330_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x300330_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x300330_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x300330_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x300330_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x300330_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x300330_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x300330_OnItemChanged(sceneId, selfId, itemdataId)

end