--军情密卷

--成吉思汗

--脚本号
x207022_g_ScriptId = 207022

--上一个任务的ID
x207022_g_MissionIdPre =10

--任务号
x207022_g_MissionId = 23

--任务目标npc
x207022_g_Name	="成吉思汗" 
x207022_g_Name2	="拖雷" 

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************


--任务发放的物品
x207022_g_MissionItem = {{id=12090011,num=1}}

--以上是动态**************************************************************

--任务文本描述
x207022_g_MissionName="令牌"
x207022_g_MissionInfo="你是我见过最忠心勇敢的人，一定是长生天安排你来帮我的，从今天起，你就是我的那可儿。这是令牌，请交给我的四儿子拖雷。"  --任务描述
x207022_g_MissionTarget="把令牌交给拖雷"		--任务目标
x207022_g_ContinueInfo="只有手拿令牌才能调动人马，军情紧急，一切拜托了，我的那可儿。"		--未完成任务的npc对话
x207022_g_MissionComplete="看到令牌我就知道你成了我父王的那可儿，只有最亲信的人才能碰令牌，恭喜你。"					--完成任务npc说话的话
--x207022_g_szBackageFull = "背包已满！"
--任务奖励
x207022_g_MoneyBonus=200
x207022_g_ItemBonus={}
x207022_g_RadioItemBonus={}
x207022_g_ExpBonus = 1000


--**********************************

--任务入口函数

--**********************************

function x207022_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207022_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207022_g_MissionId) > 0 then
		if x207022_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                     BeginEvent(sceneId)
		     AddText(sceneId,x207022_g_ContinueInfo)
		     AddText(sceneId,"需要物品")
		     for i, item in pairs(x207022_g_MissionItem) do  
		     AddItemBonus(sceneId, item.id, item.num)
		     EndEvent()
		     end

		     local bDone = x207022_CheckSubmit(sceneId, selfId, targetId)
		     DispatchMissionDemandInfo(sceneId, selfId, targetId, x207022_g_ScriptId, x207022_g_MissionId, bDone)
		
                end
                if x207022_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId, x207022_g_MissionName)
                     AddText(sceneId,x207022_g_MissionComplete)
                     AddMoneyBonus(sceneId, x207022_g_MoneyBonus)
                     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x207022_g_ScriptId, x207022_g_MissionId)
                end

        elseif x207022_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			
		x888888_PrintInfo(sceneId, x207022_g_MissionName, x207022_g_MissionInfo, x207022_g_MissionTarget, x207022_g_ItemBonus, x207022_g_MoneyBonus)

		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207022_g_ScriptId, x207022_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207022_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207022_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207022_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207022_g_ScriptId, x207022_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207022_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207022_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207022_CheckPushList(sceneId, selfId, targetId)
        if (GetName(sceneId,targetId)==x207022_g_Name) then
                if IsMissionHaveDone(sceneId, selfId, x207022_g_MissionIdPre) > 0 then
                    if IsHaveMission(sceneId,selfId, x207022_g_MissionId)<= 0 then
                    return 1
                    end
                end
        end
	if (GetName(sceneId,targetId)==x207022_g_Name2) then
		    if IsHaveMission(sceneId,selfId, x207022_g_MissionId) > 0 then
		    return 1
                    end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x207022_OnAccept(sceneId, selfId)

	        BeginAddItem(sceneId)                                                    
		for i, item in pairs(x207022_g_MissionItem) do                    
			AddItem( sceneId,item.id, item.num )             
		end                                                      
			                                             
		        ret = EndAddItem(sceneId,selfId)                                 
		        --添加任务奖励                                                   
		        if ret > 0 then                                                  
		        AddMission( sceneId, selfId, x207022_g_MissionId, x207022_g_ScriptId, 1, 0, 0)
		        AddItemListToHuman(sceneId,selfId) 
		        else                                                             
		--任务奖励没有加成功                                             
			     BeginEvent(sceneId)                                      
			     	AddText(sceneId,"物品栏已满，请整理下再来！")                    
			     EndEvent(sceneId)                                        
			     DispatchMissionTips(sceneId,selfId)                      
		        end                                                              
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x207022_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207022_g_MissionId)

end



--**********************************

--继续

--**********************************

function x207022_OnContinue(sceneId, selfId, targetId)

	--提交任务时的说明信息
	BeginEvent(sceneId)
	
	AddText(sceneId, x207022_g_MissionName)
        AddText(sceneId,x207022_g_MissionComplete)
        AddMoneyBonus(sceneId, x207022_g_MoneyBonus) 
	EndEvent()

	DispatchMissionContinueInfo(sceneId, selfId, targetId, x207022_g_ScriptId, x207022_g_MissionId)

end


--**********************************

--检测是否可以提交

--**********************************

function x207022_CheckSubmit( sceneId, selfId, targetId)

	if IsHaveMission(sceneId, selfId, x207022_g_MissionId) >= 0 then
	        if x888888_CheckHaveItems(sceneId, selfId, x207022_g_MissionItem) > 0 then
		return 1
		end
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207022_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207022_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207022_g_MissionId)
		AddExp(sceneId, selfId, x207022_g_ExpBonus)
		AddMoney(sceneId, selfId, x207022_g_MoneyBonus)
		for i, item in pairs(x207022_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x207022_g_MissionItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
	end
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207022_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x207022_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207022_OnItemChanged(sceneId, selfId, itemdataId)

end

