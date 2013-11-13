--大汗的告示

--MisDescBegin
x208003_g_ScriptId = 208003
x208003_g_MissionIdPre =56
x208003_g_MissionId = 57
x208003_g_MissionKind = 12
x208003_g_MissionLevel = 60
--x208003_g_ScriptIdNext = {ScriptId = 207007 ,LV = 1 }
x208003_g_Name	="术赤" 
x208003_g_Name2	="成吉思汗" 
x208003_g_noDemandItem ={{id=13010009,num=1}}
x208003_g_MissionName="大汗的告示"
x208003_g_MissionInfo="，我们要把战旗插在花剌子模的最高处，让每天的太阳出现的时候，第一时间照到我们的战旗。让每个人一抬头，看到的就是我蒙古大国的旗帜。\n \n    这是一个光荣的任务！你要做我的贴身侍卫，安全的把我送到皇宫门口，然后，把这个告示贴在皇宫门口处！我父汗会重赏你的。"
x208003_g_MissionTarget="    奉#G成吉思汗#W命，护送术赤到皇宫门口，然后把告示贴在城门处。"		
x208003_g_MissionComplete="    谢谢你的帮忙，这是给你的奖励。"					--完成任务npc说话的话
x208003_g_ContinueInfo = "    一切都平安吗？"

--任务奖励
--金钱奖励
x208003_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x208003_g_ItemBonus={}

--可选物品奖励，最多8种
x208003_g_RadioItemBonus={}

--MisDescEnd
x208003_g_ExpBonus = 1000

if x208003_g_husongobj == nil then
	x208003_g_husongobj = 0
end
if x208003_g_husongid == nil then
	x208003_g_husongid = 0
end
if x208003_g_PROTECTINFO == nil then
	x208003_g_PROTECTINFO={ScneneTimerIndex = -1, Step = 0, StartTime = 0, PlayerNum = 0, PlayerId= {0,0,0,0,0,0}}
end
--**********************************

--任务入口函数

--**********************************

