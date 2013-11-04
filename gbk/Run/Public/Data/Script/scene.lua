--场景的脚本文件



--脚本号

x888888_g_scriptId_scene = 888888



x888888_g_defaultRelive_SceneID_1=11;

x888888_g_defaultRelive_SceneID_2=11;



--MainHand=0,AssiHand=1,Head=2,Neck=3,Shoulder=4,Back=5,Wrist=6,Hand=7,Waist=8,Feet=9,Ring1=10,Ring2=11,Adorn1=12,Adorn2=13,Suit=14,Rider=15
x888888_g_Body_Equip_Index={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}

--0:原地无损复活    1:原地有损复活	2:城市定点复活
x888888_g_ReliveType ={OriginLosslessRelive=0,OriginDamageRelive=1, CityPosRelive=2}



function x888888_OnSceneInit( sceneId )

--场景在初始化完成后调用



end



function x888888_OnSceneTimer( sceneId, nowTime )

--场景计时器

--sceneId表示场景号，nowTime表示当前时间（程序启动后的时间，单位毫秒）



	local sceneType = LuaFnGetSceneType(sceneId) ;
    --PrintStr('sceneType ' .. tostring(sceneType));


	if sceneType == 1 then --场景类型是副本

		local copyscenetype = LuaFnGetCopySceneData_Param(sceneId,0) ;--取得副本号

		local copyscenescript = LuaFnGetCopySceneData_Param(sceneId,1) ; --取得脚本号

		if copyscenetype==FUBEN_EXAMPLE then --例子

			--例子不提供定时时间

			print("不能使用例子副本类型，例子副本类型不提供定时事件")

		elseif copyscenetype==FUBEN_EXAMPLE then --

			CallScriptFunction( copyscenescript, "OnCopySceneTimer", sceneId, nowTime ) ;

		elseif copyscenetype==FUBEN_MURENXIANG_7 then --7级木人巷副本

			CallScriptFunction( copyscenescript, "OnCopySceneTimer", sceneId, nowTime ) ;

		elseif copyscenetype==FUBEN_MURENXIANG_9 then --9级木人巷副本

			CallScriptFunction( copyscenescript, "OnCopySceneTimer", sceneId, nowTime ) ;

		elseif copyscenetype==FUBEN_MURENXIANG then --标准木人巷副本

			CallScriptFunction( copyscenescript, "OnCopySceneTimer", sceneId, nowTime ) ;

		elseif copyscenetype==FUBEN_SHUILAO then --水牢副本

			CallScriptFunction( copyscenescript, "OnCopySceneTimer", sceneId, nowTime ) ;

		elseif copyscenetype==FUBEN_ZHENGLONG then --蒸笼棋局副本

			CallScriptFunction( copyscenescript, "OnCopySceneTimer", sceneId, nowTime ) ;
	
		elseif copyscenetype==FUBEN_MONSTERPARTY then --怪兽总动员副本
			
			CallScriptFunction( copyscenescript, "OnCopySceneTimer", sceneId, nowTime ) ;
		elseif copyscenetype==FUBEN_HUOCAISHENDIAN then --活财神殿副本
			
			CallScriptFunction( copyscenescript, "OnCopySceneTimer", sceneId, nowTime ) ;
			
		elseif copyscenetype==FUBEN_JUNYAOYAOKOU then --钧窑窑口副本
			
			CallScriptFunction( copyscenescript, "OnCopySceneTimer", sceneId, nowTime ) ;	
		elseif copyscenetype==FUBEN_GOULANQUTAI then --勾栏曲台副本
			
			CallScriptFunction( copyscenescript, "OnCopySceneTimer", sceneId, nowTime ) ;	
		elseif copyscenetype==FUBEN_HUOCAISHENDIAN then --活财神庙副本
			
			CallScriptFunction( copyscenescript, "OnCopySceneTimer", sceneId, nowTime ) ;	
		elseif copyscenetype==FUBEN_01 then --测试用
			CallScriptFunction( copyscenescript, "OnCopySceneTimer", sceneId, nowTime ) ;	
		elseif copyscenetype==FUBEN_02 then --测试用
			
			CallScriptFunction( copyscenescript, "OnCopySceneTimer", sceneId, nowTime ) ;	
		elseif copyscenetype==FUBEN_MANTUOSHANZHANG then --曼陀山庄
			CallScriptFunction( copyscenescript, "OnCopySceneTimer", sceneId, nowTime ) ;	
		end

	end

