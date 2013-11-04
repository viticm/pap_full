-------------------------
--***********************
--Const
--***********************
-------------------------

--MisDescBegin

x700002_g_ScriptId 				= 700002
x700002_g_MissionId 			= 407
x700002_g_MissionKind 		= 23

x700002_g_MissionName				= "勾栏曲台"
x700002_g_MissionInfo				= "看戏！"
x700002_g_MissionTarget			= "看戏！杀怪！"
x700002_g_FuBenType				= 1

--MisDescEnd

x700002_g_CopySceneName				= "勾栏曲台"
x700002_g_Name								= ""
x700002_g_CopySceneType				= FUBEN_GOULANQUTAI
x700002_g_LimitMembers				= 1			--可以进副本的最小队伍人数
x700002_g_TickTime						= 5				--回调脚本的时钟时间（单位：秒/次）
x700002_g_LimitTotalHoldTime	= 1440	--副本可以存活的时间（单位：次数）,如果此时间到了，则任务将会失败
x700002_g_CloseTick						= 6				--副本关闭前倒计时（单位：次数）
x700002_g_NoUserTime					= 10			--副本中没有人后可以继续保存的时间（单位：秒）
x700002_g_DeadTrans						= 0				--死亡转移模式，0：死亡后还可以继续在副本，1：死亡后被强制移出副本
x700002_g_Fuben_X							= 33				--进入副本的位置X
x700002_g_Fuben_Z							= 35				--进入副本的位置Z
x700002_g_Back_X							= 421				--源场景位置X
x700002_g_Back_Z							= 429					--源场景位置Z

x700002_g_RandomBuffInterval		= 10
x700002_g_MonsterCreateInterval	= 6

x700002_g_LevelLess					= 60
x700002_g_DayCountUntil			= 1
x700002_g_StartCreateDelay	= 1

x700002_g_MissionBonusInfo	= "获得%d的经验奖励。"

x700002_g_ContinueInfo			= "你要继续努力啊！"
x700002_g_MissionComplete		= "看过瘾了？"
x700002_g_MissionFuBenOpen	= "传入副本。"

x700002_g_CompleteOutMessage		= "任务完成，将在%d秒后传送到入口位置！"

x700002_g_ErrorMessage					= "条件不符！"
x700002_g_ErrorMessage_Country	= "你不是本国人！"
x700002_g_ErrorMessage_Level		= format("你的等级不足%d！", x700002_g_LevelLess)
x700002_g_ErrorMessage_Team			= "你不在队伍中！"
x700002_g_ErrorMessage_TeamNum	= format("队伍不足%d人！", x700002_g_LimitMembers)
x700002_g_ErrorMessage_Captain	= "你不是队长！"
x700002_g_ErrorMessage_DayCount	= "你今天已经看过戏了！"

x700002_g_ErrorMessage_OtherLevel		= "%s的等级不足%d！"
x700002_g_ErrorMessage_OtherAround	= "%s不在你身边！"

x700002_g_SomeoneInTeam				= "队伍中某人"

x700002_g_RandomBuffUpMessage		= "%s获得了%s的Buff！"
x700002_g_RandomBuffDownMessage	= "全体中了%s的Buff！"

x700002_g_FuBenCreateOK					= "副本创建成功！"
x700002_g_FuBenCreateFailed			= "副本已达上限，请稍后再试！"
x700002_g_MissionAbandon				= "任务失败！"
x700002_g_CountDownMessage			= "你将在%d秒后离开场景！"
x700002_g_TimeOutFailedMessage	= "任务失败，超时！"
x700002_g_TipForEnter						= "欢迎来到勾栏曲台看戏！"
x700002_g_SceneMapNavPath				= "fuben_goulanqutai/fuben_goulanqutai.nav"

x700002_g_ExpBonusLevel			= 6
x700002_g_ExpBonusMulti			= 100

x700002_g_MissionNPCName		= {
																{scene = 11, name = "打铁匠"},		--新月
																{scene = 18, name = "打铁匠"},		--金帐
																{scene = 21, name = "打铁匠"},		--雪域
																{scene = 24, name = "打铁匠"},		--大漠
																{scene = 36, name = "燕十三"}			--皇城
															}
