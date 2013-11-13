--功能：擂台比武
--NPC：新月汗国 苏菲

x211008_g_ScriptId = 211008
x211008_g_MissionName="擂台比武"

--**********************************

--任务入口函数

--**********************************

function x211008_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	BeginEvent(sceneId)
		AddText(sceneId, "#Y擂台比武")
		AddText(sceneId, "比武场还在修缮中，等到比武场开放的时候，你可要多来看看，这里可是高手云集。想要一战成名，想要钻研更高武学，都可以来找我，我会帮助你的。当然了我会收取一点点小费了，你要是现在就报名，还可以给你打个折！")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end



--**********************************

--列举事件

--**********************************

function x211008_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x211008_g_ScriptId, x211008_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x211008_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x211008_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x211008_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211008_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211008_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211008_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211008_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211008_OnItemChanged(sceneId, selfId, itemdataId)

end