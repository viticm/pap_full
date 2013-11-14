--新手测试任务之礼物2—武器
--MisDescBegin
--当前脚本的索引号
x970005_g_ScriptId = 970005

--当前任务的MissionID，具体由专人负责分配，9开头的默认为是为测试任务分配的ID
x970005_g_MissionId = 975

--任务归类
x970005_g_MissionKind = 13
x970005_g_MissionLevel = 5

--任务起始npc
x970005_g_Name	= "时装店掌柜"

--任务提交npc
x970005_g_NameEnd	= "武器店掌柜"


--是否是精英任务
x970005_g_IfMissionElite = 0

--任务是否已经完成
x970005_g_IsMissionOkFail = 0		--变量的第0位

x970005_g_DemandItem ={}

--任务名称
x970005_g_MissionName="礼物2—武器"
--任务描述(接任务时，和所有目标完成交任务时)支持多条语句
x970005_g_MissionInfo={"#{quest_wuqi2}"} 

x970005_g_MissionTarget="去找#aB{27,106,3,杨柳村,武器店掌柜}[武器店掌柜]#aE取兵器一件"	

x970005_g_ContinueInfo={"已经拿到武器了？怎么没见你佩戴呢？"}  

x970005_g_MissionComplete="您这是第一次来吧，我们这里有最好的剑、最锋的刀、最利的枪。天下武器，应有尽有。照规矩，我们会送您一件武器，希望您会喜欢。"

x970005_g_MoneyBonus=10000

--可选物品奖励，最多8种
x970005_g_RadioItemBonus={{id=10011001,num=1},{id=10031001,num=1},{id=10051001,num=1},{id=10071001,num=1},{id=10091001,num=1},{id=10111001,num=1},{id=10131001,num=1},{id=10151001,num=1}}

--MisDescEnd


--****************************************任务可接条件判断*************************************************************************
--任务可接等级范围
x970005_g_MissionMinLevel = 1
x970005_g_MissionMaxLevel = 100

--前置任务的MissionID,可以填写多个前置任务
x970005_g_MisIdPre = {974}

--需要后续任务在该任务结束后直接弹出，则填写下面的参数，否则不填写，只能填写一个后续任务
--ScriptId为后续任务的ScriptId。LV为后续任务的等级要求，要和ScriptId对应脚本里面的等级要求一致
x970005_g_ScriptIdNext = {ScriptId = 970006 ,LV = 5 }

--****************************************任务内容开始*********************************************************************
--任务未完成时去交任务的提示文字 ，支持多条语句
x970005_g_UnDoneMissionInfo={"已经拿到趁手的武器了？怎么没见你佩戴呢？？？"}  
--总的大体任务目标描述，一句话描述
x970005_g_MissionAim="去武器店取趁手的武器"		
--任务目标类型(可以多任务目标)


--DELIVERY						--送信                        --npc为要送信给的对象,item为是否有任务物品要给送信对象,该item由任务发布人直接给予玩家; info为任务目标显示
x970005_g_DELIVERY = {{npc = "武器店掌柜",item = 0,num = 0,comeitem = 0,comenum = 0,info="您这是第一次来吧，照规矩，我们会送您一件武器。也希望您会喜欢。",type="DELIVERY",order=0}}

--********************************任务目标的组合********************************
--*切记*****切记*****切记*******************************************************************************
--*********************一个任务的目标个数最多只能为8个,现在已经超出了,请修正*******************************
--********************任务目标为最小元素,比如杀3种怪,算作3个任务目标计算***********************************
--*切记*****切记*****切记********************************************************************
x970005_g_QuestType = {x970005_g_DELIVERY}
x970005_g_Quest = {}
x970005_g_QuestNum = 0
x970005_MP_ISCOMPLETE = 7

function  x970005_g_QuestOrder(QuestType)
	local count = 0
	for i, QuestLabel in pairs(QuestType) do
		for j, QuestInfo in pairs(QuestLabel) do
			count = count + 1
			QuestInfo.order = count
			x970005_g_Quest[count] = QuestInfo
		end
	end
	x970005_g_QuestNum = count
end
	
--任务奖励(exp为经验调节参数，money为金钱调节参数)
--经验奖励
x970005_g_ExpBonustxt = "经验  1000+等级×等级"
x970005_g_exp = 1

function x970005_g_ExpBonus(sceneId, selfId, exp)
	local LV = GetLevel( sceneId, selfId )
	local ExpBonus =0
	return ExpBonus*x970005_g_exp
end

--金钱奖励
x970005_g_MoneyBonustxt = 10000
x970005_g_money = 1

