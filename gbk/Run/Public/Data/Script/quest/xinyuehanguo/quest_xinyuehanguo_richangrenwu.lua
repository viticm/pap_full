--功能：日常任务
--NPC：新月汗国 阿丹

x211012_g_ScriptId = 211012
x211012_g_MissionName="日常任务"

--**********************************

--任务入口函数

--**********************************

function x211012_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	BeginEvent(sceneId)
		AddText(sceneId, "#Y日常任务")
		AddText(sceneId, "我除了有钱，什么都没有。一天无所事事，难受得要紧，所以我就发出告示帮全国的人做些事。这下好，每天都有N多的人来找我帮忙了，我哪里忙得过来。你可愿意替我分担一些，我说了我除了有钱，什么都没有，所以我不会亏待你的。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end



--**********************************

--列举事件

--**********************************

function x211012_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x211012_g_ScriptId, x211012_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x211012_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x211012_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x211012_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211012_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211012_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211012_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211012_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211012_OnItemChanged(sceneId, selfId, itemdataId)

end