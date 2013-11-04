--MisDescBegin
-------------------------
--***********************
--Const
--***********************
-------------------------

x700004_g_ScriptId 				= 700004
x700004_g_MissionId 			= 409
x700004_g_MissionKind 		= 23
x700004_g_MissionLevel    = 12

x700004_g_FuBenType				= 1

x700004_g_CopySceneName				= "副本_01"
x700004_g_Name								= ""
x700004_g_CopySceneType				= FUBEN_01
x700004_g_LimitMembers				= 1			--可以进副本的最小队伍人数
x700004_g_TickTime						= 5				--回调脚本的时钟时间（单位：秒/次）
x700004_g_LimitTotalHoldTime	= 360	--副本可以存活的时间（单位：次数）,如果此时间到了，则任务将会失败
x700004_g_CloseTick						= 6				--副本关闭前倒计时（单位：次数）
x700004_g_NoUserTime					= 10			--副本中没有人后可以继续保存的时间（单位：秒）
x700004_g_DeadTrans						= 0				--死亡转移模式，0：死亡后还可以继续在副本，1：死亡后被强制移出副本
x700004_g_Fuben_X							= 75				--进入副本的位置X
x700004_g_Fuben_Z							= 41				--进入副本的位置Z
x700004_g_Back_X							= 38			--源场景位置X
x700004_g_Back_Z							= 180  		--源场景位置Z

x700004_g_BossType						= 300

x700004_g_FailedObj						= {type=9097, x=75, z=45, ai=7, aiscript=0, camp=24}
x700004_g_NeedKillMonster			= {
																	{hash=1, num=3, type=9107, time=4, pos=1, ai=0, aiscript=0},
																	{hash=1, num=3, type=9109, time=5, pos=1, ai=0, aiscript=0},
																	{hash=2, num=3, type=9095, time=15, pos=3, ai=0, aiscript=0},
																	{hash=2, num=5, type=9096, time=16, pos=3, ai=0, aiscript=0},
																	{hash=3, num=5, type=9111, time=25, pos=2, ai=0, aiscript=0},
																	{hash=3, num=5, type=9112, time=26, pos=2, ai=0, aiscript=0},
																	{hash=4, num=5, type=9095, time=35, pos=4, ai=0, aiscript=0},
																	{hash=4, num=1, type=9108, time=40, pos=4, ai=0, aiscript=0},
																}
x700004_g_RandomBirthPosition	=	{
																	{hash=1, x=87, z=60, r=2, patrolSetId=1, camp=21},
																	{hash=2, x=89, z=65, r=2, patrolSetId=2, camp=21},
																	{hash=3, x=92, z=68, r=2, patrolSetId=3, camp=21},
																	{hash=4, x=94, z=70, r=2, patrolSetId=4, camp=21}
																}
x700004_g_PatrolRandom	=	{
														{hash=1, patrolId=0},
														{hash=1, patrolId=0},
														{hash=1, patrolId=0},
														{hash=1, patrolId=0},
														{hash=2, patrolId=1},
														{hash=2, patrolId=1},
														{hash=2, patrolId=1},
														{hash=2, patrolId=1},
														{hash=3, patrolId=2},
														{hash=3, patrolId=2},
														{hash=3, patrolId=2},
														{hash=3, patrolId=2},
														{hash=4, patrolId=3},
														{hash=4, patrolId=3},
														{hash=4, patrolId=3},
														{hash=4, patrolId=3},
													}

x700004_g_LevelLess					= 10
x700004_g_StartCreateDelay	= 1

x700004_g_MissionName				= "杀怪副本测试"
x700004_g_MissionInfo				= "杀死全部怪物！"
x700004_g_MissionTarget			= "杀死全部怪物！"
x700004_g_MissionBonusInfo	= "获得%d金%d银%d铜的奖励。"

x700004_g_ContinueInfo			= "你要继续努力啊！"
x700004_g_MissionComplete		= "谢谢啊，俺们终于敢出门了"
x700004_g_MissionFuBenOpen	= "传入副本。"

