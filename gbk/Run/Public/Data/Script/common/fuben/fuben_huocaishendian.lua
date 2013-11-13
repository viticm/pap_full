--MisDescBegin
-------------------------
--***********************
--Const
--***********************
-------------------------

x700003_g_ScriptId 				= 700003
x700003_g_MissionId 			= 408
x700003_g_MissionKind 		= 23

x700003_g_FuBenType				= 1

x700003_g_CopySceneName				= "活财神殿"
x700003_g_Name								= "财神殿守卫"
x700003_g_CopySceneType				= FUBEN_HUOCAISHENDIAN
x700003_g_LimitMembers				= 3			--可以进副本的最小队伍人数
x700003_g_TickTime						= 5				--回调脚本的时钟时间（单位：秒/次）
x700003_g_LimitTotalHoldTime	= 360	--副本可以存活的时间（单位：次数）,如果此时间到了，则任务将会失败
--x700003_g_LimitTimeSuccess		= 500		--副本时间限制（单位：次数），如果此时间到了，任务完成
x700003_g_CloseTick						= 6				--副本关闭前倒计时（单位：次数）
x700003_g_NoUserTime					= 10			--副本中没有人后可以继续保存的时间（单位：秒）
x700003_g_DeadTrans						= 0				--死亡转移模式，0：死亡后还可以继续在副本，1：死亡后被强制移出副本
x700003_g_Fuben_X							= 20				--进入副本的位置X
x700003_g_Fuben_Z							= 106				--进入副本的位置Z
x700003_g_Back_X							= 165				--源场景位置X
x700003_g_Back_Z							= 154					--源场景位置Z

x700003_g_NeedKillMonster			= {
																	{hash=1, num=28, type=9000},
																	{hash=2, num=1, type=9001},
																	{hash=3, num=1, type=9002}
																}

x700003_g_LevelLess					= 30
x700003_g_RoundUntil				= 8
x700003_g_ShaQiUntil				= 0

x700003_g_MissionName				= "活财神殿"
x700003_g_MissionInfo				= "杀死全部怪物，解救赵公明！"
x700003_g_MissionTarget			= "杀死全部怪物"
x700003_g_MissionBonusInfo	= "获得%d金%d银%d铜的奖励。"

x700003_g_ContinueInfo			= "你要继续努力啊！"
x700003_g_MissionComplete		= "谢谢啊，俺们终于敢出门了"
x700003_g_MissionFuBenOpen	= "传入副本。"

x700003_g_KillMonsterMessage		= "你已经杀死了%d/%d只怪！"
x700003_g_CompleteOutMessage		= "任务完成，将在%d秒后传送到入口位置！"
x700003_g_OtherMonsterMessage		= "精英怪被杀！"
x700003_g_BossMergeMessage			= "BOSS出现！"

x700003_g_ErrorMessage					= "条件不符！"
x700003_g_ErrorMessage_Country	= "你不是本国人！"
x700003_g_ErrorMessage_Level		= format("你的等级不足%d！", x700003_g_LevelLess)
x700003_g_ErrorMessage_Round		= format("你今天已经完成了%d次任务，改日再来！", x700003_g_RoundUntil)
x700003_g_ErrorMessage_ShaQi		= "%s的杀气过重！"
x700003_g_ErrorMessage_Team			= "你不在队伍中！"
x700003_g_ErrorMessage_TeamNum	= format("队伍不足%d人！", x700003_g_LimitMembers)
x700003_g_ErrorMessage_Captain	= "你不是队长！"

x700003_g_ErrorMessage_OtherLevel		= "%s的等级不足%d！"
x700003_g_ErrorMessage_OtherRound		= "%s今天已经完成了%d次任务，改日再来！"
x700003_g_ErrorMessage_OtherMission	= "%s没有接任务！"
x700003_g_ErrorMessage_OtherAround	= "%s不在你身边！"

x700003_g_SomeoneInTeam				= "队伍中某人"

x700003_g_FuBenCreateOK					= "副本创建成功！"
x700003_g_FuBenCreateFailed			= "副本已达上限，请稍后再试！"
x700003_g_MissionAbandon				= "任务失败！"
x700003_g_CountDownMessage			= "你将在%d秒后离开场景！"
x700003_g_TimeOutFailedMessage	= "任务失败，超时！"
x700003_g_SceneMapNavPath				= "fuben_huocaishenmiao/fuben_huocaishenmiao.nav"

x700003_g_MoneyBonus				= 9999
x700003_g_buffId						= 1000

--MisDescEnd

x700003_g_MissionNPCName		= {
																{scene = 11, name = "苏菲"},		--新月
																{scene = 18, name = "苏菲"},		--金帐
																{scene = 21, name = "苏菲"},		--雪域
																{scene = 24, name = "苏菲"},		--大漠
																{scene = 36, name = "沈万三"}		--皇城
															}
															
