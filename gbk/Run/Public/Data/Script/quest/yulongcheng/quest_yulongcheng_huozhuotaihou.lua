--活捉太后

--MisDescBegin
x208009_g_ScriptId = 208009
x208009_g_MissionIdPre =62
x208009_g_MissionId = 63
x208009_g_MissionKind = 12
x208009_g_MissionLevel = 60
--x208009_g_ScriptIdNext = {ScriptId = 207007 ,LV = 1 }
x208009_g_Name	="速不台" 
x208009_g_Name2	="秃儿太后" 
x208009_g_noDemandItem ={}
x208009_g_DemandKill ={{id=316,num=15}}
x208009_g_MissionName="活捉太后"
x208009_g_MissionInfo="    我们的第一梯队攻上了城池，打开了城门，我们的苏鲁锭插在了他们皇宫的最高处。成吉思汗已经下令，不管付出什么代价，一定要找出魔诃魔和扎兰丁！他们两个人踪迹，至今没有找到，不过，有士兵来报，花剌子模的#G秃儿太后#W躲在（96，52）处，你去把他们剿灭，活捉太后！"
x208009_g_MissionTarget="    杀死15个#R玉龙城御卫兵#W，活捉#G秃儿太后#W，带回给#G速不台#W。"		
x208009_g_MissionComplete="    秃儿太后已经被我们收押，我会尽快审问她，她一定知道魔诃魔父子的下落。"					--完成任务npc说话的话
x208009_g_ContinueInfo = "    秃儿太后有皇宫侍卫守着，你要小心为上。"

--任务奖励
--金钱奖励
x208009_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x208009_g_ItemBonus={}

--可选物品奖励，最多8种
x208009_g_RadioItemBonus={}

--MisDescEnd
x208009_g_ExpBonus = 1000

if x208009_g_husongobj == nil then
	x208009_g_husongobj = 0
end
if x208009_g_husongid == nil then
	x208009_g_husongid = 0
end
if x208009_g_PROTECTINFO == nil then
	x208009_g_PROTECTINFO={ScneneTimerIndex = -1, Step = 0, StartTime = 0, PlayerNum = 0, PlayerId= {0,0,0,0,0,0}}
end
--**********************************

--任务入口函数

--**********************************

