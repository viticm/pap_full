--新手测试任务之  遭遇强敌
--MisDescBegin
--当前脚本的索引号
x970019_g_ScriptId = 970019

--当前任务的MissionID，具体由专人负责分配，9开头的默认为是为测试任务分配的ID
x970019_g_MissionId = 989

--任务归类
x970019_g_MissionKind = 1
x970019_g_MissionLevel = 8

--任务起始npc
x970019_g_NameHead	= "黑衣人"

--任务提交npc
x970019_g_NameEnd	= "黑衣人"

--任务是否已经完成
x970019_g_IsMissionOkFail = 0		--变量的第0位
x970019_g_IfMissionElite = 0

x970019_g_DemandKill ={{id=9103,num=1}}

x970019_g_MissionName="遭遇强敌"

--任务描述(接任务时，和所有目标完成交任务时)支持多条语句
x970019_g_MissionInfo={"又一个不知死活的！唉，愚蠢的人啊！\n我实在懒得和你这样的白丁多言,如果你真想和我说话，先打败我新抓回来的傻熊吧;否则，免开尊口。"} 

x970019_g_MissionTarget="杀掉#aB{236,39,3,杨柳村}[巨熊]#aE,然后回去找#aB{214,37,3,杨柳村,黑衣人}[黑衣人]#aE"	

x970019_g_ContinueInfo={"连蠢熊都打不赢，你居然还敢过来？回去吧，这样轻易的让你消失不是我的作风。 "}

x970019_g_MissionComplete={"看来有两下子。不过，那些熊也够蠢的，赢了不足为怪。"}

x970019_g_MoneyBonus=10000
x970019_g_ItemBonus={{id=12010003,num=2},{id=12010004,num=2}}
--MisDescEnd

--****************************************任务可接条件判断*************************************************************************
--任务可接等级范围
x970019_g_MissionMinLevel = 1
x970019_g_MissionMaxLevel = 100

--前置任务的MissionID,可以填写多个前置任务
x970019_g_MisIdPre = {988}

--需要后续任务在该任务结束后直接弹出，则填写下面的参数，否则不填写，只能填写一个后续任务
x970019_g_ScriptIdNext = {ScriptId = 211042 ,LV = 1 }


--****************************************任务内容开始*********************************************************************
--任务名称
x970019_g_MissionName="遭遇强敌"
--任务未完成时去交任务的提示文字 ，支持多条语句
x970019_g_UnDoneMissionInfo={"连蠢熊都打不赢，你居然还敢过来？回去吧，这样轻易的让你消失不是我的作风。 "}
--总的大体任务目标描述，一句话描述
x970019_g_MissionAim="杀掉#G巨熊#W"		

--任务目标类型(可以多任务目标)
--MONSTER_KILL					--杀怪                        --id为杀怪类型，name为怪物名称,num为对应杀怪数量
x970019_g_MONSTER_KILL = {{id=9103,name="巨熊",num=1,type="MONSTER_KILL",order=0}}

--********************************任务目标的组合********************************
--*切记*****切记*****切记*******************************************************************************
--*********************一个任务的目标个数最多只能为8个,现在已经超出了,请修正*******************************
--********************任务目标为最小元素,比如杀3种怪,算作3个任务目标计算***********************************
--*切记*****切记*****切记********************************************************************
x970019_g_QuestType = {x970019_g_MONSTER_ITEM,x970019_g_MONSTER_KILL}
x970019_g_Quest = {}
x970019_g_QuestNum = 0
x970019_MP_ISCOMPLETE = 7

function  x970019_g_QuestOrder(QuestType)
	local count = 0
	for i, QuestLabel in pairs(QuestType) do
		for j, QuestInfo in pairs(QuestLabel) do
			count = count + 1
			QuestInfo.order = count
			x970019_g_Quest[count] = QuestInfo
		end
	end
	x970019_g_QuestNum = count
end
	
--任务奖励(exp为经验调节参数，money为金钱调节参数)
--经验奖励
x970019_g_ExpBonustxt = ""
x970019_g_exp = 1

function x970019_g_ExpBonus(sceneId, selfId, exp)
	local LV = GetLevel( sceneId, selfId )
	local ExpBonus =35
	return ExpBonus*x970019_g_exp
end

--金钱奖励
x970019_g_MoneyBonustxt = 10000
x970019_g_money = 1

function x970019_g_MoneyBonus(sceneId, selfId, money)
	local MoneyBonus=10000
	return MoneyBonus*x970019_g_money
end

--固定物品奖励，最多8种
x970019_g_ItemBonus={{id=12010003,num=5},{id=12010004,num=5}}

