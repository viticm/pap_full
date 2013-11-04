--护花使者

--MisDescBegin
x206009_g_ScriptId = 206009
x206009_g_MissionIdPre =35
x206009_g_MissionId = 36
x206009_g_MissionKind = 8
x206009_g_MissionLevel = 40
x206009_g_ScriptIdNext = {ScriptId = 206010 ,LV = 1 }
x206009_g_Name	="成吉思汗" 
x206009_g_Name2	="窝阔台" 
x206009_g_husongName	="忽兰公主" 

x206009_g_MissionName="护花使者"
x206009_g_MissionInfo="    这是我第一次见到成吉思汗，他没有我想象的这样威武和严肃，而是一脸的和蔼，让我记忆最深刻的就是他的眼睛，充满了坚定，果断和智慧。\n \n    当大汗看到阔阔出大巫师的推荐信的时候，脸上热情了许多，但是我却感觉到，他的眼睛里多了一层疑惑，用眼角的余光在不断的打量我。\n \n    千年龟王的事情，让我感觉阔阔出和大汗似乎还有一些我不知道的秘密……，看来，是我多心了，成吉思汗居然放心让我护送他的爱妃忽兰公主去劝降，我成了这次的护花使者。"  --任务描述
x206009_g_MissionTarget="    忽兰公主带了成吉思汗的口谕，我的任务是保护好公主，把她护送到三王子#G窝阔台#W处。"		
x206009_g_MissionComplete="    不知道该怎么表达我的心情，大汗第一次见到，居然让我护送他最喜欢的人，这样的信任，让我十分的感激。\n \n    我只是一个下人，一个粗人，一个莽夫！混迹在乱世中，无非就是希望遇到一个值得信任的人。\n \n    这一刻开始，我已经决定了这一生，会跟随成吉思汗！除了要报答知遇之恩，我还是有私心的，也许是为了我怀里的那一张手帕，那是忽兰公主给我擦汗……我一直偷偷的收藏着。"					--完成任务npc说话的话
x206009_g_ContinueInfo = "    忽兰公主是大汗的最心爱的王妃！"

--任务奖励
--金钱奖励
x206009_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x206009_g_ItemBonus={}

--可选物品奖励，最多8种
x206009_g_RadioItemBonus={}

--MisDescEnd
x206009_g_ExpBonus = 1000

if x206009_g_PROTECTINFO == nil then
	x206009_g_PROTECTINFO={ScneneTimerIndex = -1, Step = 0, StartTime = 0, PlayerNum = 0, PlayerId= {0,0,0,0,0,0}}
end
if x206009_g_husongobj == nil then
	x206009_g_husongobj = 0
end


--**********************************

--任务入口函数

--**********************************

