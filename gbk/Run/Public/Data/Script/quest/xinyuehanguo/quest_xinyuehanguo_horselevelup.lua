--功能：骑乘强化功能
--NPC：骑乘强化大师

--MisDescBegin
x211027_g_ScriptId = 211027

x211027_g_MissionName = "骑乘繁殖"
--MisDescEnd
--**********************************

--任务入口函数

--**********************************

function x211027_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	BeginEvent(sceneId)
		AddText(sceneId, "#Y骑乘繁殖")
		AddText(sceneId, "良种马难得啊，当有了一匹好马，谁不希望可以用得更久呢。经过繁殖获得的新马驹，那是赤兔中的赤兔，吕布中的吕布啊！")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end



--**********************************

--列举事件

--**********************************

function x211027_OnEnumerate(sceneId, selfId, targetId)
	AddNumText(sceneId, x211027_g_ScriptId, x211027_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x211027_CheckAccept(sceneId, selfId, targetId)

end



--**********************************

--接受

--**********************************

function x211027_OnAccept(sceneId, selfId)
    
end



--**********************************

--放弃

--**********************************

function x211027_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211027_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211027_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211027_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211027_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211027_OnItemChanged(sceneId, selfId, itemdataId)

end