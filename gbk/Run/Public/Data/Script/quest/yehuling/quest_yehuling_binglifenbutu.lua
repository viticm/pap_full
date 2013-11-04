--军情密卷

--成吉思汗

--脚本号
x207011_g_ScriptId = 207011

--上一个任务的ID
x207011_g_MissionIdPre =11

--任务号
x207011_g_MissionId = 12

--任务目标npc
x207011_g_Name	="木华黎" 
x207011_g_Name1	="耶律阿海" 
x207011_g_Name2	="术赤" 
--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************


x207011_g_MissionItem = {{id=12090004,num=1}}
x207011_g_DemandKill ={{id=3154,num=1},{id=3155,num=1}}	

--以上是动态**************************************************************

--任务文本描述
x207011_g_MissionName="兵力分布图"
x207011_g_MissionInfo="驻守在黑风口的金兵虽然被拖雷击退了，但是却打草惊蛇，惊动了守城的术虎，四十万的兵力重新调整。我的儿子孛鲁化妆进城去拿兵力分布图，至今下落不明，兵力分布图事关重大，万分火急，你去把兵力分布图拿回来给术赤，耶律阿海(150,25)会接应你。    "  --任务描述
x207011_g_MissionTarget="询问耶律阿海兵力分布图的下落，拿到兵力分布图。"		--任务目标
x207011_g_ContinueInfo="拿到兵力分布图了吗。"		--未完成任务的npc对话
x207011_g_ContinueInfo2="孛鲁太粗心大意了，跟阿刺乌接头的时候被金兵抓住，关在不远的营寨里，兵力分布图应该在附近的金兵身上。"
x207011_g_MissionComplete="想不到金兵的奸细这么厉害，连十二岁的小孩都不放过，以后不能让没有经验的孛鲁出去误事了。我给你准备了马奶酒，烤全羊和本地鸡，你可以尽情享用。"					--完成任务npc说话的话
x207011_g_MissionAddItem="兵力分布图   1/1"		
x207011_g_szBackageFull = "背包已满！"
x207011_g_ShowMissionTarget="询问耶律阿海兵力分布图的下落   1/1"
--任务奖励
x207011_g_MoneyBonus=200
x207011_g_ItemBonus={}
x207011_g_RadioItemBonus={}
x207011_g_ExpBonus = 1000


--**********************************

--任务入口函数

--**********************************

function x207011_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207011_g_MissionId) > 0 then
		if (GetName(sceneId,targetId)==x207011_g_Name2) then
		   if  x207011_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                     BeginEvent(sceneId)
			
                     AddText(sceneId,x207011_g_ContinueInfo)
                     AddText(sceneId,"需要物品")  
                     for i, item in x207011_g_MissionItem do
		     AddItemBonus(sceneId, item.id, item.num)
		     EndEvent()
		     end

		     local bDone = x207011_CheckSubmit(sceneId, selfId, targetId)
		     DispatchMissionDemandInfo(sceneId, selfId,targetId,x207011_g_ScriptId, x207011_g_MissionId, bDone)
		   end
		   if  x207011_CheckSubmit(sceneId, selfId, targetId) > 0 then
		     BeginEvent(sceneId)
    	             AddText(sceneId, x207011_g_MissionName)
                     AddText(sceneId,x207011_g_MissionComplete)
                     AddMoneyBonus(sceneId, x207011_g_MoneyBonus) 
    	             EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x207011_g_ScriptId, x207011_g_MissionId)
                   end

		
                end
               	if (GetName(sceneId,targetId)==x207011_g_Name1) then
               	misIndex = GetMissionIndexByID(sceneId,selfId,x207011_g_MissionId)
		   BeginEvent(sceneId)
                   AddText(sceneId,x207011_g_ContinueInfo2)
                   EndEvent()
		   DispatchEventList(sceneId, selfId, targetId) 
		   SetMissionByIndex(sceneId,selfId,misIndex,0,2)
		   BeginEvent(sceneId)
		   AddText(sceneId, x207011_g_ShowMissionTarget)
		   EndEvent()
		   DispatchMissionTips(sceneId, selfId)
                end
	elseif x207011_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			
		x888888_PrintInfo(sceneId, x207011_g_MissionName, x207011_g_MissionInfo, x207011_g_MissionTarget, x207011_g_ItemBonus, x207011_g_MoneyBonus)

		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207011_g_ScriptId, x207011_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207011_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207011_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207011_CheckPushList(sceneId, selfId, targetId) > 0 then
              if IsMissionHaveDone(sceneId, selfId, x207011_g_MissionIdPre) > 0 then
		AddNumText(sceneId, x207011_g_ScriptId, x207011_g_MissionName)
              end
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207011_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207011_g_Name) then
					return 1
		
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207011_CheckPushList(sceneId, selfId, targetId)
        if (GetName(sceneId,targetId)==x207011_g_Name) then
             if IsHaveMission(sceneId,selfId, x207011_g_MissionId) <= 0 then
             return 1
             end
        end
        if (GetName(sceneId,targetId)==x207011_g_Name2) then
             if IsHaveMission(sceneId,selfId, x207011_g_MissionId) > 0 then
             return 1
             end
        end
	if (GetName(sceneId,targetId)==x207011_g_Name1) then
	misIndex = GetMissionIndexByID(sceneId,selfId,x207011_g_MissionId)
		    if (GetMissionParam(sceneId,selfId,misIndex,0)==1) then
		    return 1
                    end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x207011_OnAccept(sceneId, selfId)

	--加入任务到玩家列表
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x207011_g_MissionId, x207011_g_ScriptId, 1, 0, 0)
	misIndex = GetMissionIndexByID(sceneId,selfId,x207011_g_MissionId)		--添加任务                                           
	SetMissionByIndex(sceneId,selfId,misIndex,0,1)