function x970005_g_MoneyBonus(sceneId, selfId, money)
	local MoneyBonus=10000
	return MoneyBonus*x970005_g_money
end

--**********************************任务入口函数**********************************

function x970005_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	x970005_g_QuestOrder(x970005_g_QuestType)
    if IsHaveMission(sceneId,selfId,x970005_g_MissionId) > 0 then
		if (GetName(sceneId,targetId)==x970005_g_NameEnd) then
			local m = 0
			for i, QuestInfo in pairs(x970005_g_Quest) do
				if (QuestInfo.type == "DELIVERY") then
					if (#(x970005_g_DELIVERY)==1) and (x970005_g_NameEnd == x970005_g_DELIVERY[1].npc) then	
						m = 2
					else
						m = 1
					end
				else
					m = 1
				end
			end
			if m == 1 then
				local Done = x970005_CheckSubmit( sceneId, selfId )
				BeginEvent(sceneId)
					if Done == 1 then
						x970005_ShowQuestInfo( sceneId, selfId, targetId , 1)
					else
						x970005_ShowQuestInfo( sceneId, selfId, targetId , 2)
					end
				EndEvent( )
				if (Done == 1) then
					DispatchMissionContinueInfo(sceneId,selfId,targetId,x970005_g_ScriptId,x970005_g_MissionId)
				else
					DispatchMissionDemandInfo(sceneId,selfId,targetId,x970005_g_ScriptId,x970005_g_MissionId,0)
				end
			elseif m == 2 then
				local Done = 0
				if x970005_g_DELIVERY[1].item > 0 and x970005_g_DELIVERY[1].num > 0 then
					if	(LuaFnGetItemCount(sceneId,selfId,x970005_g_DELIVERY[1].item)>=x970005_g_DELIVERY[1].num) then
						Done = 1						
					end
				else
					Done = 1
				end
				if Done == 1 then
					local misIndex = GetMissionIndexByID(sceneId,selfId,x970005_g_MissionId)
					for i, QuestInfo in pairs(x970005_g_Quest) do
						if (QuestInfo.type == "DELIVERY") then
							if (GetName(sceneId,targetId)==QuestInfo.npc)then
								SetMissionByIndex(sceneId,selfId,misIndex,QuestInfo.order-1,1)
							end
						end
					end
				end
				BeginEvent(sceneId)
					if Done == 1 then
						x970005_ShowQuestInfo( sceneId, selfId, targetId , 1)
					else
						x970005_ShowQuestInfo( sceneId, selfId, targetId , 2)
					end
				EndEvent( )
				if (Done == 1) then
				  BeginEvent(sceneId)
             AddText(sceneId,"#Y"..x970005_g_MissionName)
		         AddText(sceneId,x970005_g_MissionComplete)
		      	   for i, item in pairs(x970005_g_RadioItemBonus) do
		              AddRadioItemBonus( sceneId, item.id, item.num )
		           end
		      EndEvent()
					DispatchMissionContinueInfo(sceneId,selfId,targetId,x970005_g_ScriptId,x970005_g_MissionId)
				else
					DispatchMissionDemandInfo(sceneId,selfId,targetId,x970005_g_ScriptId,x970005_g_MissionId,0)
				end
			end
		elseif (x970005_g_DELIVERY ~= nil) then
			local n = 0 
			for i, QuestInfo in pairs(x970005_g_Quest) do
				if (QuestInfo.type == "DELIVERY") then
					n = 1
					break
				end
			end
			if  n == 1 then
				for i, DeliveryInfo in pairs(x970005_g_DELIVERY) do
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
							local misIndex = GetMissionIndexByID(sceneId,selfId,x970005_g_MissionId)
							for i, QuestInfo in pairs(x970005_g_Quest) do
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
								AddText(sceneId,x970005_g_Name.."让你带给我的东西在哪呢？")
							EndEvent( )	
							DispatchEventList(sceneId,selfId,targetId)
						end
					end
				end
			end
		end
    elseif x970005_CheckAccept(sceneId,selfId,targetId) > 0 then
		--满足任务可接条件，开始显示任务的相关内容
		BeginEvent(sceneId)
			x970005_ShowQuestInfo( sceneId, selfId, targetId ,0)
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x970005_g_ScriptId,x970005_g_MissionId)
    end	
end