function x208009_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x208009_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x208009_g_MissionId) > 0 then
		misIndex = GetMissionIndexByID(sceneId,selfId,x208009_g_MissionId)
		if (GetName(sceneId,targetId)==x208009_g_Name) then
			if x208009_CheckSubmit(sceneId, selfId, targetId) > 0 then
				BeginEvent(sceneId)
	                	AddText(sceneId,"#Y"..x208009_g_MissionName)
				AddText(sceneId,x208009_g_MissionComplete)
				AddMoneyBonus(sceneId, x208009_g_MoneyBonus)
				EndEvent()
	                	DispatchMissionContinueInfo(sceneId, selfId, targetId, x208009_g_ScriptId, x208009_g_MissionId)
	               else
				BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x208009_g_MissionName)
				AddText(sceneId,x208009_g_ContinueInfo)
				AddText(sceneId,"#Y任务目标#W") 
				AddText(sceneId,x208009_g_MissionTarget) 
				AddText(sceneId,format("    把秃儿皇后带到速不台处   %d/1\n    杀死玉龙城御卫兵   %d/15", GetMissionParam(sceneId,selfId,misIndex,0), GetMissionParam(sceneId,selfId,misIndex,1) ))
				EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
			end
		end
		if (GetName(sceneId,targetId)==x208009_g_Name2) then
			if x208009_g_husongobj == 0 then
				BeginEvent(sceneId)
				AddText(sceneId,"安心上路！")
				EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
				if x208009_g_PROTECTINFO.Step == 0  then
					x208009_g_husongobj = 1
	        			x208009_g_PROTECTINFO.PlayerNum = 1                    
					x208009_g_PROTECTINFO.PlayerId[1] = selfId             
                        		x208009_g_PROTECTINFO.Step = 1                         
					x208009_g_PROTECTINFO.StartTime = LuaFnGetCurrentTime()
					x208009_g_PROTECTINFO.ScneneTimerIndex = SetTimer(sceneId, selfId, 208009, "OnScneneTimer", 1)
	        	
				elseif x208009_g_PROTECTINFO.Step == 2  then
					if x208009_g_PROTECTINFO.PlayerNum > 5  then
						return
					end
					x208009_g_PROTECTINFO.PlayerNum = x208009_g_PROTECTINFO.PlayerNum + 1
					x208009_g_PROTECTINFO.PlayerId[x208009_g_PROTECTINFO.PlayerNum] = selfId
					
				end	
			elseif x208009_g_husongobj ~= 0 then 
				BeginEvent(sceneId)
				strText = "#Y现在不能接这个任务"
				AddText(sceneId,strText)
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
			end
		end
        elseif x208009_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x208009_g_MissionName)
                AddText(sceneId,x208009_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x208009_g_MissionTarget) 
		AddMoneyBonus(sceneId, x208009_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x208009_g_ScriptId, x208009_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x208009_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x208009_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x208009_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x208009_g_ScriptId, x208009_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x208009_CheckAccept(sceneId, selfId, targetId)
	
	if (GetName(sceneId,targetId)==x208009_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x208009_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==8) then
		if IsMissionHaveDone(sceneId, selfId, x208009_g_MissionIdPre) > 0 then
			if (GetName(sceneId,targetId)==x208009_g_Name) then 
				return 1
			end
			if (GetName(sceneId,targetId)==x208009_g_Name2) then 
				x208009_g_husongid = targetId
					if x208009_g_husongobj == 0 then
						if IsHaveMission(sceneId,selfId, x208009_g_MissionId) > 0 then
							misIndex = GetMissionIndexByID(sceneId,selfId,x208009_g_MissionId)
							if GetMissionParam(sceneId,selfId,misIndex,0) == 0 then
								return 1
							end
						end
					end
			end
			
		end
	end
	return 0
	
end

--**********************************

--接受

--**********************************

function x208009_OnAccept(sceneId, selfId)
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x208009_g_MissionId, x208009_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x208009_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
end



--**********************************

--放弃

--**********************************

function x208009_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x208009_g_MissionId)
	for i=1, x208009_g_PROTECTINFO.PlayerNum  do
		if x208009_g_PROTECTINFO.PlayerId[i] == selfId  then
			x208009_g_PROTECTINFO.PlayerId[i] = 0
		end
	end
	for i, item in pairs(x208009_g_noDemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end
end



--**********************************

--检测是否可以提交

--**********************************

function x208009_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x208009_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == 1 then
		if GetMissionParam(sceneId,selfId,misIndex,1) == x208009_g_DemandKill[1].num then
			return 1
		end
	end
	return 0

end



--**********************************

--提交

--**********************************

function x208009_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x208009_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x208009_g_MissionId)
		AddExp(sceneId, selfId, x208009_g_ExpBonus)
		AddMoney(sceneId, selfId, x208009_g_MoneyBonus)
		for i, item in pairs(x208009_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end
	        --CallScriptFunction( x208009_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )

	end
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x208009_OnKillObject(sceneId, selfId, objdataId)
	if IsHaveMission(sceneId, selfId, x208009_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x208009_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,1) 
	 	 if objdataId == x208009_g_DemandKill[1].id then 
       		    if num < x208009_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,1,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死玉龙城御卫兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,1),x208009_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       	end
end



--**********************************

--进入区域事件

--**********************************

function x208009_OnEnterArea(sceneId, selfId, zoneId)
	
end

function x208009_OnLeaveArea(sceneId, selfId )
	
end

function x208009_OnTimer(sceneId, selfId )

end



--**********************************

--道具改变

--**********************************

function x208009_OnItemChanged(sceneId, selfId, itemdataId)

end


--**********************************

--计时器

--**********************************