x700003_g_MonsterGroup =	{
														{
															{	hash=1, type=x700003_g_NeedKillMonster[1].type, x=56.6176, z=77.0951, ai=0, aiscript=0},
															{	hash=1, type=x700003_g_NeedKillMonster[1].type, x=58.1541, z=79.4744, ai=0, aiscript=0},
															{	hash=1, type=x700003_g_NeedKillMonster[1].type, x=59.1455, z=77.0896, ai=0, aiscript=0},
															{	hash=1, type=x700003_g_NeedKillMonster[1].type, x=59.1192, z=66.5132, ai=0, aiscript=0},
															{	hash=1, type=x700003_g_NeedKillMonster[1].type, x=62.279, z=65.6636, ai=0, aiscript=0},
															{	hash=1, type=x700003_g_NeedKillMonster[1].type, x=61.3175, z=68.9376, ai=0, aiscript=0},
															{	hash=1, type=x700003_g_NeedKillMonster[1].type, x=71.3196, z=71.2479, ai=0, aiscript=0},
															{	hash=1, type=x700003_g_NeedKillMonster[1].type, x=73.7914, z=72.6845, ai=0, aiscript=0},
															{	hash=1, type=x700003_g_NeedKillMonster[1].type, x=71.3564, z=74.7278, ai=0, aiscript=0},
															{	hash=1, type=x700003_g_NeedKillMonster[1].type, x=40.1083, z=44.0976, ai=0, aiscript=0},
															{	hash=1, type=x700003_g_NeedKillMonster[1].type, x=37.1069, z=51.1374, ai=0, aiscript=0},
															{	hash=1, type=x700003_g_NeedKillMonster[1].type, x=35.1237, z=55.9806, ai=0, aiscript=0},
															{	hash=1, type=x700003_g_NeedKillMonster[1].type, x=32.7718, z=61.9125, ai=0, aiscript=0},
															{	hash=1, type=x700003_g_NeedKillMonster[1].type, x=32.1689, z=70.4741, ai=0, aiscript=0},
															{	hash=1, type=x700003_g_NeedKillMonster[1].type, x=75.2245, z=97.9905, ai=0, aiscript=0},
															{	hash=1, type=x700003_g_NeedKillMonster[1].type, x=80.2995, z=93.9277, ai=0, aiscript=0},
															{	hash=1, type=x700003_g_NeedKillMonster[1].type, x=84.397, z=88.6781, ai=0, aiscript=0},
															{	hash=1, type=x700003_g_NeedKillMonster[1].type, x=86.8812, z=82.9544, ai=0, aiscript=0},
															{	hash=1, type=x700003_g_NeedKillMonster[1].type, x=90.784, z=75.925, ai=0, aiscript=0},
															{	hash=1, type=x700003_g_NeedKillMonster[1].type, x=91.0128, z=66.305, ai=0, aiscript=0},
															{	hash=1, type=x700003_g_NeedKillMonster[1].type, x=89.0452, z=59.2124, ai=0, aiscript=0},
															{	hash=1, type=x700003_g_NeedKillMonster[1].type, x=84.661, z=54.7127, ai=0, aiscript=0},
															{	hash=1, type=x700003_g_NeedKillMonster[1].type, x=80.3323, z=51.7072, ai=0, aiscript=0},
															{	hash=1, type=x700003_g_NeedKillMonster[1].type, x=74.5189, z=49.2634, ai=0, aiscript=0},
															{	hash=1, type=x700003_g_NeedKillMonster[1].type, x=66.5921, z=48.2042, ai=0, aiscript=0},
															{	hash=1, type=x700003_g_NeedKillMonster[1].type, x=58.425, z=49.3004, ai=0, aiscript=0},
															{	hash=1, type=x700003_g_NeedKillMonster[1].type, x=53.9527, z=51.5132, ai=0, aiscript=0},
															{	hash=1, type=x700003_g_NeedKillMonster[1].type, x=49.4044, z=56.6412, ai=0, aiscript=0}
														},
														{
															{hash=2, type=x700003_g_NeedKillMonster[2].type, x=35.3459, z=31.1646, ai=0, aiscript=0}
														},
														{
															{hash=3, type=x700003_g_NeedKillMonster[3].type, x=66.82, z=77.42, ai=0, aiscript=0}
														},
													}

-------------------------
--***********************
--Define
--***********************
-------------------------

x700003_OK							= 0
x700003_OK_RETURN				= 1
x700003_ERROR_UNKNOWN		= -1

x700003_FAILED_COUNTRY	= 10
x700003_FAILED_LEVEL		= 11
x700003_FAILED_ROUND		= 12
x700003_FAILED_SHAQI		= 13
x700003_FAILED_TEAM			= 14
x700003_FAILED_TEAMNUM	= 15
x700003_FAILED_CAPTAIN	= 16