x700002_g_BossCreate		= {
														{
															{hash=1, type=340, x=33, z=43, num=1, ai=0}
														},
														{
															{hash=1, type=340, x=22, z=38, num=1, ai=0},
															{hash=2, type=340, x=23, z=46, num=1, ai=0}
														},
														{
															{hash=1, type=340, x=42, z=36, num=1, ai=0},
															{hash=2, type=340, x=42, z=46, num=1, ai=0}
														},
														{
															{hash=1, type=340, x=32, z=17, num=1, ai=0}
														}
													}
x700002_g_MonsterCreate	= {
														{hash=1, type=341, num=1, ai=0}
													}

x700002_g_RandomBuffUp		= {
															{hash=1, buffId=1000, name="加血"},
															{hash=2, buffId=1001, name="回蓝"},
															{hash=3, buffId=1002, name="状态恢复"}
														}
x700002_g_RandomBuffDown	= {
															{hash=1, buffId=1010, name="减血"},
															{hash=2, buffId=1011, name="减蓝"},
															{hash=3, buffId=1012, name="狂暴状态"}
														}

-------------------------
--***********************
--Define
--***********************
-------------------------

x700002_OK							= 0
x700002_OK_RETURN				= 1
x700002_ERROR_UNKNOWN		= -1

x700002_FAILED_COUNTRY	= 10
x700002_FAILED_LEVEL		= 11
x700002_FAILED_DAYCOUNT	= 12
x700002_FAILED_TEAM			= 13
x700002_FAILED_TEAMNUM	= 14
x700002_FAILED_CAPTAIN	= 15

x700002_FAILED_OTHERLEVEL			= 20
x700002_FAILED_OTHERDAYCOUNT	= 21
x700002_FAILED_OTHERMISSION		= 22
x700002_FAILED_OTHERAROUND		= 23

x700002_MP_AIMSCENE			= 0
x700002_MP_TEAMID				= 1
x700002_MP_KILLMONSTER	= 2
x700002_MP_ISCOMPLETE		= 7

x700002_CSP_FUBENTYPE				= 0
x700002_CSP_SCRIPTID				= 1
x700002_CSP_TICKCOUNT				= 2
x700002_CSP_FROMSCENEID			= 3
x700002_CSP_ISCLOSING				= 4
x700002_CSP_LEAVECOUNTDOWN	= 5
x700002_CSP_TEAMID					= 6
x700002_CSP_NALLMONSTER			= 7
x700002_CSP_NKILLMONSTER		= 8
x700002_CSP_NTOTALMONSTER		= 9
x700002_CSP_STATE						= 10
x700002_CSP_LASTBOSS				= 11

-------------------------
--***********************
--OnDefaultEvent
--***********************
-------------------------

function x700002_OnDefaultEvent(sceneId, selfId, NPCId)

	local safeCheckRet, otherRet = x700002_SafeNPCCheck(sceneId, selfId, NPCId);
	local bHaveMission = IsHaveMission(sceneId, selfId, x700002_g_MissionId);
	local misIndex;
	local str = x700002_g_MissionName.."\n";
	local dispatchType = 0;
	local bDone = 0;
	
	if bHaveMission > 0 then
		misIndex = GetMissionIndexByID(sceneId, selfId, x700002_g_MissionId);
		bDone = x700002_CheckSubmit(sceneId, selfId);

		if bDone > 0 then
			str = str..x700002_g_MissionComplete;
			dispatchType = 2;
		else
			str = str..x700002_g_ContinueInfo;
			dispatchType = 1;
		end
	elseif safeCheckRet == x700002_OK or safeCheckRet == x700002_OK_RETURN then
		str = str..x700002_g_MissionInfo;
		dispatchType = 1;
	else
		dispatchType = 4;
		if safeCheckRet == x700002_FAILED_CAPTAIN then
			str = x700002_g_ErrorMessage_Captain;
		elseif safeCheckRet == x700002_FAILED_TEAM then
			str = x700002_g_ErrorMessage_Team;
		elseif safeCheckRet == x700002_FAILED_TEAMNUM then
			str = x700002_g_ErrorMessage_TeamNum;
		elseif safeCheckRet == x700002_FAILED_COUNTRY then
			str = x700002_g_ErrorMessage_Country;
		elseif safeCheckRet == x700002_FAILED_LEVEL then
			str = x700002_g_ErrorMessage_Level;
		elseif safeCheckRet == x700002_FAILED_DAYCOUNT then
			str = x700002_g_ErrorMessage_DayCount;
		else
			local otherName = x700002_g_SomeoneInTeam;
			if otherRet >= 0 then
				otherName = GetName(sceneId, otherRet);
			end
			if safeCheckRet == x700002_FAILED_OTHERLEVEL then
				str = format(x700002_g_ErrorMessage_OtherLevel, otherName, x700002_g_LevelLess);
			elseif safeCheckRet == x700002_FAILED_OTHERMISSION then
				str = format(x700002_g_ErrorMessage_OtherMission, otherName);
			elseif safeCheckRet == x700002_FAILED_OTHERAROUND then
				str = format(x700002_g_ErrorMessage_OtherAround, otherName);
			elseif safeCheckRet == x700002_FAILED_OTHERDAYCOUNT then
				str = format(x700002_g_ErrorMessage_OtherDayCount, otherName);
			end
		end
	end
	
	BeginEvent(sceneId);
		AddText(sceneId, str);
	EndEvent();
	
	if dispatchType == 1 then
		DispatchMissionInfo(sceneId, selfId, NPCId, x700002_g_ScriptId, x700002_g_MissionId);
	elseif dispatchType == 2 then
		if bDone > 0 then
			DispatchMissionContinueInfo(sceneId, selfId, NPCId, x700002_g_ScriptId, x700002_g_MissionId);
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