end



function x888888_OnSceneQuit( sceneId )

--场景在关闭前调用



end


function x888888_OnScenePlayerFirstEnter( sceneId, playerId )

	--设置缺省的信息

--	local wuqi={10031001} --,10021001,10031001,10041001,10051001,10061001,10011001,10011001,10011001,10011001,10011001,10011001,10131001,10011001,10011001,10011001}
--	local yifu = 10231001
--	local shoutao = 10251001
--	local xiezi = 10271001
--	local MenPai= GetMenPai( sceneId, playerId)
--	BeginAddItem(sceneId)
--		AddItem( sceneId,wuqi[MenPai+1],1)
--		AddItem( sceneId,yifu,1)
--		AddItem( sceneId,shoutao,1)
--		AddItem( sceneId,xiezi,1)
--	EndAddItem(sceneId,playerId)
--	AddItemListToHuman(sceneId,playerId)
--	UseItem(sceneId,playerId,wuqi[MenPai+1])
--	UseItem(sceneId,playerId,yifu)
--	UseItem(sceneId,playerId,shoutao)
--	UseItem(sceneId,playerId,xiezi)
	
end

function x888888_OnScenePlayerEnter( sceneId, playerId )

	--设置缺省的复活信息
	
	local sceneType = LuaFnGetSceneType(sceneId) ;
	
	--[[
	if sceneType == 1 then --场景类型是副本

		local copyscenescript = LuaFnGetCopySceneData_Param(sceneId,1) ; --取得脚本号

		CallScriptFunction( copyscenescript, "OnPlayerEnter", sceneId, playerId ) ;

	else

		if	GetMenPai( sceneId, playerId)	~=9	then

			SetPlayerDefaultReliveInfo( sceneId, playerId, "%100", "-1", "0", x888888_g_defaultRelive_SceneID_1, 430, 428 );

		else

			SetPlayerDefaultReliveInfo( sceneId, playerId, "%100", "-1", "0", x888888_g_defaultRelive_SceneID_2, 430, 428 );

		end

	end
	--]]
	

end



--玩家复活的脚本事件
--ReliveType:复活方式  	1.IB复活（无虚弱状态）  2.解救复活（虚弱状态）  3.城市定点复活（回城，虚弱状态）
function x888888_OnSceneHumanRelive( sceneId, selfId, ReliveType )

	--local money = 0
	--local level = GetLevel(sceneId, selfId)
	--if level > 0 and level <= 10 then
		--扣除1个游戏币
	--	money = 1
	--elseif level > 10 and level <= 30 then
		--扣除2个游戏币
	--	money = 2
	--elseif level > 30 and level <= 60 then	
		--扣除3个游戏币	
	--	money = 3
	--elseif level > 60 and level <= 90 then	
		--扣除4个游戏币	
	--	money = 4
	--elseif level > 90 and level <= 120 then	
		--扣除5个游戏币	
	--	money = 5
	--elseif level > 120 and level <= 160 then	
		--扣除6个游戏币	
	--	money = 6							
	--end
		
	if ReliveType == x888888_g_ReliveType.OriginLosslessRelive then
		--ib复活	
		RestoreHp(sceneId, selfId,100)
		RestoreMp(sceneId, selfId,100)
		
		--消耗游戏币
		--CostMoney(sceneId, selfId,money)
				
		
	elseif ReliveType == x888888_g_ReliveType.OriginDamageRelive then
		--解救复活
		RestoreHp(sceneId, selfId,100)
		RestoreMp(sceneId, selfId,100)	
		
		--设置虚弱状态
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 1000, 1000 * 60 *2);
		
		--消耗游戏币, 暂时不消耗游戏币
		--CostMoney(sceneId, selfId,money*2)	
				
	elseif ReliveType == x888888_g_ReliveType.CityPosRelive then
		--城市定点复活
		RestoreHp(sceneId, selfId,100)
		RestoreMp(sceneId, selfId,100)	
		
		--设置虚弱状态
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 1000, 1000 * 60 *2);
		
		--newScendId是玩家重生的场景ID，需策划指定
		local newSceneId = -1
		local posX = -1
		local posZ = -1
		
		if sceneId == 11 then
			newSceneId = 11
			posX = 430
			posZ = 428
		elseif sceneId == 28 then
			newSceneId = 28
			posX = 32
			posZ = 99
		end
	
		if sceneId ~= newSceneId then
			if newSceneId == -1 then
				SetPos(sceneId,selfId,60,60)	
			else
				NewWorld(sceneId, selfId,newSceneId,posX,posZ)
			end
		else
			SetPos(sceneId,selfId,posX,posZ)	
		end
	end	
