
-------------------------
--***********************
--Const
--***********************
-------------------------

x800006_g_ScriptId 					= 800006
x800006_g_MissionName				= "结婚"
x800006_g_CostMoneyMarriage	= 520520
x800006_g_RingId						= 10280001
x800006_g_FriendPointDemand	= 1000
x800006_g_ManLevelDemand		= 35
x800006_g_WomanLevelDemand	= 20
x800006_SkillId							= 149

-------------------------
--***********************
--Define
--***********************
-------------------------
x800006_CHAT_TYPE_NORMAL	= 0
x800006_CHAT_TYPE_SYSTEM	= 4

x800006_OK										= 0
x800006_ERROR_UNKNOWN					= -1
x800006_FAILED_CAPTAIN				= 1
x800006_FAILED_TEAM						= 2
x800006_FAILED_COUNTRY				= 3
x800006_FAILED_GENDER					= 4
x800006_FAILED_FRIEND					= 5
x800006_FAILED_MARRIGE_SELF		= 6
x800006_FAILED_MARRIGE_TARGET	= 7
x800006_FAILED_LEVEL					= 8
x800006_FAILED_MONEY					= 9
x800006_FAILED_BAG						= 10
x800006_FAILED_TITLE					= 11
x800006_FAILED_DISTANCE				= 12
x800006_FAILED_MASTER					= 13
x800006_FAILED_BROTHER				= 14

-------------------------
--***********************
--IsCanMarrige
--***********************
-------------------------

function x800006_IsCanMarrige(sceneId, selfId)

	if (IsCaptain(sceneId, selfId)) ~= 1 then
		return x800006_FAILED_CAPTAIN;
	end
	
	if (GetTeamSize(sceneId, selfId) ~= 2) then
		return x800006_FAILED_TEAM;		--组队成员不是两人不可结婚
	end

	local targetId = LuaFnGetTeamSceneMember(sceneId, selfId, 0);
	
	if LuaFnIsFriend(sceneId, selfId, targetId) ~= 1 then
		return x800006_FAILED_FRIEND;
	end		
		
	if (GetCurCountry(sceneId, selfId) ~= GetCurCountry(sceneId, targetId)) then
		return x800006_FAILED_COUNTRY;		--国家不同不可结婚
	end
	
	local IsSelfMan = GetSex(sceneId, selfId);
	local ManId;
	local WomanId;
	if IsSelfMan then
		ManId = selfId;
		WomanId = targetId;
	else
		ManId = targetId;
		WomanId = selfId;
	end
	
	if GetSex(sceneId, selfId) == GetSex(sceneId, targetId) then
		return x800006_FAILED_GENDER;		--性别相同不可结婚
	end
	
	if LuaFnIsFriend(sceneId, selfId, targetId) ~=1 or LuaFnIsFriend(sceneId, targetId, selfId) ~=1 or LuaFnGetFriendPoint(sceneId, selfId, targetId) < x800006_g_FriendPointDemand	then
		return x800006_FAILED_FRIEND;
	end
	
	if LuaFnIsMarried(sceneId, selfId) == 1 then
		return x800006_FAILED_MARRIGE_SELF;
	end
	
	if LuaFnIsMarried(sceneId, targetId) == 1 then
		return x800006_FAILED_MARRIGE_TARGET;		--双方必需单身才可以结婚
	end
	
	if GetLevel(sceneId, ManId) < x800006_g_ManLevelDemand or GetLevel(sceneId, WomanId) < x800006_g_WomanLevelDemand then
		return x800006_FAILED_LEVEL;
	end
	
	if GetMoney(sceneId, ManId) < x800006_g_CostMoneyMarriage then
		return x800006_FAILED_MONEY;
	end

	if (GetItemIsEmpty(sceneId, selfId) == -1 or GetItemIsEmpty(sceneId, targetId) == -1 ) then
		return x8000006_FAILED_BAG;
	end
	
	--A是否有一个称号空间；B是否有一个称号空间。无需判断，因为配偶称号是保留的
	
	if IsInDist(sceneId, selfId,targetId, 10) ~= 1 then
		return x800006_FAILED_DISTANCE;		--双方距离大于10米不可以结婚
	end
	
	if LuaFnIsMaster(sceneId, selfId, targetId) == 1 or LuaFnIsMaster(sceneId, targetId, selfId) == 1 then
		return x800006_FAILED_MASTER;		--师徒不可结婚
	end
	
	if LuaFnIsBrother(sceneId, selfId, targetId) ==1 then
		return x800006_FAILED_BROTHER;		--结拜不可以结婚
	end
	
	return x800006_OK;

