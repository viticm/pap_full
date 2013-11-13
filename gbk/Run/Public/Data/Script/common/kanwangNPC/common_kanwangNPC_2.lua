-------------------------
--***********************
--看望NPCv2.2
--v1.00
--ZesT
--***********************
-------------------------

--MisDescBegin
-------------------------
--Const
-------------------------
x300301_g_MissionId					= 403
x300301_g_ScriptId 					= 300301
x300301_g_MissionName				= "看望NPC"
x300301_g_MissionKind				= 23    --??
--x300301_g_Country						= 0			--??国家 0=；1=？……
--x300301_g_Round							= 10
x300301_g_LevelRate1					= 5
x300301_g_LevelRate2					= 2	--看望得到的经验比
x300301_g_LevelRate3					= 200
x300301_g_MissionLowerlimit	=	1			--等级下限（包括该等级）
x300301_g_MissionUpperlimit	=	100		--等级上限（包括该等级）

x300301_g_TestMassage				= "#Y!!任务列表更新了"

x300301_g_ErrorMessage_Country	= "你不是本国人！"
x300301_g_ErrorMessage_NPC			="快去找 %s 吧，他会告诉你更多信息!"
x300301_g_ErrorMessage_Round		="今天你已经完成该任务！\n明天再来~"
x300301_g_StringStart				="任务开始的描述。\n快去找 首饰店老板 吧，他会告诉你更多的!!!"
x300301_g_MissionStrings		=	{
															{hash=2, MisStr="（故事1）曾经有一段（以下描述略过）…………\n"},
--															{hash=3, MisStr="曾经2…………\n"},
--															{hash=4, MisStr="曾经3…………\n"}
															}
x300301_g_StringEnd					="任务完成的描述。"
x300301_g_StringContinue		="想了解更多信息！去找 %s 吧"
x300301_g_EachMissionNPCNumber = 2 --任务所需对话的NPC数，不包括起始的NPC
x300301_g_MissionNPCName		=	{
															{hash=1, scene = 11, usage = "MissionStartNPC",name = "武器店老板", scenename = "新月汗国"},
															{hash=2, scene = 11, usage = "MissionNPC",name = "首饰店老板", scenename = "新月汗国"},
															{hash=3, scene = 11, usage = "MissionEndNPC",name = "中心传送使者", scenename = "新月汗国"}
															}
-------------------------
--Define
-------------------------
x300301_MISSION_FAILEDCOUNTRY			=	1
x300301_MISSION_FAILEDROUND				=	2
--别的失败条件
x300301_MISSION_ACCEPTREADY				=	8

x300301_NPC_START						= 20
x300301_NPC_AIM							= 21
x300301_NPC_FAILED					= 22

x300301_ERROR_UNKNOWN				= -1


x300301_MP_AIMNPC						= 0
--MisDescEnd

-------------------------
--SafeCheck
--进行任务或是NPC的判断，返回Define中相应的值
-------------------------
function x300301_SafeCheck(sceneId, selfId, NPCId)
	local bHaveMission = IsHaveMission(sceneId, selfId, x300301_g_MissionId);
	if bHaveMission <= 0 then
		--检测国家
		if x300301_CheckCountry(sceneId,selfId,x300301_g_MissionId,NPCId) == 0 then
			return x300301_MISSION_FAILEDCOUNTRY;
		end
		--检测次数
		if x300301_CheckRound(sceneId, selfId, x300301_g_MissionId, NPCId) < 0 then
			return x300301_MISSION_FAILEDROUND;
		end
		--任务可接
		return x300301_MISSION_ACCEPTREADY;
	end
	--任务已接
	if x300301_IsStartNPC(sceneId, selfId, x300301_g_MissionId, NPCId) > 0 then
		return x300301_NPC_START;
	end
	
	if x300301_IsAimNPC(sceneId, selfId, x300301_g_MissionId, NPCId) > 0 then
		return x300301_NPC_AIM;
	end
	
	if x300301_IsMissionNPC(sceneId, selfId, x300301_g_MissionId, NPCId) > 0 then	
		return x300301_NPC_FAILED;
	end
	
	return x300301_ERROR_UNKNOWN;
