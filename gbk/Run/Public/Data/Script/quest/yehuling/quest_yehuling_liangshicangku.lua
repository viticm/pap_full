
x207021_g_ScriptId = 207021



x207020_g_MissionId = 21
x207021_g_MissionName="点燃"

x207021_g_MissionItem = {{id=30007013,num=1}}


function x207021_OnDefaultEvent(sceneId, selfId, targetId)
        misIndex = GetMissionIndexByID(sceneId,selfId,x207020_g_MissionId)
        BeginEvent(sceneId)
	AddText(sceneId,"已经点燃") 
        EndEvent()
        DispatchEventList(sceneId, selfId, targetId)
        SetMissionByIndex(sceneId,selfId,misIndex,1,GetMissionParam(sceneId,selfId,misIndex,1)+1)
        BeginEvent(sceneId)
        x207021_g_MissionName2 = format("点燃粮食仓库   %d/3", GetMissionParam(sceneId,selfId,misIndex,1) )
        AddText(sceneId,x207021_g_MissionName2) 
        EndEvent()
        DispatchMissionTips(sceneId, selfId)
	LuaFnGmKillObj(sceneId,selfId,targetId)
		
	
		     
end


function x207021_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207021_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207020_g_MissionId) > 0 then
	    misIndex = GetMissionIndexByID(sceneId,selfId,x207020_g_MissionId)
            if GetMissionParam(sceneId,selfId,misIndex,1) < 3 then
            AddNumText(sceneId, x207021_g_ScriptId, x207021_g_MissionName)
            end
        end
	
end
	       