--军情密卷

--成吉思汗
x207000_g_MissionKind = 1

--任务等级
x207000_g_MissionLevel = 1

--是否是精英任务
x207000_g_IfMissionElite = 0


x207000_g_IsMissionOkFail = 0		


x207000_g_ScriptId = 207000

--上一个任务的ID
--x207000_g_MissionIdPre =

--任务号
x207000_g_MissionId = 1
x207000_g_MissionKind = 1

--任务目标npc
x207000_g_Name	="成吉思汗" 
x207000_g_Name1	="木华黎" 
x207000_g_Name2	="拖雷" 

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************

x207000_g_MissionItem = {{id=12090001,num=1}}

--以上是动态**************************************************************

--任务文本描述
x207000_g_MissionName="军情密卷"
x207000_g_MissionInfo="野狐岭是大漠和中原的天然长城，我们要借着打乌沙堡的士气，踏平野狐岭。金国女真人的国王荒淫无耻，贪得无厌，腐败无能，天下百姓处于水深火热之中。我们要铲除这个暴君，还要给被金国钉死在木驴上的俺巴孩汗报仇。木华黎去探视军情刚回来，你去问问木华黎关于野狐岭的军情。  "  --任务描述
x207000_g_MissionTarget="问问木华黎关于野狐岭的事情，把军情密卷给带回来。"		--任务目标
x207000_g_ContinueInfo="军情密卷拿来了吗？"		--未完成任务的npc对话
x207000_g_ContinueInfo2="野狐岭地势险峻，要攻克野狐岭城池，需要过三道关隘。这都是一夫当关，万夫莫开的险地。金军只在最后一道关隘“黑风口”做了防守，奇怪的很！我已经做好密卷，你去找拖雷拿军情密卷回去给大汗，记住，不要跟拖雷提起乌月营的伤心事。"
x207000_g_ContinueInfo3="如果是我镇守野狐岭，三道关隘将是重兵把守，可是金兵却……，木华黎总让我自己想明白，还说是攻城有望了，但我始终想不通。这是他密封好的军情密卷，你拿去吧，我再想想，唉，如果水月在我身边就好了……，水月……"
x207000_g_MissionComplete="真是拖雷给你的密卷吗？太好了，不愧是我成吉思汗的儿子，乌月营的事情是打败不了志如洪水的拖雷，他不会因为一个女人而让自己颓废，应该像现在这样，拿起手中的马刀，砍下金兵的脑袋给他的女人报仇，这才是明智之举。感谢长生天对拖雷的眷顾。"					--完成任务npc说话的话
x207000_g_szBackageFull = "背包已满！"
x207000_g_ShowMissionTarget="询问木华黎军情   1/1"
x207000_g_ShowMissionTarget2="军情密卷   1/1"	
--任务奖励
x207000_g_MoneyBonus=200
x207000_g_ItemBonus={}
x207000_g_RadioItemBonus={}
x207000_g_ExpBonus = 1000



--**********************************

--任务入口函数

--**********************************