x700003_FAILED_OTHERLEVEL		= 20
x700003_FAILED_OTHERROUND		= 21
x700003_FAILED_OTHERMISSION	= 22
x700003_FAILED_OTHERAROUND	= 23

x700003_MP_AIMSCENE			= 0
x700003_MP_TEAMID				= 1
x700003_MP_KILLMONSTER	= 2
x700003_MP_COMPLETETIME	= 3
x700003_MP_ISCOMPLETE		= 7

x700003_CSP_FUBENTYPE				= 0
x700003_CSP_SCRIPTID				= 1
x700003_CSP_TICKCOUNT				= 2
x700003_CSP_FROMSCENEID			= 3
x700003_CSP_ISCLOSING				= 4
x700003_CSP_LEAVECOUNTDOWN	= 5
x700003_CSP_TEAMID					= 6
x700003_CSP_NKILLBOSS				= 7
x700003_CSP_NKILLMONSTER		= 8

-------------------------
--***********************
--OnDefaultEvent
--***********************
-------------------------

function x700003_OnDefaultEvent(sceneId, selfId, NPCId)

	local safeCheckRet, otherRet = x700003_SafeNPCCheck(sceneId, selfId, NPCId);
	local bHaveMission = IsHaveMission(sceneId, selfId, x700003_g_MissionId);
	local misIndex;
	local str = x700003_g_MissionName.."\n";
	local dispatchType = 0;
	local bDone = 0;
	
	if bHaveMission > 0 then
		misIndex = GetMissionIndexByID(sceneId, selfId, x700003_g_MissionId);
		bDone = x700003_CheckSubmit(sceneId, selfId);
		if bDone > 0 then
			str = str..x700003_g_MissionComplete;
			dispatchType = 2;
		else
			str = str..x700003_g_ContinueInfo;
			dispatchType = 1;
		end
	elseif safeCheckRet == x700003_OK or safeCheckRet == x700003_OK_RETURN then
		str = str..x700003_g_MissionInfo;
		dispatchType = 1;
	else
		dispatchType = 4;
		if safeCheckRet == x700003_FAILED_CAPTAIN then
			str = x700003_g_ErrorMessage_Captain;
		elseif safeCheckRet == x700003_FAILED_TEAM then
			str = x700003_g_ErrorMessage_Team;
		elseif safeCheckRet == x700003_FAILED_TEAMNUM then
			str = x700003_g_ErrorMessage_TeamNum;
		elseif safeCheckRet == x700003_FAILED_COUNTRY then
			str = x700003_g_ErrorMessage_Country;
		elseif safeCheckRet == x700003_FAILED_LEVEL then
			str = x700003_g_ErrorMessage_Level;
		elseif safeCheckRet == x700003_FAILED_ROUND then
			str = x700003_g_ErrorMessage_Round;
		else
			local otherName = x700003_g_SomeoneInTeam;
			if otherRet >= 0 then
				otherName = GetName(sceneId, otherRet);
			end
			if safeCheckRet == x700003_FAILED_OTHERLEVEL then
				str = format(x700003_g_ErrorMessage_OtherLevel, otherName, x700003_g_LevelLess);
			elseif safeCheckRet == x700003_FAILED_OTHERROUND then
				str = format(x700003_g_ErrorMessage_OtherRound, otherName, x700003_g_RoundUntil);
			elseif safeCheckRet == x700003_FAILED_OTHERMISSION then
				str = format(x700003_g_ErrorMessage_OtherMission, otherName);
			elseif safeCheckRet == x700003_FAILED_OTHERAROUND then
				str = format(x700003_g_ErrorMessage_OtherAround, otherName);
			end
		end
	end
	
	BeginEvent(sceneId);
		AddText(sceneId, str);
	EndEvent();
	
	if dispatchType == 1 then
		DispatchMissionInfo(sceneId, selfId, NPCId, x700003_g_ScriptId, x700003_g_MissionId);
	elseif dispatchType == 2 then
		if bDone > 0 then
			DispatchMissionContinueInfo(sceneId, selfId, NPCId, x700003_g_ScriptId, x700003_g_MissionId);
		else
			DispatchEventList(sceneId, selfId, NPCId);
		end
	elseif dispatchType == 3 then
		DispatchEventList(sceneId, selfId, NPCId);
	else
		DispatchMissionTips(sceneId, selfId);
	end

end

-------------------------
--***********************
--OnEnumerate
--***********************
-------------------------

function x700003_OnEnumerate(sceneId, selfId, NPCId)

	if x700003_SafeDisplayCheck(sceneId, selfId, NPCId) > 0 then
		AddNumText(sceneId, x700003_g_ScriptId, x700003_g_MissionName);
	end

end

