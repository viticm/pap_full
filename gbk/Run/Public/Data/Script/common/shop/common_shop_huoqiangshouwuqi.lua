--功能：火枪手武器商店

x300325_g_ScriptId = 300325
x300325_g_MissionName="火枪手武器商店"
x300325_g_ShopList={250}
--**********************************

--任务入口函数

--**********************************

function x300325_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	DispatchShopItem( sceneId, selfId, targetId, x300325_g_ShopList[1] )
end



--**********************************

--列举事件

--**********************************

function x300325_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x300325_g_ScriptId, x300325_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x300325_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x300325_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x300325_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x300325_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x300325_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x300325_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x300325_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x300325_OnItemChanged(sceneId, selfId, itemdataId)

end