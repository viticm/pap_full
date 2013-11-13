--新手任务之旅行开始
--MisDescBegin
--当前脚本的索引号
x970000_g_ScriptId = 970000

--当前任务的MissionID，具体由专人负责分配，9开头的默认为是为测试任务分配的ID
x970000_g_MissionId = 970

--任务归类
x970000_g_MissionKind = 13
x970000_g_MissionLevel = 1

--任务起始npc
x970000_g_Name	= "多隆"

--任务提交npc
x970000_g_NameEnd	= "多隆"


--是否是精英任务
x970000_g_IfMissionElite = 0

--任务是否已经完成
x970000_g_IsMissionOkFail = 0		--变量的第0位

x970000_g_DemandItem ={}

--任务名称
x970000_g_MissionName="旅行开始"
--任务描述(接任务时，和所有目标完成交任务时)支持多条语句
x970000_g_MissionInfo={"欢迎来到武侠世界！我都恭候多时了！先自我介绍一下吧，我是你这次旅行的导游，我叫多隆。希望在这儿能圆你的武侠梦想。"} 

x970000_g_MissionTarget="与多隆继续谈话"	

--任务未完成时去交任务的提示文字 ，支持多条语句
x970000_g_UnDoneMissionInfo={"与我继续交谈吧"}

x970000_g_MissionComplete="不要着急，我会慢慢告诉你的。"

x970000_g_MoneyBonus=10000

--MisDescEnd


--****************************************任务可接条件判断*************************************************************************
--任务可接等级范围
x970000_g_MissionMinLevel = 1
x970000_g_MissionMaxLevel = 100

--前置任务的MissionID,可以填写多个前置任务
--x970000_g_MisIdPre = {}

--需要后续任务在该任务结束后直接弹出，则填写下面的参数，否则不填写，只能填写一个后续任务
--ScriptId为后续任务的ScriptId。LV为后续任务的等级要求，要和ScriptId对应脚本里面的等级要求一致
x970000_g_ScriptIdNext = {ScriptId = 970001 ,LV = 1 }
--任务描述(接任务时，和所有目标完成交任务时)支持多条语句
--x970000_g_UnDoneMissionInfo={"继续与我谈话吧"}  
--总的大体任务目标描述，一句话描述


--DELIVERY						--送信                        --npc为要送信给的对象,item为是否有任务物品要给送信对象,该item由任务发布人直接给予玩家; info为任务目标显示
x970000_g_DELIVERY = {{npc = "多隆",item = 0,num = 0,comeitem = 0,comenum = 0,info="与多隆继续谈话",dialog="新面孔啊~~您是第一次来吧？欢迎欢迎啊。",type="DELIVERY",order=0}}

--********************************任务目标的组合********************************
--*切记*****切记*****切记*******************************************************************************
--*********************一个任务的目标个数最多只能为8个,现在已经超出了,请修正*******************************
--********************任务目标为最小元素,比如杀3种怪,算作3个任务目标计算***********************************
--*切记*****切记*****切记********************************************************************
x970000_g_QuestType = {x970000_g_DELIVERY}
x970000_g_Quest = {}
x970000_g_QuestNum = 0
x970000_MP_ISCOMPLETE = 7

function  x970000_g_QuestOrder(QuestType)
	local count = 0
	for i, QuestLabel in pairs(QuestType) do
		for j, QuestInfo in pairs(QuestLabel) do
			count = count + 1
			QuestInfo.order = count
			x970000_g_Quest[count] = QuestInfo
		end
	end
	x970000_g_QuestNum = count
end
	
--任务奖励(exp为经验调节参数，money为金钱调节参数)
--经验奖励
x970000_g_ExpBonustxt = "经验  1000+等级×等级"
x970000_g_exp = 1

function x970000_g_ExpBonus(sceneId, selfId, exp)
	local LV = GetLevel( sceneId, selfId )
	local ExpBonus =6
	return ExpBonus*x970000_g_exp
end

--金钱奖励
x970000_g_MoneyBonustxt = 10000
x970000_g_money = 1

function x970000_g_MoneyBonus(sceneId, selfId, money)
	local MoneyBonus=10000
	return MoneyBonus*x970000_g_money
end

--**********************************任务入口函数**********************************

