--受伤的别儿哥

--MisDescBegin
x223013_g_ScriptId = 223013
x223013_g_MissionIdPre =304
x223013_g_MissionId = 305
x223013_g_MissionKind = 20
x223013_g_MissionLevel = 100
--x223013_g_ScriptIdNext = {ScriptId = 207007 ,LV = 1 }
x223013_g_Name	="别儿哥" 
x223013_g_Name2	="速不台" 
x223013_g_MissionName="受伤的别儿哥"
x223013_g_MissionInfo="    钦察人伏击我们的时候，为了让兄弟们先行撤退，我引开了他们的注意力，现在我受伤了，已经无法砍杀这些钦察人了。勇士，你能护送我回到营地吗？"
x223013_g_MissionTarget="    护送别儿哥到蒙军营地后向#G速不台#W复命。"		
x223013_g_MissionComplete="    别儿哥已经回来了，现在正在养伤。感谢你，没有你的出现或许我就见不到我的兄弟了，我欠你一份情！"					--完成任务npc说话的话
x223013_g_ContinueInfo = "    你见到别儿哥受伤了？他人呢？"

--任务奖励
--金钱奖励
x223013_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x223013_g_ItemBonus={}

--可选物品奖励，最多8种
x223013_g_RadioItemBonus={}

--MisDescEnd
x223013_g_ExpBonus = 1000

if x223013_g_husongobj == nil then
	x223013_g_husongobj = 0
end
if x223013_g_husongid == nil then
	x223013_g_husongid = 0
end
if x223013_g_PROTECTINFO == nil then
	x223013_g_PROTECTINFO={ScneneTimerIndex = -1, Step = 0, StartTime = 0, PlayerNum = 0, PlayerId= {0,0,0,0,0,0}}
end
--**********************************

--任务入口函数

--**********************************

function x223013_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x223013_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x223013_g_MissionId) > 0 then
		misIndex = GetMissionIndexByID(sceneId,selfId,x223013_g_MissionId)
		if x223013_CheckSubmit(sceneId, selfId, targetId) > 0 then
			BeginEvent(sceneId)
                	AddText(sceneId,"#Y"..x223013_g_MissionName)
			AddText(sceneId,x223013_g_MissionComplete)
			AddMoneyBonus(sceneId, x223013_g_MoneyBonus)
			EndEvent()
                	DispatchMissionContinueInfo(sceneId, selfId, targetId, x223013_g_ScriptId, x223013_g_MissionId)
               else
			BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x223013_g_MissionName)
			AddText(sceneId,x223013_g_ContinueInfo)
			AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x223013_g_MissionTarget) 
			AddText(sceneId,format("\n    护送别儿哥到蒙军营地   %d/1", GetMissionParam(sceneId,selfId,misIndex,0) ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end
        elseif x223013_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x223013_g_MissionName)
                AddText(sceneId,x223013_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x223013_g_MissionTarget) 
		AddMoneyBonus(sceneId, x223013_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x223013_g_ScriptId, x223013_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x223013_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x223013_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x223013_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x223013_g_ScriptId, x223013_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x223013_CheckAccept(sceneId, selfId, targetId)
	
	if (GetName(sceneId,targetId)==x223013_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x223013_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==17) then
		if IsMissionHaveDone(sceneId, selfId, x223013_g_MissionIdPre) > 0 then
			if (GetName(sceneId,targetId)==x223013_g_Name) then 
				x223013_g_husongid = targetId
				if IsHaveMission(sceneId,selfId, x223013_g_MissionId) <= 0 then
					if x223013_g_husongobj == 0 then
						return 1
					end
				end
			end
			if (GetName(sceneId,targetId)==x223013_g_Name2) then 
				if x223013_g_husongobj == 0 then
					SetPatrolId(sceneId, x223013_g_husongid, -1)
					if IsHaveMission(sceneId,selfId, x223013_g_MissionId) > 0 then
						return 1
					end
				end
				if x223013_g_husongobj == 1 then
					if IsHaveMission(sceneId,selfId, x223013_g_MissionId) > 0 then
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

function x223013_OnAccept(sceneId, selfId)
	if x223013_g_husongobj == 0 then
		if x223013_g_PROTECTINFO.Step == 0  then
			x223013_g_husongobj = 1
	        	BeginEvent(sceneId)
			AddMission( sceneId, selfId, x223013_g_MissionId, x223013_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x223013_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)
			x223013_g_PROTECTINFO.PlayerNum = 1                    
			x223013_g_PROTECTINFO.PlayerId[1] = selfId             
                        x223013_g_PROTECTINFO.Step = 1                         
			x223013_g_PROTECTINFO.StartTime = LuaFnGetCurrentTime()
			x223013_g_PROTECTINFO.ScneneTimerIndex = SetTimer(sceneId, selfId, 223013, "OnScneneTimer", 1)
	        	
			
			
	       
		elseif x223013_g_PROTECTINFO.Step == 2  then
			if x223013_g_PROTECTINFO.PlayerNum > 5  then
				return
			end
			x223013_g_PROTECTINFO.PlayerNum = x223013_g_PROTECTINFO.PlayerNum + 1
			x223013_g_PROTECTINFO.PlayerId[x223013_g_PROTECTINFO.PlayerNum] = selfId
			BeginEvent(sceneId)
			AddMission( sceneId, selfId, x223013_g_MissionId, x223013_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x223013_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)
		end	
	elseif x223013_g_husongobj ~= 0 then 
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

function x223013_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x223013_g_MissionId)
	for i=1, x223013_g_PROTECTINFO.PlayerNum  do
		if x223013_g_PROTECTINFO.PlayerId[i] == selfId  then
			x223013_g_PROTECTINFO.PlayerId[i] = 0
		end
	end
	
end



--**********************************

--检测是否可以提交

--**********************************

function x223013_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x223013_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == 1 then
			return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x223013_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x223013_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x223013_g_MissionId)
		AddExp(sceneId, selfId, x223013_g_ExpBonus)
		AddMoney(sceneId, selfId, x223013_g_MoneyBonus)
		for i, item in x223013_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end
	        --CallScriptFunction( x223013_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )

	end
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x223013_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************





