--苏州任务之解围
--MisDescBegin
--当前脚本的索引号
x110003_g_ScriptId = 110003

--当前任务的MissionID，具体由专人负责分配，9开头的默认为是为测试任务分配的ID
x110003_g_MissionId = 203

--任务归类
x110003_g_MissionKind = 1
x110003_g_MissionLevel = 15

--任务起始npc
x110003_g_NameHead	= "韩小莹"

--任务提交npc
x110003_g_NameEnd	= "张阿生"

--任务是否已经完成
x110003_g_IsMissionOkFail = 0		--变量的第0位

x110003_g_DemandKill ={{id=9121,num=15}}

x110003_g_MissionName="解围"

--任务描述(接任务时，和所有目标完成交任务时)支持多条语句
x110003_g_MissionInfo={"我好象听到了五师兄的喊声，难道他遇到了敌手？快！快去看看！"} 

x110003_g_MissionTarget="消灭掉15个#aB{86,36,10,江南野外}[大盗]#aE，完成后听听那附近的#aB{75,15,10,江南野外,张阿生}[张阿生]#aE说什么"	

x110003_g_ContinueInfo={"敌人尚在，不能突围啊！"}

x110003_g_MissionComplete={"谢谢少侠相助，刚才好险。"}

x110003_g_MoneyBonus=10000
--MisDescEnd

--****************************************任务可接条件判断*************************************************************************
--任务可接等级范围
x110003_g_MissionMinLevel = 15
x110003_g_MissionMaxLevel = 100

--前置任务的MissionID,可以填写多个前置任务
x110003_g_MisIdPre = {202}

--需要后续任务在该任务结束后直接弹出，则填写下面的参数，否则不填写，只能填写一个后续任务
--ScriptId为后续任务的ScriptId。LV为后续任务的等级要求，要和ScriptId对应脚本里面的等级要求一致
x110003_g_ScriptIdNext = {ScriptId = 110004 ,LV = 15 }

--****************************************任务内容开始*********************************************************************
--任务未完成时去交任务的提示文字 ，支持多条语句
x110003_g_UnDoneMissionInfo={"快去吧。时间不等人啊~"}
--总的大体任务目标描述，一句话描述
x110003_g_MissionAim="杀掉大盗，救师兄妹几人"		

--任务目标类型(可以多任务目标)
--MONSTER_KILL					--杀怪                        --id为杀怪类型，name为怪物名称,num为对应杀怪数量
x110003_g_MONSTER_KILL = {{id=9121,name="大盗",num=15,type="MONSTER_KILL",order=0}}

--********************************任务目标的组合********************************
--*切记*****切记*****切记*******************************************************************************
--*********************一个任务的目标个数最多只能为8个,现在已经超出了,请修正*******************************
--********************任务目标为最小元素,比如杀3种怪,算作3个任务目标计算***********************************
--*切记*****切记*****切记********************************************************************
x110003_g_QuestType = {x110003_g_MONSTER_ITEM,x110003_g_MONSTER_KILL}
x110003_g_Quest = {}
x110003_g_QuestNum = 0
x110003_MP_ISCOMPLETE = 7

function  x110003_g_QuestOrder(QuestType)
	local count = 0
	for i, QuestLabel in pairs(QuestType) do
		for j, QuestInfo in pairs(QuestLabel) do
			count = count + 1
			QuestInfo.order = count
			x110003_g_Quest[count] = QuestInfo
		end
	end
	x110003_g_QuestNum = count
end
	
--任务奖励(exp为经验调节参数，money为金钱调节参数)
--经验奖励
x110003_g_ExpBonustxt = ""
x110003_g_exp = 1

function x110003_g_ExpBonus(sceneId, selfId, exp)
	local LV = GetLevel( sceneId, selfId )
	local ExpBonus =330
	return ExpBonus*x110003_g_exp
end

--金钱奖励
x110003_g_MoneyBonustxt = 10000
x110003_g_money = 1

function x110003_g_MoneyBonus(sceneId, selfId, money)
	local MoneyBonus=10000
	return MoneyBonus*x110003_g_money
end

--**********************************任务入口函数**********************************

