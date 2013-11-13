--MisDescBegin

-------------------------
--***********************
--Const
--***********************
-------------------------

x300100_g_MissionId					= 400
x300100_g_ScriptId 					= 300100
x300100_g_MissionName				= "征税"
x300100_g_MissionKind				= 23
x300100_g_MissionLevel			= 1

x300100_g_LevelUntil				= 30
x300100_g_TexMoneyLevelRate	= 0.35
x300100_g_TexMoneyBase			= 90
x300100_g_TexLevelBase			= 5

x300100_g_MissionTarget			= "%s的%s一直拖欠税资，你去帮我收回他拖欠的税款吧，我会给你一些报酬的。你可以通过Q键打开任务管理，自动寻路找到他。"
x300100_g_MissionInfo				=	{
																{hash = 0, message = "%s的%s一直拖欠税资，你去帮我收回他拖欠的税款吧，我会给你一些报酬的。你可以通过Q键打开任务管理，自动寻路找到他。"},
																{hash = 1, message = "%s的%s长期偷税漏税，违法经营，拜托你代我去收回欠税吧，我不会忘记给你好处的！你可以通过Q键打开任务管理，自动寻路找到他。"},
															}

x300100_g_MissionCompleteInfo	=	{
																	{hash = 0, message = "看在你亲自征税的面子上，就把税金交给你吧。这里有些小钱，就算是跑腿费了！"},
																	{hash = 1, message = "这是税金，我交，我交，我没说不交啊，何必呢？这点小钱请您笑纳！一点小意思！"}
																}

x300100_g_MissionContinueInfo		= "我给你的任务还没有完成，快去帮我收税吧！"

x300100_g_MissionNPCName		= {
																{scene = 11, name = "苏菲", scenename = "新月汗国"},		--新月
																{scene = 18, name = "苏菲", scenename = "金帐汗国"},		--金帐
																{scene = 21, name = "苏菲", scenename = "雪域汗国"},		--雪域
																{scene = 24, name = "苏菲", scenename = "大漠汗国"},		--大漠
																{scene = 36, name = "西门君临", scenename = "皇城"},		--皇城
															}
x300100_g_MissionAimNPCName	=	{
																{hash = 0, scene = 11, name = "药店老板"},
																{hash = 1, scene = 11, name = "中心治疗师"},
																{hash = 2, scene = 36, name = "衣凌峰"},
																{hash = 3, scene = 36, name = "阿里巴巴"},
																{hash = 4, scene = 36, name = "沈万三"},
																{hash = 5, scene = 36, name = "蔡婆"}
															}
															
x300100_g_MissionBonusInfo			= "获得%d金%d银%d铜的奖励。"

x300100_g_AbandonMinute		= 15
x300100_g_RoundLimit			= 10
x300100_g_ShaQiUntil			= 0
															
x300100_g_ErrorMessage_Country	= "你不是本国人！"
x300100_g_ErrorMessage_Level		= "你的等级已经可以在江湖上有更大的作为，我没有任务再拜托你了！"
x300100_g_ErrorMessage_NPC			= "找错人了！"
x300100_g_ErrorMessage_Abandon	= format("你刚刚放弃了任务还不足%d分钟，稍后再来吧！", x300100_g_AbandonMinute)
x300100_g_ErrorMessage_Round		= format("你今天已经帮我收了%d次税了，去歇息吧！明天再来吧！", x300100_g_RoundLimit)
x300100_g_ErrorMessage_ShaQi		= "你的杀气太重，我不能把征税的任务交给你！"

-------------------------
--***********************
--Define
--***********************
-------------------------

x300100_OK_AIM					= 0
x300100_OK_MISSION			= 1
x300100_ERROR_UNKNOWN		= -1

x300100_FAILED_COUNTRY	= 10
x300100_FAILED_LEVEL		= 11
x300100_FAILED_NPC			= 12
x300100_FAILED_ABANDON	= 13
x300100_FAILED_ROUND		= 14
x300100_FAILED_SHAQI		= 15

x300100_MP_AIMNPC				= 0

--MisDescEnd


-------------------------
--***********************
--IsMissionNPC
--***********************
-------------------------

