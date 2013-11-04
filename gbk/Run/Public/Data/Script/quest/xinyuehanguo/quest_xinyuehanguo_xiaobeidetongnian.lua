--护送测试
--MisDescBegin
--当前脚本的索引号
x211044_g_ScriptId = 211044

--当前任务的MissionID，具体由专人负责分配，9开头的默认为是为测试任务分配的ID
x211044_g_MissionId = 383

--任务起始npc
x211044_g_Name	="多隆" 

--任务归类
x211044_g_MissionKind = 1
x211044_g_MissionLevel = 1

--是否是精英任务
x211044_g_IfMissionElite = 0

--任务是否已经完成
x211044_g_IsMissionOkFail = 0		--变量的第0位

x211044_g_DemandKill ={}

x211044_g_MissionName="护送测试"

--任务描述(接任务时，和所有目标完成交任务时)支持多条语句
x211044_g_MissionInfo={"护送NPC，完成后找村长"} 

x211044_g_MissionTarget="跟着NPC，护送他"	

x211044_g_ContinueInfo={"找到了吗"}  

x211044_g_MissionComplete="就是这个！"
x211044_g_MoneyBonus=10000
x211044_g_ItemBonus={}
x211044_g_RadioItemBonus={{id=12010001,num=5},{id=12020001,num=5}}
--MisDescEnd

--任务提交npc
x211044_g_NameEnd	= "村长"

--****************************************任务可接条件判断*************************************************************************
--任务可接等级范围
x211044_g_MissionMinLevel = 1
x211044_g_MissionMaxLevel = 100

--前置任务的MissionID,可以填写多个前置任务
x211044_g_MisIdPre = {}

--需要后续任务在该任务结束后直接弹出，则填写下面的参数，否则不填写，只能填写一个后续任务
--ScriptId为后续任务的ScriptId。LV为后续任务的等级要求，要和ScriptId对应脚本里面的等级要求一致
x211044_g_ScriptIdNext = {}

--****************************************任务内容开始*********************************************************************

--任务目标类型(可以多任务目标)
--PROTECT						--护送(本护送为新添加npc,使其成为保护对象)         --npc为要护送的npc,name为npc的名称,patrol为护送的npc路径()
x211044_g_PROTECT={{npc=3277,name="金小七",place={x=66,z=38},ai={baseai=3,scriptai=0},scriptid=-1,patrol=0,info="跟着他，沿路寻找他的轮椅",type="PROTECT",order=0}}
x211044_g_ProtectNPCID = {}
-- 护送相关的场景计时器的Index
if x211044_g_PROTECT~=nil then
	if x211044_g_PROTECTINFO == nil then
		x211044_g_PROTECTINFO={ScneneTimerIndex = -1, Step = 0, StartTime = 0, PlayerNum = 0, PlayerId= {0,0,0,0,0,0}}
	end
end
--********************************任务目标的组合********************************
--*切记*****切记*****切记*******************************************************************************
--*********************一个任务的目标个数最多只能为8个,现在已经超出了,请修正*******************************
--********************任务目标为最小元素,比如杀3种怪,算作3个任务目标计算***********************************
--*切记*****切记*****切记********************************************************************
x211044_g_QuestType = {x211044_g_PROTECT}
x211044_g_Quest = {}
x211044_g_QuestNum = 0
	
--任务奖励(exp为经验调节参数，money为金钱调节参数)
--经验奖励
x211044_g_ExpBonustxt = "经验  100"
x211044_g_exp = 1

--金钱奖励
x211044_g_MoneyBonustxt = 10000
x211044_g_money = 1

--固定物品奖励，最多8种
x211044_g_ItemBonus={{id=12010001,num=5},{id=12020001,num=5}}


--可选物品奖励，最多8种
x211044_g_RadioItemBonus={}




function  x211044_g_QuestOrder(QuestType)
	local count = 0
	for i, QuestLabel in QuestType do
		for j, QuestInfo in QuestLabel do
			count = count + 1
			QuestInfo.order = count
			x211044_g_Quest[count] = QuestInfo
		end
	end
	x211044_g_QuestNum = count
end

function x211044_g_ExpBonus(sceneId, selfId, exp)
	return 10000*x211044_g_exp
end

function x211044_g_MoneyBonus(sceneId, selfId, money)
	local MoneyBonus=10000
	return MoneyBonus*x211044_g_money
end


--**********************************

--任务入口函数

--**********************************

