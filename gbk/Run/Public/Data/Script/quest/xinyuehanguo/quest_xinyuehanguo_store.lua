--功能：仓库
--NPC：新月汗国 仓库老板，仓库伙计

x211017_g_ScriptId = 211017
x211017_g_MissionName="仓库"

--**********************************

--任务入口函数

--**********************************

function x211017_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	BankBegin(sceneId, selfId,targetId)
end



--**********************************

--列举事件

--**********************************

function x211017_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x211017_g_ScriptId, x211017_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x211017_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x211017_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x211017_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211017_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211017_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211017_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211017_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211017_OnItemChanged(sceneId, selfId, itemdataId)

end