function x700002_OnEnumerate(sceneId, selfId, NPCId)

	if x700002_SafeDisplayCheck(sceneId, selfId, NPCId) > 0 then
		AddNumText(sceneId, x700002_g_ScriptId, x700002_g_MissionName);
	end

end

-------------------------
--***********************
--SafeDisplayCheck
--***********************
-------------------------

function x700002_SafeDisplayCheck(sceneId, selfId, NPCId)

	local bHaveMission = IsHaveMission(sceneId, selfId, x700002_g_MissionId);
	
	if bHaveMission > 0 then
		return 1;
	end
	
	if x700002_IsMissionNPC(sceneId, selfId, x700002_g_MissionId, NPCId) > 0 then
		return 1;
	end
	
	return 0;

end

-------------------------
--***********************
--IsMissionNPC
--***********************
-------------------------

function x700002_IsMissionNPC(sceneId, selfId, missionId, NPCId)

	for i, item in x700002_g_MissionNPCName do
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

function x700002_CheckAllMemberLevel(sceneId, selfId, teamnum)

	for i = 0, teamnum - 1 do
		local memberId = GetNearTeamMember(sceneId, selfId, i);
		if GetLevel(sceneId, memberId) < x700002_g_LevelLess then
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

function x700002_CheckAllMemberHaveMission(sceneId, selfId, teamnum)

	for i = 0, teamnum - 1 do
		local memberId = GetNearTeamMember(sceneId, selfId, i);
		if IsHaveMission(sceneId, memberId, x700002_g_MissionId) <= 0 then
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

function x700002_CheckAllMemberAround(sceneId, selfId, teamnum)

	if GetNearTeamCount(sceneId, selfId) == teamnum then
		return 1;
	end
	
	return 0, -1;

end

-------------------------
--***********************
--CheckAllMemberDayCount
--***********************
-------------------------

function x700002_CheckAllMemberDayCount(sceneId, selfId, teamnum)

	for i = 0, teamnum - 1 do
		local memberId = GetNearTeamMember(sceneId, selfId, i);
		if x700002_GetDayCount(sceneId, memberId) > x700002_g_DayCountUntil then
			return 0, memberId;
		end
	end
	
	return 1;

end

-------------------------
--***********************
--GetDayCount
--***********************
-------------------------

function x700002_GetDayCount(sceneId, selfId)
	
	local nowtime = LuaFnGetCurrentTime();
	local today = floor(nowtime / 86400);
	
	if GetMissionData(sceneId, selfId, MD_HUOCAISHENDIAN_DAYCOUNT) ~= today then
		return 0;
	end
	
	return 0;
	
end

-------------------------
--***********************
--SetDayCount
--***********************
-------------------------

function x700002_SetDayCount(sceneId, selfId)
	
	local nowtime = LuaFnGetCurrentTime();
	local today = floor(nowtime / 86400);
	
	SetMissionData(sceneId, selfId, MD_HUOCAISHENDIAN_DAYCOUNT, today);
	
