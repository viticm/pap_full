--MisDescBegin
-------------------------
--***********************
--Const
--***********************
-------------------------

x700105_g_ScriptId 				= 700105
x700105_g_MissionId 			= 445
x700105_g_MissionKind 		= 23

x700105_g_FuBenType				= 1

x700105_g_CopySceneName				= "浮屠塔五层"
x700105_g_Name								= ""
x700105_g_CopySceneType				= FUBEN_FUTUTA
x700105_g_LimitMembers				= 1			--可以进副本的最小队伍人数
x700105_g_TickTime						= 5				--回调脚本的时钟时间（单位：秒/次）
x700105_g_LimitTotalHoldTime	= 360	--副本可以存活的时间（单位：次数）,如果此时间到了，则任务将会失败
x700105_g_CloseTick						= 2				--副本关闭前倒计时（单位：次数）
x700105_g_NoUserTime					= 10			--副本中没有人后可以继续保存的时间（单位：秒）
x700105_g_DeadTrans						= 0				--死亡转移模式，0：死亡后还可以继续在副本，1：死亡后被强制移出副本
x700105_g_Fuben_X							= 63				--进入副本的位置X
x700105_g_Fuben_Z							= 69				--进入副本的位置Z
x700105_g_Back_X							= 433				--源场景位置X
x700105_g_Back_Z							= 422					--源场景位置Z

x700105_g_MissionName				= "浮屠塔五层"
x700105_g_MissionInfo				= "杀死全部怪物！"
x700105_g_MissionTarget			= "杀死全部怪物！"
x700105_g_MissionBonusInfo	= "获得%d的经验奖励。"
x700105_g_ContinueInfo			= "你要继续努力啊！"

--MisDescEnd

x700105_g_LevelLess					= 30
x700105_g_RoundUntil				= 500

x700105_g_MissionComplete		= "谢谢啊，俺们终于敢出门了"
x700105_g_MissionFuBenOpen	= "传入副本。"

x700105_g_KillMonsterMessage		= "你已经杀死了%d/%d只怪！"
x700105_g_CompleteOutMessage		= "任务完成，将在%d秒后传送到下一层！"

x700105_g_ErrorMessage					= "条件不符！"
x700105_g_ErrorMessage_Country	= "你不是本国人！"
x700105_g_ErrorMessage_Level		= format("你的等级不足%d！", x700105_g_LevelLess)
x700105_g_ErrorMessage_Team			= "你不在队伍中！"
x700105_g_ErrorMessage_TeamNum	= format("队伍不足%d人！", x700105_g_LimitMembers)
x700105_g_ErrorMessage_Captain	= "你不是队长！"
x700105_g_ErrorMessage_Round		= format("你今天已经做过%d次了！", x700105_g_RoundUntil)
x700105_g_ErrorMessage_Item			= "你没有任务道具！"

x700105_g_ErrorMessage_OtherLevel		= "%s的等级不足%d！"
x700105_g_ErrorMessage_OtherAround	= "%s不在你身边！"
x700105_g_ErrorMessage_OtherRound		= "%s今天已经做过%d次了！"
x700105_g_ErrorMessage_OtherItem		= "%s没有任务道具！"

x700105_g_SomeoneInTeam				= "队伍中某人"

x700105_g_FuBenCreateOK					= "副本创建成功！"
x700105_g_FuBenCreateFailed			= "副本已达上限，请稍后再试！"
x700105_g_MissionAbandon				= "任务失败！"
x700105_g_CountDownMessage			= "你将在%d秒后离开场景！"
x700105_g_TimeOutFailedMessage	= "任务失败，超时！"
x700105_g_CompleteFailedNPCMessage	= "你们竟然失败了！"
x700105_g_TipForEnter						= "进入浮屠塔！"
x700105_g_SceneMapNavPath				= "fuben_fututawuceng/fuben_fututawuceng.nav"

x700105_g_ExpBonus				= 0
x700105_g_growpointStart	= 24

x700105_g_MissionNPCName		= {
																{scene = 11, name = "长者"},		--新月
																{scene = 18, name = "长者"},		--金帐
																{scene = 21, name = "长者"},		--雪域
																{scene = 24, name = "长者"},		--大漠
																{scene = 36, name = "天衣居"}		--皇城
															}
x700105_g_MissionNeedItem		= {
																{num=1, id=10200001}
															}
x700105_g_NeedKillMonster		=	{
																{hash=1, type=340, x=64, z=64, ai=0, aiscript=0},
																{hash=1, type=340, x=64, z=64, ai=0, aiscript=0},
																{hash=1, type=340, x=64, z=64, ai=0, aiscript=0},
																{hash=1, type=340, x=64, z=64, ai=0, aiscript=0},
																{hash=1, type=340, x=64, z=64, ai=0, aiscript=0}
															}
