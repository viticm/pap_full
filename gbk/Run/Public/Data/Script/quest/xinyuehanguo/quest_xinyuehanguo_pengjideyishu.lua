--该脚本包含玩家接任务时的界面构建、任务相关内容定义、多任务目标的嵌入
--MisDescBegin
--当前脚本的索引号
x211046_g_ScriptId = 211046

--当前任务的MissionID，具体由专人负责分配，9开头的默认为是为测试任务分配的ID
x211046_g_MissionId = 385

--任务起始npc
x211046_g_Name	="我是任务NPC"

--任务归类
x211046_g_MissionKind = 1
x211046_g_MissionLevel = 3

--是否是精英任务
x211046_g_IfMissionElite = 0

--任务是否已经完成
x211046_g_IsMissionOkFail = 0		--变量的第0位

x211046_g_DemandKill ={}

--任务名称
x211046_g_MissionName="武侠世界2测试之貳"
--任务描述(接任务时，和所有目标完成交任务时)支持多条语句
x211046_g_MissionInfo={"拿回东西。恩"} 

x211046_g_MissionTarget="帮他拿回想要的东西"	

x211046_g_ContinueInfo={"还没搞到手啊？测试任务都完不成！"}  

x211046_g_MissionComplete="还可以啊！不错不错。"

x211046_g_MoneyBonus=10000

--固定物品奖励，最多8种
x211046_g_ItemBonus={{id=12010003,num=5},{id=12010004,num=5}}

--可选物品奖励，最多8种
x211046_g_RadioItemBonus={{id=12010005,num=5},{id=12010006,num=5}}

--MisDescEnd

--任务提交npc
x211046_g_NameEnd	= "我是任务NPC"



--****************************************任务可接条件判断*************************************************************************
--任务可接等级范围
x211046_g_MissionMinLevel = 3
x211046_g_MissionMaxLevel = 200

--前置任务的MissionID,可以填写多个前置任务
x211046_g_MisIdPre = {384}

--需要后续任务在该任务结束后直接弹出，则填写下面的参数，否则不填写，只能填写一个后续任务
--ScriptId为后续任务的ScriptId。LV为后续任务的等级要求，要和ScriptId对应脚本里面的等级要求一致
x211046_g_ScriptIdNext = {ScriptId = 211047 ,LV = 4 }

--****************************************任务内容开始*********************************************************************


--任务目标类型(可以多任务目标)

--COLLECT						--收集物品                    --item为采集的物品类型,name为道具名称,num为需求道具个数
x211046_g_COLLECT = {{item=12010001,name="红图1级红药",num=2,type="COLLECT",order=0}}

--********************************任务目标的组合********************************
--*切记*****切记*****切记*******************************************************************************
--*********************一个任务的目标个数最多只能为8个,现在已经超出了,请修正*******************************
--********************任务目标为最小元素,比如杀3种怪,算作3个任务目标计算***********************************
--*切记*****切记*****切记********************************************************************
x211046_g_QuestType = {x211046_g_COLLECT}
x211046_g_Quest = {}
x211046_g_QuestNum = 0

function  x211046_g_QuestOrder(QuestType)
	local count = 0
	for i, QuestLabel in pairs(QuestType) do
		for j, QuestInfo in pairs(QuestLabel) do
			count = count + 1
			QuestInfo.order = count
			x211046_g_Quest[count] = QuestInfo
		end
	end
	x211046_g_QuestNum = count
end
	
--任务奖励(exp为经验调节参数，money为金钱调节参数)
--经验奖励
x211046_g_ExpBonustxt = "经验  1000+等级×等级"
x211046_g_exp = 1

function x211046_g_ExpBonus(sceneId, selfId, exp)
	local LV = GetLevel( sceneId, selfId )
	local ExpBonus =7000
	return ExpBonus*x211046_g_exp
end

--金钱奖励
x211046_g_MoneyBonustxt = 10000
x211046_g_money = 1

function x211046_g_MoneyBonus(sceneId, selfId, money)
	local MoneyBonus=10000
	return MoneyBonus*x211046_g_money
end

--**********************************任务入口函数**********************************

