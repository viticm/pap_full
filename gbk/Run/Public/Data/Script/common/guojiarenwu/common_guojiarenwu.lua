-------------------------
--***********************
--国家任务
--v0.9
--ZesT
--***********************
-------------------------
MD_GUOJIARENWU_DATE								=	10
MD_GUOJIARENWU_ROUND							=	11
MD_GUOJIARENWU_CIRCLE							=	12
MD_GUOJIARENWU_UNACCEPT						=	13
MD_GUOJIARENWU_LASTABANDON				=	14

--MisDescBegin
--Const
x300303_g_ScriptId 					= 300303
x300303_g_MissionId					= 405
x300303_g_MissionName				= "国家任务"
x300303_g_MissionKind				= 23
x300303_g_MissionLevel 			= 10

x300303_g_Country						=	0

x300303_g_LevelLowerlimit	=	1			--等级下限（包括该等级）
x300303_g_LevelUpperlimit	=	100		--等级上限（包括该等级）
x300303_g_MaxRound				= 20
x300303_g_MaxCircle				= 10
--文字描述
x300303_g_ErrorMessage_Country	= "你不是本国人！"--对话不会出现
x300303_g_ErrorMessage_Level		="国家需要你，不过现在你还不够强大。\n等你到10级再来找我吧。"
x300303_g_ErrorMessage_Abandon	="你刚刚放弃了该任务，过了15分钟再来找我吧"
x300303_g_ErrorMessage_Round		="........."
x300303_g_StringStart				="任务开始的描述。"
x300303_g_StringEnd					="任务完成的描述。"
x300303_g_StartNPC					="防具店老板"
x300303_g_Mission_Songxin					=	{ --增加送信的任务，要同时在该NPC上绑上这个脚本，注册物品信件！！
																		{hash = 1, missionName = "送信1", levelsection = 2, missionKind = "songxin", NPC_Name = "药店老板", NPC_ID = 115, item_ID = 13010077, item_Name = "交给药店老板的信", CoordinatesX=125,CoordinatesY=230, scene_Name = "新月汗国", scene_ID = 11, symbol = "中心广场东北角",
																			Start = "把这封信送到新月汗国中心广场东北角附近的药店老板(125,230)手上1_1", continue = "快去找药店老板\n他在新月汗国中心广场东北角附近", endstr = "谢谢你！\n这些钱就当时谢礼，请您务必要收下", continueX = "哦，XX的信，能够知道他的平安真的太好了……，麻烦你回去转告他我已经收到信了", endstrX = "谢谢你给我送来的信XXX"},
																		{hash = 2, missionName = "送信2", levelsection = 3, missionKind = "songxin", NPC_Name = "中心传送使者", NPC_ID = 113, item_ID = 13010078, item_Name = "交给中心传送使者的信", CoordinatesX=134,CoordinatesY=229, scene_Name = "新月汗国", scene_ID = 11, symbol = "中心广场东北角",
																		 	Start = "把这封信送到新月汗国中心广场东北角附近的中心传送使者(134,229)手上1_2", continue = "快去找中心传送使者\n他在新月汗国中心广场东北角附近", endstr = "谢谢你！\n这些钱就当时谢礼，请您务必要收下", continueX = "哦，XX的信，能够知道他的平安真的太好了……，麻烦你回去转告他我已经收到信了", endstrX = "谢谢你给我送来的信XXX"},
																		{hash = 3, missionName = "送信3", levelsection = 1, missionKind = "songxin", NPC_Name = "中心治疗师", NPC_ID = 114, item_ID = 13010079, item_Name = "交给中心治疗师的信", CoordinatesX=134,CoordinatesY=239, scene_Name = "新月汗国", scene_ID = 11, symbol = "中心广场东北角",
																			Start = "把这封信送到新月汗国中心广场东北角附近的中心治疗师(134,239)手上1_3", continue = "快去找中心治疗师\n他在新月汗国中心广场东北角附近", endstr = "谢谢你！\n这些钱就当时谢礼，请您务必要收下", continueX = "哦，XX的信，能够知道他的平安真的太好了……，麻烦你回去转告他我已经收到信了", endstrX = "谢谢你给我送来的信XXX"}
																		}
x300303_g_Mission_teshushaguai		=	{--未完成！！
																		{hash = 4, missionName = "特殊杀怪1", levelsection = 1, missionKind = "teshushaguai", moster_Name = "1234", monster_ID = 1234, CoordinatesX=125,CoordinatesY=230, scene_Name = "新月汗国", scene_ID = 11, symbol = "中心广场东北角",
																			Start = "怪物xxx在xxxx肆虐，快快前去消灭", continue = "", endstr = "谢谢你为民除害！这是你应得的"}
																		}
x300303_g_Mission_xunwu						=	{--直接按格式加任务！随便加
																		{hash = 5, missionName = "寻物1", levelsection = 1, missionKind = "xunwu", NPC_Name = "药店老板", item_ID = 11990002, item_Name = "可乐鸡翅秘方", item_Num = 3,  CoordinatesX=125,CoordinatesY=230, scene_Name = "新月汗国", scene_ID = 11, symbol = "中心广场东北角",
																			Start = "我要3份‘可乐鸡翅秘方’，\n在新月汗国中心广场东北角附近的药店老板(125,230)那里可以买到。", continue = "我要的东西呢，\n快去新月汗国中心广场东北角附近的药店老板(125,230)处买吧！！", endstr = "这下有的吃了- -||"}
																		}