end


--玩家死亡后脚本事件
--1.根据玩家等级降低装备耐久度
--2.根据玩家PK值，掉落未绑定物品
function x888888_OnSceneHumanDie( sceneId, selfId, killerId )

	local percent = 0
	
	local level = GetLevel(sceneId, selfId)
	if level > 0 and level <= 10 then
		--耐久降低1%~2%
		percent = random(2)
	elseif level > 10 and level <= 30 then
		--耐久降低2%-3%
		percent = random(2) + 1
	elseif level > 30 and level <= 60 then	
		--耐久降低3%-5%
		percent = random(3) + 2		
	elseif level > 60 and level <= 90 then	
		--耐久降低4%-8%
		percent = random(5) + 3			
	elseif level > 90 and level <= 120 then	
		--耐久降低7%-11%
		percent = random(5) + 6		
	elseif level > 120 and level <= 160 then	
		--耐久降低10%15%
		percent = random(6) + 9									
	end
	
	--得到玩家装备当前耐久度
	local oldVal = LuaFnGetBodyItemDur(sceneId, selfId)
	local newVal = oldVal * ( (100 - percent) / 100 )
	
	local text = format("玩家等级 = %d,装备降低%d/100,新耐久度%d。",level,percent,newVal )
	--PrintStr(text)
	
	for i=1,16 do 
		--改变玩家装备耐久度
		LuaFnSetBodyItemDur(sceneId, selfId,x888888_g_Body_Equip_Index[i],newVal)
	end
	

    local ObjType = LuaFnGetObjType(sceneId, killerId)
    
    if ObjType == 1 then -- OBJ_TYPE_HUMAN

    LuaFnAddEnemy(sceneId,selfId, killerId)
		--******************************************************************************
		--*PK惩罚                                                                      *
		--******************************************************************************
		local deltaLevel = abs(GetLevel(sceneId, selfId) - GetLevel(sceneId, killerId))
		local CountryIDSelf 	= GetCurCountry(sceneId, selfId)
		local CountryIDKiller	= GetCurCountry(sceneId, killerId)
		--杀死本国红名玩家会获得荣誉值，同时会减少自己的PK值
		if CountryIDSelf == CountryIDKiller then
			local PKSelf = LuaFnGetPKValue(sceneId, selfId)
			local pkKiller = LuaFnGetPKValue(sceneId, killerId)
			if PKSelf > 10 then --红名 如果大于死者等级则-1点PK值。小于等于死者等级则-2点。
			    if (GetLevel(sceneId, killerId) - GetLevel(sceneId, selfId)) > 0  then
			        pkKiller = pkKiller - 1
		            LuaFnSetPKValue(sceneId, killerId, pkKiller)
				elseif (GetLevel(sceneId, killerId) - GetLevel(sceneId, selfId)) < 0 then
			        pkKiller = pkKiller - 2
		            LuaFnSetPKValue(sceneId, killerId, pkKiller)
				end
			elseif PKSelf <= 10 then
			--条件：
			--杀死同国非红名玩家
			--If 25 > |APlayerLevel-BplayerLevel| > 10 then
			--PK = |APlayerLevel-BplayerLevel|*2
			--Elseif |APlayerLevel-BplayerLevel|<=10 then
			--PK = |APlayerLevel-BplayerLevel|*1
			--Elseif |APlayerLevel-BplayerLevel| > = 25 then
			--PK = |APlayerLevel-BplayerLevel|*3
				local pkValue = LuaFnGetPKValue(sceneId, killerId)
				if deltaLevel > 10 and deltaLevel < 25 then
					pkValue  = pkValue + (deltaLevel * 2)
		            LuaFnSetPKValue(sceneId, killerId, pkValue)
				elseif deltaLevel <= 10 then
					pkValue  = pkValue + (deltaLevel * 1)
		            LuaFnSetPKValue(sceneId, killerId, pkValue)
				elseif deltaLevel >= 25 then
					pkValue  = pkValue + (deltaLevel * 3)
		            LuaFnSetPKValue(sceneId, killerId, pkValue)
				end
			end
			
			--a.玩家等级差（杀手等级-死者等级）对照表格，取得分数基数n（等级基数）
			--b.死者PK值对照表格，取得分数基数m（PK值基数）
			--c.惩罚算法为(n/100+m/20)=z（惩罚基数）
			--d.根据z的值对照表格，获得具体死者惩罚内容
 			--a
			local levelP 	= LuaFnGetPKLevel(sceneId, selfId, deltaLevel)
			--b
			local pkValue 	= LuaFnGetPKValue(sceneId, selfId)
			local PKP	 	= LuaFnGetPKPoint(sceneId, selfId, pkValue)
			--c
			local punishP	= levelP/100 + PKP/20
			local TotalValue= LuaFnGetPKPunish(sceneId, selfId, punishP)

			--d
			--监狱：当TotalValue>100时，将玩家送入指定场景的指定坐标。
			--当100>=TotalValue>70时，玩家被杀掉落为下限20%上限60%
			--当70>=TotalValue>50时，玩家被杀掉落为下限150%上限50%
			--当50>=TotalValue>20时，玩家被杀掉落为下限10%上限30%

			--得到玩家背包和身上未绑定物品数
			local ItemCntInBag = LuaFnGetNotBindItemCountInBag(sceneId, selfId)
			local ItemCntInBody = LuaFnGetNotBindItemCountInBody(sceneId, selfId)

			local DropCountInBag = 0

			local text = format("TotalValue = %d",TotalValue )
			--PrintStr(text)
				
			if TotalValue > 100 then
				--传送到监狱   ToDo
			elseif TotalValue > 70 and TotalValue <= 100 then
				DropCountInBag 	= random (20 , 60) / 100 * ItemCntInBag
				DropCountInBody = random (20 , 60) / 100 * ItemCntInBody
			elseif TotalValue > 50 and TotalValue <= 70 then
				DropCountInBag = random (15 , 50) / 100 * ItemCntInBag
				DropCountInBody = random (15 , 50) / 100 * ItemCntInBody
			elseif TotalValue > 10 and TotalValue <= 50 then
				DropCountInBag = random (10 , 30) / 100 * ItemCntInBag
				DropCountInBody = random (10 , 30) / 100 * ItemCntInBody
			end

			local text = format("DropCountInBag = %d",DropCountInBag )
			--PrintStr(text)
				
			--掉落背包
			for i=1,DropCountInBag do
				local DropIndex = random(ItemCntInBag-i+1)
				LuaFnDropNotBindItemInBag(sceneId, selfId,DropIndex)
			end

			--掉落随身装备
			for i=1,DropCountInBody do
				local DropIndex = random(ItemCntInBody-i+1)
				local text = format("掉落 = %d",DropIndex )
				--PrintStr(text)
				LuaFnDropNotBindItemInBody(sceneId, selfId,DropIndex)
			end

			--A为杀手 B为死者
			--APlayerLevel  -  BplayerLevel  >=  30  then  A荣誉-5 B+3
			--30 > APlayerLevel  -  BplayerLevel  >=  0  then  A荣誉-2 B+1
			--0 > APlayerLevel  -  BplayerLevel  >=  -30  then  A荣誉+2 B-1
			---30 > APlayerLevel  -  BplayerLevel  then  A荣誉+5 B-3
			local deltaLevel = GetLevel(sceneId, killerId) - GetLevel(sceneId, selfId)

			if deltaLevel >= 30 then
				LuaSubHonor(sceneId, killerId, 5)
				LuaAddHonor(sceneId, selfId, 3)
			elseif deltaLevel >= 0 and deltaLevel < 30 then
				LuaSubHonor(sceneId, killerId, 2)
				LuaAddHonor(sceneId, selfId, 1)
			elseif deltaLevel >= -30 and deltaLevel < 0 then
				LuaAddHonor(sceneId, killerId, 2)
				LuaSubHonor(sceneId, selfId, 1)
			elseif deltaLevel < -30 then
				LuaAddHonor(sceneId, killerId, 5)
				LuaSubHonor(sceneId, selfId, 3)
			end


		else			--不同国
		
			--得到玩家PK值
			local PKVal = LuaFnGetPKValue(sceneId, selfId)
			--得到玩家背包和身上未绑定物品数
			local ItemCountInBag = LuaFnGetNotBindItemCountInBag(sceneId, selfId)
			local ItemCountInBody = LuaFnGetNotBindItemCountInBody(sceneId, selfId)

			local DropCountInBag = 0
			local DropCountInBody = 0

			if PKVal == 0 then
				--背包中未绑定的物品掉落10%件
				DropCountInBag = floor ( ItemCountInBag * 0.2  + 0.5 )
			elseif PKVal == 2 then
				--背包中未绑定的物品掉落15%
				DropCountInBag = floor ( ItemCountInBag * 0.15  + 0.5 )
			elseif PKVal == 3 then
				--背包中未绑定的物品掉落18%,身上未绑定的物品掉落8%
				DropCountInBag = floor ( ItemCountInBag * 0.18  + 0.5 )
				DropCountInBody = floor ( ItemCountInBody * 0.08  + 0.5 )
			elseif PKVal == 4 then
				--背包中未绑定的物品掉落23%,身上未绑定的物品掉落13%
				DropCountInBag = floor ( ItemCountInBag * 0.23  + 0.5 )
				DropCountInBody = floor ( ItemCountInBody * 0.13  + 0.5 )
			elseif PKVal == 5 then
				--背包中未绑定的物品掉落30%,身上未绑定的物品掉落16%
				DropCountInBag = floor ( ItemCountInBag * 0.3  + 0.5 )
				DropCountInBody = floor ( ItemCountInBody * 0.16  + 0.5 )
			end

			text = format("玩家PK值 = %d,背包在有%d个未绑定物品,掉落%d件。",PKVal,ItemCountInBag,DropCountInBag )
			--PrintStr(text)

			--DropCountInBag = 1
			for i=1,DropCountInBag do
				local DropIndex = random(ItemCountInBag-i+1)
				LuaFnDropNotBindItemInBag(sceneId, selfId,DropIndex)
			end

			for i=1,DropCountInBody do
				local DropIndex = random(ItemCountInBody-i+1)
				LuaFnDropNotBindItemInBody(sceneId, selfId,DropIndex)
			end
		end

    
    elseif ObjType == 2 then -- OBJ_TYPE_MONSTER
        --得到玩家PK值
		local PKVal = LuaFnGetPKValue(sceneId, selfId)
		--得到玩家背包和身上未绑定物品数
		local ItemCountInBag = LuaFnGetNotBindItemCountInBag(sceneId, selfId)
		local ItemCountInBody = LuaFnGetNotBindItemCountInBody(sceneId, selfId)

		local DropCountInBag = 0
		local DropCountInBody = 0

		if PKVal == 0 then
			--背包中未绑定的物品掉落10%件
			DropCountInBag = floor ( ItemCountInBag * 0.2  + 0.5 )
		elseif PKVal == 2 then
			--背包中未绑定的物品掉落15%
			DropCountInBag = floor ( ItemCountInBag * 0.15  + 0.5 )
		elseif PKVal == 3 then
			--背包中未绑定的物品掉落18%,身上未绑定的物品掉落8%
			DropCountInBag = floor ( ItemCountInBag * 0.18  + 0.5 )
			DropCountInBody = floor ( ItemCountInBody * 0.08  + 0.5 )
		elseif PKVal == 4 then
			--背包中未绑定的物品掉落23%,身上未绑定的物品掉落13%
			DropCountInBag = floor ( ItemCountInBag * 0.23  + 0.5 )
			DropCountInBody = floor ( ItemCountInBody * 0.13  + 0.5 )
		elseif PKVal == 5 then
			--背包中未绑定的物品掉落30%,身上未绑定的物品掉落16%
			DropCountInBag = floor ( ItemCountInBag * 0.3  + 0.5 )
			DropCountInBody = floor ( ItemCountInBody * 0.16  + 0.5 )
		end

		text = format("玩家PK值 = %d,背包在有%d个未绑定物品,掉落%d件。",PKVal,ItemCountInBag,DropCountInBag )
		--PrintStr(text)

		--DropCountInBag = 1
		for i=1,DropCountInBag do
			local DropIndex = random(ItemCountInBag-i+1)
			LuaFnDropNotBindItemInBag(sceneId, selfId,DropIndex)
		end

		for i=1,DropCountInBody do
			local DropIndex = random(ItemCountInBody-i+1)
			LuaFnDropNotBindItemInBody(sceneId, selfId,DropIndex)
		end

    end


	local sceneType = LuaFnGetSceneType(sceneId) 
	if sceneType == 1 then --场景类型是副本

		local copyscenescript = LuaFnGetCopySceneData_Param(sceneId,1) ; --取得脚本号

		CallScriptFunction( copyscenescript, "OnHumanDie", sceneId, selfId, killerId )

	end