end

-------------------------
--***********************
--SafeNPCCheck
--***********************
-------------------------

function x700002_SafeNPCCheck(sceneId, selfId, NPCId)

	bHaveMission = IsHaveMission(sceneId, selfId, x700002_g_MissionId);
	
	if bHaveMission > 0 then
	
		misIndex = GetMissionIndexByID(sceneId, selfId, x700002_g_MissionId);
		aimsceneid = GetMissionParam(sceneId, selfId, misIndex, x700002_MP_AIMSCENE);
		aimteamid = GetMissionParam(sceneId, selfId, misIndex, x700002_MP_TEAMID);
		
		if aimsceneid >= 0 and teamId == aimteamid then
			return x700002_OK_RETURN;
		else
			return x700002_ERROR_UNKNOWN;
		end
		
	else
		local teamid = GetTeamId(sceneId, selfId);
		local teamnum = GetTeamSize(sceneId, selfId);
		if GetLevel(sceneId, selfId) < x700002_g_LevelLess then
			return x700002_FAILED_LEVEL;
		elseif x700002_GetDayCount(sceneId, selfId) > 0 then
			return x700002_FAILED_DAYCOUNT;
		elseif LuaFnIsTeamLeader(sceneId, selfId) <= 0 then
			return x700002_FAILED_CAPTAIN;
		elseif teamid < 0 then
			return x700002_FAILED_TEAM;
		elseif teamnum < x700002_g_LimitMembers then
			return x700002_FAILED_TEAMNUM;
		else
		
			local nearteamnum = GetNearTeamCount(sceneId, selfId);
			local ret, otherId;
			
			ret, otherId = x700002_CheckAllMemberLevel(sceneId, selfId, nearteamnum);
			if ret <= 0 then
				return x700002_FAILED_OTHERLEVEL, otherId;
			end
			ret, otherId = x700002_CheckAllMemberDayCount(sceneId, selfId, nearteamnum);
			if ret <= 0 then
				return x700002_FAILED_DAYCOUNT, otherId;
			end
			ret, otherId = x700002_CheckAllMemberHaveMission(sceneId, selfId, nearteamnum);
			if ret <= 0 then
				return x700002_FAILED_OTHERMISSION, otherId;
			end
			ret, otherId = x700002_CheckAllMemberAround(sceneId, selfId, nearteamnum);
			if ret <= 0 then
				return x700002_FAILED_OTHERAROUND, otherId;
			end
			return x700002_OK;
			
		end
	end
	
	return x700002_ERROR_UNKNOWN;

end

-------------------------
--***********************
--CheckAccept
--***********************
-------------------------

function x700002_CheckAccept(sceneId, selfId, NPCId)

	local safeCheckRet = x700002_SafeNPCCheck(sceneId, selfId, NPCId);
	if safeCheckRet == x700002_OK or safeCheckRet == x700002_OK_RETURN then
		return 1;
	end
	
	return 0;

end

-------------------------
--***********************
--OnAccept
--***********************
-------------------------

function x700002_OnAccept(sceneId, selfId, NPCId)

	bHaveMission = IsHaveMission(sceneId, selfId, x700002_g_MissionId);
	local teamId = GetTeamId(sceneId, selfId);
	
	if bHaveMission > 0 then
		
		local safeCheckRet = x700002_SafeNPCCheck(sceneId, selfId, NPCId);
		if SafeNPCCheck == x700002_OK_RETURN then
			misIndex = GetMissionIndexByID(sceneId, selfId, x700002_g_MissionId);
			aimsceneid = GetMissionParam(sceneId, selfId, misIndex, x700002_MP_AIMSCENE);
			NewWorld(sceneId, selfId, aimsceneid, x700002_g_Fuben_X, x700002_g_Fuben_Z);
		else
			BeginEvent(sceneId);
				AddText(x700002_g_ErrorMessage);
			EndEvent();
			DispatchMissionTips(sceneId, selfId);
			return 0;
		end
		
	else
		
		local memberNum = GetNearTeamCount(sceneId, selfId);
		for i = 0, memberNum - 1 do
			local memberId = GetNearTeamMember(sceneId, selfId, i);
			AddMission(sceneId, memberId, x700002_g_MissionId, x700002_g_ScriptId, 1, 0, 0);
			local misIndex = GetMissionIndexByID(sceneId, memberId, x700002_g_MissionId);
			SetMissionByIndex(sceneId, memberId, misIndex, x700002_MP_AIMSCENE, -1);
			SetMissionByIndex(sceneId, memberId, misIndex, x700002_MP_TEAMID, teamId);
			SetMissionByIndex(sceneId, memberId, misIndex, x700002_MP_ISCOMPLETE, 0);
			x700002_SetDayCount(sceneId, selfId);
		end
		
		x700002_MakeCopyScene(sceneId, selfId, memberNum);
		
	end
	