x300303_g_Mission_gaojixunwu			=	{--同寻物
																		{hash = 6, missionName = "高级寻物1", levelsection = 5, missionKind = "gaojixunwu", item_ID = 12020001, item_Name = "麒麟1级蓝药", item_Num = 24, profession = "剑客", skill = "制毒",
																			Start = "这边老鼠真多，我需要XX,XX职业XX技能应该可以制作出来（毒药找ID不到，以后再换，先用24瓶麒麟1级蓝药代替）", continue = "带来我所需要的XXX了没，等你有了再来找我，\nXX职业XX技能应该可以制作出来", endstr = "这下那些该死的老鼠玩完了"},
																		{hash = 9, missionName = "高级寻物2", levelsection = 4, missionKind = "gaojixunwu", item_ID = 12020002, item_Name = "麒麟2级蓝药", item_Num = 10, profession = "剑客", skill = "制毒",
																			Start = "这边老鼠真多，我需要XX,XX职业XX技能应该可以制作出来（毒药找ID不到，以后再换，先用10瓶麒麟2级蓝药代替）", continue = "带来我所需要的XXX了没，等你有了再来找我，\nXX职业XX技能应该可以制作出来", endstr = "这下那些该死的老鼠玩完了"}
																		}
x300303_g_Mission_dingdianshiyongwupin	=	{--注意同时注册使用的物品，添加物品的脚本，
																					{hash = 7, missionName = "定点使用物品1", levelsection = 1, missionKind = "dingdianshiyongwupin", item_Name = "任务烟花", item_ID = 13010076, item_Num = 1, CoordinatesX=105, CoordinatesY=257, CoordinatesR=10, scene_Name = "新月汗国", scene_ID = 11, symbol = "中心广场中间",
																						Start = "我在做一个实验“……省略若干字”，把这个东西在中心广场打开！！1_1", continue = "快去，\n只能在中心广场打开，别的地方可能要着火", endstr = "做得好！看来我的研究还是很成功得！这是你应得的"}
																					}
x300303_g_Mission_shoujishengzhangdian	=	{--生长点，生长点脚本，注册脚本号，生长点中物品的注册，在server地图中修改生长点及生长点控制（没有控制的要在同目录的SCN文件中注册！）
																					{hash = 8, missionName = "收集生长点1", levelsection = 1, missionKind = "shoujishengzhangdian", item_ID = 13010080, item_Name = "易拉罐", item_Num = 10, CoordinatesX=125,CoordinatesY=230, scene_Name = "新月汗国", scene_ID = 11, symbol = "中心广场东北角",
																						Start = "到处都是垃圾，\n啊，一个要勤快的人类，这正是我要的\n如果你能帮我去广场上收集10个易拉罐，我会给你奖励的1_1", continue = "帮我收集10个易拉罐，在广场上应该能找到", endstr = "做得好！！这是给你的奖励"}
																					}
x300303_g_Mission									=	{
																		{hash = 1, missionName = "送信1", levelsection = 2, missionKind = "songxin"},
																		{hash = 2, missionName = "送信2", levelsection = 3, missionKind = "songxin"},
																		{hash = 3, missionName = "送信3", levelsection = 1, missionKind = "songxin"},
--																		{hash = 4, missionName = "特殊杀怪1", levelsection = 1, missionKind = "teshushaguai"},
																		{hash = 5, missionName = "寻物1", levelsection = 1, missionKind = "xunwu"},
																		{hash = 6, missionName = "高级寻物1", levelsection = 5, missionKind = "gaojixunwu"},
																		{hash = 7, missionName = "定点使用物品1", levelsection = 1, missionKind = "dingdianshiyongwupin"},
																		{hash = 8, missionName = "收集生长点1", levelsection = 1, missionKind = "shoujishengzhangdian"},
																		{hash = 9, missionName = "高级寻物2", levelsection = 4, missionKind = "gaojixunwu"},
																		}
--Define
x300303_MISSION_FAILEDCOUNTRY			=	1
x300303_MISSION_FAILEDROUND				=	2

x300303_MISSION_ACCEPTREADY				=	8

x300303_NPC_START						= 20
x300303_NPC_AIM							= 21
x300303_NPC_FAILED					= 22

x300303_ERROR_UNKNOWN				= -1

x300303_MP_MISSIONHASH			=0
x300303_MP_SONGXIN					=1
x300303_MP_DINGDIANSHIYONGWUPIN =2
x300303_MP_TESHUSHAGUAI			=3
x300303_MP_SHOUJISHENGZHANGDIAN =4
--MisDescEnd

-------------------------
--ConditionCheck
-------------------------
function x300303_ConditionCheck(sceneId, selfId, NPCId)
	return 1;
