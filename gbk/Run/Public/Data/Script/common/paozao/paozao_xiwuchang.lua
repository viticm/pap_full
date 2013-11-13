
-------------------------
--***********************
--Const
--***********************
-------------------------

--MisDescBegin

x300310_g_MissionId					= 412
x300310_g_ScriptId 					= 300310
x300310_g_MissionName				= "习武场"
x300310_g_MissionKind				= 23
x300310_g_MissionLevel			= 1

x300310_g_LevelLess					= 30

x300310_g_MissionTarget			= "习武！"

--MisDescEnd

x300310_g_MissionInfo					=	{
																	"是否进入习武场习武？将扣除%d金%d银%d铜！",
																	"是否进入习武场习武！将扣除道具%s"
																}
x300310_g_MissionCompleteInfo	=	"你本次习武获得的总经验为%d！"
x300310_g_MissionContinueInfo	= "要离开习武场？"
x300310_g_StartXiWuMessage		= "开始习武！"

x300310_g_EnterFeeRate		= 40
x300310_g_GetExpInterval	= 15
x300310_g_ConsistTime			= floor(30 * 60 / x300310_g_GetExpInterval)
x300310_g_GetExpRate			= 60

x300310_g_DemandItem			= 10200001
x300310_g_DemandItemName	= "XXX"

x300310_g_MissionNPCName		= {
																{scene = 11, name = "打铁匠", scenename = "新月汗国", x=421, z=431},		--新月
																{scene = 18, name = "打铁匠", scenename = "金帐汗国", x=421, z=431},		--金帐
																{scene = 21, name = "打铁匠", scenename = "雪域汗国", x=421, z=431},		--雪域
																{scene = 24, name = "打铁匠", scenename = "大漠汗国", x=421, z=431}			--大漠
															}

x300310_g_AbandonNPCName		= {
																{scene = 11, name = "苏菲", scenename = "新月汗国", x=165, z=154},		--新月
																{scene = 18, name = "苏菲", scenename = "金帐汗国", x=165, z=154},		--金帐
																{scene = 21, name = "苏菲", scenename = "雪域汗国", x=165, z=154},		--雪域
																{scene = 24, name = "苏菲", scenename = "大漠汗国", x=165, z=154}			--大漠
															}															
x300310_g_MissionBonusInfo			= "你在本次习武时总共获得%d的经验！"
x300310_g_GetExpEveryMessage		= "获得经验%d！"

x300310_g_ErrorMessage					= "条件不符！"			
x300310_g_ErrorMessage_Country	= "你不是本国人！"
x300310_g_ErrorMessage_Level		= format("你等级不足%d！", x300310_g_LevelLess)

-------------------------
--***********************
--Define
--***********************
-------------------------

x300310_OK							= 0
x300310_ERROR_UNKNOWN		= -1

x300310_FAILED_COUNTRY	= 10
x300310_FAILED_LEVEL		= 11

x300310_MP_GETEXPTIME				= 0
x300310_MP_GETEXPEVERY			= 1
x300310_MP_GETEXPSTARTTIME	= 2
x300310_MP_SCENETIMERINDEX	= 3
x300310_MP_SCENEINDEX				= 4


-------------------------
--***********************
--IsMissionNPC
--***********************
-------------------------

function x300310_IsMissionNPC(sceneId, selfId, NPCId)

	for i, item in pairs(x300310_g_MissionNPCName) do
		if item.scene == sceneId then
			if GetName(sceneId, NPCId) == item.name then
				return 1;
			end
		end
	end
	
	return 0;

end

-------------------------
--***********************
--IsAbandonNPC
--***********************
-------------------------

function x300310_IsAbandonNPC(sceneId, selfId, NPCId)

	for i, item in pairs(x300310_g_AbandonNPCName) do
		if item.scene == sceneId then
			if GetName(sceneId, NPCId) == item.name then
				return 1;
			end
		end
	end
	
	return 0;

end

-------------------------
--***********************
--CheckCountry
--***********************
-------------------------

function x300310_CheckCountry(sceneId, selfId, NPCId)

	return 1;

end

-------------------------
--***********************
--SafeDisplayCheck
--***********************
-------------------------

function x300310_SafeDisplayCheck(sceneId, selfId, NPCId)

	local bHaveMission = IsHaveMission(sceneId, selfId, x300310_g_MissionId);
	
	if bHaveMission > 0 and x300310_IsAbandonNPC(sceneId, selfId, NPCId) > 0 then
		return 1;
	end
	
	if x300310_IsMissionNPC(sceneId, selfId, NPCId) > 0 then
		return x300310_GetMode(sceneId, selfId);
	end
	
	return 0;

end

-------------------------
--***********************
--SafeNPCCheck
--***********************
-------------------------