function x110003_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	x110003_g_QuestOrder(x110003_g_QuestType)
    if IsHaveMission(sceneId,selfId,x110003_g_MissionId) > 0 then
		if (GetName(sceneId,targetId)==x110003_g_NameEnd) then
			local m = 0
			for i, QuestInfo in pairs(x110003_g_Quest) do
				if (QuestInfo.type == "DELIVERY") then
					if (getn(x110003_g_DELIVERY)==1) and (x110003_g_NameEnd == x110003_g_DELIVERY[1].npc) then	
						m = 2
					else
						m = 1
					end
				else
					m = 1
				end
			end
			if m == 1 then
				local Done = x110003_CheckSubmit( sceneId, selfId )
				BeginEvent(sceneId)
					if Done == 1 then
						x110003_ShowQuestInfo( sceneId, selfId, targetId , 1)
					else
						x110003_ShowQuestInfo( sceneId, selfId, targetId , 2)
					end
				EndEvent( )
				if (Done == 1) then
				BeginEvent(sceneId)
             AddText(sceneId,"#Y"..x110003_g_MissionName)
		         AddText(sceneId,"谢谢少侠相助，刚才好险。")
		         AddMoneyBonus(sceneId, 10000)
		    EndEvent()
					DispatchMissionContinueInfo(sceneId,selfId,targetId,x110003_g_ScriptId,x110003_g_MissionId)
				else
					DispatchMissionDemandInfo(sceneId,selfId,targetId,x110003_g_ScriptId,x110003_g_MissionId,0)
				end
			elseif m == 2 then
				local Done = 0
				if x110003_g_DELIVERY[1].item > 0 and x110003_g_DELIVERY[1].num > 0 then
					if	(LuaFnGetItemCount(sceneId,selfId,x110003_g_DELIVERY[1].item)>=x110003_g_DELIVERY[1].num) then
						Done = 1						
					end
				else
					Done = 1
				end
				if Done == 1 then
					local misIndex = GetMissionIndexByID(sceneId,selfId,x110003_g_MissionId)
					for i, QuestInfo in pairs(x110003_g_Quest) do
						if (QuestInfo.type == "MONSTER_KILL") then
							if (GetName(sceneId,targetId)==QuestInfo.npc)then
								SetMissionByIndex(sceneId,selfId,misIndex,1,1)
							end
						end
					end
				end
				BeginEvent(sceneId)
					if Done == 1 then
						x110003_ShowQuestInfo( sceneId, selfId, targetId , 1)
					else
						x110003_ShowQuestInfo( sceneId, selfId, targetId , 2)
					end
				EndEvent( )
				if (Done == 1) then
					DispatchMissionContinueInfo(sceneId,selfId,targetId,x110003_g_ScriptId,x110003_g_MissionId)
				else
					DispatchMissionDemandInfo(sceneId,selfId,targetId,x110003_g_ScriptId,x110003_g_MissionId,0)
				end
			end
		elseif (x110003_g_DELIVERY ~= nil) then
			local n = 0 
			for i, QuestInfo in pairs(x110003_g_Quest) do
				if (QuestInfo.type == "DELIVERY") then
					n = 1
					break
				end
			end
			if  n == 1 then
				for i, DeliveryInfo in pairs(x110003_g_DELIVERY) do
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
							local misIndex = GetMissionIndexByID(sceneId,selfId,x110003_g_MissionId)
							for i, QuestInfo in pairs(x110003_g_Quest) do
								if QuestInfo.type == "DELIVERY" then
									if (GetName(sceneId,targetId)==QuestInfo.npc)then
										SetMissionByIndex(sceneId,selfId,misIndex,1,1)
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
								AddText(sceneId,x110003_g_NameHead.."让你带给我的东西在哪呢？")
							EndEvent( )	
							DispatchEventList(sceneId,selfId,targetId)
						end
					end
				end
			end
		end
    elseif x110003_CheckAccept(sceneId,selfId,targetId) > 0 then
		--满足任务可接条件，开始显示任务的相关内容
		BeginEvent(sceneId)
			x110003_ShowQuestInfo( sceneId, selfId, targetId ,0)
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x110003_g_ScriptId,x110003_g_MissionId)
    end	
end