function x208009_OnScneneTimer(sceneId, selfId)
	if x208009_g_PROTECTINFO.Step == 1   then
		local nMonsterNum = GetMonsterCount(sceneId)
		local m = 0
		local HeadNPCID = 0
		for m=0, nMonsterNum-1 do
			local nMonsterId = GetMonsterObjID(sceneId,m)
			if GetName(sceneId, nMonsterId)  == x208009_g_Name  then
				HeadNPCID = nMonsterId
			end
		end
		local nTeamCount = GetNearTeamCount(sceneId, selfId)
		for i=0, nTeamCount-1 do
			local PlayerId = GetNearTeamMember(sceneId, selfId, i)
			if PlayerId ~= selfId    then
				CallScriptFunction((208009), "OnDefaultEvent", sceneId, PlayerId, HeadNPCID )
			end
		end
		x208009_g_PROTECTINFO.Step = 2
	end
	if x208009_g_PROTECTINFO.Step == 2   then
		if LuaFnGetCurrentTime() - x208009_g_PROTECTINFO.StartTime >= 10   then
			x208009_g_PROTECTINFO.Step = 3
		end
	end
	-- 有玩家点击了开始护送
	if x208009_g_PROTECTINFO.Step == 3   then
		SetPatrolId(sceneId, x208009_g_husongid, 2)
		x208009_g_PROTECTINFO.Step = 4
	end
	-- 护送过程
	if x208009_g_PROTECTINFO.Step == 4   then
		if x208009_g_husongobj < 1   then
			x208009_CloseTimer(sceneId, x208009_g_PROTECTINFO.ScneneTimerIndex)
			return
		end
		if x208009_g_husongobj ~= 0   then
			local targetX, targetZ = GetWorldPos(sceneId, x208009_g_husongid)
			for i=1, x208009_g_PROTECTINFO.PlayerNum  do
				if x208009_g_PROTECTINFO.PlayerId[i] ~= 0  then
					local nPlayerX, nPlayerZ = GetWorldPos(sceneId, x208009_g_PROTECTINFO.PlayerId[i])
					local distance1 = floor(sqrt((targetX-nPlayerX)*(targetX-nPlayerX)+(targetZ-nPlayerZ)*(targetZ-nPlayerZ)))
					if distance1 > 20    then
						BeginEvent(sceneId)
						strText = x208009_g_MissionName.."  失败"
						AddText(sceneId,strText);
						EndEvent(sceneId)
						DispatchMissionTips(sceneId,x208009_g_PROTECTINFO.PlayerId[i])
						x208009_g_PROTECTINFO.PlayerId[i] = 0
					end
				end
			end
			local targetX, targetZ = GetWorldPos(sceneId, x208009_g_husongid)
			--local x, z = GetLastPatrolPoint(sceneId, ProtectInfo.patrol)
			local x,z =70.9,180.6
			local distance = floor(sqrt((targetX-x)*(targetX-x)+(targetZ-z)*(targetZ-z)))
			if distance<=1  then
				for i=1, x208009_g_PROTECTINFO.PlayerNum  do
					if x208009_g_PROTECTINFO.PlayerId[i]~=0   then
						if IsHaveMission(sceneId,x208009_g_PROTECTINFO.PlayerId[i],x208009_g_MissionId) > 0 then
							local misIndex = GetMissionIndexByID(sceneId, x208009_g_PROTECTINFO.PlayerId[i], x208009_g_MissionId)
							SetMissionByIndex(sceneId,x208009_g_PROTECTINFO.PlayerId[i],misIndex,0,1)
							BeginEvent(sceneId)
							AddText(sceneId,format("把秃儿皇后带到速不台处   %d/1", GetMissionParam(sceneId,selfId,misIndex,0) ))
							EndEvent(sceneId)
							DispatchMissionTips(sceneId,x208009_g_PROTECTINFO.PlayerId[i])
						end
					end
				end
				x208009_g_PROTECTINFO.Step = 5
				x208009_CloseTimer(sceneId, x208009_g_PROTECTINFO.ScneneTimerIndex)
			end								
		end
	end
end


--**********************************
--关闭计时器
--**********************************
function x208009_CloseTimer( sceneId, TimerIndex )
	StopTimer(sceneId, TimerIndex)
	x208009_g_PROTECTINFO.ScneneTimerIndex = -1
	x208009_g_PROTECTINFO.Step = 0
	x208009_g_PROTECTINFO.StartTime = 0
	x208009_g_PROTECTINFO.PlayerNum = 0
	for i =1, getn(x208009_g_PROTECTINFO.PlayerId) do
		x208009_g_PROTECTINFO.PlayerId[i]=0
	end
	x208009_g_husongobj = 0
	SetPatrolId(sceneId, x208009_g_husongid, -1)
end