x700105_g_buffInfo		= {
													{hash=1, buffId=1000, comment="你获得了1号Buff"},
													{hash=2, buffId=1001, comment="你获得了2号Buff"},
													{hash=3, buffId=1002, comment="你获得了3号Buff"},
													{hash=4, buffId=1003, comment="你获得了4号Buff"},
													{hash=5, buffId=1004, comment="你获得了5号Buff"}
												}

-------------------------
--***********************
--Define
--***********************
-------------------------

x700105_OK							= 0
x700105_OK_RETURN				= 1
x700105_ERROR_UNKNOWN		= -1

x700105_FAILED_COUNTRY	= 10
x700105_FAILED_LEVEL		= 11
x700105_FAILED_ROUND		= 13
x700105_FAILED_TEAM			= 14
x700105_FAILED_TEAMNUM	= 15
x700105_FAILED_CAPTAIN	= 16
x700105_FAILED_ITEM			= 17

x700105_FAILED_OTHERLEVEL		= 20
x700105_FAILED_OTHERMISSION	= 22
x700105_FAILED_OTHERAROUND	= 23
x700105_FAILED_OTHERROUND		= 24
x700105_FAILED_OTHERITEM		= 27

x700105_MP_AIMSCENE			= 0
x700105_MP_TEAMID				= 1
x700105_MP_KILLMONSTER	= 2
x700105_MP_ISCOMPLETE		= 7

x700105_CSP_FUBENTYPE				= 0
x700105_CSP_SCRIPTID				= 1
x700105_CSP_TICKCOUNT				= 2
x700105_CSP_FROMSCENEID			= 3
x700105_CSP_ISCLOSING				= 4
x700105_CSP_LEAVECOUNTDOWN	= 5
x700105_CSP_TEAMID					= 6
x700105_CSP_NALLMONSTER			= 7
x700105_CSP_NKILLMONSTER		= 8
x700105_CSP_NTOTALMONSTER		= 9
x700105_CSP_GROWPOINT_1			= 11
x700105_CSP_GROWPOINT_2			= 12
x700105_CSP_GROWPOINT_3			= 13
x700105_CSP_GROWPOINT_4			= 14
x700105_CSP_GROWPOINT_5			= 15

x700105_MD_DayCount				= MD_FUTUTA_DAYCOUNT_B

-------------------------
--***********************
--OnDefaultEvent
--***********************
-------------------------

function x700105_OnDefaultEvent(sceneId, selfId, NPCId)

	local safeCheckRet, otherRet = x700105_SafeNPCCheck(sceneId, selfId, NPCId);
	local bHaveMission = IsHaveMission(sceneId, selfId, x700105_g_MissionId);
	local misIndex;
	local str = x700105_g_MissionName.."\n";
	local dispatchType = 0;
	local bDone = 0;
	
	if bHaveMission > 0 then
		misIndex = GetMissionIndexByID(sceneId, selfId, x700105_g_MissionId);
		bDone = x700105_CheckComplete(sceneId, selfId);

		if bDone == 1 then
			str = str..x700105_g_MissionComplete;
			dispatchType = 2;
		else
			str = str..x700105_g_CompleteFailedNPCMessage;
			dispatchType = 2;
		end
	elseif safeCheckRet == x700105_OK or safeCheckRet == x700105_OK_RETURN then
		str = str..x700105_g_MissionInfo;
		dispatchType = 1;
	else
		dispatchType = 4;
		if safeCheckRet == x700105_FAILED_ROUND then
			str = x700105_g_ErrorMessage_Round;
		elseif safeCheckRet == x700105_FAILED_COUNTRY then
			str = x700105_g_ErrorMessage_Country;
		elseif safeCheckRet == x700105_FAILED_LEVEL then
			str = x700105_g_ErrorMessage_Level;
		elseif safeCheckRet == x700105_FAILED_ITEM then
			str = x700105_g_ErrorMessage_Item;
		elseif safeCheckRet == x700105_FAILED_CAPTAIN then
			str = x700105_g_ErrorMessage_Captain;
		elseif safeCheckRet == x700105_FAILED_TEAM then
			str = x700105_g_ErrorMessage_Team;
		elseif safeCheckRet == x700105_FAILED_TEAMNUM then
			str = x700105_g_ErrorMessage_TeamNum;
		else
			local otherName = x700105_g_SomeoneInTeam;
			if otherRet >= 0 then
				otherName = GetName(sceneId, otherRet);
			end
			if safeCheckRet == x700105_FAILED_OTHERLEVEL then
				str = format(x700105_g_ErrorMessage_OtherLevel, otherName, x700105_g_LevelLess);
			elseif safeCheckRet == x700105_FAILED_OTHERROUND then
				str = format(x700105_g_ErrorMessage_OtherRound, otherName, x700105_g_RoundUntil);
			elseif safeCheckRet == x700105_FAILED_OTHERMISSION then
				str = format(x700105_g_ErrorMessage_OtherMission, otherName);
			elseif safeCheckRet == x700105_FAILED_OTHERAROUND then
				str = format(x700105_g_ErrorMessage_OtherAround, otherName);
			elseif safeCheckRet == x700105_FAILED_OTHERITEM then
				str = format(x700105_g_ErrorMessage_OtherItem, otherName);
			end
		end
	end
	
	BeginEvent(sceneId);
		AddText(sceneId, str);
	EndEvent();
	
	if dispatchType == 1 then
		DispatchMissionInfo(sceneId, selfId, NPCId, x700105_g_ScriptId, x700105_g_MissionId);
	elseif dispatchType == 2 then
		DispatchMissionContinueInfo(sceneId, selfId, NPCId, x700105_g_ScriptId, x700105_g_MissionId);
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

