
-------------------------
--***********************
--Const
--***********************
-------------------------

x800008_g_ScriptId 					= 800008
x800008_g_MissionName				= "强制离婚"
x800008_g_CostMoneyDivorce  = 200000
x800008_g_FriendPointNotify	= 100
x800008_g_SkillID						= 149

-------------------------
--***********************
--Define
--***********************
-------------------------

x800008_OK							= 0
x800008_ERROR_UNKNOWN		= -1
x800008_FAILED_MONEY		= 1
x800008_FAILED_MARRIGE	= 2

-------------------------
--***********************
--IsCanDivorce
--***********************
-------------------------

function x800008_IsCanDivorce(sceneId, selfId) 

	if GetMoney(sceneId, selfId) < x800008_g_CostMoneyDivorce then
		return x800008_FAILED_MONEY;
	end	
	
	--是否是结婚状态
	if LuaFnIsMarried(sceneId, selfId) ~= 1 then
		return x800008_FAILED_MARRIGE;
	end
	
	return x800008_OK;
	
end

-------------------------
--***********************
--DoDivorce
--***********************
-------------------------

function x800008_DoDivorce(sceneId, selfId, NPCId)

	--扣除身上金钱200000
	local ret = x800008_SafeDivorceCheck(sceneId, selfId, NPCId, 1);
	if ret ~= x800008_OK then
		return ret;
	end
	
	if LuaFnCostMoney(sceneId, selfId,x205009_g_CostMoneyDivorce) == -1 then
		return x800008_FAILED_MONEY;
	end
	
	--得到配偶GUID
	local targetGUId = LuaFnGetSpouseGUID(sceneId, selfId);

	--把好友度设置成X，X为能够看到对方在线的最低值，最后一个参数设置是否设置对方
	LuaFnSetDeadLinkFriendPoint(sceneId, selfId, targetGUId, x800008_g_FriendPointNotify, 1);
	
	--删除夫妻技能，如何删除对方技能？
	DelSkill(sceneId, selfId, x800008_g_SkillID);
	
	--删除称号，如何删除对方称号？
	LuaFnAwardSpouseTitle(sceneId, selfId, "");

	--发送mail给对方
	local mail = format("%s与你单方面离婚了。",GetName(sceneId, selfId));
	LuaFnSendNormalMail(sceneId, selfId, LuaFnGetFriendName(sceneId, selfId, targetGUId), mail);
	
	--最后一步,离婚.如何解除对方的婚姻关系？
	LuaFnDivorce(sceneId, selfId);
	
	return x800008_OK;
	
end

-------------------------
--***********************
--SafeDivorceCheck
--***********************
-------------------------

function x800008_SafeDivorceCheck(sceneId, selfId, targetId, bDirect)

	local ret 	= x800008_IsCanDivorce(sceneId, selfId);
	local str 	= "已经强制离婚。";
	
	if ret == x800008_OK then
		str = format("确定要强制离婚？\n需要支付%d金钱。", x800008_g_CostMoneyDivorce);
	
	elseif ret == x800008_FAILED_MARRIGE then
		str = "你没有结婚，就想离婚么？";
	
	elseif ret == x800008_FAILED_MONEY then
		str = format("需要携带%d金钱才能离婚。", x800008_g_CostMoneyDivorce);
	end
	
	if ret == x800008_OK and bDirect == 1 then
		return ret;
	end
	
	BeginEvent(sceneId);
	
		AddText(sceneId, str);
	
	EndEvent();

	if ret == x800008_OK then
		DispatchMissionInfo(sceneId, selfId, targetId, x800008_g_ScriptId);
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

function x800008_OnEnumerate(sceneId, selfId, targetId)
	AddNumText(sceneId, x800008_g_ScriptId, x800008_g_MissionName);
end

-------------------------
--***********************
--OnDefaultEvent
--***********************
-------------------------

function x800008_OnDefaultEvent(sceneId, selfId, targetId)

	x800008_SafeDivorceCheck(sceneId, selfId, targetId, 0);
	
end

-------------------------
--***********************
--CheckAccept
--***********************
-------------------------

function x800008_CheckAccept(sceneId, selfId, targetId)

	return 1;

end

-------------------------
--***********************
--OnAccept
--***********************
-------------------------

function x800008_OnAccept(sceneId, selfId, targetId)

	local ret = x800008_DoDivorce(sceneId, selfId, targetId);
	
	if ret == x800008_OK then
		return
	end
	
	local str = "ERROR。";
	
	if ret == x800008_FAILED_MONEY then
		str = "扣除金钱错误。";
	end
	
	BeginEvent(sceneId);
	
		AddText(sceneId, str);
	
	EndEvent();

	DispatchEventList(sceneId, selfId, targetId);

end