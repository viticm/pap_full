--功能：学习制衣技能

x510005_g_ScriptId = 510005
x510005_g_MissionName="学习制衣技能"
--**********************************

--任务入口函数

--**********************************

function x510005_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
--	DismantleSouXiaItem( sceneId, selfId, targetId)
end



--**********************************

--列举事件

--**********************************

function x510005_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x510005_g_ScriptId, x510005_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x510005_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x510005_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x510005_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x510005_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x510005_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x510005_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x510005_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x510005_OnItemChanged(sceneId, selfId, itemdataId)

end
