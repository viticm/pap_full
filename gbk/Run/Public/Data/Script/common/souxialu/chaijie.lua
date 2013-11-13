--功能：拆解捜侠录道具

x500001_g_ScriptId = 500001
x500001_g_MissionName="拆解捜侠录道具"
--**********************************

--任务入口函数

--**********************************

function x500001_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
--	DismantleSouXiaItem( sceneId, selfId, targetId)
end



--**********************************

--列举事件

--**********************************

function x500001_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x500001_g_ScriptId, x500001_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x500001_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x500001_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x500001_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x500001_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x500001_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x500001_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x500001_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x500001_OnItemChanged(sceneId, selfId, itemdataId)

end