function x970000_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	x970000_g_QuestOrder(x970000_g_QuestType)
  if IsHaveMission(sceneId,selfId,x970000_g_MissionId) > 0 then --如果玩家身上已接有此任务，则判断是否完成后显示相关内容
		if (GetName(sceneId,targetId)==x970000_g_NameEnd) then --该NPC是交任务NPC
			local m = 0
			for i, QuestInfo in pairs(x970000_g_Quest) do --轮询所需完成条件列表
				if (QuestInfo.type == "DELIVERY") then
					if (getn(x970000_g_DELIVERY)==1) and (x970000_g_NameEnd == x970000_g_DELIVERY[1].npc) then	
						m = 2
					else
						m = 1
					end
				else
					m = 1
				end
			end
			if m == 1 then
				local Done = x970000_CheckSubmit( sceneId, selfId )
				BeginEvent(sceneId)
					if Done == 1 then
						x970000_ShowQuestInfo( sceneId, selfId, targetId , 1)
					else
						x970000_ShowQuestInfo( sceneId, selfId, targetId , 2)
					end
				EndEvent( )
				if (Done == 1) then
					DispatchMissionContinueInfo(sceneId,selfId,targetId,x970000_g_ScriptId,x970000_g_MissionId)
				else
					DispatchMissionDemandInfo(sceneId,selfId,targetId,x970000_g_ScriptId,x970000_g_MissionId,0)
				end
			elseif m == 2 then
				local Done = 0
				if x970000_g_DELIVERY[1].item > 0 and x970000_g_DELIVERY[1].num > 0 then
					if	(LuaFnGetItemCount(sceneId,selfId,x970000_g_DELIVERY[1].item)>=x970000_g_DELIVERY[1].num) then
						Done = 1						
					end
				else
					Done = 1
				end
				if Done == 1 then
					local misIndex = GetMissionIndexByID(sceneId,selfId,x970000_g_MissionId)
					for i, QuestInfo in pairs(x970000_g_Quest) do
						if (QuestInfo.type == "DELIVERY") then
							if (GetName(sceneId,targetId)==QuestInfo.npc)then
								SetMissionByIndex(sceneId,selfId,misIndex,7,1)
							end
						end
					end
				end
				BeginEvent(sceneId)
					if Done == 1 then
						x970000_ShowQuestInfo( sceneId, selfId, targetId , 1)
					else
						x970000_ShowQuestInfo( sceneId, selfId, targetId , 2)
					end
				EndEvent( )
				if (Done == 1) then
				BeginEvent(sceneId)
         AddText(sceneId,"#Y"..x970000_g_MissionName)
		     AddText(sceneId,x970000_g_MissionComplete)
		     AddMoneyBonus(sceneId, 10000)
		     EndEvent()
					DispatchMissionContinueInfo(sceneId,selfId,targetId,x970000_g_ScriptId,x970000_g_MissionId)
				else
					DispatchMissionDemandInfo(sceneId,selfId,targetId,x970000_g_ScriptId,x970000_g_MissionId,0)
				end
			end
			--if m == 1 then
		elseif (x970000_g_DELIVERY ~= nil) then
			local n = 0 
			for i, QuestInfo in pairs(x970000_g_Quest) do
				if (QuestInfo.type == "DELIVERY") then
					n = 1
					break
				end
			end
			if  n == 1 then
				for i, DeliveryInfo in pairs(x970000_g_DELIVERY) do
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
							local misIndex = GetMissionIndexByID(sceneId,selfId,x970000_g_MissionId)
							for i, QuestInfo in pairs(x970000_g_Quest) do
								if QuestInfo.type == "DELIVERY" then
									if (GetName(sceneId,targetId)==QuestInfo.npc)then
										SetMissionByIndex(sceneId,selfId,misIndex,7,1)
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
								AddText(sceneId,x970000_g_Name.."让你带给我的东西在哪呢？")
							EndEvent( )	
							DispatchEventList(sceneId,selfId,targetId)
						end--if m > 0 then
					end--if (GetName(sceneId,targetId)==DeliveryInfo.npc)then
				end--for i, DeliveryInfo in pairs(x970000_g_DELIVERY) do
			end--if  n == 1 then
		end----if (GetName(sceneId,targetId)==x970000_g_NameEnd) 
		
  elseif x970000_CheckAccept(sceneId,selfId,targetId) > 0 then --如果玩家身上还没接此任务，则显示接任务的提示信息
  
		--满足任务可接条件，开始显示任务的相关内容
		BeginEvent(sceneId)
			x970000_ShowQuestInfo( sceneId, selfId, targetId ,0)
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x970000_g_ScriptId,x970000_g_MissionId)
		
  end	-- if IsHaveMission(sceneId,selfId,x970000_g_MissionId) > 0 
    
