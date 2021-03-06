--功能：领双相关
--NPC：御林军统领

--MisDescBegin
x211001_g_ScriptId = 211001
x211001_g_EventList={211034}

--MisDescEnd
--**********************************

--任务入口函数

--**********************************

function x211001_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	BeginEvent(sceneId)
		AddText(sceneId,"现在王城军队还在整编，等整编结束后，将给我新月汗国的勇士安排更多的双倍修炼时间。你可要注意我们的征兵告示了。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)	
end



--**********************************

--列举事件

--**********************************

function x211001_OnEnumerate(sceneId, selfId, targetId)
	AddNumText(sceneId, x211001_g_ScriptId, "领取双倍时间")
end

--**********************************

--检测接受条件

--**********************************

function x211001_CheckAccept(sceneId, selfId, targetId)

end


--**********************************

--接受

--**********************************

function x211001_OnAccept(sceneId, selfId)

end



--**********************************

--放弃

--**********************************

function x211001_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211001_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211001_OnSubmit(sceneId, selfId, targetId, selectRadioId)

end



--**********************************

--杀死怪物或玩家

--**********************************

function x211001_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211001_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211001_OnItemChanged(sceneId, selfId, itemdataId)

end