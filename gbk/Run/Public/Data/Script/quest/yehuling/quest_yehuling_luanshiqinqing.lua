--该脚本包含玩家接任务时的界面构建、任务相关内容定义、多任务目标的嵌入

--当前脚本的索引号
x207006_g_ScriptId = 207006

--当前任务的MissionID，具体由专人负责分配，9开头的默认为是为测试任务分配的ID
x207006_g_MissionId = 7

--任务归类
x207006_g_MissionKind = 1

--任务起始npc
x207006_g_NameHead	= "算命先生"

--任务提交npc
x207006_g_NameEnd	= "算命先生"

--****************************************任务可接条件判断*************************************************************************
--任务可接等级范围
x207006_g_MissionMinLevel = 1
x207006_g_MissionMaxLevel = 200

--前置任务的MissionID,可以填写多个前置任务
x207006_g_MisIdPre = {6}

--需要后续任务在该任务结束后直接弹出，则填写下面的参数，否则不填写，只能填写一个后续任务
--ScriptId为后续任务的ScriptId。LV为后续任务的等级要求，要和ScriptId对应脚本里面的等级要求一致
x207006_g_ScriptIdNext = {ScriptId = 207007 ,LV = 0 }

--****************************************任务内容开始*********************************************************************
--任务名称
x207006_g_MissionName="乱世亲情"
--任务描述(接任务时，和所有目标完成交任务时)支持多条语句
x207006_g_MissionInfo={"    我连自己的性命都保不了，更不用说帮你的忙！除非你先帮我一个忙。\n \n咳~！算命的虽然穷，还是有家室的，我的女人……，人是一种很自私的动物，为了私欲，什么都干得出来，战争的起因，就是这样而来的，我不想让她看到世间的残酷。\n \n你能护送我女人离开个鬼地方吗？"} 
--任务未完成时去交任务的提示文字 ，支持多条语句
x207006_g_UnDoneMissionInfo={"    在我的女人安全之前我是什么都不会说的。"}  
--总的大体任务目标描述，一句话描述
x207006_g_MissionAim="    护送算命先生的女人到城门处"		

--任务目标类型(可以多任务目标)
--MONSTER_KILL					--杀怪                        --id为杀怪类型，name为怪物名称,num为对应杀怪数量
x207006_g_MONSTER_KILL = {{id=284,name="野狐岭潜伏者",num=1,type="MONSTER_KILL",order=0},{id=285,name="潜伏者",num=1,type="MONSTER_KILL",order=0}	}

--DELIVERY						--送信                        --npc为要送信给的对象,item为是否有任务物品要给送信对象,该item由任务发布人直接给予玩家; info为任务目标显示
x207006_g_DELIVERY = {{npc = "豁儿赤",item = 0,num = 0,comeitem = 0,comenum = 0,info="询问木华黎军情",dialog="可怜的拖雷",type="DELIVERY",order=0},{npc = "赤老温",item = 12010002,num = 1,comeitem = 0,comenum = 0,info="询问木华黎军情",dialog="可怜的拖雷",type="DELIVERY",order=0}}

--COLLECT_SPECIAL				--采集(暂时先不做这个)         --item为采集的物品类型,name为道具名称,num为需求道具个数
x207006_g_COLLECT_SPECIAL = {{item=300010,name="乃蛮兵腰牌",num=30,type="COLLECT_SPECIAL",order=0},{item=300011,name="金兵腰牌",num=15,type="COLLECT_SPECIAL",order=0}}

--ENTERAREA						--区域探索           --map为区域探索的目标地图编号,area为该目标地图的事件区域编号
x207006_g_ENTERAREA = {{mapid=7,area=0,info="前往查看无量山的无量育碧",type="ENTERAREA",order=0},{mapid=7,area=1,info="前往查看华山",type="ENTERAREA",order=0}}

--PROTECT						--护送(本护送为新添加npc,使其成为保护对象)         --npc为要护送的npc,name为npc的名称,patrol为护送的npc路径()
x207006_g_PROTECT={{npc=121,name="夫人",place={x=52.9247,z=53.1867},ai={baseai=3,scriptai=0},patrol=3,info="    护送算命先生的夫人",type="PROTECT",order=0}}
x207006_g_ProtectNPCID = {}
-- 护送相关的场景计时器的Index
if x207006_g_PROTECT~=nil then
	if x207006_g_PROTECTINFO == nil then
		x207006_g_PROTECTINFO={ScneneTimerIndex = -1, Step = 0, StartTime = 0, PlayerNum = 0, PlayerId= {0,0,0,0,0,0}}
	end
end

--COLLECT						--收集物品                    --item为采集的物品类型,name为道具名称,num为需求道具个数
x207006_g_COLLECT = {{item=12010001,name="乃蛮兵腰牌",num=30,type="COLLECT",order=0},{item=12010002,name="腰牌",num=10,type="COLLECT",order=0}}

--MONSTER_ITEM					--打怪掉落                    --id为杀怪类型，item为怪物掉落物品类型,name为道具名称，per为掉落概率，max为一次掉落物品的个数上限,num为需求道具个数
x207006_g_MONSTER_ITEM = {{id=284,item=12010001,name="乃蛮兵腰牌",per=100,max=3,num=2,type="MONSTER_ITEM",order=0}}