end
-------------------------
--x300303_IsMissionComplete
--这个做好就OK了,把所有的都交给这个函数好了- -||
--作用：OnDefautEvet的时候作判断
--有missionHash,所以可以从表中得到完整的任务信息
--根据获得的任务类型进行判断！！
-------------------------
function x300303_IsMissionComplete(sceneId, selfId, NPCId, missionHash)
	local missionKind = x300303_GetMissionKind(sceneId, selfId,missionHash)
	local misIndex = GetMissionIndexByID(sceneId, selfId, x300303_g_MissionId)
	if missionKind == "teshushaguai" then
		return 1;
	elseif missionKind == "songxin" then
		local songxinFlag = GetMissionParam(sceneId, selfId, misIndex, x300303_MP_SONGXIN)
		if songxinFlag == 1 then
			return 1
		else
			return 0
		end
	elseif missionKind == "xunwu" then
		local xunwuItemNum = x300303_GetXunwuItemNum(sceneId, selfId, NPCId, missionHash)
		local xunwuItemID = x300303_GetXunwuItemID(sceneId, selfId, NPCId, missionHash)
		if GetItemCount(sceneId, selfId, xunwuItemID) >= xunwuItemNum then
			return 1
		else
			return 0
		end
	elseif missionKind == "gaojixunwu" then
		local gaojiItemNum = x300303_GetGaojiItemNum(sceneId, selfId, NPCId, missionHash)
		local gaojiItemID = x300303_GetGaojiItemID(sceneId, selfId, NPCId, missionHash)
		if GetItemCount(sceneId, selfId, gaojiItemID) >= gaojiItemNum then
			return 1
		else
			return 0
		end
	elseif missionKind == "dingdianshiyongwupin" then
		local dingdianFlag = GetMissionParam(sceneId, selfId, misIndex, x300303_MP_DINGDIANSHIYONGWUPIN)
		if dingdianFlag == 1 then
			return 1
		else
			return 0
		end
	elseif missionKind == "shoujishengzhangdian" then
		local ShoujiItemNum = x300303_GetShoujiItemNum(sceneId, selfId, NPCId, missionHash)
		local ShoujiItemID = x300303_GetShoujiItemID(sceneId, selfId, NPCId, missionHash)
		if GetItemCount(sceneId, selfId, ShoujiItemID) >= ShoujiItemNum then
			return 1
		else
			return 0
		end
	else
		return 0
	end
end
-------------------------
--OnEnumerate
-------------------------
function x300303_OnEnumerate(sceneId, selfId, NPCId)
	if (x300303_CheckCountry(sceneId,selfId,NPCId) == 1) then
		local NPCName = GetName(sceneId, NPCId)
		local bHaveMission = IsHaveMission(sceneId, selfId, x300303_g_MissionId)
		if NPCName == x300303_g_StartNPC then
			AddNumText(sceneId, x300303_g_ScriptId, x300303_g_MissionName)
		elseif bHaveMission > 0 then
			local misIndex = GetMissionIndexByID(sceneId, selfId, x300303_g_MissionId)
			local missionHash = GetMissionParam(sceneId, selfId, misIndex, x300303_MP_MISSIONHASH)
			local missionKind = x300303_GetMissionKind(sceneId, selfId,missionHash)
			if missionKind == "songxin" then
				local NPCNameRat = x300303_GetMissionNPCName(sceneId, selfId, NPCId, missionHash)
				if NPCNameRat == NPCName then
					AddNumText(sceneId, x300303_g_ScriptId, x300303_g_MissionName)
				end 
			end
		end
	end
