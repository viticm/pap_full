--功能：国家筹集军粮
--NPC：后军将军

--MisDescBegin
x211007_g_ScriptId = 211007

x211007_g_MissionName = "筹集军粮"
--MisDescEnd
--**********************************

--任务入口函数

--**********************************

function x211007_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	BeginEvent(sceneId)
		AddText(sceneId, "#Y筹集军粮")
		AddText(sceneId, "前线的战士们正在浴血奋战，我们做后勤的一定不能掉链子，做好他们的大后方。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end



--**********************************

--列举事件

--**********************************

function x211007_OnEnumerate(sceneId, selfId, targetId)
	AddNumText(sceneId, x211007_g_ScriptId, x211007_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x211007_CheckAccept(sceneId, selfId, targetId)

end



--**********************************

--接受

--**********************************

function x211007_OnAccept(sceneId, selfId)
    
end



--**********************************

--放弃

--**********************************

function x211007_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211007_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211007_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211007_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211007_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211007_OnItemChanged(sceneId, selfId, itemdataId)

end