function x700105_OnEnumerate(sceneId, selfId, NPCId)

	if x700105_SafeDisplayCheck(sceneId, selfId, NPCId) > 0 then
		AddNumText(sceneId, x700105_g_ScriptId, x700105_g_MissionName);
	end

end

-------------------------
--***********************
--SafeDisplayCheck
--***********************
-------------------------

function x700105_SafeDisplayCheck(sceneId, selfId, NPCId)

	local bHaveMission = IsHaveMission(sceneId, selfId, x700105_g_MissionId);
	
	if bHaveMission > 0 then
		return 1;
	end
	
	if x700105_IsMissionNPC(sceneId, selfId, x700105_g_MissionId, NPCId) > 0 then
		return 1;
	end
	
	return 0;

end

-------------------------
--***********************
--IsMissionNPC
--***********************
-------------------------

function x700105_IsMissionNPC(sceneId, selfId, missionId, NPCId)

	for i, item in x700105_g_MissionNPCName do
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

function x700105_CheckAllMemberLevel(sceneId, selfId, teamnum)

	for i = 0, teamnum - 1 do
		local memberId = GetNearTeamMember(sceneId, selfId, i);
		if GetLevel(sceneId, memberId) < x700105_g_LevelLess then
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

function x700105_CheckAllMemberHaveMission(sceneId, selfId, teamnum)

	for i = 0, teamnum - 1 do
		local memberId = GetNearTeamMember(sceneId, selfId, i);
		if IsHaveMission(sceneId, memberId, x700105_g_MissionId) <= 0 then
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

function x700105_CheckAllMemberAround(sceneId, selfId, teamnum)

	if GetNearTeamCount(sceneId, selfId) == teamnum then
		return 1;
	end
	
	return 0, -1;

end


-------------------------
--***********************
--CheckRound
--***********************
-------------------------

function x700105_CheckRound(sceneId, selfId)

	local daycount = GetMissionData(sceneId, selfId, x700105_MD_DayCount);
	local nowtime = LuaFnGetCurrentTime();
	
	local today = floor(nowtime / 86400);
	local round = 0;
	
	if today == floor(daycount / 10000) then
		round = floor((daycount - today * 10000) / 100) + 1;
		if round >= x700105_g_RoundUntil then
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

function x700105_CheckAllMemberRound(sceneId, selfId, teamnum)

	for i = 0, teamnum - 1 do
		local memberId = GetNearTeamMember(sceneId, selfId, i);
		if x700105_CheckRound(sceneId, memberId) < 0 then
			return 0, memberId;
		end
	end
	
	return 1;
	
end

-------------------------
--***********************
--CheckAllMemberItem
--***********************
-------------------------

function x700105_CheckAllMemberItem(sceneId, selfId, teamnum)

	for i = 0, teamnum - 1 do
		local memberId = GetNearTeamMember(sceneId, selfId, i);
		if HaveItem(sceneId, memberId, x700105_g_MissionNeedItem[1].id) < 0 then
			return 0, memberId;
		end
	end
	
	return 1;

end

-------------------------
--***********************
--SafeNPCCheck
--***********************
-------------------------