x700004_g_KillMonsterMessage		= "你已经杀死了%d/%d只怪！"
x700004_g_CompleteOutMessage		= "任务完成，将在%d秒后传送到入口位置！"
x700004_g_OtherMonsterMergeMessage	= "怪增援出现！"
x700004_g_BossMergeMessage					= "BOSS出现！"
x700004_g_RemainMonsterMessage	= "场景中还有%d只怪！"

x700004_g_ErrorMessage					= "条件不符！"
x700004_g_ErrorMessage_Country	= "你不是本国人！"
x700004_g_ErrorMessage_Level		= format("你的等级不足%d！", x700004_g_LevelLess)
x700004_g_ErrorMessage_Team			= "你不在队伍中！"
x700004_g_ErrorMessage_TeamNum	= format("队伍不足%d人！", x700004_g_LimitMembers)
x700004_g_ErrorMessage_Captain	= "你不是队长！"

x700004_g_ErrorMessage_OtherLevel		= "%s的等级不足%d！"
x700004_g_ErrorMessage_OtherAround	= "%s不在你身边！"

x700004_g_SomeoneInTeam				= "队伍中某人"

x700004_g_FuBenCreateOK					= "副本创建成功！"
x700004_g_FuBenCreateFailed			= "副本已达上限，请稍后再试！"
x700004_g_MissionAbandon				= "任务失败！"
x700004_g_CountDownMessage			= "你将在%d秒后离开场景！"
x700004_g_TimeOutFailedMessage	= "任务失败，超时！"
x700004_g_CompleteFailedNPCMessage	= "…………"
x700004_g_TipForEnter						= format("%d分钟后开始刷怪。", x700004_g_StartCreateDelay)
x700004_g_SceneMapNavPath				= "fuben_01/fuben_01.nav"

x700004_g_MoneyBonus				= 0

--MisDescEnd

x700004_g_MissionNPCName		= {
																{scene = 4, name = "黄药师"},		--桃花岛
															}

-------------------------
--***********************
--Define
--***********************
-------------------------

x700004_OK							= 0
x700004_OK_RETURN				= 1
x700004_ERROR_UNKNOWN		= -1

x700004_FAILED_COUNTRY	= 10
x700004_FAILED_LEVEL		= 11
x700004_FAILED_TEAM			= 14
x700004_FAILED_TEAMNUM	= 15
x700004_FAILED_CAPTAIN	= 16

x700004_FAILED_OTHERLEVEL		= 20
x700004_FAILED_OTHERMISSION	= 22
x700004_FAILED_OTHERAROUND	= 23

x700004_MP_AIMSCENE			= 0
x700004_MP_TEAMID				= 1
x700004_MP_KILLMONSTER	= 2
x700004_MP_ISCOMPLETE		= 7

x700004_CSP_FUBENTYPE				= 0
x700004_CSP_SCRIPTID				= 1
x700004_CSP_TICKCOUNT				= 2
x700004_CSP_FROMSCENEID			= 3
x700004_CSP_ISCLOSING				= 4
x700004_CSP_LEAVECOUNTDOWN	= 5
x700004_CSP_TEAMID					= 6
x700004_CSP_NALLMONSTER			= 7
x700004_CSP_NKILLMONSTER		= 8
x700004_CSP_NTOTALMONSTER		= 9
x700004_CSP_FAILEDOBJ				= 10

-------------------------
--***********************
--OnDefaultEvent
--***********************
-------------------------

