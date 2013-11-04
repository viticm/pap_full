--生长点


--脚本号 301012




--动态变量初始化方法

x225002_g_MissionId = 324


--生成函数开始************************************************************************

function 		x301012_OnCreate(sceneId,growPointType,x,y)
	
	local ItemBoxId = ItemBoxEnterScene(x,y,13,sceneId,0,13010121)
	
	
	
end






--生成函数结束**********************************************************************


--打开前函数开始&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
function	 x301012_OnOpen(sceneId,selfId,targetId)
	if IsHaveMission(sceneId,selfId, x225002_g_MissionId) > 0 then
		if LuaFnGetItemCount(sceneId,selfId,13010059) == 1 then
			return 0
		else
			BeginEvent(sceneId)
			AddText(sceneId,"缺少主教的钥匙")                    
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
function	 x301012_OnRecycle(sceneId,selfId,targetId)
	BeginAddItem(sceneId)                                                    
	AddItem( sceneId,13010060, 1 )             
	ret = EndAddItem(sceneId,selfId)                                 
	if ret > 0 then                                                  
		BeginEvent(sceneId)
		AddText(sceneId,format("箱中包裹   1/1"))
	        EndEvent()
		DispatchMissionTips(sceneId, selfId)
		AddItemListToHuman(sceneId,selfId) 
		DelItem(sceneId, selfId, 13010059, 1)
		return 0 
	else                                                             
		BeginEvent(sceneId)                                      
		AddText(sceneId,"物品栏已满！")                    
		EndEvent(sceneId)                                        
		DispatchMissionTips(sceneId,selfId) 
		return 0
	end       
	
end
--回收函数结束########################################################################



--打开后函数开始@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
function	x301012_OnProcOver(sceneId,selfId,targetId)

end
--打开后函数结束@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@



function	x301012_OpenCheck(sceneId,selfId,AbilityId,AblityLevel)

end