end

-------------------------
--OnEnumerate
-------------------------
function x300301_OnEnumerate(sceneId, selfId, NPCId)

	local CheckRet = x300301_SafeCheck(sceneId, selfId, NPCId);
	if CheckRet >= 0 and CheckRet <= 10 then
		if x300301_IsStartNPC(sceneId,selfId,x300301_g_MissionId,NPCId) == 1 then
			AddNumText(sceneId, x300301_g_ScriptId, x300301_g_MissionName);
		end
	elseif CheckRet >= 20 then
		AddNumText(sceneId, x300301_g_ScriptId, x300301_g_MissionName);
	elseif CheckRet< 0 then
		return
	end
end

-------------------------
--OnDefaultEvent
-------------------------
function x300301_OnDefaultEvent(sceneId, selfId, NPCId)

	local CheckRet = x300301_SafeCheck(sceneId, selfId, NPCId);
	local daycount = GetMissionData(sceneId, selfId, MD_KANWANGNPC_DAYCOUNT);
	local nowtime = LuaFnGetCurrentTime();	
	local today = floor(nowtime / 86400);
	local bHaveMission = IsHaveMission(sceneId, selfId, x300301_g_MissionId);
	local misIndex = GetMissionIndexByID(sceneId, selfId, x300301_g_MissionId);
	local aimNPCHash = GetMissionParam(sceneId, selfId, misIndex, x300301_MP_AIMNPC);
	local str = "#Y"..x300301_g_MissionName.."\n";
	
	if (CheckRet == x300301_MISSION_FAILEDCOUNTRY) then
		BeginEvent(sceneId);
			AddText(sceneId, x300301_g_ErrorMessage_Country);
		EndEvent();
		DispatchEventList(sceneId,selfId,NPCId,x300301_g_ScriptId,x300301_g_MissionId)
	elseif (CheckRet == x300301_MISSION_FAILEDROUND) then
		BeginEvent(sceneId);
			AddText(sceneId, x800200_g_ErrorMessage_Round);
		EndEvent();
		DispatchEventList(sceneId,selfId,NPCId,x300301_g_ScriptId,x300301_g_MissionId)
	elseif (CheckRet == x300301_MISSION_ACCEPTREADY) then
	--!!
	--!!
		if(daycount ~= today)then
			BeginEvent(sceneId);
				AddText(sceneId, x300301_g_StringStart);
			EndEvent();
			DispatchMissionInfo(sceneId,selfId,NPCId,x300301_g_ScriptId,x300301_g_MissionId)
		else
			BeginEvent(sceneId);
				AddText(sceneId, x300301_g_ErrorMessage_Round);
			EndEvent();
			DispatchEventList(sceneId,selfId,NPCId,x300301_g_ScriptId,x300301_g_MissionId)
		end
	elseif (CheckRet == x300301_NPC_START) or (CheckRet == x300301_NPC_FAILED) then
		BeginEvent(sceneId);
			local ShowErrorMessage = str..format(x300301_g_ErrorMessage_NPC,x300301_GetNameByHash(sceneId,selfId,aimNPCHash))
			AddText(sceneId, ShowErrorMessage);
		EndEvent();
		DispatchEventList(sceneId,selfId,NPCId,x300301_g_ScriptId,x300301_g_MissionId)
	elseif (CheckRet == x300301_NPC_AIM) then
		if x300301_IsEndNPC(sceneId,selfId,x300301_g_MissionId,NPCId) == 1 then
			BeginEvent(sceneId);
				AddText(sceneId,x300301_g_StringEnd);
			EndEvent();
			DispatchMissionContinueInfo(sceneId,selfId,NPCId,x300301_g_ScriptId,x300301_g_MissionId)
		else
			BeginEvent(sceneId);
				local ShowContinueMessage = x300301_GetContinueMessage(sceneId, selfId, NPCId)--确定不同的继续信息
				AddText(sceneId, ShowContinueMessage);
			EndEvent();
			DispatchEventList(sceneId,selfId,NPCId,x300301_g_ScriptId,x300301_g_MissionId)
			SetMissionByIndex(sceneId, selfId, misIndex, x300301_MP_AIMNPC,aimNPCHash+1);
			BeginEvent(sceneId)
			  local strText = "#Y你的任务  "..x300301_g_MissionName.."更新了!!"
			  AddText(sceneId,strText);
			EndEvent()
			DispatchMissionTips(sceneId,selfId)
		end
	elseif (CheckRet == x300301_ERROR_UNKNOWN) then
		return
	end	