--**********************************任务入口函数**********************************

function x970019_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	x970019_g_QuestOrder(x970019_g_QuestType)
    if IsHaveMission(sceneId,selfId,x970019_g_MissionId) > 0 then
		if (GetName(sceneId,targetId)==x970019_g_NameEnd) then
			local m = 0
			for i, QuestInfo in pairs(x970019_g_Quest) do
				if (QuestInfo.type == "DELIVERY") then
					if (getn(x970019_g_DELIVERY)==1) and (x970019_g_NameEnd == x970019_g_DELIVERY[1].npc) then	
						m = 2
					else
						m = 1
					end
				else
					m = 1
				end
			end
			if m == 1 then
				local Done = x970019_CheckSubmit( sceneId, selfId )
				BeginEvent(sceneId)
					if Done == 1 then
						x970019_ShowQuestInfo( sceneId, selfId, targetId , 1)
					else
						x970019_ShowQuestInfo( sceneId, selfId, targetId , 2)
					end
				EndEvent( )
				if (Done == 1) then
							BeginEvent(sceneId)
             AddText(sceneId,"#Y"..x970019_g_MissionName)
		         AddText(sceneId,"看来有两下子。不过，那些熊也够蠢的，赢了不足为怪。")
		         AddMoneyBonus(sceneId, 10000)
		         if x970019_g_ItemBonus ~= nil then
		          	for i, item in pairs(x970019_g_ItemBonus) do
			        	AddItemBonus( sceneId, item.id, item.num )
			          end
		         end
		    EndEvent()
					DispatchMissionContinueInfo(sceneId,selfId,targetId,x970019_g_ScriptId,x970019_g_MissionId)
				else
					DispatchMissionDemandInfo(sceneId,selfId,targetId,x970019_g_ScriptId,x970019_g_MissionId,0)
				end
			elseif m == 2 then
				local Done = 0
				if x970019_g_DELIVERY[1].item > 0 and x970019_g_DELIVERY[1].num > 0 then
					if	(LuaFnGetItemCount(sceneId,selfId,x970019_g_DELIVERY[1].item)>=x970019_g_DELIVERY[1].num) then
						Done = 1						
					end
				else
					Done = 1
				end
				if Done == 1 then
					local misIndex = GetMissionIndexByID(sceneId,selfId,x970019_g_MissionId)
					for i, QuestInfo in pairs(x970019_g_Quest) do
						if (QuestInfo.type == "MONSTER_KILL") then
							if (GetName(sceneId,targetId)==QuestInfo.npc)then
								SetMissionByIndex(sceneId,selfId,misIndex,QuestInfo.order-1,1)
							end
						end
					end
				end
				BeginEvent(sceneId)
					if Done == 1 then
						x970019_ShowQuestInfo( sceneId, selfId, targetId , 1)
					else
						x970019_ShowQuestInfo( sceneId, selfId, targetId , 2)
					end
				EndEvent( )
				if (Done == 1) then
					DispatchMissionContinueInfo(sceneId,selfId,targetId,x970019_g_ScriptId,x970019_g_MissionId)
				else
					DispatchMissionDemandInfo(sceneId,selfId,targetId,x970019_g_ScriptId,x970019_g_MissionId,0)
				end
			end
		elseif (x970019_g_DELIVERY ~= nil) then
			local n = 0 
			for i, QuestInfo in pairs(x970019_g_Quest) do
				if (QuestInfo.type == "DELIVERY") then
					n = 1
					break
				end
			end
			if  n == 1 then
				for i, DeliveryInfo in pairs(x970019_g_DELIVERY) do
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
							local misIndex = GetMissionIndexByID(sceneId,selfId,x970019_g_MissionId)
							for i, QuestInfo in pairs(x970019_g_Quest) do
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
								AddText(sceneId,x970019_g_NameHead.."让你带给我的东西在哪呢？")
							EndEvent( )	
							DispatchEventList(sceneId,selfId,targetId)
						end
					end
				end
			end
		end
    elseif x970019_CheckAccept(sceneId,selfId,targetId) > 0 then
		--满足任务可接条件，开始显示任务的相关内容
		BeginEvent(sceneId)
			x970019_ShowQuestInfo( sceneId, selfId, targetId ,0)
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x970019_g_ScriptId,x970019_g_MissionId)
    end	
end