--********************************任务目标的组合********************************
--*切记*****切记*****切记*******************************************************************************
--*********************一个任务的目标个数最多只能为8个,现在已经超出了,请修正*******************************
--********************任务目标为最小元素,比如杀3种怪,算作3个任务目标计算***********************************
--*切记*****切记*****切记********************************************************************
x207006_g_QuestType = {x207006_g_PROTECT}
x207006_g_Quest = {}
x207006_g_QuestNum = 0

function  x207006_g_QuestOrder(QuestType)
	local count = 0
	for i, QuestLabel in pairs(QuestType) do
		for j, QuestInfo in pairs(QuestLabel) do
			count = count + 1
			QuestInfo.order = count
			x207006_g_Quest[count] = QuestInfo
		end
	end
	x207006_g_QuestNum = count
end
	
--任务奖励(exp为经验调节参数，money为金钱调节参数)
--经验奖励
x207006_g_ExpBonustxt = "经验  1000+等级×等级"
x207006_g_exp = 1

function x207006_g_ExpBonus(sceneId, selfId, exp)
	local LV = GetLevel( sceneId, selfId )
	local ExpBonus =1000+LV*LV
	return ExpBonus*x207006_g_exp
end

--金钱奖励
x207006_g_MoneyBonustxt = 10000
x207006_g_money = 1

function x207006_g_MoneyBonus(sceneId, selfId, money)
	local MoneyBonus=10000
	return MoneyBonus*x207006_g_money
end

--固定物品奖励，最多8种
x207006_g_ItemBonus={{id=12010003,num=5},{id=12010004,num=5}}

--可选物品奖励，最多8种
x207006_g_RadioItemBonus={{id=12010005,num=5},{id=12010006,num=5}}
--MisDescEnd
--**********************************任务入口函数**********************************

function x207006_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
--DelMission(sceneId, selfId, x207006_g_MissionId)       
	x207006_g_QuestOrder(x207006_g_QuestType)
    if IsHaveMission(sceneId,selfId,x207006_g_MissionId) > 0 then
		if (GetName(sceneId,targetId)==x207006_g_NameEnd) then
			local m = 0
			for i, QuestInfo in pairs(x207006_g_Quest) do
				if (QuestInfo.type == "DELIVERY") then
					if (#(x207006_g_DELIVERY)==1) and (x207006_g_NameEnd == x207006_g_DELIVERY[1].npc) then	
						m = 2
					else
						m = 1
					end
				else
					m = 1
				end
			end
			if m == 1 then
				local Done = x207006_CheckSubmit( sceneId, selfId )
				BeginEvent(sceneId)
					if Done == 1 then
						x207006_ShowQuestInfo( sceneId, selfId, targetId , 1)
					else
						x207006_ShowQuestInfo( sceneId, selfId, targetId , 2)
					end
				EndEvent( )
				if (Done == 1) then
					DispatchMissionContinueInfo(sceneId,selfId,targetId,x207006_g_ScriptId,x207006_g_MissionId)
				else
					DispatchMissionDemandInfo(sceneId,selfId,targetId,x207006_g_ScriptId,x207006_g_MissionId,0)
				end
			elseif m == 2 then
				local Done = 0
				if x207006_g_DELIVERY[1].item > 0 and x207006_g_DELIVERY[1].num > 0 then
					if	(LuaFnGetItemCount(sceneId,selfId,x207006_g_DELIVERY[1].item)>=x207006_g_DELIVERY[1].num) then
						Done = 1						
					end
				else
					Done = 1
				end
				if Done == 1 then
					local misIndex = GetMissionIndexByID(sceneId,selfId,x207006_g_MissionId)
					for i, QuestInfo in pairs(x207006_g_Quest) do
						if (QuestInfo.type == "DELIVERY") then
							if (GetName(sceneId,targetId)==QuestInfo.npc)then
								SetMissionByIndex(sceneId,selfId,misIndex,QuestInfo.order-1,1)
							end
						end
					end
				end
				BeginEvent(sceneId)
					if Done == 1 then
						x207006_ShowQuestInfo( sceneId, selfId, targetId , 1)
					else
						x207006_ShowQuestInfo( sceneId, selfId, targetId , 2)
					end
				EndEvent( )
				if (Done == 1) then
					DispatchMissionContinueInfo(sceneId,selfId,targetId,x207006_g_ScriptId,x207006_g_MissionId)
				else
					DispatchMissionDemandInfo(sceneId,selfId,targetId,x207006_g_ScriptId,x207006_g_MissionId,0)
				end
			end
		elseif (x207006_g_DELIVERY ~= nil) then
			local n = 0 
			for i, QuestInfo in pairs(x207006_g_Quest) do
				if (QuestInfo.type == "DELIVERY") then
					n = 1
					break
				end
			end
			if  n == 1 then
				for i, DeliveryInfo in pairs(x207006_g_DELIVERY) do
					if (GetName(sceneId,targetId)==DeliveryInfo.npc)then
						if DeliveryInfo.comeitem > 0 and DeliveryInfo.comenum > 0 then
							BeginAddItem(sceneId)		
								AddItem( sceneId,DeliveryInfo.comeitem, DeliveryInfo.comenum )
							local ret = EndAddItem(sceneId,selfId)
							if  ret <=0 then
								BeginEvent(sceneId)
									strText = "物品栏已满，请整理下再来！"
									AddText(sceneId,strText);
								EndEvent(sceneId)
								DispatchMissionTips(sceneId,selfId)
								return
							end					
						end
						local m = 0
						if DeliveryInfo.item == 0 or DeliveryInfo.num == 0 then
							m = 1
						elseif DeliveryInfo.item > 0 or DeliveryInfo.num > 0 then
							if	(LuaFnGetItemCount(sceneId,selfId,DeliveryInfo.item)>=DeliveryInfo.num) then
								m = 2
							end
						end
						if m > 0 then
							local misIndex = GetMissionIndexByID(sceneId,selfId,x207006_g_MissionId)
							for i, QuestInfo in pairs(x207006_g_Quest) do
								if QuestInfo.type == "DELIVERY" then
									if (GetName(sceneId,targetId)==QuestInfo.npc)then
										SetMissionByIndex(sceneId,selfId,misIndex,QuestInfo.order-1,1)
									end
								end
							end
							BeginEvent(sceneId)
								strText = DeliveryInfo.info.."   1/1"
								AddText(sceneId,strText);
							EndEvent(sceneId)
							DispatchMissionTips(sceneId,selfId)
							BeginEvent(sceneId)
								AddText(sceneId,DeliveryInfo.dialog)
							EndEvent( )	
							DispatchEventList(sceneId,selfId,targetId)
							if m == 2 then
								DelItem(sceneId,selfId,DeliveryInfo.item,DeliveryInfo.num)
							end
							if DeliveryInfo.comeitem > 0 and DeliveryInfo.comenum > 0 then
								AddItemListToHuman(sceneId,selfId)
							end	
						elseif m == 0 then
							BeginEvent(sceneId)
								AddText(sceneId,x207006_g_NameHead.."让你带给我的东西在哪呢？")
							EndEvent( )	
							DispatchEventList(sceneId,selfId,targetId)
						end
					end
				end
			end
		end
    elseif x207006_CheckAccept(sceneId,selfId,targetId) > 0 then
		--满足任务可接条件，开始显示任务的相关内容
		BeginEvent(sceneId)
			x207006_ShowQuestInfo( sceneId, selfId, targetId ,0)
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x207006_g_ScriptId,x207006_g_MissionId)
    end	
