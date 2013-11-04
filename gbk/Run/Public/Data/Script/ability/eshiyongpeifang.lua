--使用配方的脚本

--脚本号
x713501_g_scriptId = 713501

x713501_g_RecipeItems = {}

-- ItemTable 号为索引

-- abilityId: 生长点对应技能
-- recipeId: 学习的对应配方号
-- needLevel: 学习此配方需要的相应生活技能级别
-- specialEffectID: 特效号

ZhuZao  = 4
ZhiYi   = 5
GongYi  = 6
PengRen = 7

x713501_g_RecipeItems[	12040011	] = { abilityId = ZhuZao, recipeId =	1	, needLevel =	1	, specialEffectID =	18	}
x713501_g_RecipeItems[	12040012	] = { abilityId = ZhuZao, recipeId =	2	, needLevel =	1	, specialEffectID =	18	}


x713501_g_RecipeItems[	12040012	] = { abilityId = ZhiYi, recipeId =	3	, needLevel =	1	, specialEffectID =	18	}
x713501_g_RecipeItems[	12040012	] = { abilityId = ZhiYi, recipeId =	4	, needLevel =	1	, specialEffectID =	18	}

x713501_g_RecipeItems[	12040013	] = { abilityId = GongYi, recipeId =	5	, needLevel =	1	, specialEffectID =	18	}
x713501_g_RecipeItems[	12040013	] = { abilityId = GongYi, recipeId =	6	, needLevel =	1	, specialEffectID =	18	}

x713501_g_RecipeItems[	12040014	] = { abilityId = PengRen, recipeId =	7	, needLevel =	1	, specialEffectID =	18	}
x713501_g_RecipeItems[	12040014	] = { abilityId = PengRen, recipeId =	8	, needLevel =	1	, specialEffectID =	18	}


--**********************************
-- 通用部分：使用配方，返回 1 表示学会
--**********************************
function x713501_ReadRecipe( sceneId, selfId, recipeIndex )
	local RecipeFlag = IsPrescrLearned( sceneId, selfId, recipeIndex )

	if RecipeFlag < 1 then
	-- 没有学会
		SetPrescription( sceneId, selfId, recipeIndex, 1 )
		Msg2Player( sceneId, selfId, "你学会一项新的配方", MSG2PLAYER_PARA )
		return 1
	else
	-- 已学会
	-- 目前 SetPrescription 是个双开关，学会了再调用会放弃，但是不摧毁配方实体。测试使用
		Msg2Player( sceneId, selfId, "该配方已学会", MSG2PLAYER_PARA )
		return 0
	end

	return 0
end

--**********************************
-- 返回1：技能类似的物品，可以继续类似技能的执行；返回0：执行 OnDefaultEvent。
--**********************************
function x713501_IsSkillLikeScript( sceneId, selfId )
	return 1
end

--**********************************
-- 返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x713501_CancelImpacts( sceneId, selfId )
	return 0
end

--**********************************
-- 条件检测入口：返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x713501_OnConditionCheck( sceneId, selfId )
	-- 校验使用的物品
	if LuaFnVerifyUsedItem( sceneId, selfId ) ~= 1 then
		return 0
	end

	-- 找到配方条目
	local itemTblIndex = LuaFnGetItemIndexOfUsedItem( sceneId, selfId )
	local recipeItem = x713501_g_RecipeItems[itemTblIndex]
	if not recipeItem then
		return
	end

	local AbilityLevel = QueryHumanAbilityLevel( sceneId, selfId, recipeItem.abilityId )
	--如果技能不够使用要求
	if AbilityLevel < recipeItem.needLevel then
		x713501_NotifyFailTips( sceneId, selfId, "技能等级不足" )
		return 0
	end

	if LuaFnIsPrescrLearned( sceneId, selfId, recipeItem.recipeId ) > 0 then
		x713501_NotifyFailTips( sceneId, selfId, "这个配方已经学会了" )
		return 0
	end

	return 1
end

--**********************************
--消耗检测及处理入口，负责消耗的检测和执行：
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--**********************************
function x713501_OnDeplete( sceneId, selfId )
	if LuaFnDepletingUsedItem( sceneId, selfId ) > 0 then
		return 1
	end

	return 0
end

--**********************************
--只会执行一次入口：
--聚气和瞬发技能会在消耗完成后调用这个接口（聚气结束并且各种条件都满足的时候），而引导
--技能也会在消耗完成后调用这个接口（技能的一开始，消耗成功执行之后）。
--返回1：处理成功；返回0：处理失败。
--注：这里是技能生效一次的入口
--**********************************
function x713501_OnActivateOnce( sceneId, selfId )
	-- 找到配方条目
	local itemTblIndex = LuaFnGetItemIndexOfUsedItem( sceneId, selfId )
	local recipeItem = x713501_g_RecipeItems[itemTblIndex]
	if not recipeItem then
		return 0
	end

	-- 调用通用配方学习
	x713501_ReadRecipe( sceneId, selfId, recipeItem.recipeId )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, recipeItem.specialEffectID, 0 )
	return 1
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能心跳时生效的入口
--**********************************
function x713501_OnActivateEachTick( sceneId, selfId )
	return 1
end

--**********************************
-- 醒目失败提示
--**********************************
function x713501_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