function x300310_SafeNPCCheck(sceneId, selfId, NPCId)
	
	local bHaveMission = IsHaveMission(sceneId, selfId, x300310_g_MissionId);
	
	if bHaveMission > 0 then
			return x300310_OK;
	else
	
		if x300310_CheckCountry(sceneId, selfId, NPCId) < 0 then
			return x300310_FAILED_COUNTRY;
		end
		
		if GetLevel(sceneId, selfId) < x300310_g_LevelLess then
			return x300310_FAILED_LEVEL;
		end
		
	end

	if x300310_IsMissionNPC(sceneId, selfId, NPCId) > 0 then
		local mode = x300310_GetMode(sceneId, selfId);
		return x300310_OK, mode;
	end
	
	return x300310_ERROR_UNKNOWN;

end

-------------------------
--***********************
--GetMode
--***********************
-------------------------

function x300310_GetMode(sceneId, selfId)

	if LuaFnGetItemCount(sceneId, selfId, x300310_g_DemandItem) > 0 then
		return 2;
	end
	
	if LuaFnGetMoney(sceneId, selfId) > x300310_GetEnterFee(sceneId, selfId) then
		return 1;
	end
	
	return -1;

end

-------------------------
--***********************
--OnEnumerate
--***********************
-------------------------

function x300310_OnEnumerate(sceneId, selfId, NPCId)

	if x300310_SafeDisplayCheck(sceneId, selfId, NPCId) > 0 then
		AddNumText(sceneId, x300310_g_ScriptId, x300310_g_MissionName);
	end

end

-------------------------
--***********************
--GetEnterFee
--***********************
-------------------------

function x300310_GetEnterFee(sceneId, selfId)

	return GetLevel(sceneId, selfId) * x300310_g_EnterFeeRate;

end

-------------------------
--***********************
--GetEnterFeeJYT
--***********************
-------------------------

function x300310_GetEnterFeeJYT(sceneId, selfId)

	local money = x300310_GetEnterFee(sceneId, selfId);
	
	local moneyjin = floor(money / 10000);
	local moneyyin = floor(money / 100) - moneyjin * 100;
	local moneytong = money - moneyjin * 10000 - moneyyin * 100;
	
	return moneyjin, moneyyin, moneytong;

end

-------------------------
--***********************
--GetNeedItemName
--***********************
-------------------------

function x300310_GetNeedItemName(sceneId, selfId)

	return x300310_g_DemandItemName;

end

-------------------------
--***********************
--OnDefaultEvent
--***********************
-------------------------

function x300310_OnDefaultEvent(sceneId, selfId, NPCId)

	local safeCheckRet, mode = x300310_SafeNPCCheck(sceneId, selfId, NPCId);
	local bHaveMission = IsHaveMission(sceneId, selfId, x300310_g_MissionId);

	local aimNPCHash;
	local str = x300310_g_MissionName;
	str = str.."\n";

	if safeCheckRet == x300310_OK then
		if bHaveMission > 0 then
			str = str..x300310_g_MissionContinueInfo;
		elseif mode == 1 then
			str = str..format(x300310_g_MissionInfo[1], x300310_GetEnterFeeJYT(sceneId, selfId));
		else
			str = str..format(x300310_g_MissionInfo[2], x300310_GetNeedItemName(sceneId, selfId));
		end
	elseif safeCheckRet == x300310_FAILED_COUNTRY then
		str = str..x300310_g_ErrorMessage_Country;
	elseif safeCheckRet == x300310_FAILED_LEVEL then
		str = str..x300310_g_ErrorMessage_Level;
	end
	
	BeginEvent(sceneId);
		AddText(sceneId, str);
	EndEvent();
	if bHaveMission > 0 then
		DispatchMissionContinueInfo(sceneId, selfId, NPCId, x300310_g_ScriptId, x300310_g_MissionId);
	else
		DispatchEventList(sceneId, selfId, NPCId);
	end
	
	if safeCheckRet == x300310_OK and bHaveMission <= 0 then

		DispatchMissionInfo(sceneId, selfId, NPCId, x300310_g_ScriptId, x300310_g_MissionId);
		
	end

end

-------------------------
--***********************
--CheckAccept
--***********************
-------------------------

function x300310_CheckAccept(sceneId, selfId, NPCId)

	return 1;

end

-------------------------
--***********************
--CostFeeItem
--***********************
-------------------------

function x300310_CostFeeItem(sceneId, selfId)

	local mode = x300310_GetMode(sceneId, selfId);
	
	if mode == 1 then
		local money = x300310_GetEnterFee(sceneId, selfId);
		if LuaFnCostMoney(sceneId, selfId, money) ~= 1 then
			return 0;
		end
	elseif mode == 2 then
		if DelItem(sceneId, selfId, x300310_g_DemandItem, 1) ~= 1 then
			return 0;
		end
	else
		return -1;
	end
	
	return 1;
	
end

-------------------------
--***********************
--OnAccept
--***********************
-------------------------

