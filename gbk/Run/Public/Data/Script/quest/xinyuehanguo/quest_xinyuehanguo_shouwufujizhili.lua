--新月汗国新手任务之  测试专用
--MisDescBegin
--当前脚本的索引号
x211045_g_ScriptId = 211045

--当前任务的MissionID，具体由专人负责分配，9开头的默认为是为测试任务分配的ID
x211045_g_MissionId = 384

--任务起始npc
x211045_g_Name	="我是任务NPC"

--任务归类
x211045_g_MissionKind = 1
x211045_g_MissionLevel = 1

--是否是精英任务
x211045_g_IfMissionElite = 0

--任务是否已经完成
x211045_g_IsMissionOkFail = 0		--变量的第0位

x211045_g_DemandKill ={{id=9076,num=5}}

x211045_g_MissionName="武侠世界2测试任务"

--任务描述(接任务时，和所有目标完成交任务时)支持多条语句
x211045_g_MissionInfo={"武侠世界2测试任务之打怪升级爆装备。杀5个山贼给我看看~"} 

x211045_g_MissionTarget="杀5个山贼"	

x211045_g_ContinueInfo={"还没杀完呢吗？哇哈哈哈哈，让你丫不信春哥！！"}  

x211045_g_MissionComplete="呀喝，你成功了，你永生了！！"

x211045_g_MoneyBonus=10000
x211045_g_ItemBonus={{id=12010001,num=5},{id=12020001,num=5}}
x211045_g_RadioItemBonus={{id=12010001,num=5},{id=12020001,num=5}}
--MisDescEnd

--任务提交npc
x211045_g_NameEnd	= "我是任务NPC"

--****************************************任务可接条件判断*************************************************************************
--任务可接等级范围
x211045_g_MissionMinLevel = 1
x211045_g_MissionMaxLevel = 200



--需要后续任务在该任务结束后直接弹出，则填写下面的参数，否则不填写，只能填写一个后续任务
--ScriptId为后续任务的ScriptId。LV为后续任务的等级要求，要和ScriptId对应脚本里面的等级要求一致
x211045_g_ScriptIdNext = {ScriptId = 211047 ,LV = 3 }

--****************************************任务内容开始*********************************************************************

--任务目标类型(可以多任务目标)
--MONSTER_KILL					--杀怪                        --id为杀怪类型，name为怪物名称,num为对应杀怪数量
x211045_g_MONSTER_KILL = {{id=9076,name="山贼",num=5,type="MONSTER_KILL",order=0}	}

--********************************任务目标的组合********************************
--*切记*****切记*****切记*******************************************************************************
--*********************一个任务的目标个数最多只能为8个,现在已经超出了,请修正*******************************
--********************任务目标为最小元素,比如杀3种怪,算作3个任务目标计算***********************************
--*切记*****切记*****切记********************************************************************
x211045_g_QuestType = {x211045_g_MONSTER_KILL}
x211045_g_Quest = {}
x211045_g_QuestNum = 0
	
--任务奖励(exp为经验调节参数，money为金钱调节参数)
--经验奖励
x211045_g_ExpBonustxt = "经验  100"
x211045_g_exp = 1

--金钱奖励
x211045_g_MoneyBonustxt = 10000
x211045_g_money = 1


function  x211045_g_QuestOrder(QuestType)
	local count = 0
	for i, QuestLabel in pairs(QuestType) do
		for j, QuestInfo in pairs(QuestLabel) do
			count = count + 1
			QuestInfo.order = count
			x211045_g_Quest[count] = QuestInfo
		end
	end
	x211045_g_QuestNum = count
end

function x211045_g_ExpBonus(sceneId, selfId, exp)
	return 5000*x211045_g_exp
end

function x211045_g_MoneyBonus(sceneId, selfId, money)
	local MoneyBonus=10000
	return MoneyBonus*x211045_g_money
end



--**********************************任务入口函数**********************************

function x211045_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	x211045_g_QuestOrder(x211045_g_QuestType)
    if IsHaveMission(sceneId,selfId,x211045_g_MissionId) > 0 then
		if (GetName(sceneId,targetId)==x211045_g_NameEnd) then
			local Done = x211045_CheckSubmit( sceneId, selfId )
			BeginEvent(sceneId)
				if Done == 1 then
					x211045_ShowQuestInfo( sceneId, selfId, targetId , 1)
				else
					x211045_ShowQuestInfo( sceneId, selfId, targetId , 2)
				end
			EndEvent( )
			if (Done == 1) then
				DispatchMissionContinueInfo(sceneId,selfId,targetId,x211045_g_ScriptId,x211045_g_MissionId)
			else
				DispatchMissionDemandInfo(sceneId,selfId,targetId,x211045_g_ScriptId,x211045_g_MissionId,0)
			end
		end
    elseif x211045_CheckAccept(sceneId,selfId,targetId) > 0 then
		--满足任务可接条件，开始显示任务的相关内容
		BeginEvent(sceneId)
			x211045_ShowQuestInfo( sceneId, selfId, targetId ,0)
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x211045_g_ScriptId,x211045_g_MissionId)
    end	