--**********************************任务内容显示**********************************
function	x110003_ShowQuestInfo( sceneId, selfId, targetId ,Done)
	local DoneEX = Done
	AddText(sceneId,"#Y"..x110003_g_MissionName)
	if DoneEX==2 then
		for i, Info in pairs(x110003_g_UnDoneMissionInfo) do
			AddText(sceneId,Info)
		end
	else
		for i, Info in pairs(x110003_g_MissionInfo) do
			AddText(sceneId,Info)
		end
	end
	AddText(sceneId,x110003_g_ExpBonustxt)
	AddText(sceneId,"#Y任务目标:")
	AddText(sceneId,x110003_g_MissionAim)
	--多任务目标的显示
	if Done >= 1 then
		Done = 1
	end	
	x110003_ShowQuestAim( sceneId, selfId, targetId,Done )	
	AddMoneyBonus( sceneId, x110003_g_MoneyBonustxt )
end

--**********************************任务目标显示**********************************

function	x110003_ShowQuestAim( sceneId, selfId, targetId ,Done)
	x110003_g_QuestOrder(x110003_g_QuestType)
	if x110003_g_Quest ==nil then
		print("该任务没有绑目标!!!")
	else
		local Many = 0
		misIndex = GetMissionIndexByID(sceneId,selfId,x110003_g_MissionId)
		for i, QuestInfo in pairs(x110003_g_Quest) do

			if QuestInfo.type == "MONSTER_KILL"  then
				if Done == 1 then
					Many = GetMissionParam(sceneId,selfId,misIndex,1)
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
					Many = GetMissionParam(sceneId,selfId,misIndex,1)
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
function x110003_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x110003_g_MissionId) > 0 then
    return 
    --如果已接此任务
    else
    if IsHaveMission(sceneId,selfId,x110003_g_MissionId) > 0 then
		AddNumText(sceneId,x110003_g_ScriptId,x110003_g_MissionName);
    --满足任务接收条件
    elseif x110003_CheckAccept(sceneId,selfId ,targetId) > 0 then
		AddNumText(sceneId,x110003_g_ScriptId,x110003_g_MissionName);
    end
end
end

--**********************************判断任务可接条件****************************************
--**********************************1、点击的当前NPC为任务接受NPC****************************
--**********************************2、满足等级范围需求、满足前续任务完成需求*****************

function x110003_CheckAccept( sceneId, selfId ,targetId )
	if (GetName(sceneId,targetId)==x110003_g_NameHead) then
		if (GetLevel( sceneId, selfId ) >= x110003_g_MissionMinLevel ) and (GetLevel( sceneId, selfId ) <= x110003_g_MissionMaxLevel ) then
			if	x110003_g_MisIdPre == nil then
				return	1
			else
				for i, questpre in pairs(x110003_g_MisIdPre) do
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

function x110003_CheckContinue( sceneId, selfId ,targetId )

end
--**********************************接受任务**********************************
function x110003_OnAccept(sceneId, selfId )		
	x110003_g_QuestOrder(x110003_g_QuestType)
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
	for i, QuestInfo in pairs(x110003_g_Quest) do
		if QuestInfo.type == "MONSTER_KILL" then
			DoKill = 1
		elseif (QuestInfo.type == "DELIVERY") then
				DoItem = 1	
				local m = 0
				local ret = 1
				for i, QuestLableInfo in pairs(x110003_g_Quest) do
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
	AddMission( sceneId,selfId, x110003_g_MissionId, x110003_g_ScriptId, DoKill, DoArea, DoItem )		--添加任务
	misIndex = GetMissionIndexByID(sceneId,selfId,x110003_g_MissionId)			--得到任务的序列号
	if x110003_g_QuestNum > 8 then
		print("一个任务的目标个数最多只能为8个,现在已经超出了,请修正")
		return
	end
	for j=1,x110003_g_QuestNum do
		SetMissionByIndex(sceneId,selfId,misIndex,j-1,0)	--根据序列号把任务变量的第0位置0
	end
	BeginEvent(sceneId)
	  	strText = "你接受了任务  "..x110003_g_MissionName
	  	AddText(sceneId,strText);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end