end

--**********************************任务内容显示**********************************
function	x207006_ShowQuestInfo( sceneId, selfId, targetId ,Done)
	local DoneEX = Done
	AddText(sceneId,"#Y"..x207006_g_MissionName)
	if DoneEX==2 then
		for i, Info in pairs(x207006_g_UnDoneMissionInfo) do
			AddText(sceneId,Info)
		end
	else
		for i, Info in pairs(x207006_g_MissionInfo) do
			AddText(sceneId,Info)
		end
	end
	AddText(sceneId,x207006_g_ExpBonustxt)
	AddText(sceneId,"#Y任务目标:")
	AddText(sceneId,x207006_g_MissionAim)
	--多任务目标的显示
	if Done >= 1 then
		Done = 1
	end	
	x207006_ShowQuestAim( sceneId, selfId, targetId,Done )	
	AddMoneyBonus( sceneId, x207006_g_MoneyBonustxt )
	if DoneEX == 2 then
	else
		if x207006_g_ItemBonus ~= nil then
			for i, item in pairs(x207006_g_ItemBonus) do
				AddItemBonus( sceneId, item.id, item.num )
			end
		end			
		if x207006_g_RadioItemBonus ~= nil then
			for i, item in pairs(x207006_g_RadioItemBonus) do
				AddRadioItemBonus( sceneId, item.id, item.num )
			end
		end
	end
end


--**********************************任务目标显示**********************************

function	x207006_ShowQuestAim( sceneId, selfId, targetId ,Done)
	x207006_g_QuestOrder(x207006_g_QuestType)
	if x207006_g_Quest ==nil then
	else
		local Many = 0
		misIndex = GetMissionIndexByID(sceneId,selfId,x207006_g_MissionId)
		for i, QuestInfo in pairs(x207006_g_Quest) do

			if QuestInfo.type == "MONSTER_KILL" or QuestInfo.type == "COLLECT_SPECIAL"  or QuestInfo.type == "MONSTER_ITEM" then
				if Done == 1 then
					Many = GetMissionParam(sceneId,selfId,misIndex,QuestInfo.order-1)
					if Many == nil then
						Many = 0
					end
				end
				StrTxt = QuestInfo.name.."    "..Many.."/"..QuestInfo.num
				AddText(sceneId,StrTxt)				
			elseif  (QuestInfo.type == "COLLECT") then
				if Done == 1 then
					Many = LuaFnGetItemCount(sceneId,selfId,QuestInfo.item)
					if Many == nil then
						Many = 0
					elseif Many >  QuestInfo.num then
						Many = QuestInfo.num
					end
				end
				StrTxt = QuestInfo.name.."    "..Many.."/"..QuestInfo.num
				AddText(sceneId,StrTxt)
			elseif  QuestInfo.type == "DELIVERY" or QuestInfo.type == "ENTERAREA" or QuestInfo.type == "PROTECT" then
				if Done == 1 then
					Many = GetMissionParam(sceneId,selfId,misIndex,QuestInfo.order-1)
					if Many == nil then
						Many = 0
					end
				end
				StrTxt = QuestInfo.info.."    "..Many.."/1"
				AddText(sceneId,StrTxt)
			end
		end
	end
end