-------------------------
--***********************
--SafeDisplayCheck
--***********************
-------------------------

function x700003_SafeDisplayCheck(sceneId, selfId, NPCId)

	local bHaveMission = IsHaveMission(sceneId, selfId, x700003_g_MissionId);
	
	if bHaveMission > 0 then
		return 1;
	end
	
	if x700003_IsMissionNPC(sceneId, selfId, x700003_g_MissionId, NPCId) > 0 then
		return 1;
	end
	
	return 0;

end

-------------------------
--***********************
--IsMissionNPC
--***********************
-------------------------

function x700003_IsMissionNPC(sceneId, selfId, missionId, NPCId)

	for i, item in pairs(x700003_g_MissionNPCName) do
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
--CheckRound
--***********************
-------------------------

function x700003_CheckRound(sceneId, selfId)

	local daycount = GetMissionData(sceneId, selfId, MD_HUOCAISHENDIAN_DAYCOUNT);
	local nowtime = LuaFnGetCurrentTime();
	
	local today = floor(nowtime / 86400);
	local round = 0;
	
	if today == floor(daycount / 10000) then
		round = floor((daycount - today * 10000) / 100) + 1;
		if round >= x700003_g_RoundUntil then
			return -1;
		end
	end
	
	return round;
	
end

-------------------------
--***********************
--CheckAllMemberRound
--***********************
-------------------------

function x700003_CheckAllMemberRound(sceneId, selfId, teamnum)

	for i = 0, teamnum - 1 do
		local memberId = GetNearTeamMember(sceneId, selfId, i);
		if x700003_CheckRound(sceneId, memberId) > x700003_g_RoundUntil then
			return 0, memberId;
		end
	end
	
	return 1;

end

-------------------------
--***********************
--CheckAllMemberLevel
--***********************
-------------------------

function x700003_CheckAllMemberLevel(sceneId, selfId, teamnum)

	for i = 0, teamnum - 1 do
		local memberId = GetNearTeamMember(sceneId, selfId, i);
		if GetLevel(sceneId, memberId) < x700003_g_LevelLess then
			return 0, memberId;
		end
	end
	
	return 1;

end

-------------------------
--***********************
--CheckAllMemberHaveMission
--***********************
-------------------------

function x700003_CheckAllMemberHaveMission(sceneId, selfId, teamnum)

	for i = 0, teamnum - 1 do
		local memberId = GetNearTeamMember(sceneId, selfId, i);
		if IsHaveMission(sceneId, memberId, x700003_g_MissionId) <= 0 then
--			return 0, memberId;
		end
	end
	
	return 1;

end

-------------------------
--***********************
--CheckAllMemberAround
--***********************
-------------------------

function x700003_CheckAllMemberAround(sceneId, selfId, teamnum)

	if GetNearTeamCount(sceneId, selfId) == teamnum then
		return 1;
	end
	
	return 0, -1;

end

-------------------------
--***********************
--SafeNPCCheck
--***********************
-------------------------

function x700003_SafeNPCCheck(sceneId, selfId, NPCId)

	bHaveMission = IsHaveMission(sceneId, selfId, x700003_g_MissionId);
	
	if bHaveMission > 0 then
	
		misIndex = GetMissionIndexByID(sceneId, selfId, x700003_g_MissionId);
		aimsceneid = GetMissionParam(sceneId, selfId, misIndex, x700003_MP_AIMSCENE);
		aimteamid = GetMissionParam(sceneId, selfId, misIndex, x700003_MP_TEAMID);
		
		if aimsceneid >= 0 and teamId == aimteamid then
			return x700003_OK_RETURN;
		else
			return x700003_ERROR_UNKNOWN;
		end
		
	else
		local teamid = GetTeamId(sceneId, selfId);
		local teamnum = GetTeamSize(sceneId, selfId);
		if GetLevel(sceneId, selfId) < x700003_g_LevelLess then
			return x700003_FAILED_LEVEL;
		elseif x700003_CheckRound(sceneId, selfId) > x700003_g_RoundUntil then
			return x700003_FAILED_ROUND;
		elseif LuaFnIsTeamLeader(sceneId, selfId) <= 0 then
			return x700003_FAILED_CAPTAIN;
		elseif teamid < 0 then
			return x700003_FAILED_TEAM;
		elseif teamnum < x700003_g_LimitMembers then
			return x700003_FAILED_TEAMNUM;
		else
		
			local nearteamnum = GetNearTeamCount(sceneId, selfId);
			local ret, otherId;
			
			ret, otherId = x700003_CheckAllMemberLevel(sceneId, selfId, nearteamnum);
			if ret <= 0 then
				return x700003_FAILED_OTHERLEVEL, otherId;
			end
			ret, otherId = x700003_CheckAllMemberRound(sceneId, selfId, nearteamnum);
			if ret <= 0 then
				return x700003_FAILED_OTHERROUND, otherId;
			end
			ret, otherId = x700003_CheckAllMemberHaveMission(sceneId, selfId, nearteamnum);
			if ret <= 0 then
				return x700003_FAILED_OTHERMISSION, otherId;
			end
			ret, otherId = x700003_CheckAllMemberAround(sceneId, selfId, nearteamnum);
			if ret <= 0 then
				return x700003_FAILED_OTHERAROUND, otherId;
			end
			return x700003_OK;
			
		end
	end
	
	return x700003_ERROR_UNKNOWN;