function x700105_SafeNPCCheck(sceneId, selfId, NPCId)

	bHaveMission = IsHaveMission(sceneId, selfId, x700105_g_MissionId);
	
	if bHaveMission > 0 then
	
		misIndex = GetMissionIndexByID(sceneId, selfId, x700105_g_MissionId);
		aimsceneid = GetMissionParam(sceneId, selfId, misIndex, x700105_MP_AIMSCENE);
		aimteamid = GetMissionParam(sceneId, selfId, misIndex, x700105_MP_TEAMID);
		
		if aimsceneid >= 0 and teamId == aimteamid then
			return x700105_OK_RETURN;
		else
			return x700105_ERROR_UNKNOWN;
		end
		
	else
		local teamid = GetTeamId(sceneId, selfId);
		local teamnum = GetTeamSize(sceneId, selfId);
		if GetLevel(sceneId, selfId) < x700105_g_LevelLess then
			return x700105_FAILED_LEVEL;
		elseif x700105_CheckRound(sceneId, selfId) < 0 then
			return x700105_FAILED_ROUND;
		elseif HaveItem(sceneId, selfId, x700105_g_MissionNeedItem[1].id) < 0 then
			return x700105_FAILED_ITEM;
		elseif LuaFnIsTeamLeader(sceneId, selfId) <= 0 then
			return x700105_FAILED_CAPTAIN;
		elseif teamid < 0 then
			return x700105_FAILED_TEAM;
		elseif teamnum < x700105_g_LimitMembers then
			return x700105_FAILED_TEAMNUM;
		else
		
			local nearteamnum = GetNearTeamCount(sceneId, selfId);
			local ret, otherId;
			
			ret, otherId = x700105_CheckAllMemberLevel(sceneId, selfId, nearteamnum);
			if ret <= 0 then
				return x700105_FAILED_OTHERLEVEL, otherId;
			end
			ret, otherId = x700105_CheckAllMemberRound(sceneId, selfId, nearteamnum);
			if ret <= 0 then
				return x700105_FAILED_OTHERAROUND, otherId;
			end
			ret, otherId = x700105_CheckAllMemberHaveMission(sceneId, selfId, nearteamnum);
			if ret <= 0 then
				return x700105_FAILED_OTHERMISSION, otherId;
			end
			ret, otherId = x700105_CheckAllMemberAround(sceneId, selfId, nearteamnum);
			if ret <= 0 then
				return x700105_FAILED_OTHERAROUND, otherId;
			end
			ret, otherId = x700105_CheckAllMemberItem(sceneId, selfId, nearteamnum);
			if ret <= 0 then
				return x700105_FAILED_OTHERITEM, otherId;
			end
			return x700105_OK;
			
		end
	end
	
	return x700105_ERROR_UNKNOWN;

end

-------------------------
--***********************
--CheckAccept
--***********************
-------------------------

function x700105_CheckAccept(sceneId, selfId, NPCId)

	local safeCheckRet = x700105_SafeNPCCheck(sceneId, selfId, NPCId);
	if safeCheckRet == x700105_OK or safeCheckRet == x700105_OK_RETURN then
		return 1;
	end
	
	return 0;

end

-------------------------
--***********************
--OnAccept
--***********************
-------------------------

function x700105_OnAccept(sceneId, selfId, NPCId)

	bHaveMission = IsHaveMission(sceneId, selfId, x700105_g_MissionId);
	local teamId = GetTeamId(sceneId, selfId);
	
	if bHaveMission > 0 then
		
		local safeCheckRet = x700105_SafeNPCCheck(sceneId, selfId, NPCId);
		if SafeNPCCheck == x700105_OK_RETURN then
			misIndex = GetMissionIndexByID(sceneId, selfId, x700105_g_MissionId);
			aimsceneid = GetMissionParam(sceneId, selfId, misIndex, x700105_MP_AIMSCENE);
			NewWorld(sceneId, selfId, aimsceneid, x700105_g_Fuben_X, x700105_g_Fuben_Z);
		else
			BeginEvent(sceneId);
				AddText(x700105_g_ErrorMessage);
			EndEvent();
			DispatchMissionTips(sceneId, selfId);
			return 0;
		end
		
	else
		
		local memberNum = GetNearTeamCount(sceneId, selfId);
		for i = 0, memberNum - 1 do
		
			local memberId = GetNearTeamMember(sceneId, selfId, i);
	------------------------------------------------------------
	SetHumanAbilityLevel(sceneId, memberId, 26, 1)
	------------------------------------------------------------
			if HaveItem(sceneId, memberId, x700105_g_MissionNeedItem[1].id) < 0 then
			
				local tstr = format(x700105_g_ErrorMessage_OtherItem, GetName(sceneId, memberId));
				BeginEvent(sceneId)
					AddText(sceneId, tstr);
				EndEvent()
				for j = 0, memberNum - 1 do
					local tId = GetNearTeamMember(sceneId, selfId, i);
					DispatchMissionTips(sceneId, selfId);
				end
				return -1;
				
			end
			
		end
		
		for i = 0, memberNum - 1 do
		
			local memberId = GetNearTeamMember(sceneId, selfId, i);
			
			if x888888_DeleteAndAddItem(sceneId, memberId, x700105_g_MissionNeedItem, nil, nil, x700105_g_ErrorMessage_Item) <= 0 then
				return -1;
			end
		
			AddMission(sceneId, memberId, x700105_g_MissionId, x700105_g_ScriptId, 1, 0, 0);
			local misIndex = GetMissionIndexByID(sceneId, memberId, x700105_g_MissionId);
			SetMissionByIndex(sceneId, memberId, misIndex, x700105_MP_AIMSCENE, -1);
			SetMissionByIndex(sceneId, memberId, misIndex, x700105_MP_TEAMID, teamId);
			SetMissionByIndex(sceneId, memberId, misIndex, x700105_MP_ISCOMPLETE, 0);
			
			x700105_SetDayCount(sceneId, memberId);
		end
		
		x700105_MakeCopyScene(sceneId, selfId, memberNum);
		
	end
	