end

-------------------------
--***********************
--MakeCopyScene
--***********************
-------------------------

function x700002_MakeCopyScene(sceneId, selfId, memberNum)
	
	local leaderguid = LuaFnObjId2Guid(sceneId, selfId);
	LuaFnSetSceneLoad_Map(sceneId, x700002_g_SceneMapNavPath); --地图是必须选取的，而且必须在Config/SceneInfo.ini里配置好
	LuaFnSetCopySceneData_TeamLeader(sceneId, leaderguid);
	LuaFnSetCopySceneData_NoUserCloseTime(sceneId, x700002_g_NoUserTime * 1000);
	LuaFnSetCopySceneData_Timer(sceneId, x700002_g_TickTime * 1000);
	LuaFnSetCopySceneData_Param(sceneId, x700002_CSP_FUBENTYPE, x700002_g_CopySceneType);--设置副本数据，这里将0号索引的数据设置为999，用于表示副本号999(数字自定义)
	LuaFnSetCopySceneData_Param(sceneId, x700002_CSP_SCRIPTID, x700002_g_ScriptId);--将1号数据设置为副本场景事件脚本号
	LuaFnSetCopySceneData_Param(sceneId, x700002_CSP_TICKCOUNT, 0);--设置定时器调用次数
	LuaFnSetCopySceneData_Param(sceneId, x700002_CSP_FROMSCENEID, -1);--设置副本入口场景号, 初始化
	LuaFnSetCopySceneData_Param(sceneId, x700002_CSP_ISCLOSING, 0);--设置副本关闭标志, 0开放，1关闭
	LuaFnSetCopySceneData_Param(sceneId, x700002_CSP_LEAVECOUNTDOWN, 0);--设置离开倒计时次数
	LuaFnSetCopySceneData_Param(sceneId, x700002_CSP_TEAMID, GetTeamId(sceneId, selfId)); --保存队伍号
	LuaFnSetCopySceneData_Param(sceneId, x700002_CSP_NALLMONSTER, 0) ;--全部怪数量
	LuaFnSetCopySceneData_Param(sceneId, x700002_CSP_NKILLMONSTER, 0) ;--杀死怪的数量
	LuaFnSetCopySceneData_Param(sceneId, x700002_CSP_STATE, 0) ;
	LuaFnSetCopySceneData_Param(sceneId, x700002_CSP_LASTBOSS, -1) ;
	
	local bRetSceneID = LuaFnCreateCopyScene(sceneId); --初始化完成后调用创建副本函数
		BeginEvent(sceneId);
		if bRetSceneID > 0 then
			AddText(sceneId, x700002_g_FuBenCreateOK);
		else
			AddText(sceneId, x700002_g_FuBenCreateFailed);
			for i = 0, memberNum - 1 do
				local memberId = GetNearTeamMember(sceneId, selfId, i);
				x700002_CancelMission(sceneId, memberId);
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

function x700002_OnCopySceneReady(sceneId, destsceneId)

	LuaFnSetCopySceneData_Param(destsceneId, x700002_CSP_FROMSCENEID, sceneId);--设置副本入口场景号
	leaderguid = LuaFnGetCopySceneData_TeamLeader(destsceneId);
	leaderObjId = LuaFnGuid2ObjId(sceneId, leaderguid);

	local	memberNum = GetNearTeamCount(sceneId, leaderObjId);
	
	for i = 0, memberNum - 1 do
		local memberId = GetNearTeamMember(sceneId, leaderObjId, i);

		misIndex = GetMissionIndexByID(sceneId, memberId, x700002_g_MissionId);
		SetMissionByIndex(sceneId, memberId, misIndex, x700002_MP_AIMSCENE, destsceneId);
		NewWorld(sceneId, memberId, destsceneId, x700002_g_Fuben_X, x700002_g_Fuben_Z);
	end
	
	x700002_CreateBoss(destsceneId, 1);
	