function x211046_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	x211046_g_QuestOrder(x211046_g_QuestType)
    if IsHaveMission(sceneId,selfId,x211046_g_MissionId) > 0 then
		if (GetName(sceneId,targetId)==x211046_g_NameEnd) then
			local m = 0
			for i, QuestInfo in pairs(x211046_g_Quest) do
				if (QuestInfo.type == "DELIVERY") then
					if (#(x211046_g_DELIVERY)==1) and (x211046_g_NameEnd == x211046_g_DELIVERY[1].npc) then	
						m = 2
					else
						m = 1
					end
				else
					m = 1
				end
			end
			if m == 1 then
				local Done = x211046_CheckSubmit( sceneId, selfId )
				BeginEvent(sceneId)
					if Done == 1 then
						x211046_ShowQuestInfo( sceneId, selfId, targetId , 1)
					else
						x211046_ShowQuestInfo( sceneId, selfId, targetId , 2)
					end
				EndEvent( )
				if (Done == 1) then
					DispatchMissionContinueInfo(sceneId,selfId,targetId,x211046_g_ScriptId,x211046_g_MissionId)
				else
					DispatchMissionDemandInfo(sceneId,selfId,targetId,x211046_g_ScriptId,x211046_g_MissionId,0)
				end
			elseif m == 2 then
				local Done = 0
				if x211046_g_DELIVERY[1].item > 0 and x211046_g_DELIVERY[1].num > 0 then
					if	(LuaFnGetItemCount(sceneId,selfId,x211046_g_DELIVERY[1].item)>=x211046_g_DELIVERY[1].num) then
						Done = 1						
					end
				else
					Done = 1
				end
				if Done == 1 then
					local misIndex = GetMissionIndexByID(sceneId,selfId,x211046_g_MissionId)
					for i, QuestInfo in pairs(x211046_g_Quest) do
						if (QuestInfo.type == "DELIVERY") then
							if (GetName(sceneId,targetId)==QuestInfo.npc)then
								SetMissionByIndex(sceneId,selfId,misIndex,QuestInfo.order-1,1)
							end
						end
					end
				end
				BeginEvent(sceneId)
					if Done == 1 then
						x211046_ShowQuestInfo( sceneId, selfId, targetId , 1)
					else
						x211046_ShowQuestInfo( sceneId, selfId, targetId , 2)
					end
				EndEvent( )
				if (Done == 1) then
					DispatchMissionContinueInfo(sceneId,selfId,targetId,x211046_g_ScriptId,x211046_g_MissionId)
				else
					DispatchMissionDemandInfo(sceneId,selfId,targetId,x211046_g_ScriptId,x211046_g_MissionId,0)
				end
			end
		elseif (x211046_g_DELIVERY ~= nil) then
			local n = 0 
			for i, QuestInfo in pairs(x211046_g_Quest) do
				if (QuestInfo.type == "DELIVERY") then
					n = 1
					break
				end
			end
			if  n == 1 then
				for i, DeliveryInfo in pairs(x211046_g_DELIVERY) do
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
							local misIndex = GetMissionIndexByID(sceneId,selfId,x211046_g_MissionId)
							for i, QuestInfo in pairs(x211046_g_Quest) do
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
								AddText(sceneId,x211046_g_Name.."让你带给我的东西在哪呢？")
							EndEvent( )	
							DispatchEventList(sceneId,selfId,targetId)
						end
					end
				end
			end
		end
    elseif x211046_CheckAccept(sceneId,selfId,targetId) > 0 then
		--满足任务可接条件，开始显示任务的相关内容
		BeginEvent(sceneId)
			x211046_ShowQuestInfo( sceneId, selfId, targetId ,0)
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x211046_g_ScriptId,x211046_g_MissionId)
    end	
end

--**********************************任务内容显示**********************************
function	x211046_ShowQuestInfo( sceneId, selfId, targetId ,Done)
	local DoneEX = Done
	AddText(sceneId,"#Y"..x211046_g_MissionName)
	if DoneEX==2 then
		for i, Info in pairs(x211046_g_ContinueInfo) do
			AddText(sceneId,Info)
		end
	else
		for i, Info in pairs(x211046_g_MissionInfo) do
			AddText(sceneId,Info)
		end
	end
	--AddText(sceneId,x211046_g_ExpBonustxt)
	AddText(sceneId,"#Y任务目标:")
	AddText(sceneId,x211046_g_MissionTarget)
	--多任务目标的显示
	if Done >= 1 then
		Done = 1
	end	
	x211046_ShowQuestAim( sceneId, selfId, targetId,Done )	
	AddMoneyBonus( sceneId, x211046_g_MoneyBonustxt )
	if DoneEX == 2 then
	else
		if x211046_g_ItemBonus ~= nil then
			for i, item in pairs(x211046_g_ItemBonus) do
				AddItemBonus( sceneId, item.id, item.num )
			end
		end			
		if x211046_g_RadioItemBonus ~= nil then
			for i, item in pairs(x211046_g_RadioItemBonus) do
				AddRadioItemBonus( sceneId, item.id, item.num )
			end
		end
	end