function x300100_IsMissionNPC(sceneId, selfId, missionId, NPCId)

	for i, item in pairs(x300100_g_MissionNPCName) do
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
--IsAimNPC
--***********************
-------------------------

function x300100_IsAimNPC(sceneId, selfId, missionId, NPCId)

	local misIndex = GetMissionIndexByID(sceneId, selfId, x300100_g_MissionId);
	local aimNPCHash = GetMissionParam(sceneId, selfId, misIndex, x300100_MP_AIMNPC);

	for i, item in pairs(x300100_g_MissionAimNPCName) do
		if item.scene == sceneId then
			if item.hash == aimNPCHash then
				if GetName(sceneId, NPCId) == item.name then
					return 1;
				end
			end
		end
	end
	
	return 0;

end

-------------------------
--***********************
--CheckRound
--***********************
-------------------------

function x300100_CheckRound(sceneId, selfId, NPCId)

	local daycount = GetMissionData(sceneId, selfId, MD_ZHENGSHUI_DAYCOUNT);
	local nowtime = LuaFnGetCurrentTime();
	
	local today = floor(nowtime / 86400);
	local round = 0;
	
	if today == floor(daycount / 10000) then
		round = floor((daycount - today * 10000) / 100) + 1;
		if round >= x300100_g_RoundLimit then
			return -1;
		end
	end
	
	return round;

end

-------------------------
--***********************
--CheckCircle
--***********************
-------------------------

function x300100_CheckCircle(sceneId, selfId, NPCId)

	local daycount = GetMissionData(sceneId, selfId, MD_ZHENGSHUI_DAYCOUNT);
	local nowtime = LuaFnGetCurrentTime();
	local round = x300100_CheckRound(sceneId, selfId, NPCId);
	
	if round <= 0 then
		return 0;
	end
	
	local today = floor(nowtime / 86400);
	local circle = 0;
	
	if today == floor(daycount / 10000) then
		circle = daycount - today * 10000 - (round - 1) * 100;
	end
	
	if round < circle then
		return round;
	end;
	
	return circle;

end

-------------------------
--***********************
--CheckCountry
--***********************
-------------------------

function x300100_CheckCountry(sceneId, selfId, NPCId)

	return 1;

end

-------------------------
--***********************
--CheckShaQi
--***********************
-------------------------

function x300100_CheckShaQi(sceneId, selfId, NPCId)

	return 1;

end

-------------------------
--***********************
--SafeDisplayCheck
--***********************
-------------------------

function x300100_SafeDisplayCheck(sceneId, selfId, NPCId)

	local bHaveMission = IsHaveMission(sceneId, selfId, x300100_g_MissionId);
	
	if bHaveMission > 0 then
		return 1;
	end
	
	if x300100_IsMissionNPC(sceneId, selfId, x300100_g_MissionId, NPCId) > 0 then
		return 1;
	end
	
	return 0;

end

-------------------------
--***********************
--SafeNPCCheck
--***********************
-------------------------

function x300100_SafeNPCCheck(sceneId, selfId, NPCId)
	
	local bHaveMission = IsHaveMission(sceneId, selfId, x300100_g_MissionId);
	
	if bHaveMission > 0 then

		if x300100_IsAimNPC(sceneId, selfId, x300100_g_MissionId, NPCId) > 0 then
			return x300100_OK_AIM;
		end
		
	else
	
		if x300100_CheckCountry(sceneId, selfId, NPCId) < 0 then
			return x300100_FAILED_COUNTRY;
		end
		
		if x300100_CheckShaQi(sceneId, selfId, NPCId) < 0 then
			return x300100_FAILED_SHAQI;
		end
		
		if GetLevel(sceneId, selfId) > x300100_g_LevelUntil then
			return x300100_FAILED_LEVEL;
		end
		
		if x300100_CheckRound(sceneId, selfId, NPCId) < 0 then
			return x300100_FAILED_ROUND;
		end
	
		if x300100_CheckAbandon(sceneId, selfId, NPCId) <= 0 then
			return x300100_FAILED_ABANDON;
		end
	end

	if x300100_IsMissionNPC(sceneId, selfId, x300100_g_MissionId, NPCId) > 0 then
		return x300100_OK_MISSION;
	end
	
	return x300100_FAILED_NPC;