end


-------------------------
--OnAccept
-------------------------
function x300301_OnAccept(sceneId,selfId,NPCId)

	Msg2Player(  sceneId, selfId, x800200_g_TestMassage, MSG2PLAYER_PARA )

	local DoKill,DoArea,DoItem=0,0,0;
	
	AddMission( sceneId,selfId, x300301_g_MissionId, x300301_g_ScriptId, DoKill, DoArea, DoItem )		--添加任务
	SetMissionData(sceneId,selfId,MD_KANWANGNPC_DAYCOUNT,floor(LuaFnGetCurrentTime()/86400))
--**圈数的记录
	local misIndex = GetMissionIndexByID(sceneId, selfId, x300301_g_MissionId);
	SetMissionByIndex(sceneId, selfId, misIndex, x300301_MP_AIMNPC,2);--没法传NPCId！！！ x300301_GetHashByName(sceneId, selfId, NPCId)+1);
	
	BeginEvent(sceneId)
	 	strText = "你接受了任务  "..x300301_g_MissionName
	 	AddText(sceneId,strText);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end


-------------------------
--CheckAccept
-------------------------
function x300301_CheckAccept( sceneId, selfId ,NPCId )

	if x300301_IsMissionNPC(sceneId,selfId,x300301_g_MissionId,NPCId) == 1 then
		return 1
	end
	return 0
end


-------------------------
--OnAbandon
-------------------------
function x300301_OnAbandon( sceneId, selfId )

	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x300301_g_MissionId )
  BeginEvent(sceneId)
	  local strText = "你放弃了任务  "..x300301_g_MissionName
	  AddText(sceneId,strText);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end


-------------------------
--OnSubmit
-------------------------
function x300301_OnSubmit( sceneId, selfId, NPCId,selectRadioId )

	local ExpBonus = x300301_GetExpBonus(sceneId,selfId,NPCId)
	AddExp(sceneId,selfId,ExpBonus)
	Msg2Player(sceneId,selfId,"你获得了"..ExpBonus.."的经验",MSG2PLAYER_PARA)
	DelMission( sceneId, selfId, x300301_g_MissionId )
	--**奖励
  BeginEvent(sceneId)
	  local strText = "#Y你完成了任务  "..x300301_g_MissionName
	  AddText(sceneId,strText);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
-------------------------
--CheckSubmit
-------------------------
function x300301_CheckSubmit(sceneId,selfId, NPCId)

	if(x300301_IsMissionNPC(sceneId, selfId, NPCId) > 0)then
		return 1;
	end
	return 0;
end


-------------------------
--**CheckCountry
--与NPC相同返回1，不同返回0；
-------------------------
function x300301_CheckCountry(sceneId, selfId, x300301_g_MissionId, NPCId)
	return 1;
end
-------------------------
--**CheckRound
--检测今天完成的圈数，大于等于最大圈数返回-1，根据完成圈数返回（0-N）
-------------------------
function x300301_CheckRound(sceneId, selfId, x300301_g_MissionId, NPCId)
	return 0;