end


--**********************************任务目标显示**********************************

function	x211046_ShowQuestAim( sceneId, selfId, targetId ,Done)
	x211046_g_QuestOrder(x211046_g_QuestType)
	if x211046_g_Quest ==nil then
		print("该任务没有绑目标!!!")
	else
		local Many = 0
		misIndex = GetMissionIndexByID(sceneId,selfId,x211046_g_MissionId)
		for i, QuestInfo in pairs(x211046_g_Quest) do

			if   (QuestInfo.type == "COLLECT") then
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
			end
		end
	end
end

--**********************************判断任务是否显示**********************************
function x211046_OnEnumerate( sceneId, selfId, targetId )
	x211046_g_QuestOrder(x211046_g_QuestType) 	
    if IsMissionHaveDone(sceneId,selfId,x211046_g_MissionId) > 0 then
    	return 
    elseif IsHaveMission(sceneId,selfId,x211046_g_MissionId) > 0 then
    	local m = 0
    	for  i, QuestInfo in pairs(x211046_g_Quest) do
    		if QuestInfo.type == "DELIVERY" then
    			m = 1
    		end
    	end
    	if  (m == 1)  then
    		if  (GetName(sceneId,targetId)==x211046_g_NameEnd) then
    			AddNumText(sceneId,x211046_g_ScriptId,x211046_g_MissionName);
    		else
				for i, QuestInfo in pairs(x211046_g_Quest) do
					if QuestInfo.type == "DELIVERY" then
						if (GetName(sceneId,targetId)==QuestInfo.npc)then
					    	if x211046_CheckContinue(sceneId, selfId, targetId) == 1 then
								AddNumText(sceneId,x211046_g_ScriptId,x211046_g_MissionName);	
								break
							end
						end
					end
				end
			end
		elseif  (GetName(sceneId,targetId)==x211046_g_NameEnd) then
			AddNumText(sceneId,x211046_g_ScriptId,x211046_g_MissionName);
		end					
	--如果玩家满足任务可接条件,则显示这个任务
    elseif x211046_CheckAccept(sceneId,selfId,targetId) > 0 then
		AddNumText(sceneId,x211046_g_ScriptId,x211046_g_MissionName);
    end
end



--**********************************判断任务可接条件****************************************
--**********************************1、点击的当前NPC为任务接受NPC****************************
--**********************************2、满足等级范围需求、满足前续任务完成需求*****************

function x211046_CheckAccept( sceneId, selfId ,targetId )
	if (GetName(sceneId,targetId)==x211046_g_Name) then
		if (GetLevel( sceneId, selfId ) >= x211046_g_MissionMinLevel ) and (GetLevel( sceneId, selfId ) <= x211046_g_MissionMaxLevel ) then
			if	x211046_g_MisIdPre == nil then
				return	1
			else
				for i, questpre in pairs(x211046_g_MisIdPre) do
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

function x211046_CheckContinue( sceneId, selfId ,targetId )
	x211046_g_QuestOrder(x211046_g_QuestType)
	misIndex = GetMissionIndexByID(sceneId,selfId,x211046_g_MissionId)
	for i, QuestInfo in pairs(x211046_g_Quest) do
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
function x211046_OnAccept(sceneId, selfId )		
	x211046_g_QuestOrder(x211046_g_QuestType)
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
	for i, QuestInfo in pairs(x211046_g_Quest) do
		if QuestInfo.type == "COLLECT"	then			--收集物品
				DoItem = 1
		end
	end	
	--第5个参数表示是否回调OnKillObject	第6个参数表示是否回调OnEnterArea	第7个参数表示是否回调OnItemChange
	AddMission( sceneId,selfId, x211046_g_MissionId, x211046_g_ScriptId, DoKill, DoArea, DoItem )		--添加任务
	misIndex = GetMissionIndexByID(sceneId,selfId,x211046_g_MissionId)			--得到任务的序列号
	if x211046_g_QuestNum > 8 then
		print("一个任务的目标个数最多只能为8个,现在已经超出了,请修正")
		return
	end
	for j=1,x211046_g_QuestNum do
		--检查是否可以
		local initNum 
		initNum = LuaFnGetItemCount(sceneId,selfId,x211046_g_COLLECT[j].item)
		SetMissionByIndex(sceneId,selfId,misIndex,j-1,initNum)	--根据背包里的值修改个数
	end
	BeginEvent(sceneId)
	  	strText = "你接受了任务  "..x211046_g_MissionName
	  	AddText(sceneId,strText);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end

