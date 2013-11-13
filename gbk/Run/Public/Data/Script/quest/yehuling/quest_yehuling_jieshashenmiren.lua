--军情密卷

--成吉思汗

--脚本号
x207012_g_ScriptId = 207012

--上一个任务的ID
x207012_g_MissionIdPre =12

--任务号
x207012_g_MissionId = 13

--任务目标npc
x207012_g_Name	="术赤" 

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************

--任务需要的物品
--x207012_g_DemandItem = {{id=10400001,num=1}}

--任务需要提交的物品
--x207012_g_DeleteItem = {{id=10400001,num=1}}

--任务发放的物品
x207012_g_MissionItem = {{id=12090005,num=1}}

--任务需要杀死的怪
x207012_g_DemandKill ={{id=3350,num=1},{id=3351,num=1},{id=3352,num=1}}	

--以上是动态**************************************************************

--任务文本描述
x207012_g_MissionName="截杀神秘人"
x207012_g_MissionInfo="还记得那个小不点孛鲁吗，木华黎将军的儿子，人虽然小，却胆大机灵，混到术虎的府第，似乎得到了一些秘密消息而让金国一群神秘人追杀。这群神秘人不知道跟术虎关系密切，全都带着面具，诡异之极。请到（210,45）去把追杀孛鲁的神秘人杀掉，查一下他们的身份。"  --任务描述
x207012_g_MissionTarget="杀掉追杀孛鲁的神秘人带回一个神秘的面具"		--任务目标
x207012_g_ContinueInfo="孛鲁命在旦夕，刻不容缓！"		--未完成任务的npc对话
x207012_g_MissionComplete="这面具就是那群神秘人带的？真是恐怖！好像魔鬼一样，我从未见过这样的面具。"					--完成任务npc说话的话
x207012_g_MissionAddItem="神秘的面具   1/1"		
x207012_g_szBackageFull = "背包已满！"
--任务奖励
x207012_g_MoneyBonus=20000
x207012_g_ItemBonus={}
x207012_g_RadioItemBonus={}
x207012_g_ExpBonus = 1000


--**********************************

--任务入口函数

--**********************************

function x207012_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207012_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207012_g_MissionId) > 0 then
	        if x207012_CheckSubmit(sceneId, selfId, targetId) <= 0 then
		     BeginEvent(sceneId)
		     AddText(sceneId, x207012_g_MissionName)
                     AddText(sceneId,x207012_g_ContinueInfo) 
		     AddText(sceneId,"需要物品")  
                     for i, item in pairs(x207012_g_MissionItem) do
		     AddItemBonus(sceneId, item.id, item.num)
		     EndEvent()
		     end
		     local bDone = x207012_CheckSubmit(sceneId, selfId, targetId)
		     DispatchMissionDemandInfo(sceneId, selfId, targetId, x207012_g_ScriptId, x207012_g_MissionId, bDone)
		end
		if x207012_CheckSubmit(sceneId, selfId, targetId) > 0 then
		BeginEvent(sceneId)
		     AddText(sceneId, x207012_g_MissionName)
		     AddText(sceneId,x207012_g_MissionComplete)
		     AddMoneyBonus(sceneId, x207012_g_MoneyBonus)
		     EndEvent()
		     DispatchMissionContinueInfo(sceneId, selfId, targetId, x207012_g_ScriptId, x207012_g_MissionId)
		end

		
        elseif x207012_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			
		x888888_PrintInfo(sceneId, x207012_g_MissionName, x207012_g_MissionInfo, x207012_g_MissionTarget, x207012_g_ItemBonus, x207012_g_MoneyBonus)

		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207012_g_ScriptId, x207012_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207012_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207012_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207012_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207012_g_ScriptId, x207012_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207012_CheckAccept(sceneId, selfId, targetId)

	if IsMissionHaveDone(sceneId, selfId, x207012_g_MissionIdPre) > 0 then
	    return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207012_CheckPushList(sceneId, selfId, targetId)
        if IsMissionHaveDone(sceneId, selfId, x207012_g_MissionIdPre) > 0 then
                    return 1
        end
	return 0
	
end

--**********************************

--接受

--**********************************

function x207012_OnAccept(sceneId, selfId)

	--加入任务到玩家列表
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x207012_g_MissionId, x207012_g_ScriptId, 1, 0, 0)

end



--**********************************

--放弃

--**********************************

function x207012_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207012_g_MissionId)

end




--**********************************

--检测是否可以提交

--**********************************

function x207012_CheckSubmit( sceneId, selfId, targetId)

	if IsHaveMission(sceneId, selfId, x207012_g_MissionId) >= 0 then
	     if x888888_CheckHaveItems(sceneId, selfId, x207012_g_MissionItem) > 0 then
		return 1
	     end
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207012_OnSubmit(sceneId, selfId, targetId, selectRadioId)
 
        MissionCom( sceneId,selfId, x207012_g_MissionId )
        DelMission( sceneId, selfId, x207012_g_MissionId )
	AddExp(sceneId, selfId, x207012_g_ExpBonus)   
	AddMoney(sceneId, selfId, x207012_g_MoneyBonus)
	for i, item in pairs(x207012_g_MissionItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
	
			
	     
end


--**********************************

--杀死怪物或玩家

--**********************************

function x207012_OnKillObject(sceneId, selfId, objdataId) 
      if IsHaveMission(sceneId, selfId, x207012_g_MissionId) >= 0 then                                       
         if objdataId == x207012_g_DemandKill[1].id then 
            if x888888_CheckHaveItems(sceneId, selfId, x207012_g_MissionItem) <= 0 then
                 if random(1,100)>80 then
                 x888888_DeleteAndAddItem(sceneId, selfId, nil, x207012_g_MissionItem, x207012_g_MissionAddItem, x207012_g_szBackageFull)
                 end
            end
         end
         if objdataId == x207012_g_DemandKill[2].id then 
            if x888888_CheckHaveItems(sceneId, selfId, x207012_g_MissionItem) <= 0 then
                 if random(1,100)>80 then
                 x888888_DeleteAndAddItem(sceneId, selfId, nil, x207012_g_MissionItem, x207012_g_MissionAddItem, x207012_g_szBackageFull)
                 end
            end
         end
         if objdataId == x207012_g_DemandKill[3].id then 
            if x888888_CheckHaveItems(sceneId, selfId, x207012_g_MissionItem) <= 0 then
                 if random(1,100)>80 then
                 x888888_DeleteAndAddItem(sceneId, selfId, nil, x207012_g_MissionItem, x207012_g_MissionAddItem, x207012_g_szBackageFull)
                 end
            end
         end
      end                                    
            
end                                                                                                   
                  




--**********************************

--进入区域事件

--**********************************

function x207012_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207012_OnItemChanged(sceneId, selfId, itemdataId)

end