end




function x888888_OnSceneHumanLevelUp( sceneId, objId, level )

end



function x888888_OnSceneNotify( sceneId, destsceneId )

--sceneId 为副本入口所在场景ID, destsceneId为副本场景ID

--此函数响应调用表示副本场景已经初始化完成，可以传送玩家了



	local destsceneType = LuaFnGetSceneType(destsceneId) ;



	if destsceneType == 1 then --场景类型是副本



		copyscenetype = LuaFnGetCopySceneData_Param(destsceneId,0) ;--取得副本号

		copyscenescript = LuaFnGetCopySceneData_Param(destsceneId,1) ; --取得脚本号



		if copyscenetype==FUBEN_EXAMPLE then --例子

			--例子不提供场景启动事件

			print("不能使用例子副本类型，例子副本类型不提供场景启动事件")

		elseif copyscenetype==FUBEN_EXAMPLE then --

			CallScriptFunction( copyscenescript, "OnCopySceneReady", sceneId, destsceneId ) ;

		elseif copyscenetype==FUBEN_MURENXIANG_7 then --7级木人巷副本

			CallScriptFunction( copyscenescript, "OnCopySceneReady", sceneId, destsceneId ) ;

		elseif copyscenetype==FUBEN_MURENXIANG_9 then --9级木人巷副本

			CallScriptFunction( copyscenescript, "OnCopySceneReady", sceneId, destsceneId ) ;

		elseif copyscenetype==FUBEN_MURENXIANG then --标准木人巷副本

			CallScriptFunction( copyscenescript, "OnCopySceneReady", sceneId, destsceneId ) ;

		elseif copyscenetype==FUBEN_SHUILAO then --水牢副本

			CallScriptFunction( copyscenescript, "OnCopySceneReady", sceneId, destsceneId ) ;

		elseif copyscenetype==FUBEN_ZHENGLONG then --蒸笼棋局副本

			CallScriptFunction( copyscenescript, "OnCopySceneReady", sceneId, destsceneId ) ;

		elseif copyscenetype==FUBEN_MONSTERPARTY then --怪兽总动员副本

			CallScriptFunction( copyscenescript, "OnCopySceneReady", sceneId, destsceneId ) ;
		elseif copyscenetype==FUBEN_HUOCAISHENDIAN then --活财神殿副本

			CallScriptFunction( copyscenescript, "OnCopySceneReady", sceneId, destsceneId ) ;
			
		elseif copyscenetype==FUBEN_JUNYAOYAOKOU then --钧窑窑口副本

			CallScriptFunction( copyscenescript, "OnCopySceneReady", sceneId, destsceneId ) ;	
		elseif copyscenetype==FUBEN_GOULANQUTAI then --勾栏曲台副本
			
			CallScriptFunction( copyscenescript, "OnCopySceneReady", sceneId, destsceneId ) ;	
		elseif copyscenetype==FUBEN_HUOCAISHENDIAN then --活财神庙副本
			
			CallScriptFunction( copyscenescript, "OnCopySceneReady", sceneId, destsceneId ) ;	
		elseif copyscenetype==FUBEN_01 then --测试用
			CallScriptFunction( copyscenescript, "OnCopySceneReady", sceneId, destsceneId ) ;	
		elseif copyscenetype==FUBEN_02 then --测试用
			CallScriptFunction( copyscenescript, "OnCopySceneReady", sceneId, destsceneId ) ;	
		elseif copyscenetype==FUBEN_MANTUOSHANZHANG then --曼陀山庄
			CallScriptFunction( copyscenescript, "OnCopySceneReady", sceneId, destsceneId ) ;	
		end

	end