end

-------------------------
--***********************
--OnPlayerEnter
--***********************
-------------------------

function x700002_OnPlayerEnter(sceneId, selfId)

	SetPlayerDefaultReliveInfo(sceneId, selfId, "%10", "%10", "%10", sceneId, x700002_g_Fuben_X, x700002_g_Fuben_Z);

end

-------------------------
--***********************
--CreateMonster
--***********************
-------------------------

function x700002_CreateMonster(sceneId, x, z)
	
	for i, item in x700002_g_MonsterCreate do
		LuaFnCreateMonster(sceneId, item.type, x, z, 0, 0, -1);
	end
	
end

-------------------------
--***********************
--CreateBoss
--***********************
-------------------------

function x700002_CreateBoss(sceneId, teamIndex)

	local lastobjId;
	for i, item in x700002_g_BossCreate[teamIndex] do
		lastobjId = LuaFnCreateMonster(sceneId, item.type, item.x, item.z, item.ai, 0, -1);
	end
	LuaFnSetCopySceneData_Param(sceneId, x700002_CSP_STATE, LuaFnGetCopySceneData_Param(sceneId, x700002_CSP_STATE) + 1 );
	
	return lastobjId;
	
end

-------------------------
--***********************
--CancelMission
--***********************
-------------------------

function x700002_CancelMission(sceneId, selfId)

	misIndex = GetMissionIndexByID(sceneId, selfId, x700002_g_MissionId);
	local aimsceneid = GetMissionParam(sceneId, selfId, misIndex, x700002_MP_AIMSCENE);
	
	DelMission(sceneId, selfId, x700002_g_MissionId);
	
	if sceneId == aimsceneid then --如果在副本里删除任务，则直接传送回
	
		BeginEvent(sceneId);
			AddText(sceneId, x700002_g_MissionAbandon);
		EndEvent();
		DispatchMissionTips(sceneId, selfId);
		oldsceneId = LuaFnGetCopySceneData_Param(sceneId, x700002_CSP_FROMSCENEID);--取得副本入口场景号
		
		NewWorld(sceneId, selfId, oldsceneId, x700002_g_Back_X, x700002_g_Back_Z);
		return oldsceneId;
	end
	
	return -1;
	
end

-------------------------
--***********************
--CheckSubmit
--***********************
-------------------------

function x700002_CheckSubmit(sceneId, selfId, NPCId)

	misIndex = GetMissionIndexByID(sceneId, selfId, x700002_g_MissionId);
	return GetMissionParam(sceneId, selfId, misIndex, x700002_MP_ISCOMPLETE);

end

-------------------------
--***********************
--OnSubmit
--***********************
-------------------------

function x700002_OnSubmit(sceneId, selfId, NPCId)
	
	local exp = x700002_GetExp(sceneId, selfId, NPCId);
	GetExp(sceneId, selfId, exp);
	
	BeginEvent(sceneId);
		AddText(sceneId, format(x700002_g_MissionBonusInfo, exp));
	EndEvent();
	
	DispatchMissionTips(sceneId, selfId);
	DelMission(sceneId, selfId, x700002_g_MissionId);
	
end

-------------------------
--***********************
--CheckTeamLeader
--***********************
-------------------------

function x700002_CheckTeamLeader(sceneId, selfId)
	if GetTeamId(sceneId, selfId) < 0 then	--判断是否有队伍
		return x700002_FAILED_TEAM;
	end
	
	local	memberNum = GetNearTeamCount(sceneId, selfId);
	
	if memberNum < x700002_g_LimitMembers then
		return x700002_FAILED_TEAMNUMBER;
	end
	
	if LuaFnIsTeamLeader(sceneId, selfId) == 0 then	--只有队长才能接任务
		return x700002_FAILED_CAPTAIN;
	end
	
	return x700002_OK;
end

-------------------------
--***********************
--OnAbandon
--***********************
-------------------------

function x700002_OnAbandon(sceneId, selfId)
	
	x700002_CancelMission(sceneId, selfId);
	
end

