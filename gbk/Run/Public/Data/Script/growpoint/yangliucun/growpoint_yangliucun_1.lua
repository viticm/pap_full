--生长点


--脚本号 301022




--动态变量初始化方法

--x208011_g_MissionId = 65


--生成函数开始************************************************************************

function 		x301022_OnCreate(sceneId,growPointType,x,y)
	
	local ItemBoxId = ItemBoxEnterScene(x,y,2,sceneId,0,11010001)
	
	
	
end






--生成函数结束**********************************************************************


--打开前函数开始&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
function	 x301022_OnOpen(sceneId,selfId,targetId)
--	if IsHaveMission(sceneId,selfId, x208011_g_MissionId) > 0 then
		
--	if LuaFnGetItemCount(sceneId,selfId,13010223) < 10 then
--		return 0
--	else
--		BeginEvent(sceneId)
--		AddText(sceneId,"您无法这样做")                    
--		EndEvent(sceneId)                                        
--		DispatchMissionTips(sceneId,selfId)
--		return 1 
--	end
--	else
--		BeginEvent(sceneId)                                      
		AddText(sceneId,"您没有这个任务")                    
--		EndEvent(sceneId)                                        
--		DispatchMissionTips(sceneId,selfId) 
--		return 1
--	end
end
--打开前函数结束&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


--回收函数开始########################################################################
function	 x301022_OnRecycle(sceneId,selfId,targetId)
	BeginAddItem(sceneId)                                                    
	AddItem( sceneId,11010001, 1 )             
	ret = EndAddItem(sceneId,selfId)                                 
	if ret > 0 then                                                  
		BeginEvent(sceneId)
		AddText(sceneId,format("微瑕补天道具   %d/10", LuaFnGetItemCount(sceneId,selfId,11010001)+1))
	        EndEvent()
		DispatchMissionTips(sceneId, selfId)
		AddItemListToHuman(sceneId,selfId) 
		return 1 
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
function	x301022_OnProcOver(sceneId,selfId,targetId)

end
--打开后函数结束@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@



function	x301022_OpenCheck(sceneId,selfId,AbilityId,AblityLevel)

end