function x300310_OnAccept(sceneId, selfId, NPCId)

	if x300310_CostFeeItem(sceneId, selfId) <= 0 then
		BeginEvent(sceneId);
			AddText(sceneId, x300310_g_ErrorMessage);
		EndEvent();
		DispatchMissionTips(sceneId, selfId);
		return -1;
	end
	
	AddMission(sceneId, selfId, x300310_g_MissionId, x300310_g_ScriptId, 1, 0, 0);
	local misIndex = GetMissionIndexByID(sceneId, selfId, x300310_g_MissionId);
	SetMissionByIndex(sceneId, selfId, misIndex, x300310_MP_GETEXPTIME, 1);
	SetMissionByIndex(sceneId, selfId, misIndex, x300310_MP_GETEXPEVERY, x300310_GetExpEvery(sceneId, selfId));
	SetMissionByIndex(sceneId, selfId, misIndex, x300310_MP_GETEXPSTARTTIME, LuaFnGetCurrentTime());
	
	
	local text = x300310_g_StartXiWuMessage;
		
	BeginEvent(sceneId);
		AddText(sceneId, text);
	EndEvent();
		
	DispatchMissionTips(sceneId, selfId);
	
	local sceneTimerIndex = SetTimer(sceneId, selfId, 300310, "OnSceneTimer", 1);
	SetMissionByIndex(sceneId, selfId, misIndex, x300310_MP_SCENETIMERINDEX, sceneTimerIndex);
	
	local sceneIndex = 0;
	for i, item in pairs(x300310_g_MissionNPCName) do
		sceneIndex = sceneIndex + 1;
		if item.scene == sceneId then
			break;
		end
	end
	SetMissionByIndex(sceneId, selfId, misIndex, x300310_MP_SCENEINDEX, sceneIndex);
	
	local item = x300310_g_AbandonNPCName[sceneIndex];
--	NewWorld(sceneId, selfId, item.scene, item.x, item.z);
	SetPos(sceneId, selfId, item.x, item.z);

end

-------------------------
--***********************
--OnSceneTimer
--***********************
-------------------------

function x300310_OnSceneTimer(sceneId, selfId)

	local bHaveMission = IsHaveMission(sceneId, selfId, x300310_g_MissionId);
	
	if bHaveMission <= 0 then
		return -1;
	end
	
	local misIndex = GetMissionIndexByID(sceneId, selfId, x300310_g_MissionId);
	local nowTime = LuaFnGetCurrentTime();
	local diffTime = nowTime - GetMissionParam(sceneId, selfId, misIndex, x300310_MP_GETEXPSTARTTIME);
	local getExpTime = GetMissionParam(sceneId, selfId, misIndex, x300310_MP_GETEXPTIME);

	if diffTime >= getExpTime * x300310_g_GetExpInterval then
		local exp = x300310_GetExp(sceneId, selfId);
		LuaFnAddExp(sceneId, selfId, exp);
		local text = format(x300310_g_GetExpEveryMessage, exp);
		
		BeginEvent(sceneId);
			AddText(sceneId, text);
		EndEvent();
		
		DispatchMissionTips(sceneId, selfId);
		SetMissionByIndex(sceneId, selfId, misIndex, x300310_MP_GETEXPTIME, getExpTime + 1);
	end
	
	if getExpTime > x300310_g_ConsistTime then
		x300310_EndMission(sceneId, selfId);
	end

end

-------------------------
--***********************
--GetExpEvery
--***********************
-------------------------

function x300310_GetExpEvery(sceneId, selfId)

	local level = GetLevel(sceneId, selfId);
	return level * x300310_g_GetExpRate;

end

-------------------------
--***********************
--EndMission
--***********************
-------------------------

function x300310_EndMission(sceneId, selfId)

	local misIndex = GetMissionIndexByID(sceneId, selfId, x300310_g_MissionId);
	local exp = (GetMissionParam(sceneId, selfId, misIndex, x300310_MP_GETEXPTIME) - 1) * GetMissionParam(sceneId, selfId, misIndex, x300310_MP_GETEXPEVERY);
	
	BeginEvent(sceneId);
		AddText(sceneId, format(x300310_g_MissionBonusInfo, exp));
	EndEvent();
	
	DispatchMissionTips(sceneId, selfId);
	
	local sceneTimerIndex = GetMissionParam(sceneId, selfId, misIndex, x300310_MP_SCENETIMERINDEX);
	StopTimer(sceneId, sceneTimerIndex);
	
	local sceneIndex = GetMissionParam(sceneId, selfId, misIndex, x300310_MP_SCENEINDEX);
	local item = x300310_g_MissionNPCName[sceneIndex];
--	NewWorld(sceneId, selfId, item.scene, item.x, item.z);
	SetPos(sceneId, selfId, item.x, item.z);
	DelMission(sceneId, selfId, x300310_g_MissionId);
		
end

-------------------------
--***********************
--OnAbandon
--***********************
-------------------------

function x300310_OnAbandon(sceneId, selfId)

	x300310_EndMission(sceneId, selfId);

end


-------------------------
--***********************
--OnSubmit
--***********************
-------------------------

function x300310_OnSubmit(sceneId, selfId)

	x300310_EndMission(sceneId, selfId);

end

-------------------------
--***********************
--GetExp
--***********************
-------------------------

function x300310_GetExp(sceneId, selfId)

	local ret;
	local misIndex = GetMissionIndexByID(sceneId, selfId, x300310_g_MissionId);
	ret = GetMissionParam(sceneId, selfId, misIndex, x300310_MP_GETEXPEVERY);
	return ret;
			
end