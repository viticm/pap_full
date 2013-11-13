--生长点


--脚本号 301009











--动态变量初始化方法

x206008_g_MissionId = 35


--生成函数开始************************************************************************

function 	x301009_OnCreate(sceneId,growPointType,x,y)
	
	local ItemBoxId = ItemBoxEnterScene(x,y,10,sceneId,0,13010020)
	
	
	
end






--生成函数结束**********************************************************************


--打开前函数开始&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
function	 x301009_OnOpen(sceneId,selfId,targetId)
	if IsHaveMission(sceneId,selfId, x206008_g_MissionId) > 0 then
		if LuaFnGetItemCount(sceneId,selfId,13010048) < 10 then
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
function	 x301009_OnRecycle(sceneId,selfId,targetId)
	local NPCX,NPCY = LuaFnGetWorldPos(sceneId,selfId)
	LuaFnCreateMonster(sceneId, 401,NPCX+random(-3,3),NPCY+random(-3,3),0,1,-1) 
	return 1		
	
end
--回收函数结束########################################################################



--打开后函数开始@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
function	x301009_OnProcOver(sceneId,selfId,targetId)

end
--打开后函数结束@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@



function	x301009_OpenCheck(sceneId,selfId,AbilityId,AblityLevel)

end
