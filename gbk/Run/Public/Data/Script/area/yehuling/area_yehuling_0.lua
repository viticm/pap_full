
x207016_g_MissionId=17
--玩家进入一个 area 时触发
function x500700_OnEnterArea( sceneId, selfId )
      misIndex = GetMissionIndexByID(sceneId,selfId,x207016_g_MissionId)		--添加任务                                           
      SetMissionByIndex(sceneId,selfId,misIndex,1,1)
end

--玩家在一个 area 呆了一段时间没走则定时触发
function x500700_OnTimer( sceneId, selfId )

end

--玩家离开一个 area 时触发
function x500700_OnLeaveArea( sceneId, selfId )
      misIndex = GetMissionIndexByID(sceneId,selfId,x207016_g_MissionId)		--添加任务                                           
      SetMissionByIndex(sceneId,selfId,misIndex,1,0)
      end