end

-------------------------
--***********************
--CheckAccept
--***********************
-------------------------

function x700003_CheckAccept(sceneId, selfId, NPCId)

	local safeCheckRet = x700003_SafeNPCCheck(sceneId, selfId, NPCId);
	if safeCheckRet == x700003_OK or safeCheckRet == x700003_OK_RETURN then
		return 1;
	end
	
	return 0;

end

-------------------------
--***********************
--OnAccept
--***********************
-------------------------

function x700003_OnAccept(sceneId, selfId, NPCId)

	bHaveMission = IsHaveMission(sceneId, selfId, x700003_g_MissionId);
	local teamId = GetTeamId(sceneId, selfId);
	
	if bHaveMission > 0 then
		
		local safeCheckRet = x700003_SafeNPCCheck(sceneId, selfId, NPCId);
		if SafeNPCCheck == x700003_OK_RETURN then
			misIndex = GetMissionIndexByID(sceneId, selfId, x700003_g_MissionId);
			aimsceneid = GetMissionParam(sceneId, selfId, misIndex, x700003_MP_AIMSCENE);
			NewWorld(sceneId, selfId, aimsceneid, x700003_g_Fuben_X, x700003_g_Fuben_Z);
		else
			BeginEvent(sceneId);
				AddText(x700003_g_ErrorMessage);
			EndEvent();
			DispatchMissionTips(sceneId, selfId);
			return 0;
		end
		
	else
		
		local memberNum = GetNearTeamCount(sceneId, selfId);
		for i = 0, memberNum - 1 do
			local memberId = GetNearTeamMember(sceneId, selfId, i);
			AddMission(sceneId, memberId, x700003_g_MissionId, x700003_g_ScriptId, 1, 0, 0);
			local misIndex = GetMissionIndexByID(sceneId, memberId, x700003_g_MissionId);
			SetMissionByIndex(sceneId, memberId, misIndex, x700003_MP_AIMSCENE, -1);
			SetMissionByIndex(sceneId, memberId, misIndex, x700003_MP_TEAMID, teamId);
			SetMissionByIndex(sceneId, memberId, misIndex, x700003_MP_ISCOMPLETE, 0);
			x700003_AddDayCount(sceneId, memberId);
		end
		
		x700003_MakeCopyScene(sceneId, selfId, memberNum);
		
	end
	
end

-------------------------
--***********************
--CalculateLevel
--***********************
-------------------------

function x700003_CalculateLevel(sceneId, selfId, memberNum)

	local totalLevel = 0;
	for i = 0, memberNum - 1 do
		local memberId = GetNearTeamMember(sceneId, selfId, i);
		totalLevel = totalLevel + GetLevel(sceneId, memberId);
	end
	
	return floor(totalLevel / memberNum);

end

-------------------------
--***********************
--MakeCopyScene
--***********************
-------------------------

function x700003_MakeCopyScene(sceneId, selfId, memberNum)

	local level = x700003_CalculateLevel(sceneId, selfId, memberNum);
	
	local leaderguid = LuaFnObjId2Guid(sceneId, selfId);
	LuaFnSetSceneLoad_Map(sceneId, x700003_g_SceneMapNavPath); --地图是必须选取的，而且必须在Config/SceneInfo.ini里配置好
	LuaFnSetCopySceneData_TeamLeader(sceneId, leaderguid);
	LuaFnSetCopySceneData_NoUserCloseTime(sceneId, x700003_g_NoUserTime * 1000);
	LuaFnSetCopySceneData_Timer(sceneId, x700003_g_TickTime * 1000);
	LuaFnSetCopySceneData_Param(sceneId, x700003_CSP_FUBENTYPE, x700003_g_CopySceneType);--设置副本数据，这里将0号索引的数据设置为999，用于表示副本号999(数字自定义)
	LuaFnSetCopySceneData_Param(sceneId, x700003_CSP_SCRIPTID, x700003_g_ScriptId);--将1号数据设置为副本场景事件脚本号
	LuaFnSetCopySceneData_Param(sceneId, x700003_CSP_TICKCOUNT, 0);--设置定时器调用次数
	LuaFnSetCopySceneData_Param(sceneId, x700003_CSP_FROMSCENEID, -1);--设置副本入口场景号, 初始化
	LuaFnSetCopySceneData_Param(sceneId, x700003_CSP_ISCLOSING, 0);--设置副本关闭标志, 0开放，1关闭
	LuaFnSetCopySceneData_Param(sceneId, x700003_CSP_LEAVECOUNTDOWN, 0);--设置离开倒计时次数
	LuaFnSetCopySceneData_Param(sceneId, x700003_CSP_TEAMID, GetTeamId(sceneId, selfId)); --保存队伍号
	LuaFnSetCopySceneData_Param(sceneId, x700003_CSP_NKILLBOSS, 0) ;--杀死Boss的数量
	LuaFnSetCopySceneData_Param(sceneId, x700003_CSP_NKILLMONSTER, 0) ;--杀死怪的数量
	
	local bRetSceneID = LuaFnCreateCopyScene(sceneId); --初始化完成后调用创建副本函数
		BeginEvent(sceneId);
		if bRetSceneID > 0 then
			AddText(sceneId, x700003_g_FuBenCreateOK);
		else
			AddText(sceneId, x700003_g_FuBenCreateFailed);
			for i = 0, memberNum - 1 do
				local memberId = GetNearTeamMember(sceneId, selfId, i);
				x700003_CancelMission(sceneId, memberId);
			end
		end
	EndEvent();
	DispatchMissionTips(sceneId, selfId);