end

-------------------------
--***********************
--DoMarrige
--***********************
-------------------------

function x800006_DoMarrige(sceneId, selfId, NPCId)

	local ManId = 0;
	local WomanId = 0;

	local ret = x800006_SafeMarrigeCheck(sceneId, selfId, NPCId, 1);
	if ret ~= x800006_OK then
		return ret;
	end
	
	local targetId = LuaFnGetTeamSceneMember(sceneId, selfId, 0);
		
	--得到男女方
	if GetSex(sceneId, selfId) == 1 then
		ManId = selfId;
		WomanId = targetId;
	else
		ManId = targetId;
		WomanId = selfId;
	end
	
	--分别生成一个戒指给男女
	if TryRecieveItem(sceneId, ManId, x800006_g_RingId, 1) == -1 or TryRecieveItem(sceneId, WomanId, x800006_g_RingId, 1) == -1 then
		return x800006_FAILED_BAG;
	end
	
	--扣除男方身上金钱
	if LuaFnCostMoney(sceneId, ManId, x800006_g_CostMoneyMarriage) == -1 then
		return x800006_FAILED_MONEY;
	end
		
	--分别发消息给男女双方所有好友
	local MailText = format("我亲爱的朋友，我已和%s喜结良缘，祝福我们吧！", LuaFnGetName(sceneId, selfId));
	LuaFnSendMailToAllFriend(sceneId, selfId, MailText, targetId);
	LuaFnSendMailToAllFriend(sceneId, targetId, MailText, selfId);
	
	--为男方增加一个称号"某某的夫君"，为女方增加一个称号"某某的娘子"
	local Title = format("%s的夫君", GetName(sceneId, WomanId));
	LuaFnAwardSpouseTitle(sceneId, ManId, Title);
	Title = format("%s的娘子", GetName(sceneId,ManId));
	LuaFnAwardSpouseTitle(sceneId,WomanId,Title);
	
	--为夫妻双方增加一个夫妻技能,目前没有，暂不添加
	AddSkill(sceneId, selfId, x800006_SkillId);
	AddSkill(sceneId, targetId, x800006_SkillId);
		
	--在世界频道发布消息,还需统计服务器结婚对数，暂时没有此功能
	local Msg = format("[系统]恭喜%s与%s喜结连理！", GetName(sceneId, ManId), GetName(sceneId, WomanId));
	LuaFnMsg2Player(sceneId, selfId, Msg, x800006_CHAT_TYPE_SYSTEM);
	
	--在聊天窗口给男方提示,还应提示学会的技能
	Msg = format("恭喜你和%s结为夫妻！\n 得到结婚戒指一枚。\n 得到称号%s的夫君。\n", GetName(sceneId, WomanId), GetName(sceneId, WomanId));
	LuaFnMsg2Player(sceneId, ManId, Msg, x800006_CHAT_TYPE_NORMAL);

	--在聊天窗口给女方提示,还应提示学会的技能
	Msg = format("恭喜你和%s结为夫妻！\n 得到结婚戒指一枚。\n 得到称号%s的娘子。\n", GetName(sceneId, ManId), GetName(sceneId, ManId));
	LuaFnMsg2Player(sceneId, WomanId, Msg, x800006_CHAT_TYPE_NORMAL);
	
	--最后一步,双方结为夫妻
	LuaFnMarry(sceneId, selfId, targetId);
	
	return x800006_OK;

end

-------------------------
--***********************
--SafeMarrigeCheck
--***********************
-------------------------