function x211044_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	x211044_g_QuestOrder(x211044_g_QuestType)
    if IsHaveMission(sceneId,selfId,x211044_g_MissionId) > 0 then
		if (GetName(sceneId,targetId)==x211044_g_NameEnd) then
			local Done = x211044_CheckSubmit( sceneId, selfId )
			BeginEvent(sceneId)
				if Done == 1 then
					x211044_ShowQuestInfo( sceneId, selfId, targetId , 1)
				else
					x211044_ShowQuestInfo( sceneId, selfId, targetId , 2)
				end
			EndEvent( )
			if (Done == 1) then
				DispatchMissionContinueInfo(sceneId,selfId,targetId,x211044_g_ScriptId,x211044_g_MissionId)
			else
				DispatchMissionDemandInfo(sceneId,selfId,targetId,x211044_g_ScriptId,x211044_g_MissionId,0)
			end
		end
    elseif x211044_CheckAccept(sceneId,selfId,targetId) > 0 then
		--满足任务可接条件，开始显示任务的相关内容
		BeginEvent(sceneId)
			x211044_ShowQuestInfo( sceneId, selfId, targetId ,0)
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x211044_g_ScriptId,x211044_g_MissionId)
    end	
end

--**********************************任务内容显示**********************************
function	x211044_ShowQuestInfo( sceneId, selfId, targetId ,Done)
	local DoneEX = Done
	AddText(sceneId,"#Y"..x211044_g_MissionName)
	if DoneEX==2 then
		for i, Info in x211044_g_ContinueInfo do
			AddText(sceneId,Info)
		end
	else
		for i, Info in x211044_g_MissionInfo do
			AddText(sceneId,Info)
		end
	end
	AddText(sceneId,x211044_g_ExpBonustxt)
	AddText(sceneId,"#Y任务目标:")
	AddText(sceneId,x211044_g_MissionTarget)
	--多任务目标的显示
	if Done >= 1 then
		Done = 1
	end	
	AddMoneyBonus( sceneId, x211044_g_MoneyBonustxt )
	if DoneEX == 2 then
	else
		if x211044_g_ItemBonus ~= nil then
			for i, item in x211044_g_ItemBonus do
				AddItemBonus( sceneId, item.id, item.num )
			end
		end			
		if x211044_g_RadioItemBonus ~= nil then
			for i, item in x211044_g_RadioItemBonus do
				AddRadioItemBonus( sceneId, item.id, item.num )
			end
		end
	end
end


--**********************************任务目标显示**********************************

function	x211044_ShowQuestAim( sceneId, selfId, targetId ,Done)

end

--**********************************

--列举事件

--**********************************

function x211044_OnEnumerate(sceneId, selfId, targetId)
	    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x211044_g_MissionId) > 0 then
    	return 
	end
    --如果已接此任务
    --else
    if IsHaveMission(sceneId,selfId,x211044_g_MissionId) > 0 then
		AddNumText(sceneId, x211044_g_ScriptId, x211044_g_MissionName)
    --满足任务接收条件
    elseif x211044_CheckAccept(sceneId,selfId ,targetId) > 0 then
		AddNumText(sceneId, x211044_g_ScriptId, x211044_g_MissionName)
    end
end



--**********************************

--检测接受条件

--**********************************

function x211044_CheckAccept(sceneId, selfId, targetId)
	if (GetName(sceneId,targetId)==x211044_g_Name) then
		if (GetLevel( sceneId, selfId ) >= x211044_g_MissionMinLevel ) and (GetLevel( sceneId, selfId ) <= x211044_g_MissionMaxLevel ) then
			if	x211044_g_MisIdPre == nil then
				return	1
			else
				for i, questpre in x211044_g_MisIdPre do
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

--**********************************

--接受

--**********************************

