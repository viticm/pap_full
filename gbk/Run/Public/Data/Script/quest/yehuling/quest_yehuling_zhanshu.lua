--军情密卷

--成吉思汗

--脚本号
x207018_g_ScriptId = 207018

x207018_g_MissionIdPre =13

--任务号
x207018_g_MissionId = 19

--任务目标npc
x207018_g_Name	="石抹明" 
x207018_g_Name2	="成吉思汗" 

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************

--任务需要的物品
--x207018_g_DemandItem = {{id=10400001,num=1}}

--任务需要提交的物品
--x207018_g_DeleteItem = {{id=10400001,num=1}}

--任务发放的物品
x207018_g_MissionItem = {{id=12090009,num=1}}

--以上是动态**************************************************************

--任务文本描述
x207018_g_MissionName="战书"
x207018_g_MissionInfo="术虎疑心太重，早就怕我篡位，他让我送战书给大汗，是想借大汗的手，把我除掉。要不是大汗英明，末将早已人头落地，大汗才真正是天之骄子！能给大汗效犬马之劳，那是我石抹明的荣幸，请告诉大汗，有用得着我的，火里火里来，水里水里去！  "  --任务描述
x207018_g_MissionTarget="成吉思汗的议和书带给石抹明。"		--任务目标
x207018_g_ContinueInfo="务必让大汗知道，我敬仰大汗的威仪和大度，愿意一辈子效忠于他。"		--未完成任务的npc对话
x207018_g_ContinueInfo2="石将军是个金国的智囊，只可惜金国朝野昏庸，不懂得重用，天助我也。野狐岭守将术虎已经派人来降，希望我们退兵，我们假装同意术虎的条件，引术虎出城，然后一把端掉术虎。你把这封议和的信交给石抹明，让他送去给术虎。"
x207018_g_MissionComplete="大汗真的这么说？这计策太妙了，只要术虎把三千头马牛羊赶出城门的一霎那，我会趁机把这些畜生给弄散，到时候，大汗的骑兵就趁机攻城，对，我马上把信送过去。"					--完成任务npc说话的话
x207018_g_MissionAddItem="大汗的议和书"		
x207018_g_szBackageFull = "背包已满！"
--任务奖励
x207018_g_MoneyBonus=200
x207018_g_ItemBonus={}
x207018_g_RadioItemBonus={}
x207018_g_ExpBonus = 1000


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
		     if (GetName(sceneId,targetId)==x207018_g_Name) then
		        if x207018_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                           BeginEvent(sceneId)
		           AddText(sceneId,x207018_g_ContinueInfo)
		           AddText(sceneId,"需要物品")  
                           for i, item in x207018_g_MissionItem do  
		           AddItemBonus(sceneId, item.id, item.num)
		           EndEvent()
		           end
		           local bDone = x207018_CheckSubmit(sceneId, selfId, targetId)
		           DispatchMissionDemandInfo(sceneId, selfId, targetId, x207018_g_ScriptId, x207018_g_MissionId, bDone)
		        end
		        if x207018_CheckSubmit(sceneId, selfId, targetId) > 0 then
                           BeginEvent(sceneId)
                           AddText(sceneId, x207018_g_MissionName)
                           AddText(sceneId,x207018_g_MissionComplete)
                           AddMoneyBonus(sceneId, x207018_g_MoneyBonus)
                           EndEvent()
                           DispatchMissionContinueInfo(sceneId, selfId, targetId, x207018_g_ScriptId, x207018_g_MissionId)

		        end
		    end
                     if (GetName(sceneId,targetId)==x207018_g_Name2) then
                           BeginEvent(sceneId)
		           AddText(sceneId,x207018_g_ContinueInfo2)
		           EndEvent()
		           DispatchEventList(sceneId, selfId, targetId) 
                          x888888_DeleteAndAddItem(sceneId, selfId, nil, x207018_g_MissionItem, x207018_g_MissionAddItem, x207018_g_szBackageFull)  
		     end       
        elseif x207018_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			
		x888888_PrintInfo(sceneId, x207018_g_MissionName, x207018_g_MissionInfo, x207018_g_MissionTarget, x207018_g_ItemBonus, x207018_g_MoneyBonus)

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
		return 
	end
	--如果已接此任务
	if  x207018_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207018_g_ScriptId, x207018_g_MissionName)
	end
	
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
        if (GetName(sceneId,targetId)==x207018_g_Name) then
                if IsMissionHaveDone(sceneId, selfId, x207018_g_MissionIdPre) > 0 then
                return 1
                end
        end
	if (GetName(sceneId,targetId)==x207018_g_Name2) then
		    if IsHaveMission(sceneId,selfId, x207018_g_MissionId) > 0 then
		         if x888888_CheckHaveItems(sceneId, selfId, x207018_g_MissionItem) <= 0 then
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

	        BeginAddItem(sceneId)                                                    
		AddMission( sceneId, selfId, x207018_g_MissionId, x207018_g_ScriptId, 1, 0, 0)
		EndEvent(sceneId)                                        
		
end



--**********************************

--放弃

--**********************************

function x207018_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207018_g_MissionId)

end



--**********************************

--继续

--**********************************

function x207018_OnContinue(sceneId, selfId, targetId)

	--提交任务时的说明信息
	BeginEvent(sceneId)
	
	AddText(sceneId, x207018_g_MissionName)
        AddText(sceneId,x207018_g_MissionComplete)
        AddMoneyBonus(sceneId, x207018_g_MoneyBonus) 
	EndEvent()

	DispatchMissionContinueInfo(sceneId, selfId, targetId, x207018_g_ScriptId, x207018_g_MissionId)

end


--**********************************

--检测是否可以提交

--**********************************

function x207018_CheckSubmit( sceneId, selfId, targetId)

	if IsHaveMission(sceneId, selfId, x207018_g_MissionId) >= 0 then
	        if x888888_CheckHaveItems(sceneId, selfId, x207018_g_MissionItem) > 0 then
		return 1
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
		for i, item in x207018_g_MissionItem do
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

end



--**********************************

--道具改变

--**********************************

function x207018_OnItemChanged(sceneId, selfId, itemdataId)

end

