--生长点


--脚本号 301006




--动态变量初始化方法
x213001_g_MissionId = 146


--生成函数开始************************************************************************

function 		x301006_OnCreate(sceneId,growPointType,x,y)
	
	local ItemBoxId = ItemBoxEnterScene(x,y,7,sceneId,0,13010061)
	
	
end






--生成函数结束**********************************************************************


--打开前函数开始&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
function	 x301006_OnOpen(sceneId,selfId,targetId)
	if IsHaveMission(sceneId,selfId, x213001_g_MissionId) > 0 then
		misIndex = GetMissionIndexByID(sceneId,selfId,x213001_g_MissionId)
		if GetMissionParam(sceneId,selfId,misIndex,1) < 1 then
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
function	 x301006_OnRecycle(sceneId,selfId,targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x213001_g_MissionId)
	num = GetMissionParam(sceneId,selfId,misIndex,1) 
	SetMissionByIndex(sceneId,selfId,misIndex,1,num+1)
		BeginEvent(sceneId)
		AddText(sceneId,format("在伊丽莎白桥张贴告示   %d/1", GetMissionParam(sceneId,selfId,misIndex,1)))
	        EndEvent()
		DispatchMissionTips(sceneId, selfId)
		return 0 
	 
	
end
--回收函数结束########################################################################



--打开后函数开始@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
function	x301006_OnProcOver(sceneId,selfId,targetId)

end
--打开后函数结束@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@



function	x301006_OpenCheck(sceneId,selfId,AbilityId,AblityLevel)

end
