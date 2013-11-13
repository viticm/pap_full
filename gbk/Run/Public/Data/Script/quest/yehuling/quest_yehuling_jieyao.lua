--军情密卷

--成吉思汗

--脚本号
x207009_g_ScriptId = 207009

--上一个任务的ID
x207009_g_MissionIdPre =9

--任务号
x207009_g_MissionId = 10

--任务目标npc
x207009_g_Name	="阿刺乌" 
x207009_g_Name2	="成吉思汗" 

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************


--任务发放的物品
x207009_g_MissionItem = {{id=12090003,num=1}}

--以上是动态**************************************************************

--任务文本描述
x207009_g_MissionName="解药"
x207009_g_MissionInfo="我女人已经安然回来了，这是金蚕草，请交给大汗，并告诉大汗，阿刺乌会永远效忠于他。还有一见奇怪的事情，那天我无意中听到关于乌月营大战的事情，拖雷的未婚妻水月的死有蹊跷……"  --任务描述
x207009_g_MissionTarget="把金蚕草交给成吉思汗"		--任务目标
x207009_g_ContinueInfo="拿到金蚕草了？"		--未完成任务的npc对话
x207009_g_MissionComplete="这些草药，真的是雪中送炭啊。你的胆量和身手，颇有速不台将军的风范。速不台将军是我四勇之一，勇猛过人，乌月营就是他攻下的。关于在乌月营发生的事情，千万不要再提，以免我的爱子拖雷伤心。"					--完成任务npc说话的话
x207009_g_MissionAddItem="得到金蚕草"		
--x207009_g_szBackageFull = "背包已满！"
--任务奖励
x207009_g_MoneyBonus=200
x207009_g_ItemBonus={}
x207009_g_RadioItemBonus={}
x207009_g_ExpBonus = 1000


--**********************************

--任务入口函数

--**********************************

function x207009_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207009_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207009_g_MissionId) > 0 then
		if x207009_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                     BeginEvent(sceneId)
		     AddText(sceneId,x207009_g_ContinueInfo)
		     AddText(sceneId,"需要物品")
		     for i, item in pairs(x207009_g_MissionItem) do  
		     AddItemBonus(sceneId, item.id, item.num)
		     EndEvent()
		     end

		     local bDone = x207009_CheckSubmit(sceneId, selfId, targetId)
		     DispatchMissionDemandInfo(sceneId, selfId, targetId, x207009_g_ScriptId, x207009_g_MissionId, bDone)
		
                end
                if x207009_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId, x207009_g_MissionName)
                     AddText(sceneId,x207009_g_MissionComplete)
                     AddMoneyBonus(sceneId, x207009_g_MoneyBonus)
                     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x207009_g_ScriptId, x207009_g_MissionId)
                end

        elseif x207009_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			
		x888888_PrintInfo(sceneId, x207009_g_MissionName, x207009_g_MissionInfo, x207009_g_MissionTarget, x207009_g_ItemBonus, x207009_g_MoneyBonus)

		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207009_g_ScriptId, x207009_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207009_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207009_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207009_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207009_g_ScriptId, x207009_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207009_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207009_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207009_CheckPushList(sceneId, selfId, targetId)
        if (GetName(sceneId,targetId)==x207009_g_Name) then
                if IsMissionHaveDone(sceneId, selfId, x207009_g_MissionIdPre) > 0 then
                    if IsHaveMission(sceneId,selfId, x207009_g_MissionId)<= 0 then
                    return 1
                    end
                end
        end
	if (GetName(sceneId,targetId)==x207009_g_Name2) then
		    if IsHaveMission(sceneId,selfId, x207009_g_MissionId) > 0 then
		    return 1
                    end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x207009_OnAccept(sceneId, selfId)

	        BeginAddItem(sceneId)                                                    
		for i, item in pairs(x207009_g_MissionItem) do                    
			AddItem( sceneId,item.id, item.num )             
		end                                                      
			                                             
		        ret = EndAddItem(sceneId,selfId)                                 
		        --添加任务奖励                                                   
		        if ret > 0 then                                                  
		        AddMission( sceneId, selfId, x207009_g_MissionId, x207009_g_ScriptId, 1, 0, 0)
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

function x207009_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207009_g_MissionId)

end



--**********************************

--继续

--**********************************

function x207009_OnContinue(sceneId, selfId, targetId)

	--提交任务时的说明信息
	BeginEvent(sceneId)
	
	AddText(sceneId, x207009_g_MissionName)
        AddText(sceneId,x207009_g_MissionComplete)
        AddMoneyBonus(sceneId, x207009_g_MoneyBonus) 
	EndEvent()

	DispatchMissionContinueInfo(sceneId, selfId, targetId, x207009_g_ScriptId, x207009_g_MissionId)

end


--**********************************

--检测是否可以提交

--**********************************

function x207009_CheckSubmit( sceneId, selfId, targetId)

	if IsHaveMission(sceneId, selfId, x207009_g_MissionId) >= 0 then
	        if x888888_CheckHaveItems(sceneId, selfId, x207009_g_MissionItem) > 0 then
		return 1
		end
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207009_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207009_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207009_g_MissionId)
		AddExp(sceneId, selfId, x207009_g_ExpBonus)
		AddMoney(sceneId, selfId, x207009_g_MoneyBonus)
		for i, item in pairs(x207009_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x207009_g_MissionItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
	end
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207009_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x207009_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207009_OnItemChanged(sceneId, selfId, itemdataId)

end