end

-------------------------
--***********************
--SetDayCount
--***********************
-------------------------

function x700105_SetDayCount(sceneId, selfId)
	
	local daycount = GetMissionData(sceneId, selfId, x700105_MD_DayCount);	--day*100+circle
	local nowtime = LuaFnGetCurrentTime();
	local today = floor(nowtime / 86400);
	if today == floor(daycount / 10000) then
		daycount = daycount + 101;
	else
		daycount = today * 10000 + 1;
	end
	SetMissionData(sceneId, selfId, x700105_MD_DayCount, daycount);

end

-------------------------
--***********************
--MakeCopyScene
--***********************
-------------------------

function x700105_MakeCopyScene(sceneId, selfId, memberNum)
	
	local leaderguid = LuaFnObjId2Guid(sceneId, selfId);
	LuaFnSetSceneLoad_Map(sceneId, x700105_g_SceneMapNavPath); --地图是必须选取的，而且必须在Config/SceneInfo.ini里配置好
	LuaFnSetCopySceneData_TeamLeader(sceneId, leaderguid);
	LuaFnSetCopySceneData_NoUserCloseTime(sceneId, x700105_g_NoUserTime * 1000);
	LuaFnSetCopySceneData_Timer(sceneId, x700105_g_TickTime * 1000);
	LuaFnSetCopySceneData_Param(sceneId, x700105_CSP_FUBENTYPE, x700105_g_CopySceneType);--设置副本数据，这里将0号索引的数据设置为999，用于表示副本号999(数字自定义)
	LuaFnSetCopySceneData_Param(sceneId, x700105_CSP_SCRIPTID, x700105_g_ScriptId);--将1号数据设置为副本场景事件脚本号
	LuaFnSetCopySceneData_Param(sceneId, x700105_CSP_TICKCOUNT, 0);--设置定时器调用次数
	LuaFnSetCopySceneData_Param(sceneId, x700105_CSP_FROMSCENEID, -1);--设置副本入口场景号, 初始化
	LuaFnSetCopySceneData_Param(sceneId, x700105_CSP_ISCLOSING, 0);--设置副本关闭标志, 0开放，1关闭
	LuaFnSetCopySceneData_Param(sceneId, x700105_CSP_LEAVECOUNTDOWN, 0);--设置离开倒计时次数
	LuaFnSetCopySceneData_Param(sceneId, x700105_CSP_TEAMID, GetTeamId(sceneId, selfId)); --保存队伍号
	LuaFnSetCopySceneData_Param(sceneId, x700105_CSP_NALLMONSTER, 0) ;--全部怪数量
	LuaFnSetCopySceneData_Param(sceneId, x700105_CSP_NKILLMONSTER, 0) ;--杀死怪的数量
	
	LuaFnSetCopySceneData_Param(sceneId, x700105_CSP_GROWPOINT_1, -2) ;
	LuaFnSetCopySceneData_Param(sceneId, x700105_CSP_GROWPOINT_2, -2) ;
	LuaFnSetCopySceneData_Param(sceneId, x700105_CSP_GROWPOINT_3, -2) ;
	LuaFnSetCopySceneData_Param(sceneId, x700105_CSP_GROWPOINT_4, -2) ;
	LuaFnSetCopySceneData_Param(sceneId, x700105_CSP_GROWPOINT_5, -2) ;
	
	local ntotalmonster = 0;
	for i, item in x700105_g_NeedKillMonster do
			ntotalmonster = ntotalmonster + 1;
	end
	LuaFnSetCopySceneData_Param(sceneId, x700105_CSP_NTOTALMONSTER, ntotalmonster) ;--全部怪数量
	
	local bRetSceneID = LuaFnCreateCopyScene(sceneId); --初始化完成后调用创建副本函数
		BeginEvent(sceneId);
		if bRetSceneID > 0 then
			AddText(sceneId, x700105_g_FuBenCreateOK);
		else
			AddText(sceneId, x700105_g_FuBenCreateFailed);
			for i = 0, memberNum - 1 do
				local memberId = GetNearTeamMember(sceneId, selfId, i);
				x700105_CancelMission(sceneId, memberId);
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