function x208003_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x208003_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x208003_g_MissionId) > 0 then
		misIndex = GetMissionIndexByID(sceneId,selfId,x208003_g_MissionId)
		if x208003_CheckSubmit(sceneId, selfId, targetId) > 0 then
			BeginEvent(sceneId)
                	AddText(sceneId,"#Y"..x208003_g_MissionName)
			AddText(sceneId,x208003_g_MissionComplete)
			AddMoneyBonus(sceneId, x208003_g_MoneyBonus)
			EndEvent()
                	DispatchMissionContinueInfo(sceneId, selfId, targetId, x208003_g_ScriptId, x208003_g_MissionId)
               else
			BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x208003_g_MissionName)
			AddText(sceneId,x208003_g_ContinueInfo)
			AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x208003_g_MissionTarget) 
			AddText(sceneId,format("\n    护送术赤到皇宫门口   %d/1\n    把告示贴在城门   %d/1", GetMissionParam(sceneId,selfId,misIndex,0), GetMissionParam(sceneId,selfId,misIndex,1) ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end
        elseif x208003_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x208003_g_MissionName)
                AddText(sceneId,"    "..GetName(sceneId, selfId)..x208003_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x208003_g_MissionTarget) 
		AddMoneyBonus(sceneId, x208003_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x208003_g_ScriptId, x208003_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x208003_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x208003_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x208003_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x208003_g_ScriptId, x208003_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x208003_CheckAccept(sceneId, selfId, targetId)
	
	if (GetName(sceneId,targetId)==x208003_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x208003_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==8) then
		if IsMissionHaveDone(sceneId, selfId, x208003_g_MissionIdPre) > 0 then
			if (GetName(sceneId,targetId)==x208003_g_Name) then 
				x208003_g_husongid = targetId
				if IsHaveMission(sceneId,selfId, x208003_g_MissionId) <= 0 then
					if x208003_g_husongobj == 0 then
						return 1
					end
				end
			end
			if (GetName(sceneId,targetId)==x208003_g_Name2) then 
				if x208003_g_husongobj == 0 then
					SetPatrolId(sceneId, x208003_g_husongid, -1)
					if IsHaveMission(sceneId,selfId, x208003_g_MissionId) > 0 then
						return 1
					end
				end
				if x208003_g_husongobj == 1 then
					if IsHaveMission(sceneId,selfId, x208003_g_MissionId) > 0 then
						return 1
					end
				end
			end
		        return 0
		end
	end
	return 0
	
end

--**********************************

--接受

--**********************************

function x208003_OnAccept(sceneId, selfId)
	if x208003_g_husongobj == 0 then
		if x208003_g_PROTECTINFO.Step == 0  then
			BeginAddItem(sceneId)                                                    
			AddItem( sceneId,x208003_g_noDemandItem[1].id, x208003_g_noDemandItem[1].num )             
			ret = EndAddItem(sceneId,selfId)                                 
	        	if ret > 0 then                                                  
	        		x208003_g_husongobj = 1
	        		BeginEvent(sceneId)
				AddMission( sceneId, selfId, x208003_g_MissionId, x208003_g_ScriptId, 1, 0, 0)
				AddText(sceneId,"接受任务："..x208003_g_MissionName) 
				EndEvent()
				DispatchMissionTips(sceneId, selfId)
				AddItemListToHuman(sceneId,selfId)
				x208003_g_PROTECTINFO.PlayerNum = 1                    
				x208003_g_PROTECTINFO.PlayerId[1] = selfId             
                        	x208003_g_PROTECTINFO.Step = 1                         
				x208003_g_PROTECTINFO.StartTime = LuaFnGetCurrentTime()
				x208003_g_PROTECTINFO.ScneneTimerIndex = SetTimer(sceneId, selfId, 208003, "OnScneneTimer", 1)
	        	else                                                             
		     		BeginEvent(sceneId)                                      
		     		AddText(sceneId,"物品栏已满，请整理下再来！")                    
		    		EndEvent(sceneId)                                        
		     		DispatchMissionTips(sceneId,selfId)                      
	        	end     
			
			
	       
		elseif x208003_g_PROTECTINFO.Step == 2  then
			if x208003_g_PROTECTINFO.PlayerNum > 5  then
				return
			end
			x208003_g_PROTECTINFO.PlayerNum = x208003_g_PROTECTINFO.PlayerNum + 1
			x208003_g_PROTECTINFO.PlayerId[x208003_g_PROTECTINFO.PlayerNum] = selfId
			BeginEvent(sceneId)
			AddMission( sceneId, selfId, x208003_g_MissionId, x208003_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x208003_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)
		end	
	elseif x208003_g_husongobj ~= 0 then 
		BeginEvent(sceneId)
		strText = "#Y现在不能接这个任务"
		AddText(sceneId,strText)
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	end
	
end



--**********************************

--放弃

--**********************************

function x208003_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x208003_g_MissionId)
	for i=1, x208003_g_PROTECTINFO.PlayerNum  do
		if x208003_g_PROTECTINFO.PlayerId[i] == selfId  then
			x208003_g_PROTECTINFO.PlayerId[i] = 0
		end
	end
	for i, item in pairs(x208003_g_noDemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end
end



--**********************************

--检测是否可以提交

--**********************************

function x208003_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x208003_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == 1 then
		if GetMissionParam(sceneId,selfId,misIndex,1) == 1 then
			return 1
		end
	end
	return 0

end



--**********************************

--提交

--**********************************

function x208003_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x208003_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x208003_g_MissionId)
		AddExp(sceneId, selfId, x208003_g_ExpBonus)
		AddMoney(sceneId, selfId, x208003_g_MoneyBonus)
		for i, item in pairs(x208003_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end
	        --CallScriptFunction( x208003_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )

	end
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x208003_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x208003_OnEnterArea(sceneId, selfId, zoneId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x208003_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,2,1)
	
end

function x208003_OnLeaveArea(sceneId, selfId )
	misIndex = GetMissionIndexByID(sceneId,selfId,x208003_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,2,0)
end

function x208003_OnTimer(sceneId, selfId )

end



--**********************************

--道具改变

--**********************************

function x208003_OnItemChanged(sceneId, selfId, itemdataId)

end


--**********************************

--计时器

--**********************************

function x208003_OnScneneTimer(sceneId, selfId)
	if x208003_g_PROTECTINFO.Step == 1   then
		local nMonsterNum = GetMonsterCount(sceneId)
		local m = 0
		local HeadNPCID = 0
		for m=0, nMonsterNum-1 do
			local nMonsterId = GetMonsterObjID(sceneId,m)
			if GetName(sceneId, nMonsterId)  == x208003_g_Name  then
				HeadNPCID = nMonsterId
			end
		end
		local nTeamCount = GetNearTeamCount(sceneId, selfId)
		for i=0, nTeamCount-1 do
			local PlayerId = GetNearTeamMember(sceneId, selfId, i)
			if PlayerId ~= selfId    then
				CallScriptFunction((208003), "OnDefaultEvent", sceneId, PlayerId, HeadNPCID )
			end
		end
		x208003_g_PROTECTINFO.Step = 2
	end
	if x208003_g_PROTECTINFO.Step == 2   then
		if LuaFnGetCurrentTime() - x208003_g_PROTECTINFO.StartTime >= 10   then
			x208003_g_PROTECTINFO.Step = 3
		end
	end
	-- 有玩家点击了开始护送
	if x208003_g_PROTECTINFO.Step == 3   then
		SetPatrolId(sceneId, x208003_g_husongid, 1)

		x208003_g_PROTECTINFO.Step = 4
	end
	-- 护送过程
	if x208003_g_PROTECTINFO.Step == 4   then
		if x208003_g_husongobj < 1   then
			x208003_CloseTimer(sceneId, x208003_g_PROTECTINFO.ScneneTimerIndex)
			return
		end
		if x208003_g_husongobj ~= 0   then
			local targetX, targetZ = GetWorldPos(sceneId, x208003_g_husongid)
			for i=1, x208003_g_PROTECTINFO.PlayerNum  do
				if x208003_g_PROTECTINFO.PlayerId[i] ~= 0  then
					local nPlayerX, nPlayerZ = GetWorldPos(sceneId, x208003_g_PROTECTINFO.PlayerId[i])
					local distance1 = floor(sqrt((targetX-nPlayerX)*(targetX-nPlayerX)+(targetZ-nPlayerZ)*(targetZ-nPlayerZ)))
					if distance1 > 20    then
						BeginEvent(sceneId)
						strText = x208003_g_MissionName.."  失败"
						AddText(sceneId,strText);
						EndEvent(sceneId)
						DispatchMissionTips(sceneId,x208003_g_PROTECTINFO.PlayerId[i])
						x208003_g_PROTECTINFO.PlayerId[i] = 0
					end
				end
			end
			local targetX, targetZ = GetWorldPos(sceneId, x208003_g_husongid)
			--local x, z = GetLastPatrolPoint(sceneId, ProtectInfo.patrol)
			local x,z =39.9,34.1
			local distance = floor(sqrt((targetX-x)*(targetX-x)+(targetZ-z)*(targetZ-z)))
			if distance<=1  then
				for i=1, x208003_g_PROTECTINFO.PlayerNum  do
					if x208003_g_PROTECTINFO.PlayerId[i]~=0   then
						if IsHaveMission(sceneId,x208003_g_PROTECTINFO.PlayerId[i],x208003_g_MissionId) > 0 then
							local misIndex = GetMissionIndexByID(sceneId, x208003_g_PROTECTINFO.PlayerId[i], x208003_g_MissionId)
							SetMissionByIndex(sceneId,x208003_g_PROTECTINFO.PlayerId[i],misIndex,0,1)
							BeginEvent(sceneId)
							AddText(sceneId,format("    护送术赤到皇宫门口   %d/1", GetMissionParam(sceneId,selfId,misIndex,0) ))
							EndEvent(sceneId)
							DispatchMissionTips(sceneId,x208003_g_PROTECTINFO.PlayerId[i])
						end
					end
				end
				x208003_g_PROTECTINFO.Step = 5
				x208003_CloseTimer(sceneId, x208003_g_PROTECTINFO.ScneneTimerIndex)
			end								
		end
	end
end


--**********************************
--关闭计时器
--**********************************
function x208003_CloseTimer( sceneId, TimerIndex )
	StopTimer(sceneId, TimerIndex)
	x208003_g_PROTECTINFO.ScneneTimerIndex = -1
	x208003_g_PROTECTINFO.Step = 0
	x208003_g_PROTECTINFO.StartTime = 0
	x208003_g_PROTECTINFO.PlayerNum = 0
	for i =1, getn(x208003_g_PROTECTINFO.PlayerId) do
		x208003_g_PROTECTINFO.PlayerId[i]=0
	end
	x208003_g_husongobj = 0
	SetPatrolId(sceneId, x208003_g_husongid, -1)
end