function x700004_OnDefaultEvent(sceneId, selfId, NPCId)

	local safeCheckRet, otherRet = x700004_SafeNPCCheck(sceneId, selfId, NPCId);
	local bHaveMission = IsHaveMission(sceneId, selfId, x700004_g_MissionId);
	local misIndex;
	local str = x700004_g_MissionName.."\n";
	local dispatchType = 0;
	local bDone = 0;
	
	if bHaveMission > 0 then
		misIndex = GetMissionIndexByID(sceneId, selfId, x700004_g_MissionId);
		bDone = x700004_CheckComplete(sceneId, selfId);

		if bDone == 1 then
			str = str..x700004_g_MissionComplete;
			dispatchType = 2;
		else
			str = str..x700004_g_CompleteFailedNPCMessage;
			dispatchType = 2;
		end
	elseif safeCheckRet == x700004_OK or safeCheckRet == x700004_OK_RETURN then
		str = str..x700004_g_MissionInfo;
		dispatchType = 1;
	else
		dispatchType = 4;
		if safeCheckRet == x700004_FAILED_CAPTAIN then
			str = x700004_g_ErrorMessage_Captain;
		elseif safeCheckRet == x700004_FAILED_TEAM then
			str = x700004_g_ErrorMessage_Team;
		elseif safeCheckRet == x700004_FAILED_TEAMNUM then
			str = x700004_g_ErrorMessage_TeamNum;
		elseif safeCheckRet == x700004_FAILED_COUNTRY then
			str = x700004_g_ErrorMessage_Country;
		elseif safeCheckRet == x700004_FAILED_LEVEL then
			str = x700004_g_ErrorMessage_Level;
		else
			local otherName = x700004_g_SomeoneInTeam;
			if otherRet >= 0 then
				otherName = GetName(sceneId, otherRet);
			end
			if safeCheckRet == x700004_FAILED_OTHERLEVEL then
				str = format(x700004_g_ErrorMessage_OtherLevel, otherName, x700004_g_LevelLess);
			elseif safeCheckRet == x700004_FAILED_OTHERMISSION then
				str = format(x700004_g_ErrorMessage_OtherMission, otherName);
			elseif safeCheckRet == x700004_FAILED_OTHERAROUND then
				str = format(x700004_g_ErrorMessage_OtherAround, otherName);
			end
		end
	end
	
	BeginEvent(sceneId);
		AddText(sceneId, str);
	EndEvent();
	
	if dispatchType == 1 then
		DispatchMissionInfo(sceneId, selfId, NPCId, x700004_g_ScriptId, x700004_g_MissionId);
	elseif dispatchType == 2 then
		DispatchMissionContinueInfo(sceneId, selfId, NPCId, x700004_g_ScriptId, x700004_g_MissionId);
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

function x700004_OnEnumerate(sceneId, selfId, NPCId)

	if x700004_SafeDisplayCheck(sceneId, selfId, NPCId) > 0 then
		AddNumText(sceneId, x700004_g_ScriptId, x700004_g_MissionName);
	end

end

-------------------------
--***********************
--SafeDisplayCheck
--***********************
-------------------------

function x700004_SafeDisplayCheck(sceneId, selfId, NPCId)

	local bHaveMission = IsHaveMission(sceneId, selfId, x700004_g_MissionId);
	
	if bHaveMission > 0 then
		return 1;
	end
	
	if x700004_IsMissionNPC(sceneId, selfId, x700004_g_MissionId, NPCId) > 0 then
		return 1;
	end
	
	return 0;

end

-------------------------
--***********************
--IsMissionNPC
--***********************
-------------------------

function x700004_IsMissionNPC(sceneId, selfId, missionId, NPCId)

	for i, item in x700004_g_MissionNPCName do
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
--CheckAllMemberLevel
--***********************
-------------------------

function x700004_CheckAllMemberLevel(sceneId, selfId, teamnum)

	for i = 0, teamnum - 1 do
		local memberId = GetNearTeamMember(sceneId, selfId, i);
		if GetLevel(sceneId, memberId) < x700004_g_LevelLess then
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

function x700004_CheckAllMemberHaveMission(sceneId, selfId, teamnum)

	for i = 0, teamnum - 1 do
		local memberId = GetNearTeamMember(sceneId, selfId, i);
		if IsHaveMission(sceneId, memberId, x700004_g_MissionId) <= 0 then
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

function x700004_CheckAllMemberAround(sceneId, selfId, teamnum)

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