function x211044_OnAccept(sceneId, selfId)
         x211044_g_QuestOrder(x211044_g_QuestType)
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
	for i, QuestInfo in x211044_g_Quest do
		if QuestInfo.type == "PROTECT"	then			--护送
			if (x211044_g_PROTECTINFO == nil) then
				print("该护送任务没有配置相关的定时器!!!")
				return
			else
				if x211044_g_PROTECTINFO.Step > 2  then
					BeginEvent(sceneId)
						strText = "#Y现在不能接这个任务"
						AddText(sceneId,strText);
					EndEvent(sceneId)
					DispatchMissionTips(sceneId,selfId)
					return
				end
				
				-- 如果当前 
				if x211044_g_PROTECTINFO.Step == 0  then
					-- 开启护送剧情  
					-- 检测场景中是不是有这个人物了
					local nMonsterNum = GetMonsterCount(sceneId)
					local ii = 0
					local bHaveMonster = 0
					for ii=0, nMonsterNum-1 do
						local nMonsterId = GetMonsterObjID(sceneId,ii)
						for i, QuestInfo in x211044_g_Quest do
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
						for i, QuestInfo in x211044_g_Quest do
							if QuestInfo.type == "PROTECT"	then
								local nNpcId = LuaFnCreateMonster(sceneId,  QuestInfo.npc, QuestInfo.place.x, QuestInfo.place.z, QuestInfo.ai.baseai, QuestInfo.ai.scriptai, QuestInfo.scriptid)
								--SetCharacterName(sceneId, nNpcId, ProtectInfo.name)
								-- 设置小时时间是10分钟
								--SetCharacterDieTime(sceneId, nNpcId, 600000)
							end
						end
					end
					-- 把这个玩家加到护送玩家列表中
					x211044_g_PROTECTINFO.PlayerNum = 1
					x211044_g_PROTECTINFO.PlayerId[1] = selfId
			
					-- 启动一个场景计时器,每间隔3秒,回调一次OnScneneTimer函数
					x211044_g_PROTECTINFO.ScneneTimerIndex = SetTimer(sceneId, selfId, 211044, "OnScneneTimer", 1)
					x211044_g_PROTECTINFO.Step = 1
					--当前时间
					x211044_g_PROTECTINFO.StartTime = LuaFnGetCurrentTime()
				end
				
				-- 加入到这个护送的玩家
				if x211044_g_PROTECTINFO.Step == 2  then
					if x211044_g_PROTECTINFO.PlayerNum > 5  then
						--人满了
						return
					end
				
					x211044_g_PROTECTINFO.PlayerNum = x211044_g_PROTECTINFO.PlayerNum + 1
					x211044_g_PROTECTINFO.PlayerId[x211044_g_PROTECTINFO.PlayerNum] = selfId
				end
			end
		end
	end	
	--第5个参数表示是否回调OnKillObject	第6个参数表示是否回调OnEnterArea	第7个参数表示是否回调OnItemChange
	AddMission( sceneId,selfId, x211044_g_MissionId, x211044_g_ScriptId, DoKill, DoArea, DoItem )		--添加任务
	misIndex = GetMissionIndexByID(sceneId,selfId,x211044_g_MissionId)			--得到任务的序列号
	if x211044_g_QuestNum > 8 then
		print("一个任务的目标个数最多只能为8个,现在已经超出了,请修正")
		return
	end
	for j=1,x211044_g_QuestNum do
		SetMissionByIndex(sceneId,selfId,misIndex,j-1,0)	--根据序列号把任务变量的第0位置0
	end
	BeginEvent(sceneId)
	  	strText = "你接受了任务  "..x211044_g_MissionName
	  	AddText(sceneId,strText);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)                                                          
	     
end