end
-------------------------
--OnDefaultEvent
-------------------------
function x300303_OnDefaultEvent(sceneId, selfId, NPCId)
	x300303_ClearData(sceneId, selfId, NPCId)
	local haveMission = IsHaveMission(sceneId, selfId, x300303_g_MissionId)
	local playerLevelSection = x300303_GetPlayerLevelSec(sceneId, selfId, NPCId)
	local AbandonRat = LuaFnGetCurrentTime() - GetMissionData(sceneId, selfId, MD_GUOJIARENWU_LASTABANDON)
	local unacceptedMissionHash = x300303_GetUnAcceptedMission(sceneId, selfId, NPCId)
	if playerLevelSection < 1 then
		BeginEvent(sceneId);
			AddText(sceneId, x300303_g_ErrorMessage_Level);
		EndEvent();
		DispatchEventList(sceneId,selfId,NPCId,x300303_g_ScriptId,x300303_g_MissionId)
	elseif AbandonRat < 900 then
		BeginEvent(sceneId);
			AddText(sceneId, x300303_g_ErrorMessage_Abandon);
		EndEvent();
		DispatchEventList(sceneId,selfId,NPCId,x300303_g_ScriptId,x300303_g_MissionId)
	elseif haveMission <= 0 then
		if unacceptedMissionHash <= 0 then
			x300303_SetUnAcceptedMission(sceneId, selfId, NPCId, playerLevelSection)--没有保存的任务，增加任务！
		end
		local str = x300303_GetStartByHash(sceneId, selfId, NPCId, x300303_GetUnAcceptedMission(sceneId, selfId, NPCId))--由于原来没有保存的变化了，重新Get一下。
		BeginEvent(sceneId);
			AddText(sceneId, str);
		EndEvent();
		DispatchMissionInfo(sceneId,selfId,NPCId,x300303_g_ScriptId,x300303_g_MissionId)
	else
		local missionIndex = GetMissionIndexByID(sceneId, selfId, x300303_g_MissionId)
		local missionHash = GetMissionParam(sceneId, selfId, missionIndex, x300303_MP_MISSIONHASH)
		local missionKind = x300303_GetMissionKind(sceneId, selfId,missionHash)
		if missionKind ~= "songxin" then
			if x300303_IsMissionComplete(sceneId, selfId, NPCId, missionHash) <= 0 then
				local str1 = x300303_GetContinueByHash(sceneId, selfId, NPCId, missionHash)
				BeginEvent(sceneId);
					AddText(sceneId, str1);
				EndEvent();
				DispatchEventList(sceneId,selfId,NPCId,x300303_g_ScriptId,x300303_g_MissionId)
			else
			local str2 = x300303_GetEndByHash(sceneId, selfId, NPCId, missionHash)
				BeginEvent(sceneId);
					AddText(sceneId, str2);
				EndEvent();
				DispatchMissionContinueInfo(sceneId,selfId,NPCId,x300303_g_ScriptId,x300303_g_MissionId)
			end
		else
			local NPCNameRat = x300303_GetMissionNPCName(sceneId, selfId, NPCId, missionHash)
			if (NPCNameRat == GetName(sceneId, NPCId)) then
				if x300303_IsMissionComplete(sceneId, selfId, NPCId, missionHash) <= 0 then
					local str1 = x300303_GetContinueXByHash(sceneId, selfId, NPCId, missionHash)
					DelItem(sceneId, selfId, x300303_GetSongxinItemID(sceneId, selfId, NPCId, missionHash), 1)
					BeginEvent(sceneId)
					  local strText = "你失去了物品  "..x300303_GetSongxinItemName(sceneId, selfId, NPCId, missionHash)
					  AddText(sceneId, strText);
					EndEvent(sceneId)
					DispatchMissionTips(sceneId, selfId)
						local misIndex = GetMissionIndexByID(sceneId, selfId, x300303_g_MissionId)
						SetMissionByIndex(sceneId, selfId, misIndex, x300303_MP_SONGXIN, 1)
					BeginEvent(sceneId);
						AddText(sceneId, str1);
					EndEvent();
					DispatchEventList(sceneId,selfId,NPCId,x300303_g_ScriptId,x300303_g_MissionId)
				else
					local str2 = x300303_GetEndXByHash(sceneId, selfId, NPCId, missionHash)
					BeginEvent(sceneId);
						AddText(sceneId, str2);
					EndEvent();
					DispatchEventList(sceneId,selfId,NPCId,x300303_g_ScriptId,x300303_g_MissionId)
				end	
			else
				if x300303_IsMissionComplete(sceneId, selfId, NPCId, missionHash) <= 0 then
					local str3 = x300303_GetContinueByHash(sceneId, selfId, NPCId, missionHash)
					BeginEvent(sceneId);
						AddText(sceneId, str3);
					EndEvent();
					DispatchEventList(sceneId,selfId,NPCId,x300303_g_ScriptId,x300303_g_MissionId)
				else
					local str4 = x300303_GetEndByHash(sceneId, selfId, NPCId, missionHash)
					BeginEvent(sceneId);
						AddText(sceneId, str4);
					EndEvent();
					DispatchMissionContinueInfo(sceneId,selfId,NPCId,x300303_g_ScriptId,x300303_g_MissionId)
				end			
			end
		end
	end	
end
-------------------------
--OnAbandon
-------------------------
function x300303_OnAbandon( sceneId, selfId)
	SetMissionData(sceneId, selfId, MD_GUOJIARENWU_UNACCEPT, 0)--任务记录清除
	SetMissionData(sceneId, selfId, MD_GUOJIARENWU_CIRCLE, 0)--处罚：任务环计数清除
	local misIndex = GetMissionIndexByID(sceneId, selfId, x300303_g_MissionId)
	local missionHash = GetMissionParam(sceneId, selfId, misIndex, x300303_MP_MISSIONHASH)
	local missionKind = x300303_GetMissionKind(sceneId, selfId,missionHash)
	if missionKind == "songxin" then
		DelItem(sceneId, selfId, x300303_GetSongxinItemID(sceneId, selfId, NPCId, missionHash), 1)
  elseif missionKind == "dingdianshiyongwupin" then
		DelItem(sceneId, selfId, x300303_GetDingdianItemID(sceneId, selfId, NPCId, missionHash), x300303_GetDingdianItemNum(sceneId, selfId, NPCId, missionHash) )
  end
  DelMission( sceneId, selfId, x300303_g_MissionId)--删除任务
  SetMissionData(sceneId, selfId, MD_GUOJIARENWU_LASTABANDON, LuaFnGetCurrentTime())
  BeginEvent(sceneId)
	  local strText = "你放弃了任务  "..x300303_g_MissionName
	  AddText(sceneId, strText);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId, selfId)