end

-------------------------
--***********************
--OnCopySceneReady
--***********************
-------------------------

function x700003_OnCopySceneReady(sceneId, destsceneId)

	LuaFnSetCopySceneData_Param(destsceneId, x700003_CSP_FROMSCENEID, sceneId);--设置副本入口场景号
	leaderguid = LuaFnGetCopySceneData_TeamLeader(destsceneId);
	leaderObjId = LuaFnGuid2ObjId(sceneId, leaderguid);

	local	memberNum = GetNearTeamCount(sceneId, leaderObjId);

	for i = 0, memberNum - 1 do
		local memberId = GetNearTeamMember(sceneId, leaderObjId, i);

		misIndex = GetMissionIndexByID(sceneId, memberId, x700003_g_MissionId);
		SetMissionByIndex(sceneId, memberId, misIndex, x700003_MP_AIMSCENE, destsceneId);
		NewWorld(sceneId, memberId, destsceneId, x700003_g_Fuben_X, x700003_g_Fuben_Z);
	end
	x700003_CreateMonster(destsceneId, 1);
	x700003_CreateMonster(destsceneId, 2);
end

-------------------------
--***********************
--OnPlayerEnter
--***********************
-------------------------

function x700003_OnPlayerEnter(sceneId, selfId)

	SetPlayerDefaultReliveInfo(sceneId, selfId, "%10", "%10", "%10", sceneId, x700003_g_Fuben_X, x700003_g_Fuben_Z);

end

-------------------------
--***********************
--CreateMonster
--***********************
-------------------------

function x700003_CreateMonster(sceneId, teamId)

	for i, item in pairs(x700003_g_MonsterGroup[teamId]) do
		LuaFnCreateMonster(sceneId, item.type, item.x, item.z, item.ai, item.aiscript, -1);
	end

end

-------------------------
--***********************
--CancelMission
--***********************
-------------------------

function x700003_CancelMission(sceneId, selfId)

	misIndex = GetMissionIndexByID(sceneId, selfId, x700003_g_MissionId);
	local aimsceneid = GetMissionParam(sceneId, selfId, misIndex, x700003_MP_AIMSCENE);
	
	DelMission(sceneId, selfId, x700003_g_MissionId);
	
	if sceneId == aimsceneid then --如果在副本里删除任务，则直接传送回
	
		BeginEvent(sceneId);
			AddText(sceneId, x700003_g_MissionAbandon);
		EndEvent();
		DispatchMissionTips(sceneId, selfId);
		oldsceneId = LuaFnGetCopySceneData_Param(sceneId, x700003_CSP_FROMSCENEID);--取得副本入口场景号
		
		NewWorld(sceneId, selfId, oldsceneId, x700003_g_Back_X, x700003_g_Back_Z);
		return oldsceneId;
	end
	
	return -1;
	
end

-------------------------
--***********************
--AddDayCount
--***********************
-------------------------

function x700003_AddDayCount(sceneId, selfId)

	local daycount = GetMissionData(sceneId, selfId, MD_HUOCAISHENDIAN_DAYCOUNT);	--day*100+circle
	local nowtime = LuaFnGetCurrentTime();
	local today = floor(nowtime / 86400);
	if today == floor(daycount / 10000) then
		daycount = daycount + 101;
	else
		daycount = today * 10000 + 1;
	end
	SetMissionData(sceneId, selfId, MD_HUOCAISHENDIAN_DAYCOUNT, daycount);