--**********************************任务内容显示**********************************
function	x970005_ShowQuestInfo( sceneId, selfId, targetId ,Done)
	local DoneEX = Done
	AddText(sceneId,"#Y"..x970005_g_MissionName)
	if DoneEX==2 then
		for i, Info in pairs(x970005_g_ContinueInfo) do
			AddText(sceneId,Info)
		end
	else
		for i, Info in pairs(x970005_g_MissionInfo) do
			AddText(sceneId,Info)
		end
	end
	--AddText(sceneId,x970005_g_ExpBonustxt)
	AddText(sceneId,"#Y任务目标:")
	AddText(sceneId,x970005_g_MissionTarget)
	--多任务目标的显示
	if Done >= 1 then
		Done = 1
	end	
	--x970005_ShowQuestAim( sceneId, selfId, targetId,Done )	
	AddMoneyBonus( sceneId, x970005_g_MoneyBonustxt )
	if DoneEX == 2 then
	else		
		if x970005_g_RadioItemBonus ~= nil then
			for i, item in pairs(x970005_g_RadioItemBonus) do
				AddRadioItemBonus( sceneId, item.id, item.num )
			end
		end
	end
end


--**********************************任务目标显示**********************************

function	x970005_ShowQuestAim( sceneId, selfId, targetId ,Done)
	x970005_g_QuestOrder(x970005_g_QuestType)
	if x970005_g_Quest ==nil then
		print("该任务没有绑目标!!!")
	else
		local Many = 0
		misIndex = GetMissionIndexByID(sceneId,selfId,x970005_g_MissionId)
		for i, QuestInfo in pairs(x970005_g_Quest) do

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
function x970005_OnEnumerate( sceneId, selfId, targetId )
	x970005_g_QuestOrder(x970005_g_QuestType) 	
    if IsMissionHaveDone(sceneId,selfId,x970005_g_MissionId) > 0 then
    	return 
    elseif IsHaveMission(sceneId,selfId,x970005_g_MissionId) > 0 then
    	local m = 0
    	for  i, QuestInfo in pairs(x970005_g_Quest) do
    		if QuestInfo.type == "DELIVERY" then
    			m = 1
    		end
    	end

    	if  (m == 1)  then
    		if  (GetName(sceneId,targetId)==x970005_g_NameEnd) then
    			AddNumText(sceneId,x970005_g_ScriptId,x970005_g_MissionName);
    		else
				for i, QuestInfo in pairs(x970005_g_Quest) do
					if QuestInfo.type == "DELIVERY" then
						if (GetName(sceneId,targetId)==QuestInfo.npc)then
					    	if x970005_CheckContinue(sceneId, selfId, targetId) == 1 then
								AddNumText(sceneId,x970005_g_ScriptId,x970005_g_MissionName);	
								break
							end
						end
					end
				end
			end
		elseif  (GetName(sceneId,targetId)==x970005_g_NameEnd) then
			AddNumText(sceneId,x970005_g_ScriptId,x970005_g_MissionName);
		end					
	--如果玩家满足任务可接条件,则显示这个任务
    elseif x970005_CheckAccept(sceneId,selfId,targetId) > 0 then
		AddNumText(sceneId,x970005_g_ScriptId,x970005_g_MissionName);
    end
end



--**********************************判断任务可接条件****************************************
--**********************************1、点击的当前NPC为任务接受NPC****************************
--**********************************2、满足等级范围需求、满足前续任务完成需求*****************

function x970005_CheckAccept( sceneId, selfId ,targetId )
	if (GetName(sceneId,targetId)==x970005_g_Name) then
		if (GetLevel( sceneId, selfId ) >= x970005_g_MissionMinLevel ) and (GetLevel( sceneId, selfId ) <= x970005_g_MissionMaxLevel ) then
			if	x970005_g_MisIdPre == nil then
				return	1
			else
				for i, questpre in pairs(x970005_g_MisIdPre) do
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

function x970005_CheckContinue( sceneId, selfId ,targetId )
	x970005_g_QuestOrder(x970005_g_QuestType)
	misIndex = GetMissionIndexByID(sceneId,selfId,x970005_g_MissionId)
	for i, QuestInfo in pairs(x970005_g_Quest) do
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
function x970005_OnAccept(sceneId, selfId )		
	x970005_g_QuestOrder(x970005_g_QuestType)
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
	for i, QuestInfo in pairs(x970005_g_Quest) do
		if QuestInfo.type == "MONSTER_KILL" then
			DoKill = 1
		elseif (QuestInfo.type == "DELIVERY") then
				DoItem = 1	
				local m = 0
				local ret = 1
				for i, QuestLableInfo in pairs(x970005_g_Quest) do
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
		end
	end	
	--第5个参数表示是否回调OnKillObject	第6个参数表示是否回调OnEnterArea	第7个参数表示是否回调OnItemChange
	AddMission( sceneId,selfId, x970005_g_MissionId, x970005_g_ScriptId, DoKill, DoArea, DoItem )		--添加任务
	misIndex = GetMissionIndexByID(sceneId,selfId,x970005_g_MissionId)			--得到任务的序列号
	if x970005_g_QuestNum > 8 then
		print("一个任务的目标个数最多只能为8个,现在已经超出了,请修正")
		return
	end
	for j=1,x970005_g_QuestNum do
		SetMissionByIndex(sceneId,selfId,misIndex,7,1)	--根据序列号把任务变量的第0位置0
	end
	BeginEvent(sceneId)
	  	strText = "你接受了任务  "..x970005_g_MissionName
	  	AddText(sceneId,strText);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end

