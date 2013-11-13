--该脚本包含玩家接任务时的界面构建、任务相关内容定义、多任务目标的嵌入
--MisDescBegin
--当前脚本的索引号
x211047_g_ScriptId = 211047

--当前任务的MissionID，具体由专人负责分配，9开头的默认为是为测试任务分配的ID
x211047_g_MissionId = 386

--任务起始npc
x211047_g_Name	= "百夫长"

--任务归类
x211047_g_MissionKind = 1
x211047_g_MissionLevel = 4

--是否是精英任务
x211047_g_IfMissionElite = 0

--任务是否已经完成
x211047_g_IsMissionOkFail = 0		--变量的第0位

x211047_g_DemandKill ={}

--任务名称
x211047_g_MissionName="乱世的献媚"
--任务描述(接任务时，和所有目标完成交任务时)支持多条语句
x211047_g_MissionInfo={"秘制可乐鸡翅果然不赖啊，味道不错。我一个人也吃不玩，打铁铺的铁匠也很喜欢吃鸡翅的，你给他送点去，他一高兴，估计会送你一把称手的兵器的。"} 

x211047_g_MissionTarget="送秘制的可乐鸡翅给打铁匠"	

x211047_g_ContinueInfo={"这个鸡翅着实不错！"}  

x211047_g_MissionComplete=""

x211047_g_MoneyBonus=10000

--固定物品奖励，最多8种
x211047_g_ItemBonus={{id=12010003,num=5},{id=12010004,num=5}}

--可选物品奖励，最多8种
x211047_g_RadioItemBonus={{id=12010005,num=5},{id=12010006,num=5}}

--MisDescEnd

--任务提交npc
x211047_g_NameEnd	= "打铁匠"



--****************************************任务可接条件判断*************************************************************************
--任务可接等级范围
x211047_g_MissionMinLevel = 4
x211047_g_MissionMaxLevel = 200

--前置任务的MissionID,可以填写多个前置任务
x211047_g_MisIdPre = {385}

--需要后续任务在该任务结束后直接弹出，则填写下面的参数，否则不填写，只能填写一个后续任务
--ScriptId为后续任务的ScriptId。LV为后续任务的等级要求，要和ScriptId对应脚本里面的等级要求一致
x211047_g_ScriptIdNext = {ScriptId = 211043 ,LV = 5 }

--****************************************任务内容开始*********************************************************************


--任务目标类型(可以多任务目标)

--DELIVERY						--送信                        --npc为要送信给的对象,item为是否有任务物品要给送信对象,该item由任务发布人直接给予玩家; info为任务目标显示
x211047_g_DELIVERY = {{npc = "打铁匠",item = 12010005,num = 1,comeitem = 0,comenum = 0,info="送秘制的可乐鸡翅给打铁匠",dialog="这个鸡翅着实不错！",type="DELIVERY",order=0}}

--********************************任务目标的组合********************************
--*切记*****切记*****切记*******************************************************************************
--*********************一个任务的目标个数最多只能为8个,现在已经超出了,请修正*******************************
--********************任务目标为最小元素,比如杀3种怪,算作3个任务目标计算***********************************
--*切记*****切记*****切记********************************************************************
x211047_g_QuestType = {x211047_g_DELIVERY}
x211047_g_Quest = {}
x211047_g_QuestNum = 0

function  x211047_g_QuestOrder(QuestType)
	local count = 0
	for i, QuestLabel in pairs(QuestType) do
		for j, QuestInfo in pairs(QuestLabel) do
			count = count + 1
			QuestInfo.order = count
			x211047_g_Quest[count] = QuestInfo
		end
	end
	x211047_g_QuestNum = count
end
	
--任务奖励(exp为经验调节参数，money为金钱调节参数)
--经验奖励
x211047_g_ExpBonustxt = "经验  1000+等级×等级"
x211047_g_exp = 1

function x211047_g_ExpBonus(sceneId, selfId, exp)
	local LV = GetLevel( sceneId, selfId )
	local ExpBonus =8000
	return ExpBonus*x211047_g_exp
end

--金钱奖励
x211047_g_MoneyBonustxt = 10000
x211047_g_money = 1