end

-------------------------
--***********************
--CheckSubmit
--***********************
-------------------------

function x700003_CheckSubmit(sceneId, selfId, NPCId)

	misIndex = GetMissionIndexByID(sceneId, selfId, x700003_g_MissionId);
	return GetMissionParam(sceneId, selfId, misIndex, x700003_MP_ISCOMPLETE);

end

-------------------------
--***********************
--OnSubmit
--***********************
-------------------------

function x700003_OnSubmit(sceneId, selfId, NPCId)
	
	local money = x700003_GetMoney(sceneId, selfId, NPCId);
	AddMoney(sceneId, selfId, money);
	
	local moneyjin = floor(money / 10000);
	local moneyyin = floor(money / 100) - moneyjin * 100;
	local moneytong = money - moneyjin * 10000 - moneyyin * 100;
	
	BeginEvent(sceneId);
		AddText(sceneId, format(x700003_g_MissionBonusInfo, moneyjin, moneyyin, moneytong));
	EndEvent();
	
	DispatchMissionTips(sceneId, selfId);
	DelMission(sceneId, selfId, x700003_g_MissionId);
	
end

-------------------------
--***********************
--CheckTeamLeader
--***********************
-------------------------

function x700003_CheckTeamLeader(sceneId, selfId)
	if GetTeamId(sceneId, selfId) < 0 then	--判断是否有队伍
		return x700003_FAILED_TEAM;
	end
	
	local	memberNum = GetNearTeamCount(sceneId, selfId);
	
	if memberNum < x700003_g_LimitMembers then
		return x700003_FAILED_TEAMNUMBER;
	end
	
	if LuaFnIsTeamLeader(sceneId, selfId) == 0 then	--只有队长才能接任务
		return x700003_FAILED_CAPTAIN;
	end
	
	return x700003_OK;
end

-------------------------
--***********************
--OnAbandon
--***********************
-------------------------

function x700003_OnAbandon(sceneId, selfId)
	
	x700003_CancelMission(sceneId, selfId);
	
end

-------------------------
--***********************
--OnCopySceneTimer
--***********************
-------------------------

function x700003_OnCopySceneTimer(sceneId, nowTime)

	local nowTickCount = LuaFnGetCopySceneData_Param(sceneId, x700003_CSP_TICKCOUNT) + 1;
	LuaFnSetCopySceneData_Param(sceneId, x700003_CSP_TICKCOUNT, nowTickCount);
	
	local leaveFlag = LuaFnGetCopySceneData_Param(sceneId, x700003_CSP_ISCLOSING);

	if leaveFlag > 0 then
	
		local leaveCountDown = LuaFnGetCopySceneData_Param(sceneId, x700003_CSP_LEAVECOUNTDOWN) + 1;
		LuaFnSetCopySceneData_Param(sceneId, x700003_CSP_LEAVECOUNTDOWN, leaveCountDown);
		if leaveCountDown == x700003_g_CloseTick then
			local oldsceneId = LuaFnGetCopySceneData_Param(sceneId, x700003_CSP_FROMSCENEID);
			local humancount = LuaFnGetCopyScene_HumanCount(sceneId);
			for	i = 0, humancount - 1 do
				local humanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);
				NewWorld(sceneId, humanId, oldsceneId, x700003_g_Back_X, x700003_g_Back_Z);
			end
		elseif leaveCountDown < x700003_g_CloseTick then
			local humancount = LuaFnGetCopyScene_HumanCount(sceneId);
			for	i = 0, humancount - 1 do
				local humanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);
 				local str = format(x700003_g_CountDownMessage, (x700003_g_CloseTick - leaveCountDown) * x700003_g_TickTime);
  			BeginEvent(sceneId);
  				AddText(sceneId, str);
  			EndEvent(sceneId);
  			DispatchMissionTips(sceneId, humanId);
			end
		end
		
	else

		local humancount = LuaFnGetCopyScene_HumanCount(sceneId);
		for i = 0, humancount - 1 do
			humanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);
			if nowTickCount == x700003_g_LimitTotalHoldTime then
				LuaFnSetCopySceneData_Param(sceneId, x700003_CSP_ISCLOSING, 1);
			end
			local kickout = 0;
			if IsHaveMission(sceneId, humanId, x700003_g_MissionId) > 0 then
				if GetTeamId(sceneId, humanId) ~= LuaFnGetCopySceneData_Param(sceneId, x700003_CSP_TEAMID) then
					kickout = 1;
				end
			else
				kickout = 1;
			end
			if kickout == 1 then
				x700003_CancelMission(sceneId, humanId);
			end
		end
	end

end

-------------------------
--***********************
--GetMoney
--***********************
-------------------------

function x700003_GetMoney(sceneId, selfId, NPCId)
	local ret = x700003_g_MoneyBonus;
	return ret;