-------------------------
--***********************
--OnCopySceneTimer
--***********************
-------------------------

function x700002_OnCopySceneTimer(sceneId, nowTime)

	local nowTickCount = LuaFnGetCopySceneData_Param(sceneId, x700002_CSP_TICKCOUNT) + 1;
	LuaFnSetCopySceneData_Param(sceneId, x700002_CSP_TICKCOUNT, nowTickCount);
	
	local leaveFlag = LuaFnGetCopySceneData_Param(sceneId, x700002_CSP_ISCLOSING);
	
	if leaveFlag > 0 then
	
		local leaveCountDown = LuaFnGetCopySceneData_Param(sceneId, x700002_CSP_LEAVECOUNTDOWN) + 1;
		LuaFnSetCopySceneData_Param(sceneId, x700002_CSP_LEAVECOUNTDOWN, leaveCountDown);
		
		if leaveCountDown == x700002_g_CloseTick then
			local oldsceneId = LuaFnGetCopySceneData_Param(sceneId, x700002_CSP_FROMSCENEID);
			local humancount = LuaFnGetCopyScene_HumanCount(sceneId);
			for	i = 0, humancount - 1 do
				local humanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);
				NewWorld(sceneId, humanId, oldsceneId, x700002_g_Back_X, x700002_g_Back_Z);
			end
		elseif leaveCountDown < x700002_g_CloseTick then
			local humancount = LuaFnGetCopyScene_HumanCount(sceneId);
			for	i = 0, humancount - 1 do
				local humanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);
 				local str = format(x700002_g_CountDownMessage, (x700002_g_CloseTick - leaveCountDown) * x700002_g_TickTime);
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
					AddText(sceneId, x700002_g_TipForEnter);
				EndEvent();
				DispatchMissionTips(sceneId, humanId);
			end
			if nowTickCount == x700002_g_LimitTotalHoldTime then
				local oldsceneId = x700002_CancelMission(sceneId, humanId);
				BeginEvent(oldsceneId);
					AddText(sceneId, x700002_g_TimeOutFailedMessage);
				EndEvent();
				DispatchMissionTips(oldsceneId, humanId);
			end
			local kickout = 0;
			if IsHaveMission(sceneId, humanId, x700002_g_MissionId) > 0 then
				if GetTeamId(sceneId, humanId) ~= LuaFnGetCopySceneData_Param(sceneId, x700002_CSP_TEAMID) then
					kickout = 1;
				end
			else
				kickout = 1;
			end
			if kickout == 1 then
				x700002_CancelMission(sceneId, humanId);
			end
		end
		
		if floor(nowTickCount / x700002_g_RandomBuffInterval) * x700002_g_RandomBuffInterval == nowTickCount then
			x700002_CauseRandomBuff(sceneId, humancount);
		end
		
		local lastbossobjId = LuaFnGetCopySceneData_Param(sceneId, x700002_CSP_LASTBOSS);

		if lastbossobjId ~= -1 then
			if floor(nowTickCount / x700002_g_MonsterCreateInterval) * x700002_g_MonsterCreateInterval == nowTickCount then
				local xpos, zpos = GetWorldPos(sceneId, lastbossobjId);
				x700002_CreateMonster(sceneId, xpos, zpos);
			end
		end
		
	end

end

-------------------------
--***********************
--CauseRandomBuff
--***********************
-------------------------

function x700002_CauseRandomBuff(sceneId, humancount)

	local bup = 0;
	if random(0, 1) == 0 then
		bup = 1;
	end
	
	local buff;
	local buffnum = 0;
	local randomindex;
	local humanId;
	
	if bup then
		for i, item in x700002_g_RandomBuffUp do
			buffnum = buffnum + 1;
		end
	else
		for i, item in x700002_g_RandomBuffDown do
			buffnum = buffnum + 1;
		end
	end
	
	randomindex = random(1, buffnum);
	local text;
	
	if bup then
		humanId = LuaFnGetCopyScene_HumanObjId(sceneId, random(0, humancount-1));
		buffId = x700002_g_RandomBuffUp[randomindex].buffId;
		text = format(x700002_g_RandomBuffUpMessage, GetName(sceneId, humanId), x700002_g_RandomBuffUp[randomindex].name);
		LuaFnSendSpecificImpactToUnit(sceneId, humanId, humanId, humanId, buffId, 0);
	else
		buffId = x700002_g_RandomBuffDown[randomindex].buffId;
		text = format(x700002_g_RandomBuffDownMessage, x700002_g_RandomBuffDown[randomindex].name);
		for i=0, humancount-1 do
			humanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);
			LuaFnSendSpecificImpactToUnit(sceneId, humanId, humanId, humanId, buffId, 0);
		end
	end
	
	BeginEvent(sceneId);
		AddText(sceneId, text);
	EndEvent();
	
	for i=0, humancount-1 do
		humanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);
		DispatchMissionTips(sceneId, humanId);
	end