function x211047_g_MoneyBonus(sceneId, selfId, money)
	local MoneyBonus=10000
	return MoneyBonus*x211047_g_money
end

--**********************************任务入口函数**********************************

function x211047_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	x211047_g_QuestOrder(x211047_g_QuestType)
    if IsHaveMission(sceneId,selfId,x211047_g_MissionId) > 0 then
		if (GetName(sceneId,targetId)==x211047_g_NameEnd) then
			local m = 0
			for i, QuestInfo in pairs(x211047_g_Quest) do
				if (QuestInfo.type == "DELIVERY") then
					if (getn(x211047_g_DELIVERY)==1) and (x211047_g_NameEnd == x211047_g_DELIVERY[1].npc) then	
						m = 2
					else
						m = 1
					end
				else
					m = 1
				end
			end
			if m == 1 then
				local Done = x211047_CheckSubmit( sceneId, selfId )
				BeginEvent(sceneId)
					if Done == 1 then
						x211047_ShowQuestInfo( sceneId, selfId, targetId , 1)
					else
						x211047_ShowQuestInfo( sceneId, selfId, targetId , 2)
					end
				EndEvent( )
				if (Done == 1) then
					DispatchMissionContinueInfo(sceneId,selfId,targetId,x211047_g_ScriptId,x211047_g_MissionId)
				else
					DispatchMissionDemandInfo(sceneId,selfId,targetId,x211047_g_ScriptId,x211047_g_MissionId,0)
				end
			elseif m == 2 then
				local Done = 0
				if x211047_g_DELIVERY[1].item > 0 and x211047_g_DELIVERY[1].num > 0 then
					if	(LuaFnGetItemCount(sceneId,selfId,x211047_g_DELIVERY[1].item)>=x211047_g_DELIVERY[1].num) then
						Done = 1						
					end
				else
					Done = 1
				end
				if Done == 1 then
					local misIndex = GetMissionIndexByID(sceneId,selfId,x211047_g_MissionId)
					for i, QuestInfo in pairs(x211047_g_Quest) do
						if (QuestInfo.type == "DELIVERY") then
							if (GetName(sceneId,targetId)==QuestInfo.npc)then
								SetMissionByIndex(sceneId,selfId,misIndex,QuestInfo.order-1,1)
							end
						end
					end
				end
				BeginEvent(sceneId)
					if Done == 1 then
						x211047_ShowQuestInfo( sceneId, selfId, targetId , 1)
					else
						x211047_ShowQuestInfo( sceneId, selfId, targetId , 2)
					end
				EndEvent( )
				if (Done == 1) then
					DispatchMissionContinueInfo(sceneId,selfId,targetId,x211047_g_ScriptId,x211047_g_MissionId)
				else
					DispatchMissionDemandInfo(sceneId,selfId,targetId,x211047_g_ScriptId,x211047_g_MissionId,0)
				end
			end
		elseif (x211047_g_DELIVERY ~= nil) then
			local n = 0 
			for i, QuestInfo in pairs(x211047_g_Quest) do
				if (QuestInfo.type == "DELIVERY") then
					n = 1
					break
				end
			end
			if  n == 1 then
				for i, DeliveryInfo in pairs(x211047_g_DELIVERY) do
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
							local misIndex = GetMissionIndexByID(sceneId,selfId,x211047_g_MissionId)
							for i, QuestInfo in pairs(x211047_g_Quest) do
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
								AddText(sceneId,x211047_g_Name.."让你带给我的东西在哪呢？")
							EndEvent( )	
							DispatchEventList(sceneId,selfId,targetId)
						end
					end
				end
			end
		end
    elseif x211047_CheckAccept(sceneId,selfId,targetId) > 0 then
		--满足任务可接条件，开始显示任务的相关内容
		BeginEvent(sceneId)
			x211047_ShowQuestInfo( sceneId, selfId, targetId ,0)
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x211047_g_ScriptId,x211047_g_MissionId)
    end	
end

