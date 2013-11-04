--功能：学习工匠技能

x510006_g_ScriptId = 510006
x510006_g_MissionName="学习工匠技能"
--**********************************

--任务入口函数

--**********************************

function x510006_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
--	DismantleSouXiaItem( sceneId, selfId, targetId)
end



--**********************************

--列举事件

--**********************************

function x510006_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x510006_g_ScriptId, x510006_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x510006_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x510006_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x510006_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x510006_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x510006_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x510006_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x510006_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x510006_OnItemChanged(sceneId, selfId, itemdataId)

end