end



-- 问路

function x888888_AskTheWay( sceneId, selfId, sceneNum, x, y, tip )

	Msg2Player( sceneId, selfId, "@*;flagNPC;" .. sceneNum .. ";" .. x .. ";" .. y .. ";" .. tip, MSG2PLAYER_PARA )

	Msg2Player( sceneId, selfId, "@*;flashNPC;" .. sceneNum .. ";" .. x .. ";" .. y .. ";" .. tip, MSG2PLAYER_PARA )

end



-- 播放音效，UICommandID = 123

function x888888_PlaySoundEffect( sceneId, selfId, soundId )

	BeginUICommand(sceneId)

		UICommand_AddInt(sceneId, soundId)

	EndUICommand(sceneId)

	DispatchUICommand(sceneId,selfId, 123)

end



--任务接受检测

function x888888_OnAcceptMissionCheck( sceneId, selfId, missionScript )

	if GetMissionCount(sceneId, selfId)>=20 then

		BeginEvent(sceneId)

		local	strText = "任务已满！"

			AddText(sceneId,strText);

		EndEvent(sceneId)

		DispatchMissionTips(sceneId,selfId)

		return 0

	end

	

	return 1

end

--任务Npc默认对话框

function x888888_OnNpcDefaultDialog( sceneId, selfId, targetId)
	
	local npcType = GetMonsterDataID(sceneId,targetId)
	BeginEvent(sceneId)

		local strText = "&&"..npcType.."&&"

		AddText(sceneId,strText);

	EndEvent(sceneId)	
	DispatchEventList(sceneId,selfId,targetId)

	return 1