function x206009_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x206009_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x206009_g_MissionId) > 0 then
		misIndex = GetMissionIndexByID(sceneId,selfId,x206009_g_MissionId)
		if x206009_CheckSubmit(sceneId, selfId, targetId) > 0 then
			BeginEvent(sceneId)
                	AddText(sceneId,"#Y"..x206009_g_MissionName)
			AddText(sceneId,x206009_g_MissionComplete)
			AddMoneyBonus(sceneId, x206009_g_MoneyBonus)
                	EndEvent()
			DispatchMissionContinueInfo(sceneId, selfId, targetId, x206009_g_ScriptId, x206009_g_MissionId)
               else
			BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x206009_g_MissionName)
			AddText(sceneId,x206009_g_ContinueInfo)
			AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x206009_g_MissionTarget) 
			AddText(sceneId,format("    护送忽兰公主   %d/1", GetMissionParam(sceneId,selfId,misIndex,0) ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end
        elseif x206009_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x206009_g_MissionName)
                AddText(sceneId,x206009_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x206009_g_MissionTarget) 
		AddMoneyBonus(sceneId, x206009_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x206009_g_ScriptId, x206009_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x206009_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x206009_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x206009_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x206009_g_ScriptId, x206009_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x206009_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x206009_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x206009_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==6) then
		if IsMissionHaveDone(sceneId, selfId, x206009_g_MissionIdPre) > 0 then
		        if (GetName(sceneId,targetId)==x206009_g_Name) then
		                if IsHaveMission(sceneId,selfId, x206009_g_MissionId)<= 0 then
		                    return 1
		                end
		        end
			if (GetName(sceneId,targetId)==x206009_g_Name2) then
				    if IsHaveMission(sceneId,selfId, x206009_g_MissionId) > 0 then
				    	return 1
		                    end
		        end
		end
	end
        return 0
	
end

--**********************************

--接受

--**********************************

function x206009_OnAccept(sceneId, selfId)
	if x206009_g_husongobj == 0 then
		if x206009_g_PROTECTINFO.Step == 0  then
			x206009_g_husongobj = LuaFnCreateMonster(sceneId,63,38.4042,100.1512,0,1,-1)
	        	BeginEvent(sceneId)
			AddMission( sceneId, selfId, x206009_g_MissionId, x206009_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x206009_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)
			x206009_g_PROTECTINFO.PlayerNum = 1                    
			x206009_g_PROTECTINFO.PlayerId[1] = selfId             
                        x206009_g_PROTECTINFO.Step = 1                         
			x206009_g_PROTECTINFO.StartTime = LuaFnGetCurrentTime()
			x206009_g_PROTECTINFO.ScneneTimerIndex = SetTimer(sceneId, selfId, 206009, "OnScneneTimer", 1)
			
	       
		elseif x206009_g_PROTECTINFO.Step == 2  then
			if x206009_g_PROTECTINFO.PlayerNum > 5  then
				return
			end
			x206009_g_PROTECTINFO.PlayerNum = x206009_g_PROTECTINFO.PlayerNum + 1
			x206009_g_PROTECTINFO.PlayerId[x206009_g_PROTECTINFO.PlayerNum] = selfId
			BeginEvent(sceneId)
			AddMission( sceneId, selfId, x206009_g_MissionId, x206009_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x206009_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)
		end	
	elseif x206009_g_husongobj ~= 0 then 
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

function x206009_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x206009_g_MissionId)
	for i=1, x206009_g_PROTECTINFO.PlayerNum  do
		if x206009_g_PROTECTINFO.PlayerId[i] == selfId  then
			x206009_g_PROTECTINFO.PlayerId[i] = 0
		end
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x206009_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x206009_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == 1 then
		return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x206009_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x206009_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x206009_g_MissionId)
		AddExp(sceneId, selfId, x206009_g_ExpBonus)
		AddMoney(sceneId, selfId, x206009_g_MoneyBonus)
		for i, item in x206009_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end
	        CallScriptFunction( x206009_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )

	end
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x206009_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x206009_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x206009_OnItemChanged(sceneId, selfId, itemdataId)

end


--**********************************

--计时器

--**********************************