--**********************************
--放弃
--**********************************
function x110003_OnAbandon( sceneId, selfId )
	x110003_g_QuestOrder(x110003_g_QuestType)
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x110003_g_MissionId )
    for i, QuestInfo in pairs(x110003_g_Quest) do
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
function x110003_OnContinue( sceneId, selfId, targetId )

end

--**********************************
--检测是否可以提交
--**********************************
function x110003_CheckSubmit( sceneId, selfId )
	x110003_g_QuestOrder(x110003_g_QuestType)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x110003_g_MissionId)
	local bDone = 1
	for i, QuestInfo in pairs(x110003_g_Quest) do
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
			Many = GetMissionParam(sceneId,selfId,misIndex,1)
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
function x110003_OnSubmit( sceneId, selfId, targetId,selectRadioId )
	x110003_g_QuestOrder(x110003_g_QuestType)
	if (x110003_CheckSubmit( sceneId, selfId ) == 1) then
			ret = DelMission( sceneId, selfId, x110003_g_MissionId )
			if ret > 0 then
				for i, QuestInfo in pairs(x110003_g_Quest) do
					if QuestInfo.type ==  "DELIVERY" then
						if getn(x110003_g_DELIVERY) == 1 and QuestInfo == x110003_g_DELIVERY[1] then
							if QuestInfo.npc == x110003_g_NameEnd and QuestInfo.item > 0 and QuestInfo.num > 0 then
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
				MissionCom( sceneId,selfId, x110003_g_MissionId )
				if (x110003_g_ExpBonustxt~=nil) then
					LuaFnAddExp( sceneId, selfId,x110003_g_ExpBonus(sceneId, selfId, x110003_g_exp))
				end					
				if (x110003_g_MoneyBonustxt~=nil) then
					AddMoney(sceneId,selfId,x110003_g_MoneyBonus(sceneId, selfId, x110003_g_money) );
				end
				BeginEvent(sceneId)
				  	strText = "你完成了任务  "..x110003_g_MissionName
				  	AddText(sceneId,strText);
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				if (x110003_g_ScriptIdNext.ScriptId~=nil) and (x110003_g_ScriptIdNext.ScriptId>0) then
					local CanNext = CallScriptFunction( x110003_g_ScriptIdNext.ScriptId, "CheckAccept",sceneId, selfId, targetId )
					if (CanNext == 1) then
						CallScriptFunction( x110003_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
					else
						BeginEvent(sceneId)
							AddText(sceneId,"#{quest_suzhou_jiuren}")
						EndEvent( )	
						DispatchEventList(sceneId,selfId,targetId)
					end
				end
			end
		end
	end
--**********************************--杀死怪物或玩家--**********************************
function x110003_OnKillObject( sceneId, selfId, objdataId )
	x110003_g_QuestOrder(x110003_g_QuestType)
	local QuestPlace = 0	
	for i, QuestInfo in pairs(x110003_g_Quest) do
		if QuestInfo.type ==  "MONSTER_KILL" then	
			 if objdataId == QuestInfo.id then
				  local misIndex = GetMissionIndexByID(sceneId,selfId,x110003_g_MissionId)
				  num = GetMissionParam(sceneId,selfId,misIndex,1)
				  if num < QuestInfo.num then						
				    SetMissionByIndex(sceneId,selfId,misIndex,1,num+1)

				  	BeginEvent(sceneId)
					  	strText = format("已杀死  "..QuestInfo.name.."  %d/"..QuestInfo.num, GetMissionParam(sceneId,selfId,misIndex,1) )
					  	AddText(sceneId,strText);
				  	EndEvent(sceneId)
					DispatchMissionTips(sceneId,selfId)

					if (num+1) == QuestInfo.num then
						SetMissionByIndex(sceneId,selfId,misIndex,x110003_MP_ISCOMPLETE,1)
					end
				  end
			 end
		end
	end
end

--**********************************--进入区域事件--**********************************
function x110003_OnEnterArea( sceneId, selfId, areaId )

end

function x110003_OnTimer( sceneId, selfId )

end

function x110003_OnLeaveArea( sceneId, selfId )

end
--**********************************--道具改变--**********************************
function x110003_OnItemChanged( sceneId, selfId, itemdataId )

end