--**********************************

--道具改变

--**********************************

function x223013_OnItemChanged(sceneId, selfId, itemdataId)

end


--**********************************

--计时器

--**********************************

function x223013_OnScneneTimer(sceneId, selfId)
	if x223013_g_PROTECTINFO.Step == 1   then
		local nMonsterNum = GetMonsterCount(sceneId)
		local m = 0
		local HeadNPCID = 0
		for m=0, nMonsterNum-1 do
			local nMonsterId = GetMonsterObjID(sceneId,m)
			if GetName(sceneId, nMonsterId)  == x223013_g_Name  then
				HeadNPCID = nMonsterId
			end
		end
		local nTeamCount = GetNearTeamCount(sceneId, selfId)
		for i=0, nTeamCount-1 do
			local PlayerId = GetNearTeamMember(sceneId, selfId, i)
			if PlayerId ~= selfId    then
				CallScriptFunction((223013), "OnDefaultEvent", sceneId, PlayerId, HeadNPCID )
			end
		end
		x223013_g_PROTECTINFO.Step = 2
	end
	if x223013_g_PROTECTINFO.Step == 2   then
		if LuaFnGetCurrentTime() - x223013_g_PROTECTINFO.StartTime >= 10   then
			x223013_g_PROTECTINFO.Step = 3
		end
	end
	-- 有玩家点击了开始护送
	if x223013_g_PROTECTINFO.Step == 3   then
		SetPatrolId(sceneId, x223013_g_husongid, 0)
		x223013_g_PROTECTINFO.Step = 4
	end
	-- 护送过程
	if x223013_g_PROTECTINFO.Step == 4   then
		if x223013_g_husongobj < 1   then
			x223013_CloseTimer(sceneId, x223013_g_PROTECTINFO.ScneneTimerIndex)
			return
		end
		if x223013_g_husongobj ~= 0   then
			local targetX, targetZ = GetWorldPos(sceneId, x223013_g_husongid)
			for i=1, x223013_g_PROTECTINFO.PlayerNum  do
				if x223013_g_PROTECTINFO.PlayerId[i] ~= 0  then
					local nPlayerX, nPlayerZ = GetWorldPos(sceneId, x223013_g_PROTECTINFO.PlayerId[i])
					local distance1 = floor(sqrt((targetX-nPlayerX)*(targetX-nPlayerX)+(targetZ-nPlayerZ)*(targetZ-nPlayerZ)))
					if distance1 > 20    then
						BeginEvent(sceneId)
						strText = x223013_g_MissionName.."  失败"
						AddText(sceneId,strText);
						EndEvent(sceneId)
						DispatchMissionTips(sceneId,x223013_g_PROTECTINFO.PlayerId[i])
						x223013_g_PROTECTINFO.PlayerId[i] = 0
					end
				end
			end
			local targetX, targetZ = GetWorldPos(sceneId, x223013_g_husongid)
			--local x, z = GetLastPatrolPoint(sceneId, ProtectInfo.patrol)
			local x,z =39.9,211.1
			local distance = floor(sqrt((targetX-x)*(targetX-x)+(targetZ-z)*(targetZ-z)))
			if distance<=1  then
				for i=1, x223013_g_PROTECTINFO.PlayerNum  do
					if x223013_g_PROTECTINFO.PlayerId[i]~=0   then
						if IsHaveMission(sceneId,x223013_g_PROTECTINFO.PlayerId[i],x223013_g_MissionId) > 0 then
							local misIndex = GetMissionIndexByID(sceneId, x223013_g_PROTECTINFO.PlayerId[i], x223013_g_MissionId)
							SetMissionByIndex(sceneId,x223013_g_PROTECTINFO.PlayerId[i],misIndex,0,1)
							BeginEvent(sceneId)
							AddText(sceneId,format("    护送别儿哥到蒙军营地   %d/1", GetMissionParam(sceneId,selfId,misIndex,0) ))
							EndEvent(sceneId)
							DispatchMissionTips(sceneId,x223013_g_PROTECTINFO.PlayerId[i])
						end
					end
				end
				x223013_g_PROTECTINFO.Step = 5
				x223013_CloseTimer(sceneId, x223013_g_PROTECTINFO.ScneneTimerIndex)
			end								
		end
	end
end


--**********************************
--关闭计时器
--**********************************
function x223013_CloseTimer( sceneId, TimerIndex )
	StopTimer(sceneId, TimerIndex)
	x223013_g_PROTECTINFO.ScneneTimerIndex = -1
	x223013_g_PROTECTINFO.Step = 0
	x223013_g_PROTECTINFO.StartTime = 0
	x223013_g_PROTECTINFO.PlayerNum = 0
	for i =1, getn(x223013_g_PROTECTINFO.PlayerId) do
		x223013_g_PROTECTINFO.PlayerId[i]=0
	end
	x223013_g_husongobj = 0
	SetPatrolId(sceneId, x223013_g_husongid, -1)
end