end


function x888888_OnNpcDefaultEventList( sceneId, selfId, targetId)
	BeginEvent(sceneId)
	local npcType = GetMonsterDataID(sceneId,targetId)


		local strText = "&&"..npcType.."&&"

		AddText(sceneId,strText);
		ShowNpcEventList(sceneId,selfId,targetId)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
	return 1

end




--************************
--
--模板函数
--
--************************

--****打印说明*********

--参数说明：
--	sceneId:							
--	MissionName:					任务名
--	Info:									要显示的任务说明或者继续说明
--	MissionTarget:				任务目标
--	DemandItems:					任务要求物品
--	MoneyBonus:						任务奖励金钱
--	ItemBonus:						任务奖励道具
--	RandItemBonus:				任务奖励随机道具
--	RadioItemBonus:				任务奖励可选道具
--功能说明：
--	在任务文本框中显示所需要显示的信息
--用法说明：
--	需要封闭在Event块内，需要Dispatch实现，忽略参数填写nil（包括金额）

function x888888_PrintInfo(sceneId, MissionName, Info, MissionTarget, DemandItems, MoneyBonus, ItemBonus, RandItemBonus, RadioItemBonus)

	AddText(sceneId, MissionName)
	AddText(sceneId, Info)
	AddText(sceneId, "#Y任务目标")
	AddText(sceneId, MissionTarget)
	
	if DemandItems ~= nil then
		for i, item in DemandItems do
			AddItemDemand(sceneId, item.id, item.num)
		end
	end
	
	if MoneyBonus ~= nil then
		AddMoneyBonus(sceneId, MoneyBonus)
	end
	if ItemBonus ~= nil then
		for i, item in ItemBonus do
			AddItemBonus(sceneId, item.id, item.num)
		end
	end
	if RandItemBonus ~= nil then
		for i, item in RandItemBonus do
			AddRandItemBonus(sceneId, item.id, item.num)
		end
	end
	if RadioItemBonus ~= nil then
		for i, item in RadioItemBonus do
			AddRadioItemBonus(sceneId, item.id, item.num)
		end
	end
		