function x700004_SafeNPCCheck(sceneId, selfId, NPCId)

	bHaveMission = IsHaveMission(sceneId, selfId, x700004_g_MissionId);
	
	if bHaveMission > 0 then
	
		misIndex = GetMissionIndexByID(sceneId, selfId, x700004_g_MissionId);
		aimsceneid = GetMissionParam(sceneId, selfId, misIndex, x700004_MP_AIMSCENE);
		aimteamid = GetMissionParam(sceneId, selfId, misIndex, x700004_MP_TEAMID);
		
		if aimsceneid >= 0 and teamId == aimteamid then
			return x700004_OK_RETURN;
		else
			return x700004_ERROR_UNKNOWN;
		end
		
	else
		local teamid = GetTeamId(sceneId, selfId);
		local teamnum = GetTeamSize(sceneId, selfId);
		if GetLevel(sceneId, selfId) < x700004_g_LevelLess then
			return x700004_FAILED_LEVEL;
		elseif LuaFnIsTeamLeader(sceneId, selfId) <= 0 then
			return x700004_FAILED_CAPTAIN;
		elseif teamid < 0 then
			return x700004_FAILED_TEAM;
		elseif teamnum < x700004_g_LimitMembers then
			return x700004_FAILED_TEAMNUM;
		else
		
			local nearteamnum = GetNearTeamCount(sceneId, selfId);
			local ret, otherId;
			
			ret, otherId = x700004_CheckAllMemberLevel(sceneId, selfId, nearteamnum);
			if ret <= 0 then
				return x700004_FAILED_OTHERLEVEL, otherId;
			end
			ret, otherId = x700004_CheckAllMemberHaveMission(sceneId, selfId, nearteamnum);
			if ret <= 0 then
				return x700004_FAILED_OTHERMISSION, otherId;
			end
			ret, otherId = x700004_CheckAllMemberAround(sceneId, selfId, nearteamnum);
			if ret <= 0 then
				return x700004_FAILED_OTHERAROUND, otherId;
			end
			return x700004_OK;
			
		end
	end
	
	return x700004_ERROR_UNKNOWN;

end

-------------------------
--***********************
--CheckAccept
--***********************
-------------------------

function x700004_CheckAccept(sceneId, selfId, NPCId)

	local safeCheckRet = x700004_SafeNPCCheck(sceneId, selfId, NPCId);
	if safeCheckRet == x700004_OK or safeCheckRet == x700004_OK_RETURN then
		return 1;
	end
	
	return 0;

end

-------------------------
--***********************
--OnAccept
--***********************
-------------------------

function x700004_OnAccept(sceneId, selfId, NPCId)

	bHaveMission = IsHaveMission(sceneId, selfId, x700004_g_MissionId);
	local teamId = GetTeamId(sceneId, selfId);
	
	if bHaveMission > 0 then
		
		local safeCheckRet = x700004_SafeNPCCheck(sceneId, selfId, NPCId);
		if SafeNPCCheck == x700004_OK_RETURN then
			misIndex = GetMissionIndexByID(sceneId, selfId, x700004_g_MissionId);
			aimsceneid = GetMissionParam(sceneId, selfId, misIndex, x700004_MP_AIMSCENE);
			NewWorld(sceneId, selfId, aimsceneid, x700004_g_Fuben_X, x700004_g_Fuben_Z);
		else
			BeginEvent(sceneId);
				AddText(x700004_g_ErrorMessage);
			EndEvent();
			DispatchMissionTips(sceneId, selfId);
			return 0;
		end
		
	else
		
		local memberNum = GetNearTeamCount(sceneId, selfId);
		for i = 0, memberNum - 1 do
			local memberId = GetNearTeamMember(sceneId, selfId, i);
			AddMission(sceneId, memberId, x700004_g_MissionId, x700004_g_ScriptId, 1, 0, 0);
			local misIndex = GetMissionIndexByID(sceneId, memberId, x700004_g_MissionId);
			SetMissionByIndex(sceneId, memberId, misIndex, x700004_MP_AIMSCENE, -1);
			SetMissionByIndex(sceneId, memberId, misIndex, x700004_MP_TEAMID, teamId);
			SetMissionByIndex(sceneId, memberId, misIndex, x700004_MP_ISCOMPLETE, 0);
		end
		
		x700004_MakeCopyScene(sceneId, selfId, memberNum);
		
	end
	
end

-------------------------
--***********************
--MakeCopyScene
--***********************
-------------------------