end
-------------------------
--CheckAccept
-------------------------
function x300303_CheckAccept( sceneId, selfId, NPCId)
	--应该判断任务栏是否满了
	return 1;
end
-------------------------
--OnAccept
-------------------------
function x300303_OnAccept(sceneId, selfId)
	local UnAccept = GetMissionData(sceneId, selfId, MD_GUOJIARENWU_UNACCEPT)
	local missionKind = x300303_GetMissionKind(sceneId, selfId,UnAccept)
	local DoKill,DoArea,DoItem=0,0,0;--参数的用处？？	
	if missionKind == "dingdianshiyongwupin" then
		BeginAddItem(sceneId)
			AddItem( sceneId, x300303_GetDingdianItemID(sceneId, selfId, NPCId, UnAccept), x300303_GetDingdianItemNum(sceneId, selfId, NPCId, UnAccept) )             
		ret = EndAddItem(sceneId,selfId)
	  if ret > 0 then
			AddItemListToHuman(sceneId,selfId)
	  else
		  BeginEvent(sceneId)
			  AddText(sceneId,"物品栏已满，请整理下再来！")
			  EndEvent(sceneId)
		  DispatchMissionTips(sceneId,selfId)
			return
		end
	elseif missionKind == "songxin" then
		BeginAddItem(sceneId)
			AddItem( sceneId, x300303_GetSongxinItemID(sceneId, selfId, NPCId, UnAccept), 1)
		ret = EndAddItem(sceneId,selfId)
	  if ret > 0 then
			AddItemListToHuman(sceneId,selfId)
	  else
		  BeginEvent(sceneId)
			  AddText(sceneId,"物品栏已满，请整理下再来！")
			  EndEvent(sceneId)
		  DispatchMissionTips(sceneId,selfId)
			return 
		end
	end	
	AddMission( sceneId,selfId, x300303_g_MissionId, x300303_g_ScriptId, DoKill, DoArea, DoItem )		--添加任务
	SetMissionData(sceneId, selfId, MD_GUOJIARENWU_ROUND, GetMissionData(sceneId, selfId, MD_GUOJIARENWU_ROUND)+1)--round+1
	local misIndex = GetMissionIndexByID(sceneId, selfId, x300303_g_MissionId)
	if missionKind == "shoujishengzhangdian" then --收集的的技能添加- -||
		SetHumanAbilityLevel(sceneId, selfId, 26, 1)
		SetMissionByIndex(sceneId, selfId, misIndex, x300303_MP_SHOUJISHENGZHANGDIAN, 1)
	end
	SetMissionByIndex(sceneId, selfId, misIndex, x300303_MP_AIMNPC, UnAccept)
	SetMissionData(sceneId, selfId, MD_GUOJIARENWU_UNACCEPT, 0)--UnAccept清除
	
	BeginEvent(sceneId)
	 	strText = "你接受了任务  "..x300303_g_MissionName
	 	AddText(sceneId,strText);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
-------------------------
--OnSubmit
-------------------------
function x300303_OnSubmit( sceneId, selfId, NPCId, selectRadioId)

	local round = GetMissionData(sceneId, selfId, MD_GUOJIARENWU_ROUND)
	local circle = GetMissionData(sceneId, selfId, MD_GUOJIARENWU_CIRCLE)
	local misIndex = GetMissionIndexByID(sceneId, selfId, x300303_g_MissionId)
	local missionHash = GetMissionParam(sceneId, selfId, misIndex, x300303_MP_MISSIONHASH)
	local missionKind = x300303_GetMissionKind(sceneId, selfId,missionHash)
	local ExpBonus = x300303_GetExpBonus(sceneId, selfId, NPCId, round, circle)
	local MoneyBonus = x300303_GetMoneyBonus(sceneId, selfId, NPCId, round, circle)
--寻物，高级寻物，收集成长点都要清除所需物品
	if (missionKind == "xunwu") then
		local xunwuItemID = x300303_GetXunwuItemID(sceneId, selfId, NPCId, missionHash)
		local xunwuItemName = x300303_GetXunwuItemName(sceneId, selfId, NPCId, missionHash)
		local xunwuItemNum = x300303_GetXunwuItemNum(sceneId, selfId, NPCId, missionHash)
		DelItem(sceneId, selfId, xunwuItemID, xunwuItemNum)
	  BeginEvent(sceneId)
		  local strText = "你失去了"..xunwuItemNum.."个"..xunwuItemName
		  AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	elseif (missionKind == "gaojixunwu") then
		local gaojiItemID = x300303_GetGaojiItemID(sceneId, selfId, NPCId, missionHash)
		local gaojiItemName = x300303_GetGaojiItemName(sceneId, selfId, NPCId, missionHash)
		local gaojiItemNum = x300303_GetGaojiItemNum(sceneId, selfId, NPCId, missionHash)
		DelItem(sceneId, selfId, gaojiItemID, gaojiItemNum)
	  BeginEvent(sceneId)
		  local strText = "你失去了"..gaojiItemNum.."个"..gaojiItemName
		  AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	elseif (missionKind == "shoujishengzhangdian") then
		local shoujiItemID = x300303_GetShoujiItemID(sceneId, selfId, NPCId, missionHash)
		local shoujiItemName = x300303_GetShoujiItemName(sceneId, selfId, NPCId, missionHash)
		local shoujiItemNum = x300303_GetShoujiItemNum(sceneId, selfId, NPCId, missionHash)
		DelItem(sceneId, selfId, shoujiItemID, shoujiItemNum)
	  BeginEvent(sceneId)
		  local strText = "你把全部的"..shoujiItemName.."给了他"
		  AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	end
