--功能：国家发展商店
--NPC：大司马

--MisDescBegin
x211036_g_ScriptId = 211036

x211036_g_MissionName = "国家发展商店"
x211036_g_ShopList = {1}
--MisDescEnd
--**********************************

--任务入口函数

--**********************************

function x211036_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	BeginEvent(sceneId)
		AddText(sceneId, "#Y国家发展商店")
		AddText(sceneId, "为了鼓励大家多为国家做贡献，国王让我去采购了很多好东西以奖励给对国有功之人。现在物品还没有采购完，一旦对外开放我会及时通知大家前来，按功分配！现在你还是先去多积累些功劳才是！\n我这里只奖励对#G国家建设#W的有功之人。对国防有功的人应该去找对面的中军将军。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
	--DispatchShopItem( sceneId, selfId, targetId, x211036_g_ShopList[1] )
end



--**********************************

--列举事件

--**********************************

function x211036_OnEnumerate(sceneId, selfId, targetId)
	AddNumText(sceneId, x211036_g_ScriptId, x211036_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x211036_CheckAccept(sceneId, selfId, targetId)

end



--**********************************

--接受

--**********************************

function x211036_OnAccept(sceneId, selfId)
    
end



--**********************************

--放弃

--**********************************

function x211036_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211036_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211036_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211036_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211036_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211036_OnItemChanged(sceneId, selfId, itemdataId)

end