function x206009_OnScneneTimer(sceneId, selfId)
	if x206009_g_PROTECTINFO.Step == 1   then
		local nMonsterNum = GetMonsterCount(sceneId)
		local m = 0
		local HeadNPCID = 0
		for m=0, nMonsterNum-1 do
			local nMonsterId = GetMonsterObjID(sceneId,m)
			if GetName(sceneId, nMonsterId)  == x206009_g_Name  then
				HeadNPCID = nMonsterId
			end
		end
		local nTeamCount = GetNearTeamCount(sceneId, selfId)
		for i=0, nTeamCount-1 do
			local PlayerId = GetNearTeamMember(sceneId, selfId, i)
			if PlayerId ~= selfId    then
				CallScriptFunction((206009), "OnDefaultEvent", sceneId, PlayerId, HeadNPCID )
			end
		end
		x206009_g_PROTECTINFO.Step = 2
	end
	if x206009_g_PROTECTINFO.Step == 2   then
		if LuaFnGetCurrentTime() - x206009_g_PROTECTINFO.StartTime >= 10   then
			x206009_g_PROTECTINFO.Step = 3
		end
	end
	-- 有玩家点击了开始护送
	if x206009_g_PROTECTINFO.Step == 3   then
		SetPatrolId(sceneId, x206009_g_husongobj, 0)
		x206009_g_PROTECTINFO.Step = 4
	end
	-- 护送过程
	if x206009_g_PROTECTINFO.Step == 4   then
		if x206009_g_husongobj < 1   then
			x206009_CloseTimer(sceneId, x206009_g_PROTECTINFO.ScneneTimerIndex)
			return
		end
		if x206009_g_husongobj ~= 0   then
			local targetX, targetZ = GetWorldPos(sceneId, x206009_g_husongobj)
			for i=1, x206009_g_PROTECTINFO.PlayerNum  do
				if x206009_g_PROTECTINFO.PlayerId[i] ~= 0  then
					local nPlayerX, nPlayerZ = GetWorldPos(sceneId, x206009_g_PROTECTINFO.PlayerId[i])
					local distance1 = floor(sqrt((targetX-nPlayerX)*(targetX-nPlayerX)+(targetZ-nPlayerZ)*(targetZ-nPlayerZ)))
					if distance1 > 20    then
						BeginEvent(sceneId)
						strText = x206009_g_MissionName.."  失败"
						AddText(sceneId,strText);
						EndEvent(sceneId)
						DispatchMissionTips(sceneId,x206009_g_PROTECTINFO.PlayerId[i])
						x206009_g_PROTECTINFO.PlayerId[i] = 0
					end
				end
			end
			local targetX, targetZ = GetWorldPos(sceneId, x206009_g_husongobj)
			--local x, z = GetLastPatrolPoint(sceneId, ProtectInfo.patrol)
			local x,z =159.7537,53.5807
			local distance = floor(sqrt((targetX-x)*(targetX-x)+(targetZ-z)*(targetZ-z)))
			if distance<=1  then
				for i=1, x206009_g_PROTECTINFO.PlayerNum  do
					if x206009_g_PROTECTINFO.PlayerId[i]~=0   then
						if IsHaveMission(sceneId,x206009_g_PROTECTINFO.PlayerId[i],x206009_g_MissionId) > 0 then
							local misIndex = GetMissionIndexByID(sceneId, x206009_g_PROTECTINFO.PlayerId[i], x206009_g_MissionId)
							SetMissionByIndex(sceneId,x206009_g_PROTECTINFO.PlayerId[i],misIndex,0,1)
							BeginEvent(sceneId)
							AddText(sceneId,format("    护送忽兰公主   %d/1", GetMissionParam(sceneId,selfId,misIndex,0) ))
							EndEvent(sceneId)
							DispatchMissionTips(sceneId,x206009_g_PROTECTINFO.PlayerId[i])
						end
					end
				end
				LuaFnDeleteMonster (sceneId,x206009_g_husongobj )
				x206009_g_PROTECTINFO.Step = 5
				x206009_CloseTimer(sceneId, x206009_g_PROTECTINFO.ScneneTimerIndex)
			end								
		end
	end
end


--**********************************
--关闭计时器
--**********************************
function x206009_CloseTimer( sceneId, TimerIndex )
	StopTimer(sceneId, TimerIndex)
	x206009_g_PROTECTINFO.ScneneTimerIndex = -1
	x206009_g_PROTECTINFO.Step = 0
	x206009_g_PROTECTINFO.StartTime = 0
	x206009_g_PROTECTINFO.PlayerNum = 0
	for i =1, getn(x206009_g_PROTECTINFO.PlayerId) do
		x206009_g_PROTECTINFO.PlayerId[i]=0
	end
	x206009_g_husongobj = 0
end