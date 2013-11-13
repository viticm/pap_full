
-------------------------
--***********************
--Const
--***********************
-------------------------

x800009_g_ScriptId 					= 800009
x800009_g_MissionName				= "收徒"
x800009_g_MasterLevelMin		= 50
x800009_g_PrenticeLevelMin	= 15
x800009_g_PrenticeLevelMax	= 25
x800009_g_PenaltyDay				= 3
x800009_g_MaxPrenticeNum		= 2

-------------------------
--***********************
--Define
--***********************
-------------------------

x800009_CHAT_TYPE_NORMAL			= 0
x800009_CHAT_TYPE_SYSTEM			= 4

x800009_OK											= 0
x800009_ERROR_UNKNOWN						= -1
x800009_FAILED_CAPTAIN					= 1
x800009_FAILED_TEAM							= 2
x800009_FAILED_LEVEL_MASTER			= 3
x800009_FAILED_LEVEL_PRENTICE		= 4
x800009_FAILED_BROTHER					= 5
x800009_FAILED_MARRIGE					= 6
x800009_FAILED_PENALTY_PRENTICE	= 7
x800009_FAILED_PENALTY_MASTER		= 8
x800009_FAILED_NUM_PRENTICE			= 9
x800009_FAILED_HAVEMASTER				= 10
x800009_FAILED_FRIEND						= 11

-------------------------
--***********************
--IsCanBaiShi
--***********************
-------------------------

function x800009_IsCanBaiShi(sceneId, selfId)
	
	if (IsCaptain(sceneId, selfId)) ~= 1 then
		return x800009_FAILED_CAPTAIN;
	end
	
	if (GetTeamSize(sceneId, selfId) ~= 2) then
		return x800009_FAILED_TEAM;
	end

	if GetLevel(sceneId, selfId) < x800009_g_MasterLevelMin then
		return x800009_FAILED_LEVEL_MASTER;
	end
	
	--得到徒弟的objID
	local targetId = LuaFnGetTeamSceneMember(sceneId, selfId, 0);
	
	if GetLevel(sceneId, targetId) < x800009_g_PrenticeLevelMin or GetLevel(sceneId, targetId) > x800009_g_PrenticeLevelMax then
		return x800009_FAILED_LEVEL_PRENTICE;
	end
	
	if LuaFnIsBrother(sceneId, selfId, targetId) == 1 then
		return x800009_FAILED_BROTHER;
	end

	if LuaFnIsSpouses(sceneId, selfId, targetId) == 1 then
		return x800009_FAILED_MARRIGE;
	end
	
	--得到最后一次徒弟叛师的时间,得到的是时间差（秒数）
	local iTime = LuaFnGetPrenticeBetrayTime(sceneId, targetId);
	iTime = floor(iTime/3600/24);	--将秒转为天
	
	if iTime > 0 and iTime <= x800009_g_PenaltyDay then
		return x800009_FAILED_PENALTY_PRENTICE;
	end
	
	iTime = LuaFnGetPrenticeBetrayTime(sceneId, selfId);
	iTime = floor(iTime/3600/24);
	
	if iTime > 0 and iTime < x800009_g_PenaltyDay then
		return x800009_FAILED_PENALTY_MASTER;
	end
	
	if LuaFnGetPrenticeCount(sceneId, selfId) >= x800009_g_MaxPrenticeNum then
		return x800009_FAILED_NUM_PRENTICE;
	end
	
	if LuaFnHaveMaster(sceneId, targetId) == 1 then
		return x800009_FAILED_HAVEMASTER;
	end
	
	if LuaFnIsFriend(sceneId, selfId, targetId) ~= 1 or LuaFnIsFriend(sceneId, targetId, selfId) ~= 1 then
		return x800009_FAILED_FRIEND;
	end	
	
	return x800009_OK;

end

-------------------------
--***********************
--DoBaiShi
--***********************
-------------------------