--**********************************判断任务是否显示**********************************
function x207006_OnEnumerate( sceneId, selfId, targetId )
	--DelMission( sceneId, selfId, x207006_g_MissionId )
	--LuaFnJoinMenpai(sceneId, selfId, targetId, 0)
	x207006_g_QuestOrder(x207006_g_QuestType) 	
    if IsMissionHaveDone(sceneId,selfId,x207006_g_MissionId) > 0 then
    	return 
    elseif IsHaveMission(sceneId,selfId,x207006_g_MissionId) > 0 then
    	local m = 0
    	for  i, QuestInfo in pairs(x207006_g_Quest) do
    		if QuestInfo.type == "DELIVERY" then
    			m = 1
    		end
    	end
    	if  (m == 1)  then
    		if  (GetName(sceneId,targetId)==x207006_g_NameEnd) then
    			AddNumText(sceneId,x207006_g_ScriptId,x207006_g_MissionName);
    		else
				for i, QuestInfo in pairs(x207006_g_Quest) do
					if QuestInfo.type == "DELIVERY" then
						if (GetName(sceneId,targetId)==QuestInfo.npc)then
					    	if x207006_CheckContinue(sceneId, selfId, targetId) == 1 then
								AddNumText(sceneId,x207006_g_ScriptId,x207006_g_MissionName);	
								break
							end
						end
					end
				end
			end
		elseif  (GetName(sceneId,targetId)==x207006_g_NameEnd) then
			AddNumText(sceneId,x207006_g_ScriptId,x207006_g_MissionName);
		end					
	--如果玩家满足任务可接条件,则显示这个任务
    elseif x207006_CheckAccept(sceneId,selfId,targetId) > 0 then
		AddNumText(sceneId,x207006_g_ScriptId,x207006_g_MissionName);
    end
end



--**********************************判断任务可接条件****************************************
--**********************************1、点击的当前NPC为任务接受NPC****************************
--**********************************2、满足等级范围需求、满足前续任务完成需求*****************

function x207006_CheckAccept( sceneId, selfId ,targetId )
	if (GetName(sceneId,targetId)==x207006_g_NameHead) then
		if (GetLevel( sceneId, selfId ) >= x207006_g_MissionMinLevel ) and (GetLevel( sceneId, selfId ) <= x207006_g_MissionMaxLevel ) then
			if	x207006_g_MisIdPre == nil then
				return	1
			else
				for i, questpre in pairs(x207006_g_MisIdPre) do
					if IsMissionHaveDone(sceneId,selfId,questpre) == 0 then
						return 0
					end
				end
				return 1
			end		
		else
			return 0
		end
	else
		return 0
	end	
end
--**********************************判断任务继续条件****************************************
--**********************************1、点击的当前NPC为任务接受NPC****************************
--**********************************2、主要是针对送信任务的中间环节进行判断*****************

function x207006_CheckContinue( sceneId, selfId ,targetId )
	x207006_g_QuestOrder(x207006_g_QuestType)
	misIndex = GetMissionIndexByID(sceneId,selfId,x207006_g_MissionId)
	for i, QuestInfo in pairs(x207006_g_Quest) do
		if QuestInfo.type == "DELIVERY" then
			if (GetName(sceneId,targetId)==QuestInfo.npc)then
		    	local CanContinue = GetMissionParam(sceneId,selfId,misIndex,QuestInfo.order-1)
				if CanContinue == 0 then
					return 1
				end
			end
		end
	end
	return 0	