--**********************************任务内容显示**********************************
function	x211047_ShowQuestInfo( sceneId, selfId, targetId ,Done)
	local DoneEX = Done
	AddText(sceneId,"#Y"..x211047_g_MissionName)
	if DoneEX==2 then
		for i, Info in pairs(x211047_g_ContinueInfo) do
			AddText(sceneId,Info)
		end
	else
		for i, Info in pairs(x211047_g_MissionInfo) do
			AddText(sceneId,Info)
		end
	end
	--AddText(sceneId,x211047_g_ExpBonustxt)
	AddText(sceneId,"#Y任务目标:")
	AddText(sceneId,x211047_g_MissionTarget)
	--多任务目标的显示
	if Done >= 1 then
		Done = 1
	end	
	--x211047_ShowQuestAim( sceneId, selfId, targetId,Done )	
	AddMoneyBonus( sceneId, x211047_g_MoneyBonustxt )
	if DoneEX == 2 then
	else
		if x211047_g_ItemBonus ~= nil then
			for i, item in pairs(x211047_g_ItemBonus) do
				AddItemBonus( sceneId, item.id, item.num )
			end
		end			
		if x211047_g_RadioItemBonus ~= nil then
			for i, item in pairs(x211047_g_RadioItemBonus) do
				AddRadioItemBonus( sceneId, item.id, item.num )
			end
		end
	end
end


--**********************************任务目标显示**********************************

function	x211047_ShowQuestAim( sceneId, selfId, targetId ,Done)
	x211047_g_QuestOrder(x211047_g_QuestType)
	if x211047_g_Quest ==nil then
		print("该任务没有绑目标!!!")
	else
		local Many = 0
		misIndex = GetMissionIndexByID(sceneId,selfId,x211047_g_MissionId)
		for i, QuestInfo in pairs(x211047_g_Quest) do

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
function x211047_OnEnumerate( sceneId, selfId, targetId )
	x211047_g_QuestOrder(x211047_g_QuestType) 	
    if IsMissionHaveDone(sceneId,selfId,x211047_g_MissionId) > 0 then
    	return 
    elseif IsHaveMission(sceneId,selfId,x211047_g_MissionId) > 0 then
    	local m = 0
    	for  i, QuestInfo in pairs(x211047_g_Quest) do
    		if QuestInfo.type == "DELIVERY" then
    			m = 1
    		end
    	end

    	if  (m == 1)  then
    		if  (GetName(sceneId,targetId)==x211047_g_NameEnd) then
    			AddNumText(sceneId,x211047_g_ScriptId,x211047_g_MissionName);
    		else
				for i, QuestInfo in pairs(x211047_g_Quest) do
					if QuestInfo.type == "DELIVERY" then
						if (GetName(sceneId,targetId)==QuestInfo.npc)then
					    	if x211047_CheckContinue(sceneId, selfId, targetId) == 1 then
								AddNumText(sceneId,x211047_g_ScriptId,x211047_g_MissionName);	
								break
							end
						end
					end
				end
			end
		elseif  (GetName(sceneId,targetId)==x211047_g_NameEnd) then
			AddNumText(sceneId,x211047_g_ScriptId,x211047_g_MissionName);
		end					
	--如果玩家满足任务可接条件,则显示这个任务
    elseif x211047_CheckAccept(sceneId,selfId,targetId) > 0 then
		AddNumText(sceneId,x211047_g_ScriptId,x211047_g_MissionName);
    end
end



--**********************************判断任务可接条件****************************************
--**********************************1、点击的当前NPC为任务接受NPC****************************
--**********************************2、满足等级范围需求、满足前续任务完成需求*****************

function x211047_CheckAccept( sceneId, selfId ,targetId )
	if (GetName(sceneId,targetId)==x211047_g_Name) then
		if (GetLevel( sceneId, selfId ) >= x211047_g_MissionMinLevel ) and (GetLevel( sceneId, selfId ) <= x211047_g_MissionMaxLevel ) then
			if	x211047_g_MisIdPre == nil then
				return	1
			else
				for i, questpre in pairs(x211047_g_MisIdPre) do
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