--**********************************任务内容显示**********************************
function	x970019_ShowQuestInfo( sceneId, selfId, targetId ,Done)
	local DoneEX = Done
	AddText(sceneId,"#Y"..x970019_g_MissionName)
	if DoneEX==2 then
		for i, Info in pairs(x970019_g_UnDoneMissionInfo) do
			AddText(sceneId,Info)
		end
	else
		for i, Info in pairs(x970019_g_MissionInfo) do
			AddText(sceneId,Info)
		end
	end
	AddText(sceneId,x970019_g_ExpBonustxt)
	AddText(sceneId,"#Y任务目标:")
	AddText(sceneId,x970019_g_MissionAim)
	--多任务目标的显示
	if Done >= 1 then
		Done = 1
	end	
	x970019_ShowQuestAim( sceneId, selfId, targetId,Done )	
	AddMoneyBonus( sceneId, x970019_g_MoneyBonustxt )
	if DoneEX == 2 then
	else
		if x970019_g_ItemBonus ~= nil then
			for i, item in pairs(x970019_g_ItemBonus) do
				AddItemBonus( sceneId, item.id, item.num )
			end
		end			
	end
end

--**********************************任务目标显示**********************************

function	x970019_ShowQuestAim( sceneId, selfId, targetId ,Done)
	x970019_g_QuestOrder(x970019_g_QuestType)
	if x970019_g_Quest ==nil then
		print("该任务没有绑目标!!!")
	else
		local Many = 0
		misIndex = GetMissionIndexByID(sceneId,selfId,x970019_g_MissionId)
		for i, QuestInfo in pairs(x970019_g_Quest) do

			if QuestInfo.type == "MONSTER_KILL"  then
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
function x970019_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x970019_g_MissionId) > 0 then
    	return 
	end
    --如果已接此任务
    --else
    if IsHaveMission(sceneId,selfId,x970019_g_MissionId) > 0 then
		AddNumText(sceneId,x970019_g_ScriptId,x970019_g_MissionName);
    --满足任务接收条件
    elseif x970019_CheckAccept(sceneId,selfId ,targetId) > 0 then
		AddNumText(sceneId,x970019_g_ScriptId,x970019_g_MissionName);
    end
end


--**********************************判断任务可接条件****************************************
--**********************************1、点击的当前NPC为任务接受NPC****************************
--**********************************2、满足等级范围需求、满足前续任务完成需求*****************

function x970019_CheckAccept( sceneId, selfId ,targetId )
	if (GetName(sceneId,targetId)==x970019_g_NameHead) then
		if (GetLevel( sceneId, selfId ) >= x970019_g_MissionMinLevel ) and (GetLevel( sceneId, selfId ) <= x970019_g_MissionMaxLevel ) then
			if	x970019_g_MisIdPre == nil then
				return	1
			else
				for i, questpre in pairs(x970019_g_MisIdPre) do
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

function x970019_CheckContinue( sceneId, selfId ,targetId )
	
end
--**********************************接受任务**********************************
function x970019_OnAccept(sceneId, selfId )		
	x970019_g_QuestOrder(x970019_g_QuestType)
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
	for i, QuestInfo in pairs(x970019_g_Quest) do
		if QuestInfo.type == "MONSTER_KILL" then
			DoKill = 1
		elseif (QuestInfo.type == "DELIVERY") then
				DoItem = 1	
				local m = 0
				local ret = 1
				for i, QuestLableInfo in pairs(x970019_g_Quest) do
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
				elseif QuestInfo.type == "MONSTER_ITEM"	then			--打怪掉落
				DoKill = 1
				DoItem = 1
			end
		end
	--第5个参数表示是否回调OnKillObject	第6个参数表示是否回调OnEnterArea	第7个参数表示是否回调OnItemChange
	AddMission( sceneId,selfId, x970019_g_MissionId, x970019_g_ScriptId, DoKill, DoArea, DoItem )		--添加任务
	misIndex = GetMissionIndexByID(sceneId,selfId,x970019_g_MissionId)			--得到任务的序列号
	if x970019_g_QuestNum > 8 then
		print("一个任务的目标个数最多只能为8个,现在已经超出了,请修正")
		return
	end
	for j=1,x970019_g_QuestNum do
		SetMissionByIndex(sceneId,selfId,misIndex,j-1,0)	--根据序列号把任务变量的第0位置0
	end
	BeginEvent(sceneId)
	  	strText = "你接受了任务  "..x970019_g_MissionName
	  	AddText(sceneId,strText);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end

--**********************************
--放弃
--**********************************
function x970019_OnAbandon( sceneId, selfId )
	x970019_g_QuestOrder(x970019_g_QuestType)
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x970019_g_MissionId )
    for i, QuestInfo in pairs(x970019_g_Quest) do
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

--**********************************
--继续
--**********************************
function x970019_OnContinue( sceneId, selfId, targetId )

end