end



--**********************************

--放弃

--**********************************

function x207011_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207011_g_MissionId)

end



--**********************************

--继续

--**********************************

function x207011_OnContinue(sceneId, selfId, targetId)

	--提交任务时的说明信息
	BeginEvent(sceneId)
	
	AddText(sceneId, x207011_g_MissionName)
        AddText(sceneId,x207011_g_MissionComplete)
        AddMoneyBonus(sceneId, x207011_g_MoneyBonus) 
	EndEvent()

	DispatchMissionContinueInfo(sceneId, selfId, targetId, x207011_g_ScriptId, x207011_g_MissionId)

end


--**********************************

--检测是否可以提交

--**********************************

function x207011_CheckSubmit( sceneId, selfId, targetId)

	if IsHaveMission(sceneId, selfId, x207011_g_MissionId) >= 0 then
		if x888888_CheckHaveItems(sceneId, selfId, x207011_g_MissionItem) > 0 then
			return 1
		end
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207011_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207011_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207011_g_MissionId)
		AddExp(sceneId, selfId, x207011_g_ExpBonus)
		AddMoney(sceneId, selfId, x207011_g_MoneyBonus)
		for i, item in x207011_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x207011_g_MissionItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
	end
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207011_OnKillObject(sceneId, selfId, objdataId) 
      if IsHaveMission(sceneId, selfId, x207011_g_MissionId) >= 0 then                                       
         if objdataId == x207011_g_DemandKill[1].id then 
            misIndex = GetMissionIndexByID(sceneId,selfId,x207011_g_MissionId)
            if (GetMissionParam(sceneId,selfId,misIndex,0)==2) then
               if x888888_CheckHaveItems(sceneId, selfId, x207011_g_MissionItem) <= 0 then
                 if random(1,100)>90 then
                 x888888_DeleteAndAddItem(sceneId, selfId, nil, x207011_g_MissionItem, x207011_g_MissionAddItem, x207011_g_szBackageFull)
                 end
               end
            end
         end
         if objdataId == x207011_g_DemandKill[2].id then 
            misIndex = GetMissionIndexByID(sceneId,selfId,x207011_g_MissionId)
            if (GetMissionParam(sceneId,selfId,misIndex,0)==2) then
               if x888888_CheckHaveItems(sceneId, selfId, x207011_g_MissionItem) <= 0 then
                 if random(1,100)>90 then
                 x888888_DeleteAndAddItem(sceneId, selfId, nil, x207011_g_MissionItem, x207011_g_MissionAddItem, x207011_g_szBackageFull)
                 end
               end
            end
         end
      end                                    
            
end          



--**********************************

--进入区域事件

--**********************************

function x207011_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207011_OnItemChanged(sceneId, selfId, itemdataId)

end

