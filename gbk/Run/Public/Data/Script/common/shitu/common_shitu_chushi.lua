-------------------------
--***********************
--Const
--***********************
-------------------------

x800010_g_ScriptId 			= 800010
x800010_g_MissionName		= "出师"
x800010_g_LevelMin			= 40
x800010_g_ItemId				= 10280001
x800010_g_MoralPoint		= 100
x800010_g_MoralPointUp	= 1000
x800010_g_LevelOver			= 45
x800010_g_FriendLess		= 300

-------------------------
--***********************
--Define
--***********************
-------------------------

x800010_CHAT_TYPE_NORMAL	= 0
x800010_CHAT_TYPE_SYSTEM	= 4

x800010_OK									= 0
x800010_ERROR_UNKNOWN				= -1
x800010_FAILED_TEAM					= 1
x800010_FAILED_LEVEL				= 2
x800010_FAILED_MASTER				= 3
x800010_FAILED_BAG_MASTER		= 4
x800010_FAILED_BAG_PRENTICE	= 5

-------------------------
--***********************
--IsCanChuShi
--***********************
-------------------------

function x800010_IsCanChuShi(sceneId, selfId)

	if (GetTeamSize(sceneId, selfId) ~= 2) then
		return x800010_FAILED_TEAM;
	end

	--得到徒弟的objID
	local targetId = LuaFnGetTeamSceneMember(sceneId, selfId, 0);
	
	if LuaFnIsMaster(sceneId, targetId, selfId) ~= 1 then
		return x800010_FAILED_MASTER;
	end
	
	if GetLevel(sceneId, targetId) < x800010_g_LevelMin then
		return x800010_FAILED_LEVEL;
	end
	
	--A和B的背包中分别至少有一个普通物品的空格
	if (GetItemIsEmpty(sceneId, selfId) == -1) then
		return x800010_FAILED_BAG_MASTER;
	end
		
	if (GetItemIsEmpty(sceneId, targetId) == -1) then
		return x800010_FAILED_BAG_PRENTICE;
	end
	
	return x800010_OK;

end

-------------------------
--***********************
--DoChuShi
--***********************
-------------------------

function x800010_DoChuShi(sceneId, selfId, NPCId)

	local ret = x800010_SafeChuShiCheck(sceneId, selfId, NPCId, 1);

	if ret ~= x800010_OK then
		return ret;
	end
	
	--得到徒弟objID
	local targetId = LuaFnGetTeamSceneMember(sceneId, selfId, 0);
	
	--给双方的背包中分别放入奖励道具
	if (TryRecieveItem(sceneId, selfId, x800010_g_ItemId, 1) == -1) then
		return x800010_FAILED_BAG_MASTER;
	end
	
	if (TryRecieveItem(sceneId, targetId, x800010_g_ItemId, 1) == -1) then
		return x800010_FAILED_BAG_PRENTICE;
	end
	
	LuaFnFinishAprentice(sceneId, targetId, selfId);	--取消师徒关系
	
	--得到师德点
	local point = LuaFnGetMasterMoralPoint(sceneId, selfId);
	
	--给师父增加师德点数
	point = point + x800010_g_MoralPoint;
	LuaFnSetMasterMoralPoint(sceneId, selfId, point);
	
	--给师父的提示信息
	local Msg = format(" 出师成功！\n 你得到出师糖豆一个。\n 得到师德点数%d。", x800010_g_MoralPoint);
	
	--如果累积师德点数达到一定数值,获得称号
	if point >= x800010_g_MoralPointUp then
		--获得称号，还没有完成
		--LuaFnAwardTitle(sceneId,selfId,0,0)
		Msg = format("%s\n 获得称号%s", Msg, "称号名");
	end

	LuaFnMsg2Player(sceneId, selfId, Msg, x800010_CHAT_TYPE_NORMAL);
	
	--LuaFnAwardTitle(sceneId, targetId, 0, 0);
	--给徒弟的提示信息
	Msg = format("出师成功！\n 你得到出师糖豆一个。\n 获得称号：%s之徒。", GetName(sceneId, selfId));
	LuaFnMsg2Player(sceneId, targetId, Msg, x800010_CHAT_TYPE_NORMAL);
	
	if GetLevel(sceneId, selfId) < x800010_g_LevelOver or LuaFnGetFriendPoint(sceneId, selfId, targetId) < x800010_g_FriendLess then
		--LuaFnFinishAprentice(sceneId, targetId, selfId);	--取消师徒关系
		--给师父的提示信息
		local Msg = format("出师成功！\n 由于友好度不到%d或者徒弟等级大于%d级，没有奖励。", x800010_g_FriendLess, x800010_g_LevelOver);
		LuaFnMsg2Player(sceneId, selfId, Msg, x800010_CHAT_TYPE_NORMAL);
		--给徒弟的提示信息
		LuaFnMsg2Player(sceneId, targetId, Msg, x800010_CHAT_TYPE_NORMAL);
	end	
	
	return x800010_OK;

end

-------------------------
--***********************
--SafeChuShiCheck
--***********************
-------------------------

function x800010_SafeChuShiCheck(sceneId, selfId, NPCId, bDirect)

	local ret 	= x800010_IsCanChuShi(sceneId, selfId);
	local str 	= "成功出师。";
	
	if ret == x800010_OK then
		str = "确定要出师？";
	
	elseif ret == x800010_FAILED_TEAM then
		str = "需要师徒二人组队来找我。";
	
	elseif ret == x800010_FAILED_LEVEL then
		str = format("徒弟等级达到%d级才能出师。", x800010_g_LevelMin);
	
	elseif ret == x800010_FAILED_MASTER then
		str = "你们不是师徒关系。";
	
	elseif ret == x800010_FAILED_BAG_MASTER then
		str = format("%s必须有一个背包空位。", selfId);
		
	elseif ret == x800010_FAILED_BAG_PRENTICE then
		local targetId = LuaFnGetTeamSceneMember(sceneId, selfId, 0);
		str = format("%s必须有一个背包空位。", targetId);
	
	end
	
	if ret == x800010_OK and bDirect == 1 then
		return ret;
	end
	
	BeginEvent(sceneId);
	
		AddText(sceneId, str);
	
	EndEvent();

	if ret == x800010_OK then
		DispatchMissionInfo(sceneId, selfId, NPCId, x800010_g_ScriptId);
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

function x800010_OnEnumerate(sceneId, selfId, targetId)
	AddNumText(sceneId, x800010_g_ScriptId, x800010_g_MissionName);
end

-------------------------
--***********************
--OnDefaultEvent
--***********************
-------------------------

function x800010_OnDefaultEvent(sceneId, selfId, targetId)

	x800010_SafeChuShiCheck(sceneId, selfId, targetId, 0);
	
end

-------------------------
--***********************
--CheckAccept
--***********************
-------------------------

function x800010_CheckAccept(sceneId, selfId, targetId)

	return 1;

end

-------------------------
--***********************
--OnAccept
--***********************
-------------------------

function x800010_OnAccept(sceneId, selfId, targetId)

	local ret = x800010_DoChuShi(sceneId, selfId, targetId);
		
	if ret == x800010_OK then
		return
	end

end