end

--**********************************任务内容显示**********************************
function	x211045_ShowQuestInfo( sceneId, selfId, targetId ,Done)
	local DoneEX = Done
	AddText(sceneId,"#Y"..x211045_g_MissionName)
	if DoneEX==2 then
		for i, Info in pairs(x211045_g_ContinueInfo) do
			AddText(sceneId,Info)
		end
	else
		for i, Info in pairs(x211045_g_MissionInfo) do
			AddText(sceneId,Info)
		end
	end
	--AddText(sceneId,x211045_g_ExpBonustxt)
	AddText(sceneId,"#Y任务目标:")
	AddText(sceneId,x211045_g_MissionTarget)
	--多任务目标的显示
	if Done >= 1 then
		Done = 1
	end	
	x211045_ShowQuestAim( sceneId, selfId, targetId,Done )	
	AddMoneyBonus( sceneId, x211045_g_MoneyBonustxt )
	if DoneEX == 2 then
	else
		if x211045_g_ItemBonus ~= nil then
			for i, item in pairs(x211045_g_ItemBonus) do
				AddItemBonus( sceneId, item.id, item.num )
			end
		end			
		if x211045_g_RadioItemBonus ~= nil then
			for i, item in pairs(x211045_g_RadioItemBonus) do
				AddRadioItemBonus( sceneId, item.id, item.num )
			end
		end
	end
end


--**********************************任务目标显示**********************************

function	x211045_ShowQuestAim( sceneId, selfId, targetId ,Done)
	x211045_g_QuestOrder(x211045_g_QuestType)
	if x211045_g_Quest ==nil then
		print("该任务没有绑目标!!!")
	else
		local Many = 0
		misIndex = GetMissionIndexByID(sceneId,selfId,x211045_g_MissionId)
		for i, QuestInfo in pairs(x211045_g_Quest) do

			if QuestInfo.type == "MONSTER_KILL" or QuestInfo.type == "COLLECT_SPECIAL"  or QuestInfo.type == "MONSTER_ITEM" then
				if Done == 1 then
					Many = GetMissionParam(sceneId,selfId,misIndex,QuestInfo.order-1)
					if Many == nil then
						Many = 0
					end
				end
				StrTxt = QuestInfo.name.."    "..Many.."/"..QuestInfo.num
				AddText(sceneId,StrTxt)				
			end
		end
	end
end

--**********************************判断任务是否显示**********************************
function x211045_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x211045_g_MissionId) > 0 then
    	return 
	end
    --如果已接此任务
    --else
    if IsHaveMission(sceneId,selfId,x211045_g_MissionId) > 0 then
		AddNumText(sceneId,x211045_g_ScriptId,x211045_g_MissionName);
    --满足任务接收条件
    elseif x211045_CheckAccept(sceneId,selfId ,targetId) > 0 then
		AddNumText(sceneId,x211045_g_ScriptId,x211045_g_MissionName);
    end
end



--**********************************判断任务可接条件****************************************
--**********************************1、点击的当前NPC为任务接受NPC****************************
--**********************************2、满足等级范围需求、满足前续任务完成需求*****************

function x211045_CheckAccept( sceneId, selfId ,targetId )

	if (GetName(sceneId,targetId)==x211045_g_Name) then
		if (GetLevel( sceneId, selfId ) >= x211045_g_MissionMinLevel ) and (GetLevel( sceneId, selfId ) <= x211045_g_MissionMaxLevel ) then
			return 1
		else
			return 0
		end
	end
	return 0		
end
--**********************************判断任务继续条件****************************************
--**********************************1、点击的当前NPC为任务接受NPC****************************
--**********************************2、主要是针对送信任务的中间环节进行判断*****************

function x211045_CheckContinue( sceneId, selfId ,targetId )
	
end
--**********************************接受任务**********************************
function x211045_OnAccept(sceneId, selfId )		
	x211045_g_QuestOrder(x211045_g_QuestType)
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
	for i, QuestInfo in pairs(x211045_g_Quest) do
		if QuestInfo.type == "MONSTER_KILL" then
			DoKill = 1
		end
	end	
	--第5个参数表示是否回调OnKillObject	第6个参数表示是否回调OnEnterArea	第7个参数表示是否回调OnItemChange
	AddMission( sceneId,selfId, x211045_g_MissionId, x211045_g_ScriptId, DoKill, DoArea, DoItem )		--添加任务
	misIndex = GetMissionIndexByID(sceneId,selfId,x211045_g_MissionId)			--得到任务的序列号
	if x211045_g_QuestNum > 8 then
		print("一个任务的目标个数最多只能为8个,现在已经超出了,请修正")
		return
	end
	for j=1,x211045_g_QuestNum do
		SetMissionByIndex(sceneId,selfId,misIndex,j-1,0)	--根据序列号把任务变量的第0位置0
	end
	BeginEvent(sceneId)
	  	strText = "你接受了任务  "..x211045_g_MissionName
	  	AddText(sceneId,strText);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end

