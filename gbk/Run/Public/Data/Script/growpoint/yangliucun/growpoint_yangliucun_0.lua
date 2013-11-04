--生长点
--对应生活技能：采矿	采矿技能的编号4
--采矿
--脚本号301021
--概率分布的矿石	   0.15	     0.05     0.1     0.05	
--以表格概率(35%)得到副产品12130001,12130002,12130003,12130004 中的一种，数量1
--等级1

--每次打开必定获得的产品
x301021_g_MainItemId = 11990001
--副产品
x301021_g_Byproduct = {12130001,12130002,12130003,12130004}
--需要技能Id
x301021_g_AbilityId = 1
--需要技能等级
x301021_g_AbilityLevel = 1


--生成函数开始************************************************************************
--每个ItemBox中最多10个物品
function 		x301021_OnCreate(sceneId,growPointType,x,y)
	--放入ItemBox同时放入一个物品growPointType=1
	targetId  = ItemBoxEnterScene(x,y,1,sceneId,0,x301021_g_MainItemId)	--每个生长点最少能得到一个物品,这里直接放入itembox中一个
	
end
--生成函数结束**********************************************************************


--打开前函数开始&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
function	 x301021_OnOpen(sceneId,selfId,targetId)
--返回类型
-- 0 表示打开成功
	ABilityID = GetItemBoxRequireAbilityID(sceneId,targetId)
	AbilityLevel = QueryHumanAbilityLevel(sceneId,selfId,ABilityID)
	res = x301021_OpenCheck(sceneId,selfId,ABilityID,AbilityLevel)
	return res
end
--打开前函数结束&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


--回收函数开始########################################################################
function	 x301021_OnRecycle(sceneId,selfId,targetId)
--AddItemToBox();
	BeginAddItem(sceneId)                                                  


	--获得1~100的随机数,用来随机生成的道具
	--主产品1~50获得主产品帮会令，51~85 炼器神符，86~100没有获得道具
	local ItemCount = random(1,100)
	local ByproductId = random(1,4)
	
	if ItemCount >= 0 and ItemCount <= 50 then
		AddItem( sceneId,x301021_g_MainItemId, 1 )  
	elseif ItemCount >= 51 and ItemCount <= 65 then
		AddItem( sceneId,x301021_g_Byproduct[ByproductId], 1 )    
	elseif ItemCount >= 65 and ItemCount <= 70 then
		AddItem( sceneId,x301021_g_Byproduct[ByproductId], 1 )
	elseif ItemCount >= 71 and ItemCount <= 80 then
		AddItem( sceneId,x301021_g_Byproduct[ByproductId], 1 )
	elseif ItemCount >= 81 and ItemCount <= 85 then
		AddItem( sceneId,x301021_g_Byproduct[ByproductId], 1 )
	end
         
	ret = EndAddItem(sceneId,selfId)           

	-- 增加熟练度
	ABilityID	=	GetItemBoxRequireAbilityID(sceneId,targetId)
	CallScriptFunction(ABILITYLOGIC_ID, "GatherGainExperience", sceneId, selfId, ABilityID, x301021_g_AbilityLevel)
	
	if ret > 0 then                                                  
		BeginEvent(sceneId)
	
		if ItemCount >= 0 and ItemCount <= 50 then
			AddText(sceneId,format("得到帮会令   %d", LuaFnGetItemCount(sceneId,selfId,x301021_g_MainItemId)+1))
		end
		
		if ItemCount >= 51 and ItemCount <= 85 then
			if  x301021_g_Byproduct[ByproductId] == 12130001 then
				AddText(sceneId,format("1级炼器神符   %d", LuaFnGetItemCount(sceneId,selfId,x301021_g_Byproduct[ByproductId])+1))
			elseif x301021_g_Byproduct[ByproductId] == 12130002 then
				AddText(sceneId,format("2级炼器神符   %d", LuaFnGetItemCount(sceneId,selfId,x301021_g_Byproduct[ByproductId])+1))
			elseif x301021_g_Byproduct[ByproductId] == 12130003 then
				AddText(sceneId,format("3级炼器神符   %d", LuaFnGetItemCount(sceneId,selfId,x301021_g_Byproduct[ByproductId])+1))
			elseif x301021_g_Byproduct[ByproductId] == 12130004  then
				AddText(sceneId,format("4级炼器神符   %d", LuaFnGetItemCount(sceneId,selfId,x301021_g_Byproduct[ByproductId])+1))
			end
		end

		if ItemCount >=86 and ItemCount <=100  then
			AddText(sceneId,format("没有采集到任何矿石"))
		end

	        EndEvent()
		DispatchMissionTips(sceneId, selfId)
		if ItemCount >= 0 and ItemCount <=85  then
	       		AddItemListToHuman(sceneId,selfId) 
		end
		return 1 
	else                                                             
		BeginEvent(sceneId)                                      
		AddText(sceneId,"物品栏已满！")                    
		EndEvent(sceneId)                                        
		DispatchMissionTips(sceneId,selfId) 
		return 0
	end       

	--返回1，生长点回收
	return 1
end
--回收函数结束########################################################################



--打开后函数开始@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
function	x301021_OnProcOver( sceneId, selfId, targetId )
	--local ABilityID = GetItemBoxRequireAbilityID( sceneId, targetId )
	--CallScriptFunction( ABILITYLOGIC_ID, "EnergyCostCaiJi", sceneId, selfId, ABilityID, x301021_g_AbilityLevel )
	return 0
end
--打开后函数结束@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

function	x301021_OpenCheck(sceneId,selfId,AbilityId,AbilityLevel)
	--检查生活技能等级
	if AbilityLevel < x301021_g_AbilityLevel then
		return OR_NO_LEVEL
	end
	--检查精力
	if GetHumanEnergy(sceneId,selfId)< (floor(x301021_g_AbilityLevel * 1.5 +2) * 2) then
		return OR_NOT_ENOUGH_ENERGY
	end
	return OR_OK
end