function x700105_OnCopySceneReady(sceneId, destsceneId)

	LuaFnSetCopySceneData_Param(destsceneId, x700105_CSP_FROMSCENEID, sceneId);--设置副本入口场景号
	leaderguid = LuaFnGetCopySceneData_TeamLeader(destsceneId);
	leaderObjId = LuaFnGuid2ObjId(sceneId, leaderguid);

	local	memberNum = GetNearTeamCount(sceneId, leaderObjId);
	
	for i = 0, memberNum - 1 do
		local memberId = GetNearTeamMember(sceneId, leaderObjId, i);

		misIndex = GetMissionIndexByID(sceneId, memberId, x700105_g_MissionId);
		SetMissionByIndex(sceneId, memberId, misIndex, x700105_MP_AIMSCENE, destsceneId);
		NewWorld(sceneId, memberId, destsceneId, x700105_g_Fuben_X, x700105_g_Fuben_Z);
	end
	
	x700105_CreateMonster(destsceneId, 1);
	
end

-------------------------
--***********************
--OnPlayerEnter
--***********************
-------------------------

function x700105_OnPlayerEnter(sceneId, selfId)

	SetPlayerDefaultReliveInfo(sceneId, selfId, "%10", "%10", "%10", sceneId, x700105_g_Fuben_X, x700105_g_Fuben_Z);

end

-------------------------
--***********************
--CreateMonster
--***********************
-------------------------

function x700105_CreateMonster(sceneId, teamIndex)

	for i, item in x700105_g_NeedKillMonster do
		if item.hash == teamIndex then
			LuaFnCreateMonster(sceneId, item.type, item.x, item.z, item.ai, item.aiscript, -1);
		end
	end
	
end

-------------------------
--***********************
--CancelMission
--***********************
-------------------------

function x700105_CancelMission(sceneId, selfId)

	misIndex = GetMissionIndexByID(sceneId, selfId, x700105_g_MissionId);
	local aimsceneid = GetMissionParam(sceneId, selfId, misIndex, x700105_MP_AIMSCENE);
	
	DelMission(sceneId, selfId, x700105_g_MissionId);
	
	if sceneId == aimsceneid then --如果在副本里删除任务，则直接传送回
	
		BeginEvent(sceneId);
			AddText(sceneId, x700105_g_MissionAbandon);
		EndEvent();
		DispatchMissionTips(sceneId, selfId);
		oldsceneId = LuaFnGetCopySceneData_Param(sceneId, x700105_CSP_FROMSCENEID);--取得副本入口场景号
		
		NewWorld(sceneId, selfId, oldsceneId, x700105_g_Back_X, x700105_g_Back_Z);
		return oldsceneId;
	end
	
	return -1;
	
end

-------------------------
--***********************
--CheckSubmit
--***********************
-------------------------

function x700105_CheckSubmit(sceneId, selfId, NPCId)

	return 1;

end

-------------------------
--***********************
--CheckComplete
--***********************
-------------------------

function x700105_CheckComplete(sceneId, selfId, NPCId)

	local misIndex = GetMissionIndexByID(sceneId, selfId, x700105_g_MissionId);
	return GetMissionParam(sceneId, selfId, misIndex, x700105_MP_ISCOMPLETE);

end

-------------------------
--***********************
--OnSubmit
--***********************
-------------------------

function x700105_OnSubmit(sceneId, selfId, NPCId)
	
	local iscomplete = x700105_CheckComplete(sceneId, selfId, NPCId);
	
	local str;
	if iscomplete > 0 then
		str = x700105_g_MissionComplete;
	else
		str = x700105_g_MissionAbandon;
	end
	
	BeginEvent(sceneId);
		AddText(sceneId, str);
	EndEvent();
	DispatchMissionTips(sceneId, selfId);
	DelMission(sceneId, selfId, x700105_g_MissionId);
	