end

-------------------------
--***********************
--OnKillObject
--***********************
-------------------------

function x700003_OnKillObject(sceneId, selfId, objdataId ,objId)
	
	local sceneType = LuaFnGetSceneType(sceneId);
	if sceneType ~= x700003_g_FuBenType then
		return 0;
	end
	
	local fubenType = LuaFnGetCopySceneData_Param(sceneId, x700003_CSP_FUBENTYPE);
	if fubenType ~= x700003_g_CopySceneType then
		return 0;
	end
	
	local leaveFlag = LuaFnGetCopySceneData_Param(sceneId, x700003_CSP_LEAVECOUNTDOWN);
	if leaveFlag == 1 then --如果副本已经被置成关闭状态，则杀怪无效
		return 0;
	end
	
	local humancount = LuaFnGetCopyScene_HumanCount(sceneId);
	
	local killmonster = LuaFnGetCopySceneData_Param(sceneId, x700003_CSP_NKILLMONSTER);
	local killnum = 0;
	local killtype = 0;
	for i, item in pairs(x700003_g_NeedKillMonster) do
		if item.type == objdataId then
			if item.hash == 1 then
				killmonster = killmonster + 1;
				killtype = 1;
				killnum = mod(killmonster, 100);
			elseif item.hash == 2 then
				killmonster = killmonster + 100;
				killtype = 2;
				killnum = mod(floor(killmonster/100), 100);
			elseif item.hash == 3 then
				killmonster = killmonster + 10000;
				killtype = 3;
				killnum = floor(killmonster/10000);
			end
			break;
		end
	end
	
	if killtype == 1 then
	
		if killnum < x700003_g_NeedKillMonster[killtype].num then
			local str = format(x700003_g_KillMonsterMessage, killnum, x700003_g_NeedKillMonster[killtype].num);
			BeginEvent(sceneId);
				AddText(sceneId, str);
			EndEvent();
		else
			x700003_CreateMonster(sceneId, killtype+2);
			BeginEvent(sceneId);
				AddText(sceneId, x700003_g_BossMergeMessage);
			EndEvent();
		end
		
	elseif killtype == 2 then
	
		if killnum < x700003_g_NeedKillMonster[killtype].num then
			local str = format(x700003_g_KillMonsterMessage, killnum, x700003_g_NeedKillMonster[killtype].num);
			BeginEvent(sceneId);
				AddText(sceneId, str);
			EndEvent();
		else
			x700003_CauseBuff(sceneId);
			BeginEvent(sceneId);
				AddText(sceneId, x700003_g_OtherMonsterMessage);
			EndEvent();
		end
		
	elseif killtype == 3 then
	
		LuaFnSetCopySceneData_Param(sceneId, x700003_CSP_ISCLOSING, 1);
		local tickcount = LuaFnGetCopySceneData_Param(sceneId, x700003_CSP_TICKCOUNT);
		
		for i = 0, humancount - 1 do
			humanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);	--取得当前场景里人的objId
			
			local completeTime = tickcount * x700003_g_TickTime;
			SetMissionByIndex(sceneId, humanId, misIndex, x700003_MP_COMPLETETIME, completeTime);--设置任务数据
			SetMissionByIndex(sceneId, humanId, misIndex, x700003_MP_ISCOMPLETE, 1);

			str = format(x700003_g_CompleteOutMessage, x700003_g_CloseTick * x700003_g_TickTime);
			BeginEvent(sceneId);
				AddText(sceneId, str);
			EndEvent();
			DispatchMissionTips(sceneId, humanId);
		end
		
	end
	
	LuaFnSetCopySceneData_Param(sceneId, x700003_CSP_NKILLMONSTER, killmonster);
	
	for i = 0, humancount - 1 do
		local humanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);--取得当前场景里人的objId
		DispatchMissionTips(sceneId, humanId);
		
		misIndex = GetMissionIndexByID(sceneId, humanId, x700003_g_MissionId); --取得任务数据索引值
		local killedcount = GetMissionParam(sceneId, humanId, misIndex, x700003_MP_KILLMONSTER) + 1; --取得已经杀了的怪物数
		SetMissionByIndex(sceneId, humanId, misIndex, x700003_MP_KILLMONSTER, killedcount) --设置任务数据
	end
end

-------------------------
--***********************
--CauseBuff
--***********************
-------------------------

function x700003_CauseBuff(sceneId)

	local humancount = LuaFnGetCopyScene_HumanCount(sceneId);
	for	i = 0, humancount - 1 do
		local humanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);
		LuaFnSendSpecificImpactToUnit(sceneId, humanId, humanId, humanId, x700003_g_buffId, 0);
	end

end

-------------------------
--***********************
--OnHumanDie
--***********************
-------------------------

function x700003_OnHumanDie(sceneId, selfId, killerId)
end
