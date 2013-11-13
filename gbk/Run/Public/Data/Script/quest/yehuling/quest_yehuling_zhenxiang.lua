--真相

--MisDescBegin
x207018_g_ScriptId = 207018
x207018_g_MissionIdPre =18
x207018_g_MissionId = 19
x207018_g_MissionKind = 1
x207018_g_ScriptIdNext = {}
x207018_g_Name	="算命先生" 
x207018_g_Name2	="王昭君" 
x207018_g_Name3	="西施" 
x207018_g_Name4	="杨玉环" 
x207018_g_Name5	="貂禅" 
x207018_g_DemandItem ={}
x207018_g_DemandKill ={}

x207018_g_MissionName="真相"
x207018_g_MissionInfo="    看你面相，天庭饱满，一脸英气，你前途不可限量，只可惜……，印堂发黑，、煞气相冲！恩，当然，你能遇到我，算是运气，我是布衣神相的传人，能为你消灾解难！我算算……，对，你是在找人，而且是女人……，这个女人可是你的煞星，我劝你还是放弃吧！（他身后的几个女人有没有可能有术虎在其中呢？过去看看吧）"  --任务描述
x207018_g_MissionTarget="    查看四个女人"		                                                                                               
x207018_g_MissionComplete="    你能大难不死，已经渡过了这一劫，只是你找的那个人，已经走远了！我只是依书直说……"					--完成任务npc说话的话
x207018_g_ContinueInfo="    人命禀于天,则有表候于体,盖性命之著乎形骨,吉凶之表乎气貌"
x207018_g_MidInfo2="    (看她面黄肌瘦，不像是术虎！)"
x207018_g_MidInfo3="    (颇有点姿色，娴熟文静的，看起来以前是谁家的小姨太。)"
x207018_g_MidInfo4="    (咿……，这个，够丑够胖，那眉毛也很粗，应该是……，厄！差点冒犯了人家，她没有喉结，不是男的。)"
x207018_g_MidInfo5="    (这么矮的女人，也不是！)"
--任务奖励
x207018_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x207018_g_ItemBonus={}

--可选物品奖励，最多8种
x207018_g_RadioItemBonus={}

--MisDescEnd
--**********************************

--任务入口函数

--**********************************

function x207018_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207018_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207018_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x207018_g_MissionId)
		if (GetName(sceneId,targetId)==x207018_g_Name) then
	        	if x207018_CheckSubmit(sceneId, selfId, targetId) <= 0 then
	                        BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x207018_g_MissionName)
				AddText(sceneId,x207018_g_ContinueInfo)
			        AddText(sceneId,"#Y任务目标#W") 
				AddText(sceneId,x207018_g_MissionTarget) 
				AddText(sceneId,format("\n    查看王昭君   %d/1\n    查看西施   %d/1\n    查看杨玉环   %d/1\n    查看貂蝉   %d/1", GetMissionParam(sceneId,selfId,misIndex,0),GetMissionParam(sceneId,selfId,misIndex,1),GetMissionParam(sceneId,selfId,misIndex,2),GetMissionParam(sceneId,selfId,misIndex,3) ))
				EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
			end
	
			     
	                if x207018_CheckSubmit(sceneId, selfId, targetId) > 0 then
	                     BeginEvent(sceneId)
	                     AddText(sceneId,"#Y"..x207018_g_MissionName)
			     AddText(sceneId,x207018_g_MissionComplete)
			     AddText(sceneId,"#Y任务目标#W") 
			     AddText(sceneId,x207018_g_MissionTarget) 
			     AddText(sceneId,format("\n    查看王昭君   %d/1\n    查看西施   %d/1\n    查看杨玉环   %d/1\n    查看貂蝉   %d/1", GetMissionParam(sceneId,selfId,misIndex,0),GetMissionParam(sceneId,selfId,misIndex,1),GetMissionParam(sceneId,selfId,misIndex,2),GetMissionParam(sceneId,selfId,misIndex,3) ))
			     EndEvent()
	                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x207018_g_ScriptId, x207018_g_MissionId)
	                end
	       end
	       if (GetName(sceneId,targetId)==x207018_g_Name2) then
	        	SetMissionByIndex(sceneId,selfId,misIndex,0,1)
	        	BeginEvent(sceneId)
			AddText(sceneId,x207018_g_MidInfo2)
        		EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
	       end
	       if (GetName(sceneId,targetId)==x207018_g_Name3) then
	        	SetMissionByIndex(sceneId,selfId,misIndex,1,1)
	        	BeginEvent(sceneId)
			AddText(sceneId,x207018_g_MidInfo3)
        		EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
	       end
	       if (GetName(sceneId,targetId)==x207018_g_Name4) then
	        	SetMissionByIndex(sceneId,selfId,misIndex,2,1)
	        	BeginEvent(sceneId)
			AddText(sceneId,x207018_g_MidInfo4)
        		EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
	       end
	       if (GetName(sceneId,targetId)==x207018_g_Name5) then
	        	SetMissionByIndex(sceneId,selfId,misIndex,3,1)
	        	BeginEvent(sceneId)
			AddText(sceneId,x207018_g_MidInfo5)
        		EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
	       end

        elseif x207018_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x207018_g_MissionName)
                AddText(sceneId,x207018_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x207018_g_MissionTarget) 
		AddMoneyBonus(sceneId, x207018_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207018_g_ScriptId, x207018_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207018_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207018_g_MissionId) > 0 then
		return 0
	end
	--如果已接此任务
	if  x207018_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207018_g_ScriptId, x207018_g_MissionName)
	end
	return 0
	