end

--*******查看是否含有物品**********

--参数说明：
--	sceneId:							
--	selfId:
--	Items:				所需检查的道具
--功能说明：
--	检查任务身上是否有该物品
--用法说明：
--	道具数组结构：
--		id：道具编号
--		num：道具个数
function x888888_CheckHaveItems(sceneId, selfId, Items)

	if Items ~= nil then
		for i, item in Items do
			return HaveItem(sceneId, selfId, item.id)
		end
	end
	
	return 0

end

--******删除并增加物品*********

--参数说明：
--	sceneId:							
--	selfId:			
--	ItemToDelete:				需要删除的道具
--	ItemToAdd:					需要添加的道具
--	NormalMessage:			接受任务后显示的信息
--	ErrorMessage:				背包满的时候显示的信息
--功能说明：
--	在任务文本框中显示所需要显示的信息
--用法说明：
--	需要封闭在Event块内，需要Dispatch实现，忽略参数填写nil（包括金额）
--	从人物身上删除之前应判断是否含有该道具
--	道具数组结构：
--		id：道具编号
--		num：道具个数
function x888888_DeleteAndAddItem(sceneId, selfId, ItemToDelete, ItemToAdd, NormalMessage, ErrorMessage)

	local ret = 1
	local message = nil
	
	if ItemToAdd ~= nil then
		BeginAddItem(sceneId)
		--加入道具至列表
		for i, item in ItemToAdd do
			AddItem(sceneId,item.id, item.num)
		end
	
		ret = EndAddItem(sceneId, selfId)
	
		if ret > 0 then
		
			AddItemListToHuman(sceneId, selfId)
			message = NormalMessage
		
		else
		
			message = ErrorMessage
			
		end
		
	end
	
	if ItemToDelete ~= nil then
	
		--从人物身上删除（之前应判断是否含有道具）
		for i, item in ItemToDelete do
			DelItem(sceneId, selfId, item.id, item.num)
		end
		
	end
	
	BeginEvent(sceneId)

	if message ~= nil then
		AddText(sceneId, message)
	end

	EndEvent(sceneId)

	DispatchMissionTips(sceneId, selfId)
	
	return ret

end