end

--**********************************任务内容显示**********************************
function	x970000_ShowQuestInfo( sceneId, selfId, targetId ,Done)
	local DoneEX = Done
	AddText(sceneId,"#Y"..x970000_g_MissionName)
	if DoneEX==2 then
		for i, Info in pairs(x970000_g_ContinueInfo) do
			AddText(sceneId,Info)
		end
	else
		for i, Info in pairs(x970000_g_MissionInfo) do
			AddText(sceneId,Info)
		end
	end
	--AddText(sceneId,x970000_g_ExpBonustxt)
	AddText(sceneId,"#Y任务目标:")
	AddText(sceneId,x970000_g_MissionTarget)
	--多任务目标的显示
	if Done >= 1 then
		Done = 1
	end	
	--x970000_ShowQuestAim( sceneId, selfId, targetId,Done )	
	AddMoneyBonus( sceneId, x970000_g_MoneyBonustxt )
end


--**********************************任务目标显示**********************************

function	x970000_ShowQuestAim( sceneId, selfId, targetId ,Done)
	x970000_g_QuestOrder(x970000_g_QuestType)
	if x970000_g_Quest ==nil then
		print("该任务没有绑目标!!!")
	else
		local Many = 0
		misIndex = GetMissionIndexByID(sceneId,selfId,x970000_g_MissionId)
		for i, QuestInfo in pairs(x970000_g_Quest) do

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
					Many = GetMissionParam(sceneId,selfId,misIndex,7)
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
function x970000_OnEnumerate( sceneId, selfId, targetId )
	x970000_g_QuestOrder(x970000_g_QuestType) 	
    if IsMissionHaveDone(sceneId,selfId,x970000_g_MissionId) > 0 then
    	return 
    elseif IsHaveMission(sceneId,selfId,x970000_g_MissionId) > 0 then
    	local m = 0
    	for  i, QuestInfo in pairs(x970000_g_Quest) do
    		if QuestInfo.type == "DELIVERY" then
    			m = 1
    		end
    	end

    	if  (m == 1)  then
    		if  (GetName(sceneId,targetId)==x970000_g_NameEnd) then
    			AddNumText(sceneId,x970000_g_ScriptId,x970000_g_MissionName);
    		else
				for i, QuestInfo in pairs(x970000_g_Quest) do
					if QuestInfo.type == "DELIVERY" then
						if (GetName(sceneId,targetId)==QuestInfo.npc)then
					    	if x970000_CheckContinue(sceneId, selfId, targetId) == 1 then
								AddNumText(sceneId,x970000_g_ScriptId,x970000_g_MissionName);	
								break
							end
						end
					end
				end
			end
		elseif  (GetName(sceneId,targetId)==x970000_g_NameEnd) then
			AddNumText(sceneId,x970000_g_ScriptId,x970000_g_MissionName);
		end					
	--如果玩家满足任务可接条件,则显示这个任务
    elseif x970000_CheckAccept(sceneId,selfId,targetId) > 0 then
		AddNumText(sceneId,x970000_g_ScriptId,x970000_g_MissionName);
    end
end

--**********************************判断任务可接条件****************************************
--**********************************1、点击的当前NPC为任务接受NPC****************************
--**********************************2、满足等级范围需求、满足前续任务完成需求*****************

function x970000_CheckAccept( sceneId, selfId ,targetId )
	if (GetName(sceneId,targetId)==x970000_g_Name) then
		if (GetLevel( sceneId, selfId ) >= x970000_g_MissionMinLevel ) and (GetLevel( sceneId, selfId ) <= x970000_g_MissionMaxLevel ) then
			if	x970000_g_MisIdPre == nil then
				return	1
			else
				for i, questpre in pairs(x970000_g_MisIdPre) do
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