function x700004_MakeCopyScene(sceneId, selfId, memberNum)
	
	local leaderguid = LuaFnObjId2Guid(sceneId, selfId);
	LuaFnSetSceneLoad_Map(sceneId, x700004_g_SceneMapNavPath); --地图是必须选取的，而且必须在Config/SceneInfo.ini里配置好
	LuaFnSetCopySceneData_TeamLeader(sceneId, leaderguid);
	LuaFnSetCopySceneData_NoUserCloseTime(sceneId, x700004_g_NoUserTime * 1000);
	LuaFnSetCopySceneData_Timer(sceneId, x700004_g_TickTime * 1000);
	LuaFnSetCopySceneData_Param(sceneId, x700004_CSP_FUBENTYPE, x700004_g_CopySceneType);--设置副本数据，这里将0号索引的数据设置为999，用于表示副本号999(数字自定义)
	LuaFnSetCopySceneData_Param(sceneId, x700004_CSP_SCRIPTID, x700004_g_ScriptId);--将1号数据设置为副本场景事件脚本号
	LuaFnSetCopySceneData_Param(sceneId, x700004_CSP_TICKCOUNT, 0);--设置定时器调用次数
	LuaFnSetCopySceneData_Param(sceneId, x700004_CSP_FROMSCENEID, -1);--设置副本入口场景号, 初始化
	LuaFnSetCopySceneData_Param(sceneId, x700004_CSP_ISCLOSING, 0);--设置副本关闭标志, 0开放，1关闭
	LuaFnSetCopySceneData_Param(sceneId, x700004_CSP_LEAVECOUNTDOWN, 0);--设置离开倒计时次数
	LuaFnSetCopySceneData_Param(sceneId, x700004_CSP_TEAMID, GetTeamId(sceneId, selfId)); --保存队伍号
	LuaFnSetCopySceneData_Param(sceneId, x700004_CSP_NALLMONSTER, 0) ;--全部怪数量
	LuaFnSetCopySceneData_Param(sceneId, x700004_CSP_NKILLMONSTER, 0) ;--杀死怪的数量
	
	local ntotalmonster = 0;
	for i, item in x700004_g_NeedKillMonster do
		ntotalmonster = ntotalmonster + item.num;
	end
	LuaFnSetCopySceneData_Param(sceneId, x700004_CSP_NTOTALMONSTER, ntotalmonster);
	
	local bRetSceneID = LuaFnCreateCopyScene(sceneId); --初始化完成后调用创建副本函数
		BeginEvent(sceneId);
		if bRetSceneID > 0 then
			AddText(sceneId, x700004_g_FuBenCreateOK);
		else
			AddText(sceneId, x700004_g_FuBenCreateFailed);
			for i = 0, memberNum - 1 do
				local memberId = GetNearTeamMember(sceneId, selfId, i);
				x700004_CancelMission(sceneId, memberId);
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

function x700004_OnCopySceneReady(sceneId, destsceneId)

	LuaFnSetCopySceneData_Param(destsceneId, x700004_CSP_FROMSCENEID, sceneId);--设置副本入口场景号
	leaderguid = LuaFnGetCopySceneData_TeamLeader(destsceneId);
	leaderObjId = LuaFnGuid2ObjId(sceneId, leaderguid);

	local	memberNum = GetNearTeamCount(sceneId, leaderObjId);
	
	local item = x700004_g_FailedObj;
	local objId = LuaFnCreateMonster(destsceneId, item.type, item.x, item.z, item.ai, item.aiscript, x700004_g_ScriptId);
	SetCurCamp(destsceneId, objId, item.camp);
	
	LuaFnSetCopySceneData_Param(destsceneId, x700004_CSP_FAILEDOBJ, objId);
	
	for i = 0, memberNum - 1 do
		local memberId = GetNearTeamMember(sceneId, leaderObjId, i);

		misIndex = GetMissionIndexByID(sceneId, memberId, x700004_g_MissionId);
		SetMissionByIndex(sceneId, memberId, misIndex, x700004_MP_AIMSCENE, destsceneId);
		NewWorld(sceneId, memberId, destsceneId, x700004_g_Fuben_X, x700004_g_Fuben_Z);
	end
	
end

-------------------------
--***********************
--OnPlayerEnter
--***********************
-------------------------

function x700004_OnPlayerEnter(sceneId, selfId)

	SetPlayerDefaultReliveInfo(sceneId, selfId, "%10", "%10", "%10", sceneId, x700004_g_Fuben_X, x700004_g_Fuben_Z);

end

-------------------------
--***********************
--CreateMonster
--***********************
-------------------------