end

-------------------------
--***********************
--GetExp
--***********************
-------------------------

function x700002_GetExp(sceneId, selfId, NPCId)
	local ret = (GetLevel(sceneId, selfId) + x700002_g_ExpBonusLevel) * x700002_g_ExpBonusMulti;
	return ret;
end

-------------------------
--***********************
--OnKillObject
--***********************
-------------------------

function x700002_OnKillObject(sceneId, selfId, objdataId ,objId)
	
	local sceneType = LuaFnGetSceneType(sceneId);
	if sceneType ~= x700002_g_FuBenType then
		return 0;
	end
	
	local fubenType = LuaFnGetCopySceneData_Param(sceneId, x700002_CSP_FUBENTYPE);
	if fubenType ~= x700002_g_CopySceneType then
		return 0;
	end
	
	local leaveFlag = LuaFnGetCopySceneData_Param(sceneId, x700002_CSP_LEAVECOUNTDOWN);

	if leaveFlag == 1 then --如果副本已经被置成关闭状态，则杀怪无效
		return 0;
	end
	
	local humancount = LuaFnGetCopyScene_HumanCount(sceneId);
	
	local misIndex;
	
	monsterstate = LuaFnGetCopySceneData_Param(sceneId, x700002_CSP_STATE);
	
	local monsternum = GetMonsterCount(sceneId);
	local deadmonsternum = 0;
	for i=0, monsternum-1 do
		local monobjId = GetMonsterObjID(sceneId, i);
		if GetHp(sceneId, monobjId) <= 0 then
			deadmonsternum = deadmonsternum + 1;
		end
	end
	
	if LuaFnGetCopySceneData_Param(sceneId, x700002_CSP_LASTBOSS) == objId then
		LuaFnSetCopySceneData_Param(sceneId, x700002_CSP_LASTBOSS, -1);
	end
	
	if monsternum == deadmonsternum then
	
		local lastobjId;
		if monsterstate < 4 then
			lastobjId = x700002_CreateBoss(sceneId, monsterstate + 1);
			if monsterstate == 3 then
				LuaFnSetCopySceneData_Param(sceneId, x700002_CSP_LASTBOSS, lastobjId);
			end
		else
			for i = 0, humancount - 1 do
			
				humanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);	--取得当前场景里人的objId	
				misIndex = GetMissionIndexByID(sceneId, humanId, x700002_g_MissionId);
				SetMissionByIndex(sceneId, humanId, misIndex, x700002_MP_ISCOMPLETE, 1);
	
				str = format(x700002_g_CompleteOutMessage, x700002_g_CloseTick * x700002_g_TickTime);
				BeginEvent(sceneId);
					AddText(sceneId, str);
				EndEvent();
				DispatchMissionTips(sceneId, humanId);
			end
			
			LuaFnSetCopySceneData_Param(sceneId, x700002_CSP_ISCLOSING, 1);
		end
		
	end
	
	LuaFnSetCopySceneData_Param(sceneId, x700002_CSP_NKILLMONSTER, killmonster);
	
	for i = 0, humancount - 1 do
		local humanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);--取得当前场景里人的objId
		
		misIndex = GetMissionIndexByID(sceneId, humanId, x700002_g_MissionId); --取得任务数据索引值
		local killedcount = GetMissionParam(sceneId, humanId, misIndex, x700002_MP_KILLMONSTER) + 1; --取得已经杀了的怪物数
		SetMissionByIndex(sceneId, humanId, misIndex, x700002_MP_KILLMONSTER, killedcount); --设置任务数据
	end
end

-------------------------
--***********************
--OnHumanDie
--***********************
-------------------------

function x700002_OnHumanDie(sceneId, selfId, killerId)
end