end

-------------------------
--***********************
--OnEnumerate
--***********************
-------------------------

function x300100_OnEnumerate(sceneId, selfId, NPCId)

	if x300100_SafeDisplayCheck(sceneId, selfId, NPCId) > 0 then
		AddNumText(sceneId, x300100_g_ScriptId, x300100_g_MissionName);
	end

end

-------------------------
--***********************
--GetRandomAimNPCHash
--***********************
-------------------------

function x300100_GetRandomAimNPCHash(sceneId, selfId, NPCId)

	local numInScene = 0;
	
	for i, item in pairs(x300100_g_MissionAimNPCName) do
		if item.scene == sceneId then
			numInScene = numInScene + 1;
		end
	end
	
	if numInScene == 0 then
		return x300100_ERROR_UNKNOWN;
	end
	
	local randNum = random(0, numInScene-1);
	
	numInScene = 0;
	
	for i, item in pairs(x300100_g_MissionAimNPCName) do
		if item.scene <= sceneId then
			if numInScene == randNum then
				return item.hash;
			end
			numInScene = numInScene + 1;
		end
	end
	
	return x300100_ERROR_UNKNOWN;

end

-------------------------
--***********************
--GetAimNPCName
--***********************
-------------------------

function x300100_GetAimNPCName(sceneId, selfId, aimNPCHash)

	for i, item in pairs(x300100_g_MissionAimNPCName) do
		if item.hash == aimNPCHash then
			return item.name;
		end
	end
	
	return nil;

end

-------------------------
--***********************
--GetRandomMissionInfo
--***********************
-------------------------

function x300100_GetRandomMissionInfo(sceneId, selfId, NPCId)

	local size = 0;
	
	for i, item in pairs(x300100_g_MissionInfo) do
		size = size + 1;
	end
	
	if size == 0 then
		return nil;
	end
	
	local randNum = random(0, size-1) + 1;
	return x300100_g_MissionInfo[randNum].message;

end

-------------------------
--***********************
--GetRandomCompleteInfo
--***********************
-------------------------

function x300100_GetRandomCompleteInfo(sceneId, selfId, NPCId)

	local size = 0;
	
	for i, item in pairs(x300100_g_MissionCompleteInfo) do
		size = size + 1;
	end
	
	if size == 0 then
		return nil;
	end
	
	local randNum = random(0, size-1) + 1;

	return x300100_g_MissionCompleteInfo[randNum].message;

end

-------------------------
--***********************
--GetSceneName
--***********************
-------------------------
function x300100_GetSceneName(sceneId, selfId, NPCId)

	for i, item in pairs(x300100_g_MissionNPCName) do
		if item.scene == sceneId then
			return item.scenename;
		end
	end
	
	return nil;

end

-------------------------
--***********************
--CheckAbandon
--***********************
-------------------------

function x300100_CheckAbandon(sceneId, selfId, NPCId)

	local nowtime = LuaFnGetCurrentTime();
	local lastAbandon = GetMissionData(sceneId, selfId, MD_ZHENGSHUI_LASTABANDON);
	
	if nowtime - lastAbandon < x300100_g_AbandonMinute * 60 then
		return 0;
	end
	
	return 1;

end

-------------------------
--***********************
--OnDefaultEvent
--***********************
-------------------------