end



--**********************************

--检测接受条件

--**********************************

function x207018_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207018_g_Name) then
		return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207018_CheckPushList(sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x207018_g_MissionId)
        if IsMissionHaveDone(sceneId, selfId, x207018_g_MissionIdPre) > 0 then
        	if IsHaveMission(sceneId,selfId, x207018_g_MissionId) > 0 then
	        	if (GetName(sceneId,targetId)==x207018_g_Name2) then
	        		if GetMissionParam(sceneId,selfId,misIndex,0) <= 0 then
	        			return 1
	        		end
	        	end
	        	if (GetName(sceneId,targetId)==x207018_g_Name3) then
	        		if GetMissionParam(sceneId,selfId,misIndex,1) <= 0 then
	        			return 1
	        		end
	        	end
	        	if (GetName(sceneId,targetId)==x207018_g_Name4) then
	        		if GetMissionParam(sceneId,selfId,misIndex,2) <= 0 then
	        			return 1
	        		end
	        	end
	        	if (GetName(sceneId,targetId)==x207018_g_Name5) then
	        		if GetMissionParam(sceneId,selfId,misIndex,3) <= 0 then
	        			return 1
	        		end
	        	end
	        	if (GetName(sceneId,targetId)==x207018_g_Name) then
	        			return 1
	        	end
	        end
	        if IsHaveMission(sceneId,selfId, x207018_g_MissionId)<= 0 then
	        	if (GetName(sceneId,targetId)==x207018_g_Name) then
	        			return 1
	        	end
	        end
        end
        return 0
		
end

--**********************************

--接受

--**********************************

function x207018_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x207018_g_MissionId, x207018_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x207018_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x207018_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207018_g_MissionId)
	for i, item in pairs(x207018_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x207018_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x207018_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == 1 then
		if GetMissionParam(sceneId,selfId,misIndex,1) == 1 then
			if GetMissionParam(sceneId,selfId,misIndex,2) == 1 then
				if GetMissionParam(sceneId,selfId,misIndex,3) == 1 then
	        			return 1
	        		end
	        	end
	        end
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207018_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207018_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207018_g_MissionId)
		AddExp(sceneId, selfId, x207018_g_ExpBonus)
		AddMoney(sceneId, selfId, x207018_g_MoneyBonus)
		for i, item in pairs(x207018_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x207018_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207018_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x207018_OnEnterArea(sceneId, selfId, zoneId)

	misIndex = GetMissionIndexByID(sceneId,selfId,x207018_g_MissionId)
        if GetMissionParam(sceneId,selfId,misIndex,4) <= 0 then
        	if IsHaveMission(sceneId,selfId, x207018_g_MissionId) > 0 then
        	SetMissionByIndex(sceneId,selfId,misIndex,4,1)
        	LuaFnCreateMonster(sceneId, 420,43.87,44,0,1,-1)
        	LuaFnCreateMonster(sceneId, 420,43.57,44,0,1,-1)
        	LuaFnCreateMonster(sceneId, 420,43.87,44.5,0,1,-1)
        	LuaFnCreateMonster(sceneId, 420,43.57,44.5,0,1,-1)
        	end
        	
        end

end

function x207018_OnTimer(sceneId, selfId )
	misIndex = GetMissionIndexByID(sceneId,selfId,x207018_g_MissionId)
        if GetMissionParam(sceneId,selfId,misIndex,4) <= 0 then
        	if IsHaveMission(sceneId,selfId, x207018_g_MissionId) > 0 then
        	SetMissionByIndex(sceneId,selfId,misIndex,4,1)
        	LuaFnCreateMonster(sceneId, 420,43.87,44,0,1,-1)
        	LuaFnCreateMonster(sceneId, 420,43.57,44,0,1,-1)
        	LuaFnCreateMonster(sceneId, 420,43.87,44.5,0,1,-1)
        	LuaFnCreateMonster(sceneId, 420,43.57,44.5,0,1,-1)
        	end
        	
        end
end

function x207018_OnLeaveArea(sceneId, selfId )

end



--**********************************

--道具改变

--**********************************

function x207018_OnItemChanged(sceneId, selfId, itemdataId)

end

