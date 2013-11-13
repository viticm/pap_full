--功能：缝合捜侠录

x500003_g_ScriptId = 500003
x500003_g_MissionName="缝合捜侠录"
--**********************************

--任务入口函数

--**********************************

function x500003_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
--	SewSouXiaItem( sceneId, selfId, targetId)
end



--**********************************

--列举事件

--**********************************

function x500003_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x500003_g_ScriptId, x500003_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x500003_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x500003_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x500003_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x500003_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x500003_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x500003_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x500003_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x500003_OnItemChanged(sceneId, selfId, itemdataId)

end