function x211047_CheckContinue( sceneId, selfId ,targetId )
	x211047_g_QuestOrder(x211047_g_QuestType)
	misIndex = GetMissionIndexByID(sceneId,selfId,x211047_g_MissionId)
	for i, QuestInfo in pairs(x211047_g_Quest) do
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
function x211047_OnAccept(sceneId, selfId )		
	x211047_g_QuestOrder(x211047_g_QuestType)
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
	for i, QuestInfo in pairs(x211047_g_Quest) do
		if QuestInfo.type == "MONSTER_KILL" then
			DoKill = 1
		elseif (QuestInfo.type == "DELIVERY") then
				DoItem = 1	
				local m = 0
				local ret = 1
				for i, QuestLableInfo in pairs(x211047_g_Quest) do
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
			if (x211047_g_PROTECTINFO == nil) then
				print("该护送任务没有配置相关的定时器!!!")
				return
			else
				if x211047_g_PROTECTINFO.Step > 2  then
					BeginEvent(sceneId)
						strText = "#Y现在不能接这个任务"
						AddText(sceneId,strText);
					EndEvent(sceneId)
					DispatchMissionTips(sceneId,selfId)
					return
				end
				
				-- 如果当前 
				if x211047_g_PROTECTINFO.Step == 0  then
					-- 开启护送剧情  
					-- 检测场景中是不是有这个人物了
					local nMonsterNum = GetMonsterCount(sceneId)
					local ii = 0
					local bHaveMonster = 0
					for ii=0, nMonsterNum-1 do
						local nMonsterId = GetMonsterObjID(sceneId,ii)
						for i, QuestInfo in pairs(x211047_g_Quest) do
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
						for i, QuestInfo in pairs(x211047_g_Quest) do
							if QuestInfo.type == "PROTECT"	then
								local nNpcId = LuaFnCreateMonster(sceneId,  QuestInfo.npc, QuestInfo.place.x, QuestInfo.place.z, QuestInfo.ai.baseai, QuestInfo.ai.scriptai, x211047_g_ScriptId)
								--SetCharacterName(sceneId, nNpcId, ProtectInfo.name)
								-- 设置小时时间是10分钟
								--SetCharacterDieTime(sceneId, nNpcId, 600000)
							end
						end
					end
					-- 把这个玩家加到护送玩家列表中
					x211047_g_PROTECTINFO.PlayerNum = 1
					x211047_g_PROTECTINFO.PlayerId[1] = selfId
			
					-- 启动一个场景计时器,每间隔3秒,回调一次OnScneneTimer函数
					x211047_g_PROTECTINFO.ScneneTimerIndex = SetTimer(sceneId, selfId, 211047, "OnScneneTimer", 1)
					x211047_g_PROTECTINFO.Step = 1
					--当前时间
					x211047_g_PROTECTINFO.StartTime = LuaFnGetCurrentTime()
				end
				
				-- 加入到这个护送的玩家
				if x211047_g_PROTECTINFO.Step == 2  then
					if x211047_g_PROTECTINFO.PlayerNum > 5  then
						--人满了
						return
					end
				
					x211047_g_PROTECTINFO.PlayerNum = x211047_g_PROTECTINFO.PlayerNum + 1
					x211047_g_PROTECTINFO.PlayerId[x211047_g_PROTECTINFO.PlayerNum] = selfId
				end
			end
		end
	end	
	--第5个参数表示是否回调OnKillObject	第6个参数表示是否回调OnEnterArea	第7个参数表示是否回调OnItemChange
	AddMission( sceneId,selfId, x211047_g_MissionId, x211047_g_ScriptId, DoKill, DoArea, DoItem )		--添加任务
	misIndex = GetMissionIndexByID(sceneId,selfId,x211047_g_MissionId)			--得到任务的序列号
	if x211047_g_QuestNum > 8 then
		print("一个任务的目标个数最多只能为8个,现在已经超出了,请修正")
		return
	end
	for j=1,x211047_g_QuestNum do
		SetMissionByIndex(sceneId,selfId,misIndex,j-1,0)	--根据序列号把任务变量的第0位置0
	end
	BeginEvent(sceneId)
	  	strText = "你接受了任务  "..x211047_g_MissionName
	  	AddText(sceneId,strText);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end

--**********************************
--放弃
--**********************************
function x211047_OnAbandon( sceneId, selfId )
	x211047_g_QuestOrder(x211047_g_QuestType)
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x211047_g_MissionId )
    for i, QuestInfo in pairs(x211047_g_Quest) do
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
	end    