end
--**********************************接受任务**********************************
function x207006_OnAccept(sceneId, selfId )		
	x207006_g_QuestOrder(x207006_g_QuestType)
	if GetMissionCount(sceneId, selfId)>=20 then
		Msg2Player(  sceneId, selfId,"#Y你的任务日志已经满了" , MSG2PLAYER_PARA )
		BeginEvent(sceneId)
			strText = "#Y你的任务日志已经满了"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	local DoKill,DoArea,DoItem = 0,0,0
	for i, QuestInfo in pairs(x207006_g_Quest) do
		if QuestInfo.type == "MONSTER_KILL" then
			DoKill = 1
		elseif (QuestInfo.type == "DELIVERY") then
				DoItem = 1	
				local m = 0
				local ret = 1
				for i, QuestLableInfo in pairs(x207006_g_Quest) do
					if (QuestLableInfo.type == "DELIVERY")and (QuestLableInfo.order==QuestInfo.order)then
						if QuestInfo.item > 0 and QuestInfo.num > 0 then
							m = 1
							break
						end	
					end
				end
				if m == 1 then
					BeginAddItem(sceneId)
					if QuestInfo.item > 0 and QuestInfo.num > 0 then
						AddItem( sceneId,QuestInfo.item, QuestInfo.num )
					end
					local ret = EndAddItem(sceneId,selfId)
				end				
				if ret > 0 then
					if m == 1 then
						AddItemListToHuman(sceneId,selfId)
					end
				else
					BeginEvent(sceneId)
						strText = "背包已满,无法获得任务物品"
						AddText(sceneId,strText);
					EndEvent(sceneId)
					DispatchMissionTips(sceneId,selfId)
					return
				end
		elseif QuestInfo.type == "COLLECT_SPECIAL"	then	--采集(暂时先不做这个)
				DoItem = 1
		elseif QuestInfo.type == "ENTERAREA"	then			--区域探索
				DoArea = 1
		elseif QuestInfo.type == "COLLECT"	then			--收集物品
				DoItem = 1
		elseif QuestInfo.type == "MONSTER_ITEM"	then			--打怪掉落
				DoKill = 1
				DoItem = 1
		elseif QuestInfo.type == "PROTECT"	then			--护送
			if (x207006_g_PROTECTINFO == nil) then
				return
			else
				if x207006_g_PROTECTINFO.Step > 2  then
					BeginEvent(sceneId)
						strText = "#Y现在不能接这个任务"
						AddText(sceneId,strText);
					EndEvent(sceneId)
					DispatchMissionTips(sceneId,selfId)
					return
				end
				
				-- 如果当前 
				if x207006_g_PROTECTINFO.Step == 0  then
					-- 开启护送剧情  
					-- 检测场景中是不是有这个人物了
					local nMonsterNum = GetMonsterCount(sceneId)
					local ii = 0
					local bHaveMonster = 0
					for ii=0, nMonsterNum-1 do
						local nMonsterId = GetMonsterObjID(sceneId,ii)
						for i, QuestInfo in pairs(x207006_g_Quest) do
							if QuestInfo.type == "PROTECT"	then
								if GetName(sceneId, nMonsterId)  == QuestInfo.name  then
									bHaveMonster = 1
								end
							end
						end
					end
					
					-- 有这个人了，不能在现在去创建脚本
					if bHaveMonster == 1   then 
						BeginEvent(sceneId)
							strText = "#Y现在不能接这个任务"
							AddText(sceneId,strText);
						EndEvent(sceneId)
						DispatchMissionTips(sceneId,selfId)
						return
					elseif bHaveMonster == 0   then
						for i, QuestInfo in pairs(x207006_g_Quest) do
							if QuestInfo.type == "PROTECT"	then
								local nNpcId = LuaFnCreateMonster(sceneId,  QuestInfo.npc, QuestInfo.place.x, QuestInfo.place.z, QuestInfo.ai.baseai, QuestInfo.ai.scriptai, x207006_g_ScriptId)
								--SetCharacterName(sceneId, nNpcId, ProtectInfo.name)
								-- 设置小时时间是10分钟
								--SetCharacterDieTime(sceneId, nNpcId, 600000)
							end
						end
					end
					-- 把这个玩家加到护送玩家列表中
					x207006_g_PROTECTINFO.PlayerNum = 1
					x207006_g_PROTECTINFO.PlayerId[1] = selfId
			
					-- 启动一个场景计时器,每间隔3秒,回调一次OnScneneTimer函数
					x207006_g_PROTECTINFO.ScneneTimerIndex = SetTimer(sceneId, selfId, 207006, "OnScneneTimer", 1)
					x207006_g_PROTECTINFO.Step = 1
					--当前时间
					x207006_g_PROTECTINFO.StartTime = LuaFnGetCurrentTime()
				end
				
				-- 加入到这个护送的玩家
				if x207006_g_PROTECTINFO.Step == 2  then
					if x207006_g_PROTECTINFO.PlayerNum > 5  then
						--人满了
						return
					end
				
					x207006_g_PROTECTINFO.PlayerNum = x207006_g_PROTECTINFO.PlayerNum + 1
					x207006_g_PROTECTINFO.PlayerId[x207006_g_PROTECTINFO.PlayerNum] = selfId
				end
			end
		end
	end	
	--第5个参数表示是否回调OnKillObject	第6个参数表示是否回调OnEnterArea	第7个参数表示是否回调OnItemChange
	AddMission( sceneId,selfId, x207006_g_MissionId, x207006_g_ScriptId, DoKill, DoArea, DoItem )		--添加任务
	misIndex = GetMissionIndexByID(sceneId,selfId,x207006_g_MissionId)			--得到任务的序列号
	if x207006_g_QuestNum > 8 then
		return
	end
	for j=1,x207006_g_QuestNum do
		SetMissionByIndex(sceneId,selfId,misIndex,j-1,0)	--根据序列号把任务变量的第0位置0
	end
	BeginEvent(sceneId)
	  	strText = "你接受了任务  "..x207006_g_MissionName
	  	AddText(sceneId,strText);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end

--**********************************
--放弃
--**********************************
function x207006_OnAbandon( sceneId, selfId )
	x207006_g_QuestOrder(x207006_g_QuestType)
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x207006_g_MissionId )
    for i, QuestInfo in pairs(x207006_g_Quest) do
		if QuestInfo.type ==  "DELIVERY" then
			if QuestInfo.item > 0 and QuestInfo.num > 0 then
				local deliveryitemnum = LuaFnGetItemCount(sceneId,selfId,QuestInfo.item)
				if deliveryitemnum > 0 then
					DelItem(sceneId,selfId,QuestInfo.item,deliveryitemnum)
				end
			end
			if QuestInfo.comeitem > 0 and QuestInfo.comenum >0 then
				local deliverycomeitemnum = LuaFnGetItemCount(sceneId,selfId,QuestInfo.comeitem)
				if deliverycomeitemnum > 0 then
					DelItem(sceneId,selfId,QuestInfo.comeitem,deliverycomeitemnum)
				end
			end
		end
		if QuestInfo.type ==  "COLLECT_SPECIAL" then
			local collectitemnum = LuaFnGetItemCount(sceneId,selfId,QuestInfo.item)
			if collectitemnum > 0 then
				DelItem(sceneId,selfId,QuestInfo.item,collectitemnum)
			end
		end
		if QuestInfo.type ==  "MONSTER_ITEM" then
			local monsteritemnum = LuaFnGetItemCount(sceneId,selfId,QuestInfo.item)
			if monsteritemnum > 0 then
				DelItem(sceneId,selfId,QuestInfo.item,monsteritemnum)
			end
		end
	end    
end

