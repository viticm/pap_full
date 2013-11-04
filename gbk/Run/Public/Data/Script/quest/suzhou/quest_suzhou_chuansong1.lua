--功能：传送
--MisDescBegin
x100000_g_ScriptId = 100000
x100000_g_MissionId = 100
x100000_g_MissionName="我要去桃花岛"

--MisDescEnd
--**********************************

--任务入口函数

--**********************************

function x100000_OnDefaultEvent(sceneId, selfId, targetId,PosX,PosZ)	--点击该任务后执行此脚本
		NewWorld(sceneId, selfId,4,32,180)
			BeginEvent(sceneId)
			strText = "你来到了桃花岛"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
end

--**********************************

--列举事件

--**********************************

function x100000_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x100000_g_ScriptId, x100000_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x100000_CheckAccept( sceneId, selfId ,targetId )
end

--**********************************

--接受

--**********************************

function x100000_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x100000_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x100000_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x100000_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x100000_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x100000_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x100000_OnItemChanged(sceneId, selfId, itemdataId)

end