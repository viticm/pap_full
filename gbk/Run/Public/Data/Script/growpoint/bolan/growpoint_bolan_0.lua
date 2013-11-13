--生长点


--脚本号 301016




--动态变量初始化方法
x226000_g_MissionId = 337


--生成函数开始************************************************************************

function 		x301016_OnCreate(sceneId,growPointType,x,y)
	
	local ItemBoxId = ItemBoxEnterScene(x,y,17,sceneId,0,13010161)
	
	
end






--生成函数结束**********************************************************************


--打开前函数开始&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
function	 x301016_OnOpen(sceneId,selfId,targetId)
	if IsHaveMission(sceneId,selfId, x226000_g_MissionId) > 0 then
		misIndex = GetMissionIndexByID(sceneId,selfId,x226000_g_MissionId)
		if GetMissionParam(sceneId,selfId,misIndex,0) < 5 then
			return 0
		else
			BeginEvent(sceneId)
			AddText(sceneId,"您无法这样做")                    
			EndEvent(sceneId)                                        
			DispatchMissionTips(sceneId,selfId)
			return 1 
		end
	else
		BeginEvent(sceneId)                                      
		AddText(sceneId,"您没有这个任务")                    
		EndEvent(sceneId)                                        
		DispatchMissionTips(sceneId,selfId) 
		return 1
	end

end
--打开前函数结束&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


--回收函数开始########################################################################
function	 x301016_OnRecycle(sceneId,selfId,targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x226000_g_MissionId)
	num = GetMissionParam(sceneId,selfId,misIndex,0) 
	SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
		BeginEvent(sceneId)
		AddText(sceneId,format("点燃枯草堆   %d/5", GetMissionParam(sceneId,selfId,misIndex,0)))
	        EndEvent()
		DispatchMissionTips(sceneId, selfId)
		return 1 
	 
	
end
--回收函数结束########################################################################



--打开后函数开始@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
function	x301016_OnProcOver(sceneId,selfId,targetId)

end
--打开后函数结束@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@



function	x301016_OpenCheck(sceneId,selfId,AbilityId,AblityLevel)

end
