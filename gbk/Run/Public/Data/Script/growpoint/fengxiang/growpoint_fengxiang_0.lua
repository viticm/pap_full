--生长点
--生长出来士兵
--
--脚本号 920000


--生长的士兵列表
x920000_g_MonsterList = {1000,1001,1002,1003,1004,1000}
x920000_g_ChangePosList = {{-1,-1},{0,-1},{1,-1},{-1,0},{0,0},{1,0},{-1,1},{0,1},{1,1}}
x920000_g_MonsterAIList = {108,109,110,111,112,113}

--动态变量初始化方法

if(x920000_g_MonsterTotalNum ==nil) then
x920000_g_MonsterTotalNum = 0
end


--生成函数开始************************************************************************

function 		x920000_OnCreate(sceneId,growPointType,x,y)
	
	
	local ItemBoxId = ItemBoxEnterScene(x,y,573,sceneId,0,13010001)
	--SetHumanAbilityLevel(sceneId, 15000,26,1)

	--SetItemBoxMaxGrowTime(sceneId,ItemBoxId,5000)	--设定回收时间
	
	
end


function	 x920000_MonsterNum()
		x920000_g_MonsterTotalNum = x920000_g_MonsterTotalNum - 1
end



--生成函数结束**********************************************************************


--打开前函数开始&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
function	 x920000_OnOpen(sceneId,selfId,targetId)

return 0

end
--打开前函数结束&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


--回收函数开始########################################################################
function	 x920000_OnRecycle(sceneId,selfId,targetId)
	BeginAddItem(sceneId)                                                    
	AddItem( sceneId,13010001, 1 )             
	ret = EndAddItem(sceneId,selfId)                                 
	if ret > 0 then                                                  
		BeginEvent(sceneId)
		AddText(sceneId,format("武士证书   %d/10", LuaFnGetItemCount(sceneId,selfId,13010001)+1 )) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		AddItemListToHuman(sceneId,selfId) 
	else                                                             
		BeginEvent(sceneId)                                      
		AddText(sceneId,"物品栏已满！")                    
		EndEvent(sceneId)                                        
		DispatchMissionTips(sceneId,selfId) 
	end                     
	
end
--回收函数结束########################################################################



--打开后函数开始@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
function	x920000_OnProcOver(sceneId,selfId,targetId)

end
--打开后函数结束@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@



function	x920000_OpenCheck(sceneId,selfId,AbilityId,AblityLevel)

end
