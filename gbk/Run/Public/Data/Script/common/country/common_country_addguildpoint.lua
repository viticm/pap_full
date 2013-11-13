--帮贡测试用
--添加帮贡

--************************************************************************
--MisDescBegin

--脚本号
x300306_g_ScriptId = 300306


--任务文本描述
x300306_g_MissionName="神啊，请赐我帮贡吧！"
x300306_g_MissionInfo="就赏你这100帮贡吧！"

function x300306_OnDefaultEvent( sceneId, selfId, targetId )
--AddGuildUserPoint(sceneId,selfId,100)
	BeginEvent(sceneId)
		
		AddText(sceneId,x300306_g_MissionInfo)
	
	EndEvent(sceneId)
	DispatchMissionInfo(sceneId,selfId,targetId,x300306_g_ScriptId,x300306_g_MissionId)
	
end

--**********************************
function x300306_CheckAccept( sceneId, selfId )

	return	1

end

--**********************************
function x300306_OnAccept( sceneId, selfId )

	AddGuildUserPoint(sceneId,selfId,100)

end

--**********************************

function x300306_OnEnumerate(sceneId, selfId, targetId)
--	AddGuildUserPoint(sceneId,selfId,100)
	AddNumText(sceneId, x300306_g_ScriptId, x300306_g_MissionName)
end