end
-------------------------
--IsStartNPC
--是否开始NPC
-------------------------
function x300301_IsStartNPC(sceneId, selfId, x300301_g_MissionId, NPCId)
	local NPCName = GetName(sceneId,NPCId)
	for i,item in pairs(x300301_g_MissionNPCName) do
		if ((item.scene == sceneId) and (item.name == NPCName)) then
			if (x300301_residue(item.hash,x300301_g_EachMissionNPCNumber+1) == 1) then
				return 1;
			end
		end
	end
	return 0;
end
-------------------------
--IsEndNPC
--是否最后NPC
-------------------------
function x300301_IsEndNPC(sceneId, selfId, x300301_g_MissionId, NPCId)
	for i,item in pairs(x300301_g_MissionNPCName) do
		if ((item.scene == sceneId) and (item.name == GetName(sceneId,NPCId))) then
			if (x300301_residue(item.hash, x300301_g_EachMissionNPCNumber+1) == 0) then
				return 1;
			end
		end
	end
	return 0;
end
-------------------------
--IsAimNPC
--判断是否当前目标NPC
-------------------------
function x300301_IsAimNPC(sceneId, selfId, x300301_g_MissionId, NPCId)
	local misIndex = GetMissionIndexByID(sceneId, selfId, x300301_g_MissionId);
	local aimNPCHash = GetMissionParam(sceneId, selfId, misIndex, x300301_MP_AIMNPC);
	for i,item in pairs(x300301_g_MissionNPCName) do
		if ((item.scene == sceneId) and (item.hash == aimNPCHash)) then
			if (GetName(sceneId,NPCId) == item.name) then
				return 1;
			end
		end
	end
	return 0;
end

-------------------------
--IsMissionNPC
--任务中出现的所有NPC
-------------------------
function x300301_IsMissionNPC(sceneId, selfId, x300301_g_MissionId, NPCId)
	local NPCName = GetName(sceneId,NPCId)
	for i,item in pairs(x300301_g_MissionNPCName) do
		if ((item.scene == sceneId) and (item.name == NPCName)) then
			return item.hash;
		end
	end
	return 0;
end


---------------------------
--GetContinueMessage
---------------------------
function x300301_GetContinueMessage(sceneId, selfId, NPCId)
	local misIndex = GetMissionIndexByID(sceneId, selfId, x300301_g_MissionId);
	local aimNPCHash = GetMissionParam(sceneId, selfId, misIndex, x300301_MP_AIMNPC);
	local TextString = "（任务描述）";
	for i,item in pairs(x300301_g_MissionStrings) do
		if(item.hash == aimNPCHash) then
			TextString = item.MisStr ..format(x300301_g_StringContinue,x300301_GetNameByHash(sceneId,selfId,aimNPCHash+1));
			return TextString;
		end
	end
	return TextString;
end

---------------------------
--GetMaxHash
---------------------------
function x300301_GetMaxHash(sceneId, selfId)
	local n=0
	for i,item in pairs(x300301_g_MissionNPCName) do
		n=n+1;
	end
	return n;
end
---------------------------
--GetHashByNPCId
---------------------------
function x300301_GetHashByName(sceneId, selfId, NPCId)
	local n = 0;
	local NPCName = GetName(sceneId,selfId,NPCId);
	for i,item in pairs(x300301_g_MissionNPCName) do
		if (item.sceneId == sceneId) and (item.name == NPCName) then
			n=i;
		end	
	end
	return n;
end
---------------------------
--GetExpBonus
--EXP奖励公式
---------------------------
function x300301_GetExpBonus(sceneId,selfId,NPCName)
	local ExpBonus = (GetLevel(sceneId,selfId) + x300301_g_LevelRate1) * x300301_g_LevelRate2 * x300301_g_LevelRate3
	return ExpBonus;
end
-----------------------------
--GetNameByHash
-----------------------------
function x300301_GetNameByHash(sceneId,selfId,NPCHash)
	for i ,item in pairs(x300301_g_MissionNPCName) do
		if (item.hash == NPCHash) then
			return item.name;
		end
	end
	return "ERROR"
end
----------------------------
--x300301_residue
----------------------------
function x300301_residue(a,b)
	return a-b*floor(a/b)
end