--**********************************
--检测是否可以提交
--**********************************
function x970019_CheckSubmit( sceneId, selfId )
	x970019_g_QuestOrder(x970019_g_QuestType)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x970019_g_MissionId)
	local bDone = 1
	for i, QuestInfo in pairs(x970019_g_Quest) do
		if QuestInfo.type == "MONSTER_KILL" or QuestInfo.type == "MONSTER_ITEM" then
			local Many = GetMissionParam(sceneId,selfId,misIndex,1)
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
function x970019_OnSubmit( sceneId, selfId, targetId,selectRadioId )
	x970019_g_QuestOrder(x970019_g_QuestType)
	if (x970019_CheckSubmit( sceneId, selfId ) == 1) then
		BeginAddItem(sceneId)
		local givebonus = 0
		local giveitem = 0
		if getn(x970019_g_ItemBonus) ==0 then
			givebonus = 1
		else
			for i, item in pairs(x970019_g_ItemBonus) do
				if item.id>0 and item.num>0 then
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
			ret = DelMission( sceneId, selfId, x970019_g_MissionId )
			if ret > 0 then
				for i, QuestInfo in pairs(x970019_g_Quest) do
					if QuestInfo.type ==  "DELIVERY" then
						if getn(x970019_g_DELIVERY) == 1 and QuestInfo == x970019_g_DELIVERY[1] then
							if QuestInfo.npc == x970019_g_NameEnd and QuestInfo.item > 0 and QuestInfo.num > 0 then
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
				MissionCom( sceneId,selfId, x970019_g_MissionId )
				if (x970019_g_ExpBonustxt~=nil) then
					LuaFnAddExp( sceneId, selfId,x970019_g_ExpBonus(sceneId, selfId, x970019_g_exp))
				end					
				if (x970019_g_MoneyBonustxt~=nil) then
					AddMoney(sceneId,selfId,x970019_g_MoneyBonus(sceneId, selfId, x970019_g_money) );
				end
				if giveitem > 0 then
					AddItemListToHuman(sceneId,selfId)
				end
				BeginEvent(sceneId)
				  	strText = "你完成了任务  "..x970019_g_MissionName
				  	AddText(sceneId,strText);
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				if (x970019_g_ScriptIdNext.ScriptId~=nil) and (x970019_g_ScriptIdNext.ScriptId>0) then
					local CanNext = CallScriptFunction( x970019_g_ScriptIdNext.ScriptId, "CheckAccept",sceneId, selfId, targetId )
					if (CanNext == 1) then
						CallScriptFunction( x970019_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
					else
						BeginEvent(sceneId)
							AddText(sceneId, "#Y真相")
		          AddText(sceneId, "  #{quest_zhenxiang1}")
		          AddText(sceneId, "  #{quest_zhenxiang2}" )
		          AddText(sceneId, "  #{quest_zhenxiang3}")
						EndEvent( )	
						DispatchEventList(sceneId,selfId,targetId)
					end
				end
			end
		end
	end
end

--**********************************--杀死怪物或玩家--**********************************
function x970019_OnKillObject( sceneId, selfId, objdataId )
	x970019_g_QuestOrder(x970019_g_QuestType)
	local QuestPlace = 0	--子任务对应在之前SetMissionByIndex(sceneId,selfId,misIndex,j-1,0)时存在的位置,==j-1
	for i, QuestInfo in pairs(x970019_g_Quest) do
		if QuestInfo.type ==  "MONSTER_KILL" then	
			 if objdataId == QuestInfo.id then
				  local misIndex = GetMissionIndexByID(sceneId,selfId,x970019_g_MissionId)
				  num = GetMissionParam(sceneId,selfId,misIndex,1)
				  if num < QuestInfo.num then						
				    SetMissionByIndex(sceneId,selfId,misIndex,1,num+1)
				  	BeginEvent(sceneId)
					  	strText = format("已杀死  "..QuestInfo.name.."  %d/"..QuestInfo.num, GetMissionParam(sceneId,selfId,misIndex,1) )
					  	AddText(sceneId,strText);
				  	EndEvent(sceneId)
					DispatchMissionTips(sceneId,selfId)
					
					if (num+1) == QuestInfo.num then
						SetMissionByIndex(sceneId,selfId,misIndex,x970019_MP_ISCOMPLETE,1)
				  end
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
function x970019_OnEnterArea( sceneId, selfId, areaId )

end

function x970019_OnTimer( sceneId, selfId )

end

function x970019_OnLeaveArea( sceneId, selfId )

end
--**********************************--道具改变--**********************************
function x970019_OnItemChanged( sceneId, selfId, itemdataId )

end