function x700004_CreateMonster(sceneId, teamIndex)

	local item = x700004_g_NeedKillMonster[teamIndex];
	local xO;
	local zO;
	local r;
	local camp;
	local patrolSetId;
	
	for i, posItem in x700004_g_RandomBirthPosition do
		if posItem.hash == item.pos then
			xO = posItem.x;
			zO = posItem.z;
			r = posItem.r;
			camp = posItem.camp;
			patrolSetId = posItem.patrolSetId;
		end
	end
	
	for i=1, item.num do
		local x = random(-r, r) + xO;
		local z = random(-r, r) + zO;
		local objId = LuaFnCreateMonster(sceneId, item.type, x, z, item.ai, item.aiscript, -1);
		
		local patrolCount = 0;
		local pstart = -1;
		local tindex = 0;
		
		for j, patrolItem in x700004_g_PatrolRandom do
			tindex = tindex + 1;
			if patrolItem.hash == patrolSetId then
				if pstart == -1 then
					pstart = tindex;
				end
				patrolCount = patrolCount + 1;
			end
		end
		tindex = pstart + random(1, patrolCount) - 1;
		
		SetPatrolId(sceneId, objId, x700004_g_PatrolRandom[tindex].patrolId);
		SetCurCamp(sceneId, objId, camp);
	end
	
	local nallmonster = LuaFnGetCopySceneData_Param(sceneId, x700004_CSP_NALLMONSTER);
	LuaFnSetCopySceneData_Param(sceneId, x700004_CSP_NALLMONSTER, nallmonster + item.num);
	
end

-------------------------
--***********************
--CancelMission
--***********************
-------------------------

function x700004_CancelMission(sceneId, selfId)

	misIndex = GetMissionIndexByID(sceneId, selfId, x700004_g_MissionId);
	local aimsceneid = GetMissionParam(sceneId, selfId, misIndex, x700004_MP_AIMSCENE);
	
	DelMission(sceneId, selfId, x700004_g_MissionId);
	
	if sceneId == aimsceneid then --如果在副本里删除任务，则直接传送回
	
		BeginEvent(sceneId);
			AddText(sceneId, x700004_g_MissionAbandon);
		EndEvent();
		DispatchMissionTips(sceneId, selfId);
		oldsceneId = LuaFnGetCopySceneData_Param(sceneId, x700004_CSP_FROMSCENEID);--取得副本入口场景号
		
		NewWorld(sceneId, selfId, oldsceneId, x700004_g_Back_X, x700004_g_Back_Z);
		return oldsceneId;
	end
	
	return -1;
	
end

-------------------------
--***********************
--CheckSubmit
--***********************
-------------------------

function x700004_CheckSubmit(sceneId, selfId, NPCId)

	return 1;

end

-------------------------
--***********************
--CheckComplete
--***********************
-------------------------

function x700004_CheckComplete(sceneId, selfId, NPCId)

	local misIndex = GetMissionIndexByID(sceneId, selfId, x700004_g_MissionId);
	return GetMissionParam(sceneId, selfId, misIndex, x700004_MP_ISCOMPLETE);

end

-------------------------
--***********************
--OnSubmit
--***********************
-------------------------

function x700004_OnSubmit(sceneId, selfId, NPCId)
	
	local iscomplete = x700004_CheckComplete(sceneId, selfId, NPCId);
	
	local str;
	if iscomplete > 0 then
		local money = x700004_GetMoney(sceneId, selfId, NPCId);
		AddMoney(sceneId, selfId, money);
	
		local moneyjin = floor(money / 10000);
		local moneyyin = floor(money / 100) - moneyjin * 100;
		local moneytong = money - moneyjin * 10000 - moneyyin * 100;
		
		str = format(x700004_g_MissionBonusInfo, moneyjin, moneyyin, moneytong);
	else
		str = x700004_g_MissionAbandon;
	end
	
	BeginEvent(sceneId);
		AddText(sceneId, str);
	EndEvent();
	DispatchMissionTips(sceneId, selfId);
	DelMission(sceneId, selfId, x700004_g_MissionId);
	
end

-------------------------
--***********************
--CheckTeamLeader
--***********************
-------------------------