--**********************************--场景计时器--**********************************
function x207006_OnScneneTimer(sceneId, selfId)
	x207006_g_QuestOrder(x207006_g_QuestType)
	local bHavePlayer = 0
	-- 等待5秒进入2
	if x207006_g_PROTECTINFO.Step == 1   then
		-- 通知自己队伍的其他玩家接这个任务
		local nMonsterNum = GetMonsterCount(sceneId)
		local m = 0
		local HeadNPCID = 0
		local bHaveMonster = 0
		for m=0, nMonsterNum-1 do
			local nMonsterId = GetMonsterObjID(sceneId,m)
			if GetName(sceneId, nMonsterId)  == x207006_g_NameHead  then
				HeadNPCID = nMonsterId
				bHaveMonster = 1
			end
		end
		local nTeamCount = GetNearTeamCount(sceneId, selfId)
		for i=0, nTeamCount-1 do
			local PlayerId = GetNearTeamMember(sceneId, selfId, i)
			if PlayerId ~= selfId    then
				CallScriptFunction((207006), "OnDefaultEvent", sceneId, PlayerId, HeadNPCID )
			end
		end
		x207006_g_PROTECTINFO.Step = 2
	end
	-- 开始等待别的玩家来一起做这个任务,10秒钟时间
	if x207006_g_PROTECTINFO.Step == 2   then
		if LuaFnGetCurrentTime() - x207006_g_PROTECTINFO.StartTime >= 10   then
			x207006_g_PROTECTINFO.Step = 3
		end
	end
	-- 有玩家点击了开始护送
	if x207006_g_PROTECTINFO.Step == 3   then
		local nMonsterNum = GetMonsterCount(sceneId)
		local ii = 0
		local bHaveMonster = 0
		for ii=0, nMonsterNum-1 do
			local nMonsterId = GetMonsterObjID(sceneId,ii)
			for j, ProtectInfo in pairs(x207006_g_PROTECT) do
				if GetName(sceneId, nMonsterId)  ==  ProtectInfo.name then
					bHaveMonster = bHaveMonster + 1
					x207006_g_ProtectNPCID[j] = nMonsterId
				end
			end
		end
		if bHaveMonster == #(x207006_g_PROTECT)  then
			for j, ProtectInfo in pairs(x207006_g_PROTECT) do
				SetPatrolId(sceneId, x207006_g_ProtectNPCID[j], ProtectInfo.patrol)
			end
			x207006_g_PROTECTINFO.Step = 4
		end
	end
	-- 护送过程
	if x207006_g_PROTECTINFO.Step == 4   then
		local nMonsterNum = GetMonsterCount(sceneId)
		local ii = 0
		local bHaveMonster = 0

		local bDone = 0
		for ii=0, nMonsterNum-1   do
			local nMonsterId = GetMonsterObjID(sceneId,ii)
			for j, ProtectInfo in pairs(x207006_g_PROTECT) do
				if GetName(sceneId, nMonsterId)  ==  ProtectInfo.name then
					bHaveMonster = bHaveMonster + 1
					x207006_g_ProtectNPCID[j] = nMonsterId
				end
			end
		end
		if bHaveMonster < #(x207006_g_PROTECT)   then
			-- 关闭计时器
			x207006_CloseTimer(sceneId, x207006_g_PROTECTINFO.ScneneTimerIndex)
			return
		end
		for j, NpcID in pairs(x207006_g_ProtectNPCID) do 
			-- 检测ProtectNPC 和玩家之间的距离
			local targetX, targetZ = GetWorldPos(sceneId, NpcID)
			-- 检测如果玩家的距离已经离开的场景或者玩家不在护送对象10米内，这个玩家失败
			for i=1, x207006_g_PROTECTINFO.PlayerNum  do
				if x207006_g_PROTECTINFO.PlayerId[i] ~= 0  then
					local nPlayerX, nPlayerZ = GetWorldPos(sceneId, x207006_g_PROTECTINFO.PlayerId[i])
					local distance1 = floor(sqrt((targetX-nPlayerX)*(targetX-nPlayerX)+(targetZ-nPlayerZ)*(targetZ-nPlayerZ)))
					
					if distance1 > 20    then
						--提示这个玩家任务失败
						BeginEvent(sceneId)
							strText = x207006_g_MissionName.."  失败"
							AddText(sceneId,strText);
						EndEvent(sceneId)
						DispatchMissionTips(sceneId,x207006_g_PROTECTINFO.PlayerId[i])
						-- 从列表中删除这个玩家
						x207006_g_PROTECTINFO.PlayerId[i] = 0
					end
				end
			end
		end	
		for j, ProtectInfo in pairs(x207006_g_PROTECT) do
			for j, NpcID in pairs(x207006_g_ProtectNPCID) do 
				if  GetName(sceneId, NpcID)==ProtectInfo.name  then		
					local targetX, targetZ = GetWorldPos(sceneId, NpcID)
					--local x, z = GetLastPatrolPoint(sceneId, ProtectInfo.patrol)
					local x,z =144,25
					local distance = floor(sqrt((targetX-x)*(targetX-x)+(targetZ-z)*(targetZ-z)))
					-- 到达终点
					if distance<=1  then
						for i=1, x207006_g_PROTECTINFO.PlayerNum  do
							if x207006_g_PROTECTINFO.PlayerId[i]~=0   then
								-- 检测玩家是不是有这个任务
								if IsHaveMission(sceneId,x207006_g_PROTECTINFO.PlayerId[i],x207006_g_MissionId) > 0 then
									local misIndex = GetMissionIndexByID(sceneId, x207006_g_PROTECTINFO.PlayerId[i], x207006_g_MissionId)
									for i, QuestInfo in pairs(x207006_g_Quest) do
										if QuestInfo.type == "PROTECT" then
											SetMissionByIndex(sceneId,x207006_g_PROTECTINFO.PlayerId[i],misIndex,QuestInfo.order-1,1)
										end
									end
									BeginEvent(sceneId)
										strText = ProtectInfo.info.."  1/1"
										AddText(sceneId,strText);
									EndEvent(sceneId)
									DispatchMissionTips(sceneId,x207006_g_PROTECTINFO.PlayerId[i])
								end
							end
						end
						RemoveMonster(sceneId, NpcID)
						bDone = bDone + 1
					end								
				end
			end
		end
		if (bDone >= #(x207006_g_PROTECT)) then
			x207006_g_PROTECTINFO.Step = 5
			-- 关闭计时器
			x207006_CloseTimer(sceneId, x207006_g_PROTECTINFO.ScneneTimerIndex)
		end
	end
end

--**********************************
--关闭计时器
--**********************************
function x207006_CloseTimer( sceneId, TimerIndex )
	StopTimer(sceneId, TimerIndex)
	x207006_g_PROTECTINFO.ScneneTimerIndex = -1
	x207006_g_PROTECTINFO.Step = 0
	x207006_g_PROTECTINFO.StartTime = 0
	x207006_g_PROTECTINFO.PlayerNum = 0
	for i =1, #(x207006_g_PROTECTINFO.PlayerId) do
		x207006_g_PROTECTINFO.PlayerId[i]=0
	end
	x207006_g_ProtectNPCID = {}
end

--**********************************
--继续
--**********************************
function x207006_OnContinue( sceneId, selfId, targetId )

end

--**********************************
--检测是否可以提交
--**********************************
function x207006_CheckSubmit( sceneId, selfId )
	x207006_g_QuestOrder(x207006_g_QuestType)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x207006_g_MissionId)
	local bDone = 1
	for i, QuestInfo in pairs(x207006_g_Quest) do
		if QuestInfo.type == "MONSTER_KILL" or QuestInfo.type == "COLLECT_SPECIAL" or QuestInfo.type == "ENTERAREA" or QuestInfo.type == "PROTECT"  or QuestInfo.type == "COLLECT" or QuestInfo.type == "MONSTER_ITEM" then
			local Many = GetMissionParam(sceneId,selfId,misIndex,QuestInfo.order-1)
			if QuestInfo.num == nil then
				QuestInfo.num = 1
			end
			if Many == nil then

			elseif	Many < QuestInfo.num then
				bDone = 0
				break
			end
		elseif QuestInfo.type == "DELIVERY" then
			Many = GetMissionParam(sceneId,selfId,misIndex,QuestInfo.order-1)
			if Many == nil then

			elseif	Many < 1   then
				bDone = 0
				break
			elseif ( QuestInfo.comeitem >0 and QuestInfo.comeitem>0 ) then
				if (LuaFnGetItemCount(sceneId,selfId,QuestInfo.comeitem) < QuestInfo.comenum) then
					bDone = 0
					break
				end
			end
		end
	end
	if bDone == 1 then
		return 1
	end
	return 0