function x207000_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件

	--如果已接此任务
	
	if IsHaveMission(sceneId,selfId, x207000_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x207000_g_MissionId)
		if (GetName(sceneId,targetId)==x207000_g_Name) then
		     if  x888888_CheckHaveItems(sceneId, selfId, x207000_g_MissionItem)<=0 then
                     BeginEvent(sceneId)
		     AddText(sceneId,x207000_g_ContinueInfo)
                     AddText(sceneId,"需要物品") 
                     for i, item in x207000_g_MissionItem do
		     AddItemBonus(sceneId, item.id, item.num)
		     EndEvent()
		     end
		     local bDone = x207000_CheckSubmit(sceneId, selfId, targetId)
		     DispatchMissionDemandInfo(sceneId, selfId,targetId,x207000_g_ScriptId, x207000_g_MissionId, bDone)
		     end
		     if  x888888_CheckHaveItems(sceneId, selfId, x207000_g_MissionItem)>0 then
		     BeginEvent(sceneId)
	             AddText(sceneId,x207000_g_MissionComplete)
                     AddMoneyBonus(sceneId, x207000_g_MoneyBonus) 
	             EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x207000_g_ScriptId, x207000_g_MissionId)
                     end
                end
               	if (GetName(sceneId,targetId)==x207000_g_Name1) then
		   BeginEvent(sceneId)
                   AddText(sceneId,x207000_g_ContinueInfo2)
                   
		   EndEvent()
		   DispatchEventList(sceneId, selfId, targetId) 
		   SetMissionByIndex(sceneId,selfId,misIndex,0,2)
		   BeginEvent(sceneId)
		   AddText(sceneId, x207000_g_ShowMissionTarget)
		   EndEvent()
		   DispatchMissionTips(sceneId, selfId)
                end
		if (GetName(sceneId,targetId)==x207000_g_Name2) then
		   BeginEvent(sceneId)
		   x888888_DeleteAndAddItem(sceneId, selfId, nil, x207000_g_MissionItem, x207000_g_ShowMissionTarget2, x207000_g_szBackageFull)   
		   EndEvent()
		   BeginEvent(sceneId)
                   AddText(sceneId, x207000_g_ContinueInfo3)       
		   EndEvent()
		   DispatchEventList(sceneId, selfId, targetId)
		
		end
	elseif x207000_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			
		x888888_PrintInfo(sceneId, x207000_g_MissionName, x207000_g_MissionInfo, x207000_g_MissionTarget, x207000_g_ItemBonus, x207000_g_MoneyBonus)

		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207000_g_ScriptId, x207000_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207000_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207000_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207000_CheckPushList(sceneId, selfId, targetId) > 0 then
              if GetLevel( sceneId, selfId ) >= 1 then
		AddNumText(sceneId, x207000_g_ScriptId, x207000_g_MissionName)
              end
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207000_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207000_g_Name) then
					return 1
		
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207000_CheckPushList(sceneId, selfId, targetId)
        misIndex = GetMissionIndexByID(sceneId,selfId,x207000_g_MissionId)
        if (GetName(sceneId,targetId)==x207000_g_Name) then
             return 1
        end
	if (GetName(sceneId,targetId)==x207000_g_Name1) then
		    if (GetMissionParam(sceneId,selfId,misIndex,0)==1) then
		    return 1
                    end
        end
        if (GetName(sceneId,targetId)==x207000_g_Name2) then
		    if (GetMissionParam(sceneId,selfId,misIndex,0)==2) then
		        if x888888_CheckHaveItems(sceneId, selfId, x207000_g_MissionItem) <= 0 then
		        return 1
		        end
	            end
	end
	return 0
	
end

--**********************************

--接受

--**********************************

function x207000_OnAccept(sceneId, selfId)

	--加入任务到玩家列表
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x207000_g_MissionId, x207000_g_ScriptId, 1, 0, 0)
	misIndex = GetMissionIndexByID(sceneId,selfId,x207000_g_MissionId)		--添加任务                                           
	SetMissionByIndex(sceneId,selfId,misIndex,0,1)
end



--**********************************

--放弃

--**********************************

function x207000_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207000_g_MissionId)

end





--**********************************

--检测是否可以提交

--**********************************

function x207000_CheckSubmit( sceneId, selfId, targetId)

	if IsHaveMission(sceneId, selfId, x207000_g_MissionId) >= 0 then
		if x888888_CheckHaveItems(sceneId, selfId, x207000_g_MissionItem) > 0 then
			return 1
		end
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207000_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207000_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207000_g_MissionId)
		AddExp(sceneId, selfId, x207000_g_ExpBonus)
		AddMoney(sceneId, selfId, x207000_g_MoneyBonus)
		for i, item in x207000_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end
	        for i, item in x207000_g_MissionItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end

	end
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207000_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x207000_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207000_OnItemChanged(sceneId, selfId, itemdataId)

end