--**********************************--场景计时器--**********************************
function x211044_OnScneneTimer(sceneId, selfId)
	x211044_g_QuestOrder(x211044_g_QuestType)
	local bHavePlayer = 0
	-- 等待5秒进入2
	if x211044_g_PROTECTINFO.Step == 1   then
		-- 通知自己队伍的其他玩家接这个任务
		local nMonsterNum = GetMonsterCount(sceneId)
		local m = 0
		local HeadNPCID = 0
		local bHaveMonster = 0
		for m=0, nMonsterNum-1 do
			local nMonsterId = GetMonsterObjID(sceneId,m)
			if GetName(sceneId, nMonsterId)  == x211044_g_NameHead  then
				HeadNPCID = nMonsterId
				bHaveMonster = 1
			end
		end
		local nTeamCount = GetNearTeamCount(sceneId, selfId)
		for i=0, nTeamCount-1 do
			local PlayerId = GetNearTeamMember(sceneId, selfId, i)
			if PlayerId ~= selfId    then
				CallScriptFunction((211044), "OnDefaultEvent", sceneId, PlayerId, HeadNPCID )
			end
		end
		x211044_g_PROTECTINFO.Step = 2
	end
	-- 开始等待别的玩家来一起做这个任务,10秒钟时间
	if x211044_g_PROTECTINFO.Step == 2   then
		if LuaFnGetCurrentTime() - x211044_g_PROTECTINFO.StartTime >= 10   then
			x211044_g_PROTECTINFO.Step = 3
		end
	end
	-- 有玩家点击了开始护送
	if x211044_g_PROTECTINFO.Step == 3   then
		local nMonsterNum = GetMonsterCount(sceneId)
		local ii = 0
		local bHaveMonster = 0
		for ii=0, nMonsterNum-1 do
			local nMonsterId = GetMonsterObjID(sceneId,ii)
			for j, ProtectInfo in x211044_g_PROTECT do
				if GetName(sceneId, nMonsterId)  ==  ProtectInfo.name then
					bHaveMonster = bHaveMonster + 1
					x211044_g_ProtectNPCID[j] = nMonsterId
				end
			end
		end
		if bHaveMonster == getn(x211044_g_PROTECT)  then
			for j, ProtectInfo in x211044_g_PROTECT do
				SetPatrolId(sceneId, x211044_g_ProtectNPCID[j], ProtectInfo.patrol)
			end
			x211044_g_PROTECTINFO.Step = 4
		end
	end
	-- 护送过程
	if x211044_g_PROTECTINFO.Step == 4   then
		local nMonsterNum = GetMonsterCount(sceneId)
		local ii = 0
		local bHaveMonster = 0

		local bDone = 0
		for ii=0, nMonsterNum-1   do
			local nMonsterId = GetMonsterObjID(sceneId,ii)
			for j, ProtectInfo in x211044_g_PROTECT do
				if GetName(sceneId, nMonsterId)  ==  ProtectInfo.name then
					bHaveMonster = bHaveMonster + 1
					x211044_g_ProtectNPCID[j] = nMonsterId
				end
			end
		end
		if bHaveMonster < getn(x211044_g_PROTECT)   then
			-- 关闭计时器
			x211044_CloseTimer(sceneId, x211044_g_PROTECTINFO.ScneneTimerIndex)
			return
		end
		for j, NpcID in x211044_g_ProtectNPCID do 
			-- 检测ProtectNPC 和玩家之间的距离
			local targetX, targetZ = GetWorldPos(sceneId, NpcID)
			-- 检测如果玩家的距离已经离开的场景或者玩家不在护送对象10米内，这个玩家失败
			for i=1, x211044_g_PROTECTINFO.PlayerNum  do
				if x211044_g_PROTECTINFO.PlayerId[i] ~= 0  then
					local nPlayerX, nPlayerZ = GetWorldPos(sceneId, x211044_g_PROTECTINFO.PlayerId[i])
					local distance1 = floor(sqrt((targetX-nPlayerX)*(targetX-nPlayerX)+(targetZ-nPlayerZ)*(targetZ-nPlayerZ)))
					
					if distance1 > 20    then
						--提示这个玩家任务失败
						BeginEvent(sceneId)
							strText = x211044_g_MissionName.."  失败"
							AddText(sceneId,strText);
						EndEvent(sceneId)
						DispatchMissionTips(sceneId,x211044_g_PROTECTINFO.PlayerId[i])
						-- 从列表中删除这个玩家
						x211044_g_PROTECTINFO.PlayerId[i] = 0
					end
				end
			end
		end	
		for j, ProtectInfo in x211044_g_PROTECT do
			for j, NpcID in x211044_g_ProtectNPCID do 
				if  GetName(sceneId, NpcID)==ProtectInfo.name  then		
					local targetX, targetZ = GetWorldPos(sceneId, NpcID)
					--local x, z = GetLastPatrolPoint(sceneId, ProtectInfo.patrol)
					local x,z =113,134
					local distance = floor(sqrt((targetX-x)*(targetX-x)+(targetZ-z)*(targetZ-z)))
					-- 到达终点
					if distance<=1  then
						for i=1, x211044_g_PROTECTINFO.PlayerNum  do
							if x211044_g_PROTECTINFO.PlayerId[i]~=0   then
								-- 检测玩家是不是有这个任务
								if IsHaveMission(sceneId,x211044_g_PROTECTINFO.PlayerId[i],x211044_g_MissionId) > 0 then
									local misIndex = GetMissionIndexByID(sceneId, x211044_g_PROTECTINFO.PlayerId[i], x211044_g_MissionId)
									for i, QuestInfo in x211044_g_Quest do
										if QuestInfo.type == "PROTECT" then
											SetMissionByIndex(sceneId,x211044_g_PROTECTINFO.PlayerId[i],misIndex,QuestInfo.order-1,1)
										end
									end
									BeginEvent(sceneId)
										strText = ProtectInfo.info.."  1/1"
										AddText(sceneId,strText);
									EndEvent(sceneId)
									DispatchMissionTips(sceneId,x211044_g_PROTECTINFO.PlayerId[i])
								end
							end
						end
						LuaFnDeleteMonster(sceneId, NpcID)
						bDone = bDone + 1
					end								
				end
			end
		end
		if (bDone >= getn(x211044_g_PROTECT)) then
			x211044_g_PROTECTINFO.Step = 5
			-- 关闭计时器
			x211044_CloseTimer(sceneId, x211044_g_PROTECTINFO.ScneneTimerIndex)
		end
	end
