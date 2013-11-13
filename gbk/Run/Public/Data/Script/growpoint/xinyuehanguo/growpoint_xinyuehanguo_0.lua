--生长点

--脚本号 301017

x300303_g_MissionId		= 405
x300303_MP_SHOUJISHENGZHANGDIAN = 4

--生成函数开始************************************************************************

function 		x301017_OnCreate(sceneId,growPointType,x,y)
	
	local ItemBoxId = ItemBoxEnterScene(x,y,18,sceneId,0,13010171) --第三位为生长点物品编号，后面的是直接往背包塞物品，所以，暂时没用- -||
	
end

--生成函数结束**********************************************************************
--打开前函数开始&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
function	 x301017_OnOpen(sceneId,selfId,targetId)
	local misIndex = GetMissionIndexByID(sceneId, selfId, x300303_g_MissionId)
	local flag = GetMissionParam(sceneId, selfId, misIndex, x300303_MP_SHOUJISHENGZHANGDIAN)
	if IsHaveMission(sceneId,selfId, x300303_g_MissionId) > 0 and flag == 1 then
		if LuaFnGetItemCount(sceneId,selfId,13010080) < 10 then
			return 0
		else
			BeginEvent(sceneId)
			AddText(sceneId,"收集的够多了~别太黑心了~给别人留点")                    
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
function	 x301017_OnRecycle(sceneId,selfId,targetId)
	BeginAddItem(sceneId)                                                    
	AddItem( sceneId,13010080, 1 )             
	ret = EndAddItem(sceneId,selfId)                                 
	if ret > 0 then                                                  
		BeginEvent(sceneId)
		AddText(sceneId,format("易拉罐   %d/10", LuaFnGetItemCount(sceneId,selfId,13010080)+1))
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
function	x301017_OnProcOver(sceneId,selfId,targetId)

end
--打开后函数结束@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@



function	x301017_OpenCheck(sceneId,selfId,AbilityId,AblityLevel)

end