--**********************************
--放弃
--**********************************
function x211045_OnAbandon( sceneId, selfId )
	x211045_g_QuestOrder(x211045_g_QuestType)
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x211045_g_MissionId )
end


--**********************************
--继续
--**********************************
function x211045_OnContinue( sceneId, selfId, targetId )

end

--**********************************
--检测是否可以提交
--**********************************
function x211045_CheckSubmit( sceneId, selfId )
	x211045_g_QuestOrder(x211045_g_QuestType)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x211045_g_MissionId)
	local bDone = 1
	for i, QuestInfo in pairs(x211045_g_Quest) do
		if QuestInfo.type == "MONSTER_KILL"  then
			local Many = GetMissionParam(sceneId,selfId,misIndex,QuestInfo.order-1)
			if QuestInfo.num == nil then
				QuestInfo.num = 1
			end
			if Many == nil then

			elseif	Many < QuestInfo.num then
				bDone = 0
				break
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
function x211045_OnSubmit( sceneId, selfId, targetId,selectRadioId )
	x211045_g_QuestOrder(x211045_g_QuestType)
	if (x211045_CheckSubmit( sceneId, selfId ) == 1) then
		BeginAddItem(sceneId)
		local givebonus = 0
		local giveitem = 0
		if (getn(x211045_g_ItemBonus) ==0)  and  (getn(x211045_g_RadioItemBonus) == 0 ) then
			givebonus = 1
		else
			for i, item in pairs(x211045_g_ItemBonus) do
				if item.id>0 and item.num>0 then
					AddItem( sceneId,item.id, item.num )
					giveitem = 1
				end
			end
			for i, item in pairs(x211045_g_RadioItemBonus) do
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
			ret = DelMission( sceneId, selfId, x211045_g_MissionId )
			if ret > 0 then
				MissionCom( sceneId,selfId, x211045_g_MissionId )
				if (x211045_g_ExpBonustxt~=nil) then
					LuaFnAddExp( sceneId, selfId,x211045_g_ExpBonus(sceneId, selfId, x211045_g_exp))
				end					
				if (x211045_g_MoneyBonustxt~=nil) then
					AddMoney(sceneId,selfId,x211045_g_MoneyBonus(sceneId, selfId, x211045_g_money) );
				end
				if giveitem > 0 then
					AddItemListToHuman(sceneId,selfId)
				end
				BeginEvent(sceneId)
				  	strText = "你完成了任务  "..x211045_g_MissionName
				  	AddText(sceneId,strText);
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				if (x211045_g_ScriptIdNext.ScriptId~=nil) and (x211045_g_ScriptIdNext.ScriptId>0) then
					local CanNext = CallScriptFunction( x211045_g_ScriptIdNext.ScriptId, "CheckAccept",sceneId, selfId, targetId )
					
					if (CanNext == 1) then
						CallScriptFunction( x211045_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
					else
						BeginEvent(sceneId)
							AddText(sceneId,"哦了！这里没你事儿了，你现肘吧。")
						EndEvent( )	
						DispatchEventList(sceneId,selfId,targetId)
					end
				end
			end
		end
	end
end

--**********************************--杀死怪物或玩家--**********************************
function x211045_OnKillObject( sceneId, selfId, objdataId )
	x211045_g_QuestOrder(x211045_g_QuestType)
	local QuestPlace = 0	--子任务对应在之前SetMissionByIndex(sceneId,selfId,misIndex,j-1,0)时存在的位置,==j-1
	for i, QuestInfo in pairs(x211045_g_Quest) do
		if QuestInfo.type ==  "MONSTER_KILL" then	
			 if objdataId == QuestInfo.id then
				  local misIndex = GetMissionIndexByID(sceneId,selfId,x211045_g_MissionId)
				  num = GetMissionParam(sceneId,selfId,misIndex,QuestInfo.order-1)
				  if num < QuestInfo.num then						
				    SetMissionByIndex(sceneId,selfId,misIndex,QuestInfo.order-1,num+1)
				    SetMissionByIndex(sceneId,selfId,misIndex,QuestInfo.order,num+1)
				  	BeginEvent(sceneId)
					  	strText = format("已杀死  "..QuestInfo.name.."  %d/"..QuestInfo.num, GetMissionParam(sceneId,selfId,misIndex,QuestInfo.order-1) )
					  	AddText(sceneId,strText);
				  	EndEvent(sceneId)
					DispatchMissionTips(sceneId,selfId)
				  end
			 end
		end
	end
end

--**********************************--进入区域事件--**********************************
function x211045_OnEnterArea( sceneId, selfId, areaId )

end

function x211045_OnTimer( sceneId, selfId )

end

function x211045_OnLeaveArea( sceneId, selfId )

end
--**********************************--道具改变--**********************************
function x211045_OnItemChanged( sceneId, selfId, itemdataId )

end