end

--**********************************
--关闭计时器
--**********************************
function x211044_CloseTimer( sceneId, TimerIndex )
	StopTimer(sceneId, TimerIndex)
	x211044_g_PROTECTINFO.ScneneTimerIndex = -1
	x211044_g_PROTECTINFO.Step = 0
	x211044_g_PROTECTINFO.StartTime = 0
	x211044_g_PROTECTINFO.PlayerNum = 0
	for i =1, getn(x211044_g_PROTECTINFO.PlayerId) do
		x211044_g_PROTECTINFO.PlayerId[i]=0
	end
	x211044_g_ProtectNPCID = {}
end





--**********************************

--放弃

--**********************************

function x211044_OnAbandon(sceneId, selfId)
	x211044_g_QuestOrder(x211044_g_QuestType)
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x211044_g_MissionId )
end



--**********************************

--检测是否可以提交

--**********************************

function x211044_CheckSubmit( sceneId, selfId, targetId)
	x211044_g_QuestOrder(x211044_g_QuestType)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x211044_g_MissionId)
	local bDone = 1
	for i, QuestInfo in x211044_g_Quest do
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

function x211044_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	x211044_g_QuestOrder(x211044_g_QuestType)
	if (x211044_CheckSubmit( sceneId, selfId ) == 1) then
		BeginAddItem(sceneId)
		local givebonus = 0
		local giveitem = 0
		if (getn(x211044_g_ItemBonus) ==0)  and  (getn(x211044_g_RadioItemBonus) == 0 ) then
			givebonus = 1
		else
			for i, item in x211044_g_ItemBonus do
				if item.id>0 and item.num>0 then
					AddItem( sceneId,item.id, item.num )
					giveitem = 1
				end
			end
			for i, item in x211044_g_RadioItemBonus do
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
			ret = DelMission( sceneId, selfId, x211044_g_MissionId )
			if ret > 0 then
				for i, QuestInfo in x211044_g_Quest do
					if QuestInfo.type ==  "DELIVERY" then
						if getn(x211044_g_DELIVERY) == 1 and QuestInfo == x211044_g_DELIVERY[1] then
							if QuestInfo.npc == x211044_g_NameEnd and QuestInfo.item > 0 and QuestInfo.num > 0 then
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
				MissionCom( sceneId,selfId, x211044_g_MissionId )
				if (x211044_g_ExpBonustxt~=nil) then
					LuaFnAddExp( sceneId, selfId,x211044_g_ExpBonus(sceneId, selfId, x211044_g_exp))
				end					
				if (x211044_g_MoneyBonustxt~=nil) then
					AddMoney(sceneId,selfId,x211044_g_MoneyBonus(sceneId, selfId, x211044_g_money) );
				end
				if giveitem > 0 then
					AddItemListToHuman(sceneId,selfId)
				end
				BeginEvent(sceneId)
				  	strText = "你完成了任务  "..x211044_g_MissionName
				  	AddText(sceneId,strText);
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				if (x211044_g_ScriptIdNext.ScriptId~=nil) and (x211044_g_ScriptIdNext.ScriptId>0) then
					local CanNext = CallScriptFunction( x211044_g_ScriptIdNext.ScriptId, "CheckAccept",sceneId, selfId, targetId )
					if (CanNext == 1) then
						CallScriptFunction( x211044_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
					else
						BeginEvent(sceneId)
							AddText(sceneId,"等你到了"..x211044_g_ScriptIdNext.LV.."级再来找我，我还有很重要的事要交给你去做。千万记住了！")
						EndEvent( )	
						DispatchEventList(sceneId,selfId,targetId)
					end
				end
			end
		end
	end
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211044_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211044_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211044_OnItemChanged(sceneId, selfId, itemdataId)

end