--**********************************
--放弃
--**********************************
function x970005_OnAbandon( sceneId, selfId )
	x970005_g_QuestOrder(x970005_g_QuestType)
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x970005_g_MissionId )
    for i, QuestInfo in pairs(x970005_g_Quest) do
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
function x970005_OnContinue( sceneId, selfId, targetId )

end

--**********************************
--检测是否可以提交
--**********************************
function x970005_CheckSubmit( sceneId, selfId )
	x970005_g_QuestOrder(x970005_g_QuestType)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x970005_g_MissionId)
	local bDone = 1
	for i, QuestInfo in pairs(x970005_g_Quest) do
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
function x970005_OnSubmit( sceneId, selfId, targetId,selectRadioId )
	x970005_g_QuestOrder(x970005_g_QuestType)
	if (x970005_CheckSubmit( sceneId, selfId ) == 1) then
		BeginAddItem(sceneId)
		local givebonus = 0
		local giveitem = 0
		if #(x970005_g_RadioItemBonus) == 0  then
			givebonus = 1
		else
			for i, item in pairs(x970005_g_RadioItemBonus) do
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
			ret = DelMission( sceneId, selfId, x970005_g_MissionId )
			if ret > 0 then
				for i, QuestInfo in pairs(x970005_g_Quest) do
					if QuestInfo.type ==  "DELIVERY" then
						if #(x970005_g_DELIVERY) == 1 and QuestInfo == x970005_g_DELIVERY[1] then
							if QuestInfo.npc == x970005_g_NameEnd and QuestInfo.item > 0 and QuestInfo.num > 0 then
								DelItem(sceneId,selfId,QuestInfo.item,QuestInfo.num)
							end								
						end
						if QuestInfo.comeitem > 0 and QuestInfo.comenum >0 then
							DelItem(sceneId,selfId,QuestInfo.comeitem,QuestInfo.comenum)
						end
					end					
				end   
				MissionCom( sceneId,selfId, x970005_g_MissionId )
				if (x970005_g_ExpBonustxt~=nil) then
					LuaFnAddExp( sceneId, selfId,x970005_g_ExpBonus(sceneId, selfId, x970005_g_exp))
				end					
				if (x970005_g_MoneyBonustxt~=nil) then
					AddMoney(sceneId,selfId,x970005_g_MoneyBonus(sceneId, selfId, x970005_g_money) );
				end
				if giveitem > 0 then
					AddItemListToHuman(sceneId,selfId)
				end
				BeginEvent(sceneId)
				  	strText = "你完成了任务  "..x970005_g_MissionName
				  	AddText(sceneId,strText);
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				if (x970005_g_ScriptIdNext.ScriptId~=nil) and (x970005_g_ScriptIdNext.ScriptId>0) then
					local CanNext = CallScriptFunction( x970005_g_ScriptIdNext.ScriptId, "CheckAccept",sceneId, selfId, targetId )
					if (CanNext == 1) then
						CallScriptFunction( x970005_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
					else
						BeginEvent(sceneId)
							AddText(sceneId,"")
						EndEvent( )	
						DispatchEventList(sceneId,selfId,targetId)
					end
				end
			end
		end
	end
end

--**********************************--杀死怪物或玩家--**********************************
function x970005_OnKillObject( sceneId, selfId, objdataId )

end

--**********************************--进入区域事件--**********************************
function x970005_OnEnterArea( sceneId, selfId, areaId )

end

function x970005_OnTimer( sceneId, selfId )

end

function x970005_OnLeaveArea( sceneId, selfId )

end
--**********************************--道具改变--**********************************
function x970005_OnItemChanged( sceneId, selfId, itemdataId )
	x970005_g_QuestOrder(x970005_g_QuestType)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x970005_g_MissionId)
	for i, QuestInfo in pairs(x970005_g_Quest) do
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
