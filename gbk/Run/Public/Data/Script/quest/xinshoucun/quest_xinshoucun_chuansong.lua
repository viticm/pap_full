--功能：传送
--MisDescBegin
x999999_g_ScriptId = 999999
x999999_g_MissionId = 999
x999999_g_MissionName="传送"

--MisDescEnd
--**********************************

--任务入口函数

--**********************************

function x999999_OnDefaultEvent(sceneId, selfId, targetId,PosX,PosZ)	--点击该任务后执行此脚本
	  if IsMissionHaveDone(sceneId,selfId,991) == 1 then
		NewWorld(sceneId, selfId,9,333,275)
			BeginEvent(sceneId)
			strText = "你来到了苏州"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	else
	BeginEvent(sceneId)
			AddText(sceneId, "#Y传送")
			AddText(sceneId, "只有村子里得到大家认可的英雄，我才会派人将你快速送到苏州。当你完成整个新手村主线任务的时候，我会把你传送到苏州城的。")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end

--**********************************

--列举事件

--**********************************

function x999999_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x999999_g_ScriptId, x999999_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x999999_CheckAccept( sceneId, selfId ,targetId )
end

--**********************************

--接受

--**********************************

function x999999_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x999999_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x999999_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x999999_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x999999_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x999999_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x999999_OnItemChanged(sceneId, selfId, itemdataId)

end