end



--**********************************
--继续
--**********************************
function x211047_OnContinue( sceneId, selfId, targetId )

end

--**********************************
--检测是否可以提交
--**********************************
function x211047_CheckSubmit( sceneId, selfId )
	x211047_g_QuestOrder(x211047_g_QuestType)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x211047_g_MissionId)
	local bDone = 1
	for i, QuestInfo in pairs(x211047_g_Quest) do
		if QuestInfo.type == "DELIVERY" then
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
function x211047_OnSubmit( sceneId, selfId, targetId,selectRadioId )
	x211047_g_QuestOrder(x211047_g_QuestType)
	if (x211047_CheckSubmit( sceneId, selfId ) == 1) then
		BeginAddItem(sceneId)
		local givebonus = 0
		local giveitem = 0
		if (getn(x211047_g_ItemBonus) ==0)  and  (getn(x211047_g_RadioItemBonus) == 0 ) then
			givebonus = 1
		else
			for i, item in pairs(x211047_g_ItemBonus) do
				if item.id>0 and item.num>0 then
					AddItem( sceneId,item.id, item.num )
					giveitem = 1
				end
			end
			for i, item in pairs(x211047_g_RadioItemBonus) do
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
			ret = DelMission( sceneId, selfId, x211047_g_MissionId )
			if ret > 0 then
				for i, QuestInfo in pairs(x211047_g_Quest) do
					if QuestInfo.type ==  "DELIVERY" then
						if getn(x211047_g_DELIVERY) == 1 and QuestInfo == x211047_g_DELIVERY[1] then
							if QuestInfo.npc == x211047_g_NameEnd and QuestInfo.item > 0 and QuestInfo.num > 0 then
								DelItem(sceneId,selfId,QuestInfo.item,QuestInfo.num)
							end								
						end
						if QuestInfo.comeitem > 0 and QuestInfo.comenum >0 then
							DelItem(sceneId,selfId,QuestInfo.comeitem,QuestInfo.comenum)
						end
					end					
				end   
				MissionCom( sceneId,selfId, x211047_g_MissionId )
				if (x211047_g_ExpBonustxt~=nil) then
					LuaFnAddExp( sceneId, selfId,x211047_g_ExpBonus(sceneId, selfId, x211047_g_exp))
				end					
				if (x211047_g_MoneyBonustxt~=nil) then
					AddMoney(sceneId,selfId,x211047_g_MoneyBonus(sceneId, selfId, x211047_g_money) );
				end
				if giveitem > 0 then
					AddItemListToHuman(sceneId,selfId)
				end
				BeginEvent(sceneId)
				  	strText = "你完成了任务  "..x211047_g_MissionName
				  	AddText(sceneId,strText);
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				if (x211047_g_ScriptIdNext.ScriptId~=nil) and (x211047_g_ScriptIdNext.ScriptId>0) then
					local CanNext = CallScriptFunction( x211047_g_ScriptIdNext.ScriptId, "CheckAccept",sceneId, selfId, targetId )
					if (CanNext == 1) then
						CallScriptFunction( x211047_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
					else
						BeginEvent(sceneId)
							AddText(sceneId,"等你到了"..x211047_g_ScriptIdNext.LV.."级再来找我，我还有很重要的事要交给你去做。千万记住了！")
						EndEvent( )	
						DispatchEventList(sceneId,selfId,targetId)
					end
				end
			end
		end
	end
end

--**********************************--杀死怪物或玩家--**********************************
function x211047_OnKillObject( sceneId, selfId, objdataId )

end

--**********************************--进入区域事件--**********************************
function x211047_OnEnterArea( sceneId, selfId, areaId )

end

function x211047_OnTimer( sceneId, selfId )

end

function x211047_OnLeaveArea( sceneId, selfId )

end
--**********************************--道具改变--**********************************
function x211047_OnItemChanged( sceneId, selfId, itemdataId )
	x211047_g_QuestOrder(x211047_g_QuestType)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x211047_g_MissionId)
	for i, QuestInfo in pairs(x211047_g_Quest) do
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