--**奖励
	AddExp(sceneId,selfId,ExpBonus)
	AddMoney(sceneId,selfId,MoneyBonus)
	local moneyjin = floor(MoneyBonus / 10000);
	local moneyyin = floor(MoneyBonus / 100) - moneyjin * 100;
	local moneytong = MoneyBonus - moneyjin * 10000 - moneyyin * 100;		
	BeginEvent(sceneId);
		AddText(sceneId, format("你获得奖励%d金%d银%d铜", moneyjin, moneyyin, moneytong));
	EndEvent();		
	DispatchMissionTips(sceneId, selfId);
	
	SetMissionData(sceneId, selfId, MD_GUOJIARENWU_CIRCLE, mod(circle+1, x300303_g_MaxCircle))
	DelMission(sceneId, selfId, x300303_g_MissionId)
  BeginEvent(sceneId)
	  local strText = "#Y你完成了任务  "..x300303_g_MissionName
	  AddText(sceneId,strText);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
-------------------------
--CheckSubmit
-------------------------
function x300303_CheckSubmit(sceneId,selfId, NPCId)
	if IsHaveMission(sceneId, selfId, x300303_g_MissionId) > 0 then
		return 1;
	end
	return 0;
end
-------------------------
--CheckCountry
--!!问题无法获取自己的国家号
-------------------------
function x300303_CheckCountry(sceneId,selfId,NPCId)
	return 1;
end
-------------------------
--ClearData
--在每次点选的时候清除
-------------------------
function x300303_ClearData(sceneId,selfId, NPCId)
	local dateRat = GetMissionData(sceneId, selfId, MD_GUOJIARENWU_DATE)
	local nowtime = LuaFnGetCurrentTime()
	local today = floor(nowtime / 86400)
	if dateRat ~= today then
		SetMissionData(sceneId, selfId, MD_GUOJIARENWU_DATE, today)--时间置成今天
		SetMissionData(sceneId, selfId, MD_GUOJIARENWU_ROUND, 0)--圈置零
		SetMissionData(sceneId, selfId, MD_GUOJIARENWU_CIRCLE, 0)--环置零
		SetMissionData(sceneId, selfId, MD_GUOJIARENWU_UNACCEPT, 0)--保存的未接任务清除
	end
end
-------------------------
--UnAcceptedMission
-------------------------
function x300303_GetUnAcceptedMission(sceneId, selfId, NPCId)
	return GetMissionData(sceneId, selfId, MD_GUOJIARENWU_UNACCEPT);
end
-------------------------
--GetPlayerLevelSec
-------------------------
function x300303_GetPlayerLevelSec(sceneId, selfId, NPCId)
	local playerLevel = GetLevel(sceneId, selfId)
	if playerLevel>=10 and playerLevel < 20 then
		return 1;
	elseif playerLevel>=20 and playerLevel < 40 then
		return 2;
	elseif playerLevel>=40 and playerLevel < 60 then
		return 3;
	elseif playerLevel>=60 and playerLevel < 80 then
		return 4;
	elseif playerLevel>=80 and playerLevel < 100 then
		return 5;
	end
	return 0;
end
-------------------------
--MissionCountInLevelSec
--某一等级段的Mission数
-------------------------
function x300303_MissionCountByLevelSec(sceneId, selfId, NPCId, levelSec)
	if (levelSec < 1 or levelSec > 5) then
		return -1;
	end
	local k = 0
	for i ,item in pairs(x300303_g_Mission) do
		if(item.levelsection == levelSec) then
			k = k+1;
		end
	end
	return k;
end
-------------------------
--GetMissionHashCount
--某一等级段的Mission数
-------------------------
function x300303_GetRandomMissionHash(sceneId, selfId, NPCId, levelSec)

	if (levelSec < 1 or levelSec > 5) then
		return -1;
	end
	local k = 0
	for i ,item in pairs(x300303_g_Mission) do
		if(item.levelsection == levelSec) then
			k = k+1;
		end
	end
	local randomNum = random(1,k)
	for i ,item in pairs(x300303_g_Mission) do
		if(item.levelsection == levelSec) then
			randomNum = randomNum -1;
			if (randomNum == 0) then
				return item.hash;
			end
		end
	end