end

-------------------------
--***********************
--CheckTeamLeader
--***********************
-------------------------

function x700105_CheckTeamLeader(sceneId, selfId)
	if GetTeamId(sceneId, selfId) < 0 then	--判断是否有队伍
		return x700105_FAILED_TEAM;
	end
	
	local	memberNum = GetNearTeamCount(sceneId, selfId);
	
	if memberNum < x700105_g_LimitMembers then
		return x700105_FAILED_TEAMNUMBER;
	end
	
	if LuaFnIsTeamLeader(sceneId, selfId) == 0 then	--只有队长才能接任务
		return x700105_FAILED_CAPTAIN;
	end
	
	return x700105_OK;
end

-------------------------
--***********************
--OnAbandon
--***********************
-------------------------

function x700105_OnAbandon(sceneId, selfId)
	
	x700105_CancelMission(sceneId, selfId);
	
end

-------------------------
--***********************
--OnCopySceneTimer
--***********************
-------------------------

function x700105_OnCopySceneTimer(sceneId, nowTime)

	local nowTickCount = LuaFnGetCopySceneData_Param(sceneId, x700105_CSP_TICKCOUNT) + 1;
	LuaFnSetCopySceneData_Param(sceneId, x700105_CSP_TICKCOUNT, nowTickCount);
	
	local leaveFlag = LuaFnGetCopySceneData_Param(sceneId, x700105_CSP_ISCLOSING);
	
	if leaveFlag > 0 then
	
		local leaveCountDown = LuaFnGetCopySceneData_Param(sceneId, x700105_CSP_LEAVECOUNTDOWN) + 1;
		LuaFnSetCopySceneData_Param(sceneId, x700105_CSP_LEAVECOUNTDOWN, leaveCountDown);
		
		if leaveCountDown == x700105_g_CloseTick then
			local oldsceneId = LuaFnGetCopySceneData_Param(sceneId, x700105_CSP_FROMSCENEID);
			local humancount = LuaFnGetCopyScene_HumanCount(sceneId);
			for	i = 0, humancount - 1 do
				local humanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);
				DelMission(sceneId, humanId, x700105_g_MissionId);
				CallScriptFunction(700106, "OnAccept", sceneId, humanId, nil, oldsceneId);
--				NewWorld(sceneId, humanId, oldsceneId, x700105_g_Back_X, x700105_g_Back_Z);
			end
		elseif leaveCountDown < x700105_g_CloseTick then
			local humancount = LuaFnGetCopyScene_HumanCount(sceneId);
			for	i = 0, humancount - 1 do
				local humanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);
 				local str = format(x700105_g_CountDownMessage, (x700105_g_CloseTick - leaveCountDown) * x700105_g_TickTime);
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
					AddText(sceneId, x700105_g_TipForEnter);
				EndEvent();
				DispatchMissionTips(sceneId, humanId);
			end
			if nowTickCount == x700105_g_LimitTotalHoldTime then
				local oldsceneId = x700105_CancelMission(sceneId, humanId);
				BeginEvent(oldsceneId);
					AddText(sceneId, x700105_g_TimeOutFailedMessage);
				EndEvent();
				DispatchMissionTips(oldsceneId, humanId);
			end
			local kickout = 0;
			if IsHaveMission(sceneId, humanId, x700105_g_MissionId) > 0 then
				if GetTeamId(sceneId, humanId) ~= LuaFnGetCopySceneData_Param(sceneId, x700105_CSP_TEAMID) then
					kickout = 1;
				end
			else
				kickout = 1;
			end
			if kickout == 1 then
				x700105_CancelMission(sceneId, humanId);
			end
			
--			
--
			
		end
		if nowTime == x700105_g_LimitTotalHoldTime then
			LuaFnSetCopySceneData_Param(sceneId, x700105_CSP_ISCLOSING, 1);
		end	
	end

end

-------------------------
--***********************
--GetMoney
--***********************
-------------------------

function x700105_GetExp(sceneId, selfId, NPCId)

	local ret = x700105_g_ExpBonus;
	return ret;
	
end

-------------------------
--***********************
--OnKillObject
--***********************
-------------------------