--**********************************
--放弃
--**********************************
function x211046_OnAbandon( sceneId, selfId )
	x211046_g_QuestOrder(x211046_g_QuestType)
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x211046_g_MissionId )
end

--**********************************--场景计时器--**********************************
function x211046_OnScneneTimer(sceneId, selfId)
	x211046_g_QuestOrder(x211046_g_QuestType)
	local bHavePlayer = 0
	-- 等待5秒进入2
	if x211046_g_PROTECTINFO.Step == 1   then
		-- 通知自己队伍的其他玩家接这个任务
		local nMonsterNum = GetMonsterCount(sceneId)
		local m = 0
		local HeadNPCID = 0
		local bHaveMonster = 0
		for m=0, nMonsterNum-1 do
			local nMonsterId = GetMonsterObjID(sceneId,m)
			if GetName(sceneId, nMonsterId)  == x211046_g_Name  then
				HeadNPCID = nMonsterId
				bHaveMonster = 1
			end
		end
		local nTeamCount = GetNearTeamCount(sceneId, selfId)
		for i=0, nTeamCount-1 do
			local PlayerId = GetNearTeamMember(sceneId, selfId, i)
			if PlayerId ~= selfId    then
				CallScriptFunction((211046), "OnDefaultEvent", sceneId, PlayerId, HeadNPCID )
			end
		end
		x211046_g_PROTECTINFO.Step = 2
	end
	-- 开始等待别的玩家来一起做这个任务,10秒钟时间
	if x211046_g_PROTECTINFO.Step == 2   then
		if LuaFnGetCurrentTime() - x211046_g_PROTECTINFO.StartTime >= 10   then
			x211046_g_PROTECTINFO.Step = 3
		end
	end
	-- 有玩家点击了开始护送
	if x211046_g_PROTECTINFO.Step == 3   then
		local nMonsterNum = GetMonsterCount(sceneId)
		local ii = 0
		local bHaveMonster = 0
		for ii=0, nMonsterNum-1 do
			local nMonsterId = GetMonsterObjID(sceneId,ii)
			for j, ProtectInfo in pairs(x211046_g_PROTECT) do
				if GetName(sceneId, nMonsterId)  ==  ProtectInfo.name then
					bHaveMonster = bHaveMonster + 1
					x211046_g_ProtectNPCID[j] = nMonsterId
				end
			end
		end
		if bHaveMonster == #(x211046_g_PROTECT)  then
			for j, ProtectInfo in pairs(x211046_g_PROTECT) do
				SetPatrolId(sceneId, x211046_g_ProtectNPCID[j], ProtectInfo.patrol)
			end
			x211046_g_PROTECTINFO.Step = 4
		end
	end
	-- 护送过程
	if x211046_g_PROTECTINFO.Step == 4   then
		local nMonsterNum = GetMonsterCount(sceneId)
		local ii = 0
		local bHaveMonster = 0

		local bDone = 0
		for ii=0, nMonsterNum-1   do
			local nMonsterId = GetMonsterObjID(sceneId,ii)
			for j, ProtectInfo in pairs(x211046_g_PROTECT) do
				if GetName(sceneId, nMonsterId)  ==  ProtectInfo.name then
					bHaveMonster = bHaveMonster + 1
					x211046_g_ProtectNPCID[j] = nMonsterId
				end
			end
		end
		if bHaveMonster < #(x211046_g_PROTECT)   then
			-- 关闭计时器
			x211046_CloseTimer(sceneId, x211046_g_PROTECTINFO.ScneneTimerIndex)
			return
		end
		for j, NpcID in pairs(x211046_g_ProtectNPCID) do 
			-- 检测ProtectNPC 和玩家之间的距离
			local targetX, targetZ = GetWorldPos(sceneId, NpcID)
			-- 检测如果玩家的距离已经离开的场景或者玩家不在护送对象10米内，这个玩家失败
			for i=1, x211046_g_PROTECTINFO.PlayerNum  do
				if x211046_g_PROTECTINFO.PlayerId[i] ~= 0  then
					local nPlayerX, nPlayerZ = GetWorldPos(sceneId, x211046_g_PROTECTINFO.PlayerId[i])
					local distance1 = floor(sqrt((targetX-nPlayerX)*(targetX-nPlayerX)+(targetZ-nPlayerZ)*(targetZ-nPlayerZ)))
					
					if distance1 > 20    then
						--提示这个玩家任务失败
						BeginEvent(sceneId)
							strText = x211046_g_MissionName.."  失败"
							AddText(sceneId,strText);
						EndEvent(sceneId)
						DispatchMissionTips(sceneId,x211046_g_PROTECTINFO.PlayerId[i])
						-- 从列表中删除这个玩家
						x211046_g_PROTECTINFO.PlayerId[i] = 0
					end
				end
			end
		end	
		for j, ProtectInfo in pairs(x211046_g_PROTECT) do
			for j, NpcID in pairs(x211046_g_ProtectNPCID) do 
				if  GetName(sceneId, NpcID)==ProtectInfo.name  then		
					local targetX, targetZ = GetWorldPos(sceneId, NpcID)
					--local x, z = GetLastPatrolPoint(sceneId, ProtectInfo.patrol)
					local x,z =18,139
					local distance = floor(sqrt((targetX-x)*(targetX-x)+(targetZ-z)*(targetZ-z)))
					-- 到达终点
					if distance<=1  then
						for i=1, x211046_g_PROTECTINFO.PlayerNum  do
							if x211046_g_PROTECTINFO.PlayerId[i]~=0   then
								-- 检测玩家是不是有这个任务
								if IsHaveMission(sceneId,x211046_g_PROTECTINFO.PlayerId[i],x211046_g_MissionId) > 0 then
									local misIndex = GetMissionIndexByID(sceneId, x211046_g_PROTECTINFO.PlayerId[i], x211046_g_MissionId)
									for i, QuestInfo in pairs(x211046_g_Quest) do
										if QuestInfo.type == "PROTECT" then
											SetMissionByIndex(sceneId,x211046_g_PROTECTINFO.PlayerId[i],misIndex,QuestInfo.order-1,1)
										end
									end
									BeginEvent(sceneId)
										strText = ProtectInfo.info.."  1/1"
										AddText(sceneId,strText);
									EndEvent(sceneId)
									DispatchMissionTips(sceneId,x211046_g_PROTECTINFO.PlayerId[i])
								end
							end
						end
						RemoveMonster(sceneId, NpcID)
						bDone = bDone + 1
					end								
				end
			end
		end
		if (bDone >= #(x211046_g_PROTECT)) then
			x211046_g_PROTECTINFO.Step = 5
			-- 关闭计时器
			x211046_CloseTimer(sceneId, x211046_g_PROTECTINFO.ScneneTimerIndex)
		end
	end
end

--**********************************
--关闭计时器
--**********************************
function x211046_CloseTimer( sceneId, TimerIndex )
	StopTimer(sceneId, TimerIndex)
	x211046_g_PROTECTINFO.ScneneTimerIndex = -1
	x211046_g_PROTECTINFO.Step = 0
	x211046_g_PROTECTINFO.StartTime = 0
	x211046_g_PROTECTINFO.PlayerNum = 0
	for i =1, #(x211046_g_PROTECTINFO.PlayerId) do
		x211046_g_PROTECTINFO.PlayerId[i]=0
	end
	x211046_g_ProtectNPCID = {}
end

--**********************************
--继续
--**********************************
function x211046_OnContinue( sceneId, selfId, targetId )

end

--**********************************
--检测是否可以提交
--**********************************
function x211046_CheckSubmit( sceneId, selfId )
	x211046_g_QuestOrder(x211046_g_QuestType)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x211046_g_MissionId)
	local bDone = 1
	for i, QuestInfo in pairs(x211046_g_Quest) do
		if  QuestInfo.type == "COLLECT"  then
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
function x211046_OnSubmit( sceneId, selfId, targetId,selectRadioId )
	x211046_g_QuestOrder(x211046_g_QuestType)
	if (x211046_CheckSubmit( sceneId, selfId ) == 1) then
		BeginAddItem(sceneId)
		local givebonus = 0
		local giveitem = 0
		if (#(x211046_g_ItemBonus) ==0)  and  (#(x211046_g_RadioItemBonus) == 0 ) then
			givebonus = 1
		else
			for i, item in pairs(x211046_g_ItemBonus) do
				if item.id>0 and item.num>0 then
					AddItem( sceneId,item.id, item.num )
					giveitem = 1
				end
			end
			for i, item in pairs(x211046_g_RadioItemBonus) do
				if item.id == selectRadioId and item.num > 0 and item.id > 0 then
					AddItem( sceneId,item.id, item.num )
					giveitem = 1
				end
			end
			if giveitem == 1 then
				giveitem = EndAddItem(sceneId,selfId)
			end
		end				
		if (giveitem<=0) and (givebonus==0)  then
			--任务奖励没有加成功
			BeginEvent(sceneId)
				strText = "物品栏已满，请整理下再来！"
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		else
			ret = DelMission( sceneId, selfId, x211046_g_MissionId )
			if ret > 0 then
				for i, QuestInfo in pairs(x211046_g_Quest) do	
					if QuestInfo.type ==  "COLLECT"   then
						DelItem(sceneId,selfId,QuestInfo.item,QuestInfo.num)
					end						
				end   
				MissionCom( sceneId,selfId, x211046_g_MissionId )
				if (x211046_g_ExpBonustxt~=nil) then
					LuaFnAddExp( sceneId, selfId,x211046_g_ExpBonus(sceneId, selfId, x211046_g_exp))
				end					
				if (x211046_g_MoneyBonustxt~=nil) then
					AddMoney(sceneId,selfId,x211046_g_MoneyBonus(sceneId, selfId, x211046_g_money) );
				end
				if giveitem > 0 then
					AddItemListToHuman(sceneId,selfId)
				end
				BeginEvent(sceneId)
				  	strText = "你完成了任务  "..x211046_g_MissionName
				  	AddText(sceneId,strText);
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				if (x211046_g_ScriptIdNext.ScriptId~=nil) and (x211046_g_ScriptIdNext.ScriptId>0) then
					local CanNext = CallScriptFunction( x211046_g_ScriptIdNext.ScriptId, "CheckAccept",sceneId, selfId, targetId )
					if (CanNext == 1) then
						CallScriptFunction( x211046_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
					else
						BeginEvent(sceneId)
							AddText(sceneId,"等你到了"..x211046_g_ScriptIdNext.LV.."级再来找我，我还有很重要的事要交给你去做。千万记住了！")
						EndEvent( )	
						DispatchEventList(sceneId,selfId,targetId)
					end
				end
			end
		end
	end
end

--**********************************--杀死怪物或玩家--**********************************
function x211046_OnKillObject( sceneId, selfId, objdataId )
	x211046_g_QuestOrder(x211046_g_QuestType)
	local QuestPlace = 0	--子任务对应在之前SetMissionByIndex(sceneId,selfId,misIndex,j-1,0)时存在的位置,==j-1
	for i, QuestInfo in pairs(x211046_g_Quest) do
		if QuestInfo.type ==  "MONSTER_KILL" then	
			 if objdataId == QuestInfo.id then
				  local misIndex = GetMissionIndexByID(sceneId,selfId,x211046_g_MissionId)
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
function x211046_OnEnterArea( sceneId, selfId, areaId )
	x211046_g_QuestOrder(x211046_g_QuestType)
	if IsHaveMission(sceneId,selfId,x211046_g_MissionId) > 0 then
		for i, QuestInfo in pairs(x211046_g_Quest) do
			if QuestInfo.type == "ENTERAREA" then
				if (areaId == QuestInfo.area) and (sceneId == QuestInfo.mapid) then 
					local misIndex = GetMissionIndexByID(sceneId,selfId,x211046_g_MissionId)
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

function x211046_OnTimer( sceneId, selfId )

end

function x211046_OnLeaveArea( sceneId, selfId )

end
--**********************************--道具改变--**********************************
function x211046_OnItemChanged( sceneId, selfId, itemdataId )
	x211046_g_QuestOrder(x211046_g_QuestType)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x211046_g_MissionId)
	for i, QuestInfo in pairs(x211046_g_Quest) do
		if QuestInfo.type == "COLLECT"  then
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