end

--**********************************
--提交
--**********************************
function x207006_OnSubmit( sceneId, selfId, targetId,selectRadioId )
	x207006_g_QuestOrder(x207006_g_QuestType)
	if (x207006_CheckSubmit( sceneId, selfId ) == 1) then
		BeginAddItem(sceneId)
			if (x207006_g_ItemBonus~=nil) then
				for i, item in pairs(x207006_g_ItemBonus) do
					AddItem( sceneId,item.id, item.num )
				end
			end
			if (x207006_g_RadioItemBonus~=nil) then
				for i, item in pairs(x207006_g_RadioItemBonus) do
					if item.id == selectRadioId then
						AddItem( sceneId,item.id, item.num )
					end
				end
			end
		local giveitem = EndAddItem(sceneId,selfId)		
		if (giveitem<=0) then
			--任务奖励没有加成功
			BeginEvent(sceneId)
				strText = "物品栏已满，请整理下再来！"
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		else
			ret = DelMission( sceneId, selfId, x207006_g_MissionId )
			if ret > 0 then
				for i, QuestInfo in pairs(x207006_g_Quest) do
					if QuestInfo.type ==  "DELIVERY" then
						if #(x207006_g_DELIVERY) == 1 and QuestInfo == x207006_g_DELIVERY[1] then
							if QuestInfo.npc == x207006_g_NameEnd and QuestInfo.item > 0 and QuestInfo.num > 0 then
								DelItem(sceneId,selfId,QuestInfo.item,QuestInfo.num)
							end								
						end
						if QuestInfo.comeitem > 0 and QuestInfo.comenum >0 then
							DelItem(sceneId,selfId,QuestInfo.comeitem,QuestInfo.comenum)
						end
					end							
					if QuestInfo.type ==  "COLLECT"  or QuestInfo.type ==  "COLLECT_SPECIAL" or QuestInfo.type ==  "MONSTER_ITEM" then
						DelItem(sceneId,selfId,QuestInfo.item,QuestInfo.num)
					end						
				end   
				MissionCom( sceneId,selfId, x207006_g_MissionId )
				if (x207006_g_ExpBonustxt~=nil) then
					LuaFnAddExp( sceneId, selfId,x207006_g_ExpBonus(sceneId, selfId, x207006_g_exp))
				end					
				if (x207006_g_MoneyBonustxt~=nil) then
					AddMoney(sceneId,selfId,x207006_g_MoneyBonus(sceneId, selfId, x207006_g_money) );
				end
				if (x207006_g_ItemBonus~=nil)or (x207006_g_RadioItemBonus~=nil) then
					AddItemListToHuman(sceneId,selfId)
				end
				if (x207006_g_ScriptIdNext.ScriptId~=nil) and (x207006_g_ScriptIdNext.ScriptId>0) then
					local CanNext = CallScriptFunction( x207006_g_ScriptIdNext.ScriptId, "CheckAccept",sceneId, selfId, targetId )
					if (CanNext == 1) then
						CallScriptFunction( x207006_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
					else
						BeginEvent(sceneId)
							AddText(sceneId,"等你到了"..x207006_g_ScriptIdNext.LV.."级再来找我，我还有很重要的事要交给你去做。千万记住了！")
						EndEvent( )	
						DispatchEventList(sceneId,selfId,targetId)
					end
				end
			end
		end
	end
end

--**********************************--杀死怪物或玩家--**********************************
function x207006_OnKillObject( sceneId, selfId, objdataId )
	x207006_g_QuestOrder(x207006_g_QuestType)
	local QuestPlace = 0	--子任务对应在之前SetMissionByIndex(sceneId,selfId,misIndex,j-1,0)时存在的位置,==j-1
	for i, QuestInfo in pairs(x207006_g_Quest) do
		if QuestInfo.type ==  "MONSTER_KILL" then	
			 if objdataId == QuestInfo.id then
				  local misIndex = GetMissionIndexByID(sceneId,selfId,x207006_g_MissionId)
				  num = GetMissionParam(sceneId,selfId,misIndex,QuestInfo.order-1)
				  if num < QuestInfo.num then						
				    SetMissionByIndex(sceneId,selfId,misIndex,QuestInfo.order-1,num+1)
				  	BeginEvent(sceneId)
					  	strText = format("已杀死  "..QuestInfo.name.."  %d/"..QuestInfo.num, GetMissionParam(sceneId,selfId,misIndex,QuestInfo.order-1) )
					  	AddText(sceneId,strText);
				  	EndEvent(sceneId)
					DispatchMissionTips(sceneId,selfId)
				  end
			 end
		end
		if QuestInfo.type ==  "MONSTER_ITEM" then
			if objdataId == QuestInfo.id then
				local monsteritemnum = LuaFnGetItemCount(sceneId,selfId,QuestInfo.item)
				if monsteritemnum < QuestInfo.num then
					if QuestInfo.per >= random(1,100) then
						local additemnum = random(QuestInfo.max)
						if (monsteritemnum + additemnum > QuestInfo.num ) then
							additemnum = QuestInfo.num - monsteritemnum
						end
						BeginAddItem(sceneId)
							AddItem( sceneId,QuestInfo.item, additemnum )
						ret = EndAddItem(sceneId,selfId)
						if ret > 0 then
								AddItemListToHuman(sceneId,selfId)
						else
							--任务奖励没有加成功
							BeginEvent(sceneId)
								strText = "背包已满,无法获得物品"
								AddText(sceneId,strText);
							EndEvent(sceneId)
							DispatchMissionTips(sceneId,selfId)
						end
					end
				end
			end
		end
	end
end

--**********************************--进入区域事件--**********************************
function x207006_OnEnterArea( sceneId, selfId, areaId )
	x207006_g_QuestOrder(x207006_g_QuestType)
	if IsHaveMission(sceneId,selfId,x207006_g_MissionId) > 0 then
		for i, QuestInfo in pairs(x207006_g_Quest) do
			if QuestInfo.type == "ENTERAREA" then
				if (areaId == QuestInfo.area) and (sceneId == QuestInfo.mapid) then 
					local misIndex = GetMissionIndexByID(sceneId,selfId,x207006_g_MissionId)
					if (GetMissionParam(sceneId,selfId,misIndex,QuestInfo.order-1) == 0) then
						SetMissionByIndex(sceneId,selfId,misIndex,QuestInfo.order-1,1)
						BeginEvent(sceneId)
							strText = QuestInfo.info.."    1/1"
							AddText(sceneId,strText);
						EndEvent(sceneId)
						DispatchMissionTips(sceneId,selfId)
					end
				end
			end
		end
	end
end

function x207006_OnTimer( sceneId, selfId )

end

function x207006_OnLeaveArea( sceneId, selfId )

end
--**********************************--道具改变--**********************************
function x207006_OnItemChanged( sceneId, selfId, itemdataId )
	x207006_g_QuestOrder(x207006_g_QuestType)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x207006_g_MissionId)
	for i, QuestInfo in pairs(x207006_g_Quest) do
		if QuestInfo.type == "COLLECT_SPECIAL" or QuestInfo.type == "COLLECT" or QuestInfo.type == "MONSTER_ITEM" then
			if (QuestInfo.item == itemdataId) then
				local questitemnum = LuaFnGetItemCount(sceneId,selfId,QuestInfo.item)
				if ( questitemnum >= 0 ) and ( questitemnum <= QuestInfo.num )then
					SetMissionByIndex(sceneId,selfId,misIndex,QuestInfo.order-1,questitemnum)
					BeginEvent(sceneId)
						strText = format("已获得  "..QuestInfo.name.."  %d/"..QuestInfo.num,questitemnum )
					 	AddText(sceneId,strText);
				 	EndEvent(sceneId)
					DispatchMissionTips(sceneId,selfId)
				end
			end
		end
	end
end