function x700105_OnKillObject(sceneId, selfId, objdataId ,objId)
	
	local sceneType = LuaFnGetSceneType(sceneId);
	if sceneType ~= x700105_g_FuBenType then
		return 0;
	end
	
	local fubenType = LuaFnGetCopySceneData_Param(sceneId, x700105_CSP_FUBENTYPE);
	if fubenType ~= x700105_g_CopySceneType then
		return 0;
	end
	
	local leaveFlag = LuaFnGetCopySceneData_Param(sceneId, x700105_CSP_LEAVECOUNTDOWN);

	if leaveFlag == 1 then --如果副本已经被置成关闭状态，则杀怪无效
		return 0;
	end
	
	local humancount = LuaFnGetCopyScene_HumanCount(sceneId);
	
	local killmonster = LuaFnGetCopySceneData_Param(sceneId, x700105_CSP_NKILLMONSTER) + 1;
	local ntotalmonster = LuaFnGetCopySceneData_Param(sceneId, x700105_CSP_NTOTALMONSTER);
	
	local humanId;
	local misIndex;
	
	--
	
	if ntotalmonster == killmonster then
		for i = 0, humancount - 1 do
		
			humanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);	--取得当前场景里人的objId	
			misIndex = GetMissionIndexByID(sceneId, humanId, x700105_g_MissionId);
			SetMissionByIndex(sceneId, humanId, misIndex, x700105_MP_ISCOMPLETE, 1);

			local str = format(x700105_g_CompleteOutMessage, x700105_g_CloseTick * x700105_g_TickTime);
			
			BeginEvent(sceneId);
				AddText(sceneId, str);
			EndEvent();
			DispatchMissionTips(sceneId, humanId);
			
			local exp = x700105_GetExp(sceneId, humanId);
			GetExp(sceneId, humanId, exp);
			str = format(x700105_g_MissionBonusInfo, exp);
			BeginEvent(sceneId);
				AddText(sceneId, str);
			EndEvent();
			DispatchMissionTips(sceneId, humanId);
			
		end
		
		LuaFnSetCopySceneData_Param(sceneId, x700105_CSP_ISCLOSING, 1);
		
	end
	
	LuaFnSetCopySceneData_Param(sceneId, x700105_CSP_NKILLMONSTER, killmonster);
	
	for i = 0, humancount - 1 do
		local humanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);--取得当前场景里人的objId
		
		misIndex = GetMissionIndexByID(sceneId, humanId, x700105_g_MissionId); --取得任务数据索引值
		local killedcount = GetMissionParam(sceneId, humanId, misIndex, x700105_MP_KILLMONSTER) + 1; --取得已经杀了的怪物数
		SetMissionByIndex(sceneId, humanId, misIndex, x700105_MP_KILLMONSTER, killedcount); --设置任务数据
	end
end

-------------------------
--***********************
--_OnCreate
--***********************
-------------------------

function x700105__OnCreate(sceneId, growPointType, x, z)

	local csp = x700105_CSP_GROWPOINT_1 + growPointType - x700105_g_growpointStart;
	if LuaFnGetCopySceneData_Param(sceneId, csp) < -1 then
		local ItemBoxId = ItemBoxEnterScene(x, z, growPointType, sceneId);
		LuaFnSetCopySceneData_Param(sceneId, csp, ItemBoxId);
	end
	
end

-------------------------
--***********************
--_OnOpen
--***********************
-------------------------

function x700105__OnOpen(sceneId, selfId, targetId)

	for offset = 0, 4 do
		if targetId == LuaFnGetCopySceneData_Param(sceneId, x700105_CSP_GROWPOINT_1 + offset) then
			return 0;
		end
	end
	
	return 1;

end

-------------------------
--***********************
--_OnRecycle
--***********************
-------------------------

function x700105__OnRecycle(sceneId, selfId, targetId)

	for offset = 0, 4 do
		if targetId == LuaFnGetCopySceneData_Param(sceneId, x700105_CSP_GROWPOINT_1 + offset) then
			LuaFnSetCopySceneData_Param(sceneId, x700105_CSP_GROWPOINT_1 + offset, -1);
			x700105_CauseBuff(sceneId, offset + 1);
			return 0;
		end
	end

end

-------------------------
--***********************
--CauseBuff
--***********************
-------------------------

function x700105_CauseBuff(sceneId, setId)

	local humancount = LuaFnGetCopyScene_HumanCount(sceneId);
	local buffId = x700105_g_buffInfo[setId].buffId;
	BeginEvent(sceneId);
		AddText(sceneId, x700105_g_buffInfo[setId].comment);
	EndEvent();
	for	i = 0, humancount - 1 do
		local humanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);
		LuaFnSendSpecificImpactToUnit(sceneId, humanId, humanId, humanId, buffId, 0);
		DispatchMissionTips(sceneId, humanId);
	end

end
-------------------------
--***********************
--OnHumanDie
--***********************
-------------------------

function x700105_OnHumanDie(sceneId, selfId, killerId)
end