function x700004_CheckTeamLeader(sceneId, selfId)
	if GetTeamId(sceneId, selfId) < 0 then	--判断是否有队伍
		return x700004_FAILED_TEAM;
	end
	
	local	memberNum = GetNearTeamCount(sceneId, selfId);
	
	if memberNum < x700004_g_LimitMembers then
		return x700004_FAILED_TEAMNUMBER;
	end
	
	if LuaFnIsTeamLeader(sceneId, selfId) == 0 then	--只有队长才能接任务
		return x700004_FAILED_CAPTAIN;
	end
	
	return x700004_OK;
end

-------------------------
--***********************
--OnAbandon
--***********************
-------------------------

function x700004_OnAbandon(sceneId, selfId)
	
	x700004_CancelMission(sceneId, selfId);
	
end

-------------------------
--***********************
--OnCopySceneTimer
--***********************
-------------------------

function x700004_OnCopySceneTimer(sceneId, nowTime)

	local nowTickCount = LuaFnGetCopySceneData_Param(sceneId, x700004_CSP_TICKCOUNT) + 1;
	LuaFnSetCopySceneData_Param(sceneId, x700004_CSP_TICKCOUNT, nowTickCount);
	
	for i, item in x700004_g_NeedKillMonster do
		if item.time == nowTickCount then
			x700004_CreateMonster(sceneId, i);
		end
	end
	
	local leaveFlag = LuaFnGetCopySceneData_Param(sceneId, x700004_CSP_ISCLOSING);
	
	if leaveFlag > 0 then
	
		local leaveCountDown = LuaFnGetCopySceneData_Param(sceneId, x700004_CSP_LEAVECOUNTDOWN) + 1;
		LuaFnSetCopySceneData_Param(sceneId, x700004_CSP_LEAVECOUNTDOWN, leaveCountDown);
		
		if leaveCountDown == x700004_g_CloseTick then
			local oldsceneId = LuaFnGetCopySceneData_Param(sceneId, x700004_CSP_FROMSCENEID);
			local humancount = LuaFnGetCopyScene_HumanCount(sceneId);
			for	i = 0, humancount - 1 do
				local humanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);
				NewWorld(sceneId, humanId, oldsceneId, x700004_g_Back_X, x700004_g_Back_Z);
			end
		elseif leaveCountDown < x700004_g_CloseTick then
			local humancount = LuaFnGetCopyScene_HumanCount(sceneId);
			for	i = 0, humancount - 1 do
				local humanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);
 				local str = format(x700004_g_CountDownMessage, (x700004_g_CloseTick - leaveCountDown) * x700004_g_TickTime);
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
			if nowTickCount == 1 then
				BeginEvent(sceneId);
					AddText(sceneId, x700004_g_TipForEnter);
				EndEvent();
				DispatchMissionTips(sceneId, humanId);
			end
			if nowTickCount == x700004_g_LimitTotalHoldTime then
				local oldsceneId = x700004_CancelMission(sceneId, humanId);
				BeginEvent(oldsceneId);
					AddText(sceneId, x700004_g_TimeOutFailedMessage);
				EndEvent();
				DispatchMissionTips(oldsceneId, humanId);
			end
			local kickout = 0;
			if IsHaveMission(sceneId, humanId, x700004_g_MissionId) > 0 then
				if GetTeamId(sceneId, humanId) ~= LuaFnGetCopySceneData_Param(sceneId, x700004_CSP_TEAMID) then
					kickout = 1;
				end
			else
				kickout = 1;
			end
			if kickout == 1 then
				x700004_CancelMission(sceneId, humanId);
			end
			
			local remainmonster = LuaFnGetCopySceneData_Param(sceneId, x700004_CSP_NALLMONSTER) - LuaFnGetCopySceneData_Param(sceneId, x700004_CSP_NKILLMONSTER);
			if remainmonster > 0 then
				BeginEvent(sceneId)
					AddText(sceneId, format(x700004_g_RemainMonsterMessage, remainmonster));
				EndEvent();
				DispatchMissionTips(sceneId, humanId);
			end
			
		end
		if nowTime == x700004_g_LimitTotalHoldTime then
			LuaFnSetCopySceneData_Param(sceneId, x700004_CSP_ISCLOSING, 1);
		end	
	end