function x800006_SafeMarrigeCheck(sceneId, selfId, NPCId, bDirect)

	local ret 	= x800006_IsCanMarrige(sceneId, selfId);
	local str 	= "已经结婚。";
	local targetId = LuaFnGetTeamSceneMember(sceneId, selfId, 0);
	
	if ret == x800006_OK then
		str = format("确定要结婚？\n男方需要支付%d金钱。", x800006_g_CostMoneyMarriage);
	
	elseif ret == x800006_FAILED_CAPTAIN then
		str = "只有队长才能申请结婚。";

	elseif ret == x800006_FAILED_TEAM then
		str = "如果想结为夫妻，请男女双方二人组成一队再来找我。";

	elseif ret == x800006_FAILED_COUNNTRY then
		str = "你们身负国仇，不能结婚。";
	
	elseif ret == x800006_FAILED_GENDER then
		str = "（只见月老的额头冒出豆大一滴汗珠）\n我真的很敬佩你们这种挑战传统的勇气，可是，可是。。。唉，在我们的时代，世俗是无法接受这种行为的，想当初我和我师兄。。。唉，不提也罢，不提也罢。";
	
	elseif ret == x800006_FAILED_FRIEND then
		str = format("双方必须为好友且对对方的友好度必须达到%d才能结为连理。", x800006_g_FriendPointDemand);
	
	elseif ret == x800006_FAILED_MARRIGE_SELF then
		str = "既然已经结婚了，就要对爱人一心一意，小心犯重婚罪。";
		local Msg = "对方既已成婚，你们不能结婚。";
		LuaFnMsg2Player(sceneId, targetId, Msg, x800006_CHAT_TYPE_NORMAL);
	
	elseif ret == x800006_FAILED_MARRIGE_TARGET then
		str = "你带来的人已经结婚了，你怎么能这样做呢？"
		local Msg = "你已成婚，你们不能结婚。";
		LuaFnMsg2Player(sceneId, targetId, Msg, x800006_CHAT_TYPE_NORMAL);
	
	elseif ret == x800006_FAILED_LEVEL then
		str = format("这么年轻就想结婚？男方需要达到%d级，女方需要达到%d级。", x800006_g_ManLevelDemand, x800006_g_WomanLevelDemand);
	
	elseif ret == x800006_FAILED_MONEY then
		str = format("结婚这等人生大事没有点积蓄是不行的，男方需要携带%d金钱才能结婚。", x800006_g_CostMoneyMarriage);
	
	elseif ret == x800006_FAILED_BAG then
		str = "你们二人的背包中分别至少有一个空位，用于存放结婚戒指。";
	
	elseif ret == x800006_FAILED_TITLE then
		str = "称号已满，无法结婚。";
	
	elseif ret == x800006_FAILED_DISTANCE then
		str = "只有二人都走到我身边才可以结婚。";
	
	elseif ret == x800006_FAILED_MASTER then
		str = "你们是师徒，怎么可以结婚呢？";
	
	elseif ret == x800006_FAILED_BROTHER then
		str = "你们现在是结拜关系，不能结婚。";
	
	end
	
	if ret == x800006_OK and bDirect == 1 then
		return ret;
	end
	
	BeginEvent(sceneId);
	
		AddText(sceneId, str);
	
	EndEvent();

	if ret == x800006_OK then
		DispatchMissionInfo(sceneId, selfId, NPCId, x800006_g_ScriptId);
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

function x800006_OnEnumerate(sceneId, selfId, targetId)
	AddNumText(sceneId, x800006_g_ScriptId, x800006_g_MissionName);
end

-------------------------
--***********************
--OnDefaultEvent
--***********************
-------------------------

function x800006_OnDefaultEvent(sceneId, selfId, targetId)

	x800006_SafeMarrigeCheck(sceneId, selfId, targetId, 0);

end

-------------------------
--***********************
--CheckAccept
--***********************
-------------------------

function x800006_CheckAccept(sceneId, selfId, targetId)

	return 1;

end

-------------------------
--***********************
--OnAccept
--***********************
-------------------------

function x800006_OnAccept(sceneId, selfId, targetId)

	local ret = x800006_DoMarrige(sceneId, selfId, targetId);
	
	if ret == x800006_OK then
		return
	end
	
	local str = "ERROR";
	
	if ret == x800006_FAILED_BAG then
		str = "添加戒指错误。";
	elseif ret == x800006_FAILED_MONEY then
		str = "扣除金钱错误。";
	end
	
	BeginEvent(sceneId);
	
		AddText(sceneId, str);
	
	EndEvent();

	DispatchEventList(sceneId, selfId, targetId);

end