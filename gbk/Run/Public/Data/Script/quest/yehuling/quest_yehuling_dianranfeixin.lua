--军情密卷

--成吉思汗

--脚本号
x207016_g_ScriptId = 207016

--上一个任务的ID
x207016_g_MissionIdPre =15

--任务号
x207016_g_MissionId = 17

--任务目标npc
x207016_g_Name	="成吉思汗" 

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************

--任务需要的物品
--x207016_g_DemandItem = {{id=10400001,num=1}}

--任务需要提交的物品
--x207016_g_DeleteItem = {{id=10400001,num=1}}

--任务发放的物品
x207016_g_MissionItem = {{id=12090007,num=1}}

--以上是动态**************************************************************

--任务文本描述
x207016_g_MissionName="点燃飞信"
x207016_g_MissionInfo="豁儿赤真有一套，把液体涂在士兵和火炮的衣服上，在大雾中很难发现，我们的人马打到城门底下的时候金兵才发现。术虎为了求和，派人送信给我，想用财物来换取我退兵。你把飞信拿到（100,50）点燃，让哲别从侧面攻城。飞信可以在高处那里点燃使用。"  --任务描述
x207016_g_MissionTarget="在高地点燃飞信后向成吉思汗复命"		--任务目标
x207016_g_ContinueInfo="飞信很重要，你点燃了吗？"		--未完成任务的npc对话
x207016_g_MissionComplete="哲别和木华黎，是我的左右臂膀，一个从正面进攻，一个从侧面进攻，野狐岭势必一举拿下。术虎想让我退兵，那是痴心妄想。拖雷脾气太暴躁，你去看看他怎么样了。"					--完成任务npc说话的话
x207016_g_MissionAddItem="得到飞信"
x207016_g_ShowMissionTarget="点燃飞信   1/1"	
x207016_g_szBackageFull = "背包已满！"
--任务奖励
x207016_g_MoneyBonus=200
x207016_g_ItemBonus={}
x207016_g_RadioItemBonus={}
x207016_g_ExpBonus = 1000


--**********************************

--任务入口函数

--**********************************

function x207016_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207016_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207016_g_MissionId) > 0 then
	     misIndex = GetMissionIndexByID(sceneId,selfId,x207016_g_MissionId)
		if (GetName(sceneId,targetId)==x207016_g_Name) then
		   if x207016_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                     BeginEvent(sceneId)
		     AddText(sceneId,x207016_g_ContinueInfo)
		     EndEvent()
		     local bDone = x207016_CheckSubmit(sceneId, selfId, targetId)
		     DispatchMissionDemandInfo(sceneId, selfId, targetId, x207016_g_ScriptId, x207016_g_MissionId, bDone)
		   end
		    if x207016_CheckSubmit(sceneId, selfId, targetId) > 0 then
                      BeginEvent(sceneId)
                      AddText(sceneId, x207016_g_MissionName)
                      AddText(sceneId,x207016_g_MissionComplete)
                      AddMoneyBonus(sceneId, x207016_g_MoneyBonus)
                      EndEvent()
                      DispatchMissionContinueInfo(sceneId, selfId, targetId, x207016_g_ScriptId, x207016_g_MissionId)
                    end
                 end
        elseif x207016_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			
		x888888_PrintInfo(sceneId, x207016_g_MissionName, x207016_g_MissionInfo, x207016_g_MissionTarget, x207016_g_ItemBonus, x207016_g_MoneyBonus)

		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207016_g_ScriptId, x207016_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207016_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207016_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207016_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207016_g_ScriptId, x207016_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207016_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207016_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207016_CheckPushList(sceneId, selfId, targetId)
        if IsMissionHaveDone(sceneId, selfId, x207016_g_MissionIdPre) > 0 then
                    return 1
        end
	
        return 0
	
end

--**********************************

--接受

--**********************************

function x207016_OnAccept(sceneId, selfId)

	BeginAddItem(sceneId)                                                    
	for i, item in pairs(x207016_g_MissionItem) do                    
	AddItem( sceneId,item.id, item.num )             
	end                                                      
	ret = EndAddItem(sceneId,selfId)                                 
		if ret > 0 then                                                  
		AddMission( sceneId, selfId, x207016_g_MissionId, x207016_g_ScriptId, 1, 0, 0)
		AddItemListToHuman(sceneId,selfId) 
		BeginEvent(sceneId)
		AddText(sceneId,x207016_g_MissionAddItem)
		DispatchMissionTips(sceneId,selfId) 
		EndEvent(sceneId)
		else                                                             
		BeginEvent(sceneId)                                      
		AddText(sceneId,"物品栏已满，请整理下再来！")                    
		EndEvent(sceneId)                                        
		DispatchMissionTips(sceneId,selfId)                      
		end    
        	misIndex = GetMissionIndexByID(sceneId,selfId,x207016_g_MissionId)		--添加任务                                           
	        SetMissionByIndex(sceneId,selfId,misIndex,0,0)
	        SetMissionByIndex(sceneId,selfId,misIndex,1,0)                                                      
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x207016_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207016_g_MissionId)

end



--**********************************

--继续

--**********************************

function x207016_OnContinue(sceneId, selfId, targetId)

	--提交任务时的说明信息
	BeginEvent(sceneId)
	
	AddText(sceneId, x207016_g_MissionName)
        AddText(sceneId,x207016_g_MissionComplete)
        AddMoneyBonus(sceneId, x207016_g_MoneyBonus) 
	EndEvent()

	DispatchMissionContinueInfo(sceneId, selfId, targetId, x207016_g_ScriptId, x207016_g_MissionId)

end


--**********************************

--检测是否可以提交

--**********************************

function x207016_CheckSubmit( sceneId, selfId, targetId)

	if IsHaveMission(sceneId, selfId, x207016_g_MissionId) >= 0 then
	        misIndex = GetMissionIndexByID(sceneId,selfId,x207016_g_MissionId) 
	        if (GetMissionParam(sceneId,selfId,misIndex,0)==1) then
	        return 1
		end
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207016_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207016_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207016_g_MissionId)
		AddExp(sceneId, selfId, x207016_g_ExpBonus)
		AddMoney(sceneId, selfId, x207016_g_MoneyBonus)
		for i, item in pairs(x207016_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		
	end
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207016_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x207016_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207016_OnItemChanged(sceneId, selfId, itemdataId)

end

