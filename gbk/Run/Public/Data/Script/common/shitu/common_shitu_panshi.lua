-------------------------
--***********************
--Const
--***********************
-------------------------

x800012_g_ScriptId 					= 800012
x800012_g_MissionName				= "叛师"
x800012_g_CostMoneyPanShi		= 20000
x800012_g_PenaltyDay				= 3

-------------------------
--***********************
--Define
--***********************
-------------------------

x800012_CHAT_TYPE_NORMAL			= 0
x800012_CHAT_TYPE_SYSTEM			= 4

x800012_OK							= 0
x800012_ERROR_UNKNOWN		= -1
x800012_FAILED_MASTER		= 1
x800012_FAILED_MONEY		= 2

-------------------------
--***********************
--IsCanPanShi
--***********************
-------------------------

function x800012_IsCanPanShi(sceneId, selfId)

	if LuaFnHaveMaster(sceneId, selfId) ~= 1 then
		return x800012_FAILED_MASTER;
	end
	
	if GetMoney(sceneId, selfId) < x800012_g_CostMoneyPanShi then
		return x800012_FAILED_MONEY;
	end
			
	return x800012_OK;

end

-------------------------
--***********************
--DoPanShi
--***********************
-------------------------

function x800012_DoPanShi(sceneId, selfId, NPCId)

	local ret = x800012_SafePanShiCheck(sceneId, selfId, NPCId, 1);

	if ret ~= x800012_OK then
		return ret;
	end
	
	--扣除身上金钱
	if LuaFnCostMoney(sceneId, selfId, x800012_g_CostMoneyPanShi) == -1 then
		return x800012_FAILED_MONEY;
	end
	
	--给师父发邮件
	local mail = format("%s已经与你解除了师徒关系。", GetName(sceneId, selfId));
	
	--得到师父GUID
	local targetGUID = LuaFnGetMasterGUID(sceneId, selfId);
	LuaFnSendNormalMail(sceneId, selfId, LuaFnGetFriendName(sceneId, selfId, targetGUID), mail);
	
	--叛师
	LuaFnBetrayMaster(sceneId, selfId);
	
	--给徒弟的提示信息
	Msg = format("你解除了和%s的师徒关系，%d天之后才可以再次拜师。", LuaFnGetFriendName(sceneId, selfId, targetGUID), x800012_g_PenaltyDay);
	LuaFnMsg2Player(sceneId, selfId, Msg, x800012_CHAT_TYPE_NORMAL);
	
end

-------------------------
--***********************
--SafePanShiCheck
--***********************
-------------------------

function x800012_SafePanShiCheck(sceneId, selfId, NPCId, bDirect)

	local ret 	= x800012_IsCanPanShi(sceneId, selfId);
	local str 	= "已经叛师。";
	
	if ret == x800012_OK then
		str = "确定要叛离师门？";
	
	elseif ret == x800012_FAILED_MASTER then
		str = "你还没有拜师。";
	
	elseif ret == x800012_FAILED_MONEY then
		str = format("解除师徒关系需要交纳%d钱。", x800012_g_CostMoneyPanShi);
	
	end
	
	if ret == x800012_OK and bDirect == 1 then
		return ret;
	end
	
	BeginEvent(sceneId);
	
		AddText(sceneId, str);
	
	EndEvent();

	if ret == x800012_OK then
		DispatchMissionInfo(sceneId, selfId, NPCId, x800012_g_ScriptId);
	else
		DispatchEventList(sceneId, selfId, NPCId);
	end
	
	return ret;
	
end

-------------------------
--***********************
--OnEnumerate
--***********************
-------------------------

function x800012_OnEnumerate(sceneId, selfId, targetId)
	AddNumText(sceneId, x800012_g_ScriptId, x800012_g_MissionName);
end

-------------------------
--***********************
--OnDefaultEvent
--***********************
-------------------------

function x800012_OnDefaultEvent(sceneId, selfId, targetId)

	x800012_SafePanShiCheck(sceneId, selfId, targetId, 0);
	
end

-------------------------
--***********************
--CheckAccept
--***********************
-------------------------

function x800012_CheckAccept(sceneId, selfId, targetId)

	return 1;

end

-------------------------
--***********************
--OnAccept
--***********************
-------------------------

function x800012_OnAccept(sceneId, selfId, targetId)

	local ret = x800012_DoPanShi(sceneId, selfId, targetId);
	
	if ret == x800012_OK then
		return
	end

end