function x800009_DoBaiShi(sceneId, selfId, NPCId)

	local ret = x800009_SafeBaiShiCheck(sceneId, selfId, NPCId, 1);
	if ret ~= x800009_OK then
		return ret;
	end
	
	--得到徒弟的objID
	local targetId = LuaFnGetTeamSceneMember(sceneId, selfId, 0);
	
	LuaFnAprentice(sceneId, targetId, selfId);		--拜师
	
	LuaFnMsg2Player(sceneId, selfId, "恭喜收徒成功！\n 师傅要努力教好你的徒儿。", x800009_CHAT_TYPE_NORMAL);
	LuaFnMsg2Player(sceneId, targetId, "恭喜拜师成功！", x800009_CHAT_TYPE_NORMAL);
	
	return x800009_OK;
	
end

-------------------------
--***********************
--SafeBaiShiCheck
--***********************
-------------------------

function x800009_SafeBaiShiCheck(sceneId, selfId, targetId, bDirect)

	local ret 	= x800009_IsCanBaiShi(sceneId, selfId);
	local str 	= "成功收徒。";
	
	if ret == x800009_OK then
		str = "确定要收领徒弟？";
	
	elseif ret == x800009_FAILED_CAPTAIN then
		str = "只有队长才能申请收徒。";
	
	elseif ret == x800009_FAILED_TEAM then
		str = "需要师徒二人组队来找我。";
	
	elseif ret == x800009_FAILED_LEVEL_MASTER then
		str = format("师傅等级必须达到%d级。", x800009_g_MasterLevelMin);
	
	elseif ret == x800009_FAILED_LEVEL_PRENTICE then
		str = format("徒弟等级达到%d级且不超过%d级才能拜师。", x800009_g_PrenticeLevelMin, x800009_g_PrenticeLevelMax);
	
	elseif ret == x800009_FAILED_BROTHER then
		str = "有结拜关系不能拜师。";
	
	elseif ret == x800009_FAILED_MARRIGE then
		str = "夫妻关系不能拜师。";
	
	elseif ret == x800009_FAILED_PENALTY_PRENTICE then
		str = format("徒弟强行解除师徒关系%d天后才能再次拜师。", x800009_g_PenaltyDay);
	
	elseif ret == x800009_FAILED_PENALTY_MASETER then
		str = format("师傅强行解除师徒关系%d天后才能再次收徒。", x800009_g_PenaltyDay);
	
	elseif ret == x800009_FAILED_NUM_PRENTICE then
		str = format("每个师傅最多收%d个徒弟", x800009_g_MaxPrenticeNum);
	
	elseif ret == x800009_FAILED_HAVEMASTER then
		str = "对方已经有师傅，无法拜师。";
	
	elseif ret == x800009_FAILED_FRIEND then
		str = "相互加为好友才能拜师。";
	end
	
	if ret == x800009_OK and bDirect == 1 then
		return ret;
	end
	
	BeginEvent(sceneId);
	
		AddText(sceneId, str);
	
	EndEvent();

	if ret == x800009_OK then
		DispatchMissionInfo(sceneId, selfId, targetId, x800009_g_ScriptId);
	else
		DispatchEventList(sceneId, selfId, targetId);
	end
	
	return ret;
	
end

-------------------------
--***********************
--OnEnumerate
--***********************
-------------------------

function x800009_OnEnumerate(sceneId, selfId, targetId)
	AddNumText(sceneId, x800009_g_ScriptId, x800009_g_MissionName);
end

-------------------------
--***********************
--OnDefaultEvent
--***********************
-------------------------

function x800009_OnDefaultEvent(sceneId, selfId, targetId)

	x800009_SafeBaiShiCheck(sceneId, selfId, targetId, 0);
	
end

-------------------------
--***********************
--CheckAccept
--***********************
-------------------------

function x800009_CheckAccept(sceneId, selfId, targetId)

	return 1;

end

-------------------------
--***********************
--OnAccept
--***********************
-------------------------

function x800009_OnAccept(sceneId, selfId, targetId)

	local ret = x800009_DoBaiShi(sceneId, selfId, targetId);
	
	if ret == x800009_OK then
		return
	end

end