function x300100_OnDefaultEvent(sceneId, selfId, NPCId)

	local safeCheckRet = x300100_SafeNPCCheck(sceneId, selfId, NPCId);
	local bHaveMission = IsHaveMission(sceneId, selfId, x300100_g_MissionId);

	local aimNPCHash;
	local str = x300100_g_MissionName;
	str = str.."\n";
	
	if safeCheckRet == x300100_OK_AIM then
		str = str..x300100_GetRandomCompleteInfo(sceneId, selfId, NPCId);
	elseif safeCheckRet == x300100_OK_MISSION then
		if bHaveMission > 0 then
			str = str..x300100_g_MissionContinueInfo;
		else
			aimNPCHash = x300100_GetRandomAimNPCHash(sceneId, selfId, NPCId);
			if aimNPCHash == x300100_ERROR_UNKNOWN then
				return
			end
			str = str..format(x300100_GetRandomMissionInfo(sceneId, selfId, NPCId), x300100_GetSceneName(sceneId, selfId, NPCId), x300100_GetAimNPCName(sceneId, selfId, aimNPCHash));
		end
	elseif safeCheckRet == x300100_FAILED_SHAQI then
		str = str..x300100_g_ErrorMessage_ShaQi;
	elseif safeCheckRet == x300100_FAILED_ABANDON then
		str = str..x300100_g_ErrorMessage_Abandon;
	elseif safeCheckRet == x300100_FAILED_ROUND then
		str = str..x300100_g_ErrorMessage_Round;
	elseif safeCheckRet == x300100_FAILED_COUNTRY then
		str = str..x300100_g_ErrorMessage_Country;
	elseif safeCheckRet == x300100_FAILED_LEVEL then
		str = str..x300100_g_ErrorMessage_Level;
	elseif safeCheckRet == x300100_FAILED_NPC then
		str = str..x300100_g_ErrorMessage_NPC;
	end
	
	BeginEvent(sceneId);
		AddText(sceneId, str);
	EndEvent();
	DispatchEventList(sceneId, selfId, NPCId);
	
	if safeCheckRet == x300100_OK_MISSION and bHaveMission <= 0 then

		AddMission(sceneId, selfId, x300100_g_MissionId, x300100_g_ScriptId, 1, 0, 0);
		local misIndex = GetMissionIndexByID(sceneId, selfId, x300100_g_MissionId);
		SetMissionByIndex(sceneId, selfId, misIndex, x300100_MP_AIMNPC, aimNPCHash);
		
		local daycount = GetMissionData(sceneId, selfId, MD_ZHENGSHUI_DAYCOUNT);	--day*10000+round*100+circle
		local nowtime = LuaFnGetCurrentTime();
		local today = floor(nowtime / 86400);
		if today == floor(daycount / 10000) then
			daycount = daycount + 101;
		else
			daycount = today * 10000 + 1;
		end
		SetMissionData(sceneId, selfId, MD_ZHENGSHUI_DAYCOUNT, daycount);

	elseif safeCheckRet == x300100_OK_AIM then
	
		local money = x300100_GetMoney(sceneId, selfId, NPCId);
		AddMoney(sceneId, selfId, money);
		
		local moneyjin = floor(money / 10000);
		local moneyyin = floor(money / 100) - moneyjin * 100;
		local moneytong = money - moneyjin * 10000 - moneyyin * 100;
		
		BeginEvent(sceneId);
			AddText(sceneId, format(x300100_g_MissionBonusInfo, moneyjin, moneyyin, moneytong));
		EndEvent();
		
		DispatchMissionTips(sceneId, selfId);
		DelMission(sceneId, selfId, x300100_g_MissionId);
		
	end

end

-------------------------
--***********************
--OnAbandon
--***********************
-------------------------

function x300100_OnAbandon(sceneId, selfId)

	DelMission(sceneId, selfId, x300100_g_MissionId);
	
	local lastAbandon = LuaFnGetCurrentTime();
	SetMissionData(sceneId, selfId, MD_ZHENGSHUI_LASTABANDON, lastAbandon);
	
	local daycount = GetMissionData(sceneId, selfId, MD_ZHENGSHUI_DAYCOUNT);	--day*10000+round*100+circle
	local round = x300100_CheckRound(sceneId, selfId, nil);
	if round <= 1 then
		round = 0;
	end
	daycount = floor(daycount / 10000) * 10000 + (round - 1) * 100;
	SetMissionData(sceneId, selfId, MD_ZHENGSHUI_DAYCOUNT, daycount);

end


-------------------------
--***********************
--GetMoney
--***********************
-------------------------

function x300100_GetMoney(sceneId, selfId, NPCId)

	local ret = x300100_g_TexMoneyBase +
		(GetLevel(sceneId, selfId) + x300100_g_TexLevelBase) * x300100_g_TexMoneyLevelRate * x300100_CheckCircle(sceneId, selfId, NPCId);
	return ret;
	
end