end

-------------------------
--***********************
--GetMoney
--***********************
-------------------------

function x700004_GetMoney(sceneId, selfId, NPCId)
	local ret = x700004_g_MoneyBonus;
	return ret;
end

-------------------------
--***********************
--OnKillObject
--***********************
-------------------------

function x700004_OnKillObject(sceneId, selfId, objdataId ,objId)
	
	local sceneType = LuaFnGetSceneType(sceneId);
	if sceneType ~= x700004_g_FuBenType then
		return 0;
	end
	
	local fubenType = LuaFnGetCopySceneData_Param(sceneId, x700004_CSP_FUBENTYPE);
	if fubenType ~= x700004_g_CopySceneType then
		return 0;
	end
	
	local leaveFlag = LuaFnGetCopySceneData_Param(sceneId, x700004_CSP_LEAVECOUNTDOWN);

	if leaveFlag == 1 then --如果副本已经被置成关闭状态，则杀怪无效
		return 0;
	end
	
	local humancount = LuaFnGetCopyScene_HumanCount(sceneId);
	
	local killmonster = LuaFnGetCopySceneData_Param(sceneId, x700004_CSP_NKILLMONSTER) + 1;
	local ntotalmonster = LuaFnGetCopySceneData_Param(sceneId, x700004_CSP_NTOTALMONSTER);
	
	local humanId;
	local misIndex;
	
	local failedobj = LuaFnGetCopySceneData_Param(sceneId, x700004_CSP_FAILEDOBJ);
	if failedobj == -1 then
		return 0;
	end
	
	if ntotalmonster == killmonster then
		for i = 0, humancount - 1 do
		
			humanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);	--取得当前场景里人的objId	
			misIndex = GetMissionIndexByID(sceneId, humanId, x700004_g_MissionId);
			SetMissionByIndex(sceneId, humanId, misIndex, x700004_MP_ISCOMPLETE, 1);

			local str = format(x700004_g_CompleteOutMessage, x700004_g_CloseTick * x700004_g_TickTime);
			
			BeginEvent(sceneId);
				AddText(sceneId, str);
			EndEvent();
			DispatchMissionTips(sceneId, humanId);
		end
		
		LuaFnSetCopySceneData_Param(sceneId, x700004_CSP_ISCLOSING, 1);
		
	end
	
	LuaFnSetCopySceneData_Param(sceneId, x700004_CSP_NKILLMONSTER, killmonster);
	
	for i = 0, humancount - 1 do
		local humanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);--取得当前场景里人的objId
		DispatchMissionTips(sceneId, humanId);
		
		misIndex = GetMissionIndexByID(sceneId, humanId, x700004_g_MissionId); --取得任务数据索引值
		local killedcount = GetMissionParam(sceneId, humanId, misIndex, x700004_MP_KILLMONSTER) + 1; --取得已经杀了的怪物数
		SetMissionByIndex(sceneId, humanId, misIndex, x700004_MP_KILLMONSTER, killedcount); --设置任务数据
	end
end

-------------------------
--***********************
--OnDie
--***********************
-------------------------

function x700004_OnDie(sceneId, selfId, killerId)

	local humancount = LuaFnGetCopyScene_HumanCount(sceneId);
	local failedobj = LuaFnGetCopySceneData_Param(sceneId, x700004_CSP_FAILEDOBJ);
	local failed = 0;
	if failedobj == selfId then
		failed = 1;
	end
	
	if failed > 0 then
		for i = 0, humancount - 1 do
		
			humanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);	--取得当前场景里人的objId	

			str = x700004_g_MissionAbandon;
			
			BeginEvent(sceneId);
				AddText(sceneId, str);
			EndEvent();
			DispatchMissionTips(sceneId, humanId);
		end
		
		LuaFnSetCopySceneData_Param(sceneId, x700004_CSP_ISCLOSING, 1);
		LuaFnSetCopySceneData_Param(sceneId, x700004_CSP_FAILEDOBJ, -1);
	end

end

-------------------------
--***********************
--OnHumanDie
--***********************
-------------------------

function x700004_OnHumanDie(sceneId, selfId, killerId)
end