end
-------------------------
--GetStartByHash
-------------------------
function x300303_GetStartByHash(sceneId, selfId, NPCId, missionHash)
	local missionKind = x300303_GetMissionKind(sceneId, selfId,missionHash)
	if missionKind == "teshushaguai" then
		for i ,item in pairs(x300303_g_Mission_teshushaguai) do
			if(item.hash == missionHash) then
				return item.Start;
			end
		end
	elseif missionKind == "songxin" then
		for i ,item in pairs(x300303_g_Mission_Songxin pairs(do
			if(item.hash == missionHash) then
				return item.Start;
			end
		end
	elseif missionKind == "xunwu" then
		for i ,item in pairs(x300303_g_Mission_xunwu) do
			if(item.hash == missionHash) then
				return item.Start;
			end
		end	
	elseif missionKind == "gaojixunwu" then
		for i ,item in pairs(x300303_g_Mission_gaojixunwu) do
			if(item.hash == missionHash) then
				return item.Start;
			end
		end	
	elseif missionKind == "dingdianshiyongwupin" then
		for i ,item in pairs(x300303_g_Mission_dingdianshiyongwupin pairs(do
			if(item.hash == missionHash) then
				return item.Start;
			end
		end	
	elseif missionKind == "shoujishengzhangdian" then
		for i ,item in pairs(x300303_g_Mission_shoujishengzhangdian) do
			if(item.hash == missionHash) then
				return item.Start;
			end
		end	
	end
end
-------------------------
--GetContinueByHash
-------------------------
function x300303_GetContinueByHash(sceneId, selfId, NPCId, missionHash)
	local missionKind = x300303_GetMissionKind(sceneId, selfId, missionHash)
	if missionKind == "teshushaguai" then
		for i ,item in pairs(x300303_g_Mission_teshushaguai) do
			if(item.hash == missionHash) then
				return item.continue;
			end
		end
	elseif missionKind == "songxin" then
		for i ,item in pairs(x300303_g_Mission_Songxin pairs(do
			if(item.hash == missionHash) then
				return item.continue;
			end
		end
	elseif missionKind == "xunwu" then
		for i ,item in pairs(x300303_g_Mission_xunwu) do
			if(item.hash == missionHash) then
				return item.continue;
			end
		end	
	elseif missionKind == "gaojixunwu" then
		for i ,item in pairs(x300303_g_Mission_gaojixunwu) do
			if(item.hash == missionHash) then
				return item.continue;
			end
		end	
	elseif missionKind == "dingdianshiyongwupin" then
		for i ,item in pairs(x300303_g_Mission_dingdianshiyongwupin pairs(do
			if(item.hash == missionHash) then
				return item.continue;
			end
		end	
	elseif missionKind == "shoujishengzhangdian" then
		for i ,item in pairs(x300303_g_Mission_shoujishengzhangdian) do
			if(item.hash == missionHash) then
				return item.continue;
			end
		end	
	end
end
-------------------------
--GetContinueXByHash
-------------------------
function x300303_GetContinueXByHash(sceneId, selfId, NPCId, missionHash)
	for i ,item in pairs(x300303_g_Mission_Songxin pairs(do
		if(item.hash == missionHash) then
			return item.continueX;
		end
	end
end
-------------------------
--GetEndXByHash
-------------------------
function x300303_GetEndXByHash(sceneId, selfId, NPCId, missionHash)
	for i ,item in pairs(x300303_g_Mission_Songxin pairs(do
		if(item.hash == missionHash) then
			return item.endstrX;
		end
	end
end
-------------------------
--GetEndByHash
-------------------------
function x300303_GetEndByHash(sceneId, selfId, NPCId, missionHash)
	local missionKind = x300303_GetMissionKind(sceneId, selfId,missionHash)
	if missionKind == "teshushaguai" then
		for i ,item in pairs(x300303_g_Mission_teshushaguai) do
			if(item.hash == missionHash) then
				return item.endstr;
			end
		end
	elseif missionKind == "songxin" then
		for i ,item in pairs(x300303_g_Mission_Songxin pairs(do
			if(item.hash == missionHash) then
				return item.endstr;
			end
		end
	elseif missionKind == "xunwu" then
		for i ,item in pairs(x300303_g_Mission_xunwu) do
			if(item.hash == missionHash) then
				return item.endstr;
			end
		end	
	elseif missionKind == "gaojixunwu" then
		for i ,item in pairs(x300303_g_Mission_gaojixunwu) do
			if(item.hash == missionHash) then
				return item.endstr;
			end
		end	
	elseif missionKind == "dingdianshiyongwupin" then
		for i ,item in pairs(x300303_g_Mission_dingdianshiyongwupin pairs(do
			if(item.hash == missionHash) then
				return item.endstr;
			end
		end	
	elseif missionKind == "shoujishengzhangdian" then
		for i ,item in pairs(x300303_g_Mission_shoujishengzhangdian) do
			if(item.hash == missionHash) then
				return item.endstr;
			end
		end	
	end
end
-------------------------
--SetUnAcceptedMission
-------------------------
function x300303_SetUnAcceptedMission(sceneId, selfId, NPCId, levelSec)
	local hash = x300303_GetRandomMissionHash(sceneId, selfId, NPCId, levelSec)
	SetMissionData(sceneId, selfId, MD_GUOJIARENWU_UNACCEPT, hash)
end
-------------------------
--GetEcpBonus
-------------------------
function x300303_GetExpBonus(sceneId, selfId, NPCId, round, circle)
	return 11;
end
-------------------------
--GetMoneyBonus
-------------------------
function x300303_GetMoneyBonus(sceneId, selfId, NPCId, round, circle)
	return 12345;
end
-------------------------
--GetMissionKind
-------------------------
function x300303_GetMissionKind(sceneId, selfId,missionHash)
	for i ,item in pairs(x300303_g_Mission) do
		if(item.hash == missionHash) then
			return item.missionKind;
		end
	end	
end
-------------------------
--MissionNPCName
-------------------------
function x300303_GetMissionNPCName(sceneId, selfId, NPCId, missionHash)
	for i ,item in pairs(x300303_g_Mission_Songxin pairs(do
		if (item.hash == missionHash) then
			return item.NPC_Name;
		end
	end
end
-------------------------
--GetXunwuItemID
-------------------------
function x300303_GetXunwuItemID(sceneId, selfId, NPCId, missionHash)
	for i ,item in pairs(x300303_g_Mission_xunwu) do
		if (item.hash == missionHash) then
			return item.item_ID;
		end
	end
end
-------------------------
--GetXunwuItemName
-------------------------
function x300303_GetXunwuItemName(sceneId, selfId, NPCId, missionHash)
	for i ,item in pairs(x300303_g_Mission_xunwu) do
		if (item.hash == missionHash) then
			return item.item_Name;
		end
	end
end
-------------------------
--GetXunwuItemNum
-------------------------
function x300303_GetXunwuItemNum(sceneId, selfId, NPCId, missionHash)
	for i ,item in pairs(x300303_g_Mission_xunwu) do
		if (item.hash == missionHash) then
			return item.item_Num;
		end
	end
end
-------------------------
--GetGaojiItemID
-------------------------
function x300303_GetGaojiItemID(sceneId, selfId, NPCId, missionHash)
	for i ,item in pairs(x300303_g_Mission_gaojixunwu) do
		if (item.hash == missionHash) then
			return item.item_ID;
		end
	end
end
-------------------------
--GetGaojiItemName
-------------------------
function x300303_GetGaojiItemName(sceneId, selfId, NPCId, missionHash)
	for i ,item in pairs(x300303_g_Mission_gaojixunwu) do
		if (item.hash == missionHash) then
			return item.item_Name;
		end
	end
end
-------------------------
--GetGaojiItemNum
-------------------------
function x300303_GetGaojiItemNum(sceneId, selfId, NPCId, missionHash)
	for i ,item in pairs(x300303_g_Mission_gaojixunwu) do
		if (item.hash == missionHash) then
			return item.item_Num;
		end
	end
end
-------------------------
--GetshoujiItemID
-------------------------
function x300303_GetShoujiItemID(sceneId, selfId, NPCId, missionHash)
	for i ,item in pairs(x300303_g_Mission_shoujishengzhangdian) do
		if (item.hash == missionHash) then
			return item.item_ID;
		end
	end
end
-------------------------
--GetshoujiItemName
-------------------------
function x300303_GetShoujiItemName(sceneId, selfId, NPCId, missionHash)
	for i ,item in pairs(x300303_g_Mission_shoujishengzhangdian) do
		if (item.hash == missionHash) then
			return item.item_Name;
		end
	end
end
-------------------------
--GetshoujiItemNum
-------------------------
function x300303_GetShoujiItemNum(sceneId, selfId, NPCId, missionHash)
	for i ,item in pairs(x300303_g_Mission_shoujishengzhangdian) do
		if (item.hash == missionHash) then
			return item.item_Num;
		end
	end
end
-------------------------
--GetDingdianItemID
-------------------------
function x300303_GetDingdianItemID(sceneId, selfId, NPCId, missionHash)
	for i ,item in pairs(x300303_g_Mission_dingdianshiyongwupin pairs(do
		if (item.hash == missionHash) then
			return item.item_ID;
		end
	end
end
-------------------------
--GetDingdiantemName
-------------------------
function x300303_GetDingdianItemName(sceneId, selfId, NPCId, missionHash)
	for i ,item in pairs(x300303_g_Mission_dingdianshiyongwupin pairs(do
		if (item.hash == missionHash) then
			return item.item_Name;
		end
	end
end
-------------------------
--GetDingdianItemNum
-------------------------
function x300303_GetDingdianItemNum(sceneId, selfId, NPCId, missionHash)
	for i ,item in pairs(x300303_g_Mission_dingdianshiyongwupin pairs(do
		if (item.hash == missionHash) then
			return item.item_Num;
		end
	end
end
-------------------------
--GetSongxinItemID
-------------------------
function x300303_GetSongxinItemID(sceneId, selfId, NPCId, missionHash)
	for i ,item in pairs(x300303_g_Mission_Songxin pairs(do
		if (item.hash == missionHash) then
			return item.item_ID;
		end
	end
end
-------------------------
--GetSongxintemName
-------------------------
function x300303_GetSongxinItemName(sceneId, selfId, NPCId, missionHash)
	for i ,item in pairs(x300303_g_Mission_Songxin pairs(do
		if (item.hash == missionHash) then
			return item.item_Name;
		end
	end
end