function x970000_CheckContinue( sceneId, selfId ,targetId )
end
--**********************************接受任务**********************************
function x970000_OnAccept(sceneId, selfId )		
	x970000_g_QuestOrder(x970000_g_QuestType)
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
	for i, QuestInfo in pairs(x970000_g_Quest) do
		if (QuestInfo.type == "DELIVERY") then
				DoItem = 1	
				local m = 0
				local ret = 1
				for i, QuestLableInfo in pairs(x970000_g_Quest) do
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
	AddMission( sceneId,selfId, x970000_g_MissionId, x970000_g_ScriptId, DoKill, DoArea, DoItem )		--添加任务
	misIndex = GetMissionIndexByID(sceneId,selfId,x970000_g_MissionId)			--得到任务的序列号
	if x970000_g_QuestNum > 8 then
		print("一个任务的目标个数最多只能为8个,现在已经超出了,请修正")
		return
	end
	for j=1,x970000_g_QuestNum do
		SetMissionByIndex(sceneId,selfId,misIndex,j-1,0)	--根据序列号把任务变量的第0位置0
	end
	BeginEvent(sceneId)
	  	strText = "你接受了任务  "..x970000_g_MissionName
	  	AddText(sceneId,strText);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end

--**********************************
--放弃
--**********************************
function x970000_OnAbandon( sceneId, selfId )
	x970000_g_QuestOrder(x970000_g_QuestType)
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x970000_g_MissionId )
    for i, QuestInfo in pairs(x970000_g_Quest) do
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
function x970000_OnContinue( sceneId, selfId, targetId )

end

--**********************************
--检测是否可以提交
--**********************************
function x970000_CheckSubmit( sceneId, selfId )
	x970000_g_QuestOrder(x970000_g_QuestType)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x970000_g_MissionId)
	local bDone = 1
	for i, QuestInfo in pairs(x970000_g_Quest) do
		if QuestInfo.type == "DELIVERY" then
			Many = GetMissionParam(sceneId,selfId,misIndex,7)
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
function x970000_OnSubmit( sceneId, selfId, targetId)
	x970000_g_QuestOrder(x970000_g_QuestType)
	if (x970000_CheckSubmit( sceneId, selfId ) == 1) then
			ret = DelMission( sceneId, selfId, x970000_g_MissionId )
			if ret > 0 then
				for i, QuestInfo in pairs(x970000_g_Quest) do
					if QuestInfo.type ==  "DELIVERY" then
						if getn(x970000_g_DELIVERY) == 1 and QuestInfo == x970000_g_DELIVERY[1] then
							if QuestInfo.npc == x970000_g_NameEnd and QuestInfo.item > 0 and QuestInfo.num > 0 then
								DelItem(sceneId,selfId,QuestInfo.item,QuestInfo.num)
							end								
						end
						if QuestInfo.comeitem > 0 and QuestInfo.comenum >0 then
							DelItem(sceneId,selfId,QuestInfo.comeitem,QuestInfo.comenum)
						end
					end					
				end   
				MissionCom( sceneId,selfId, x970000_g_MissionId )
				if (x970000_g_ExpBonustxt~=nil) then
					LuaFnAddExp( sceneId, selfId,x970000_g_ExpBonus(sceneId, selfId, x970000_g_exp))
				end					
				if (x970000_g_MoneyBonustxt~=nil) then
					AddMoney(sceneId,selfId,x970000_g_MoneyBonus(sceneId, selfId, x970000_g_money) );
				end
				BeginEvent(sceneId)
				  	strText = "你完成了任务  "..x970000_g_MissionName
				  	AddText(sceneId,strText);
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				if (x970000_g_ScriptIdNext.ScriptId~=nil) and (x970000_g_ScriptIdNext.ScriptId>0) then
					local CanNext = CallScriptFunction( x970000_g_ScriptIdNext.ScriptId, "CheckAccept",sceneId, selfId, targetId )
					if (CanNext == 1) then
						CallScriptFunction( x970000_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
					else
						BeginEvent(sceneId)
							AddText(sceneId,"很好，很强大。")
						EndEvent( )	
						DispatchEventList(sceneId,selfId,targetId)
					end
				end
			end
		end
	end
--**********************************--杀死怪物或玩家--**********************************
function x970000_OnKillObject( sceneId, selfId, objdataId )

end

--**********************************--进入区域事件--**********************************
function x970000_OnEnterArea( sceneId, selfId, areaId )

end

function x970000_OnTimer( sceneId, selfId )

end

function x970000_OnLeaveArea( sceneId, selfId )

end
--**********************************--道具改变--**********************************
function x970000_OnItemChanged( sceneId, selfId, itemdataId )

end
