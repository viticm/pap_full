--军情密卷

--成吉思汗

--脚本号
x207017_g_ScriptId = 207017

--上一个任务的ID
x207017_g_MissionIdPre =17

--任务号
x207017_g_MissionId = 18

--任务目标npc
x207017_g_Name	="拖雷" 

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************

--任务需要的物品
--x207017_g_DemandItem = {{id=10400001,num=1}}

--任务需要提交的物品
--x207017_g_DeleteItem = {{id=10400001,num=1}}

--任务发放的物品
x207017_g_MissionItem = {{id=12090008,num=1}}

--任务需要杀死的怪
x207017_g_DemandKill ={{id=4003,num=1}}	

--以上是动态**************************************************************

--任务文本描述
x207017_g_MissionName="追杀术虎"
x207017_g_MissionInfo="大汗传令了，野狐岭金兵的所有将领一律斩杀，唉，他是为了安慰我，不然也不会滥杀。我已经想通了，乌月营的事情，不应该牵扯上野狐岭这些战败的俘虏。如果水月还活着，一定也会这么想。我们只要杀术虎(33,71)一个人就足够了，你能帮我在乱军中找到他吗？"  --任务描述
x207017_g_MissionTarget="替拖雷杀了术虎"		--任务目标
x207017_g_ContinueInfo="别让术虎跑了"		--未完成任务的npc对话
x207017_g_MissionComplete="术虎真的死了？我看到他的人头，一点也高兴不起来，逝者已矣！最近我感觉到自己的心已经很平淡了。"					--完成任务npc说话的话
x207017_g_MissionAddItem="术虎的头   1/1"		
x207017_g_szBackageFull = "背包已满！"
--任务奖励
x207017_g_MoneyBonus=20000
x207017_g_ItemBonus={{id=12010001,num=1}}
x207017_g_RadioItemBonus={{id=12010001,num=1},{id=12010001,num=1}}
x207017_g_ExpBonus = 1000


--**********************************

--任务入口函数

--**********************************

function x207017_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207017_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207017_g_MissionId) > 0 then
	         if x207017_CheckSubmit(sceneId, selfId, targetId) <= 0 then
		     BeginEvent(sceneId)
		     AddText(sceneId,x207017_g_ContinueInfo)
		     AddText(sceneId,"需要物品") 
                     for i, item in x207017_g_MissionItem do  
		     AddItemBonus(sceneId, item.id, item.num)
		     EndEvent()
		     end
		     local bDone = x207017_CheckSubmit(sceneId, selfId, targetId)
		     DispatchMissionDemandInfo(sceneId, selfId, targetId, x207017_g_ScriptId, x207017_g_MissionId, bDone)
		 end
		 if x207017_CheckSubmit(sceneId, selfId, targetId) > 0 then
		     BeginEvent(sceneId)
		     AddText(sceneId, x207017_g_MissionName)
                     AddText(sceneId,x207017_g_MissionComplete)
                     AddMoneyBonus(sceneId, x207017_g_MoneyBonus)
                     for i, item in x207017_g_ItemBonus do
	             AddItemBonus(sceneId, item.id, item.num)
	             for i, item in x207017_g_RadioItemBonus do
	             AddRadioItemBonus(sceneId, item.id, item.num)
		     end
	             end
	             EndEvent()
	             DispatchMissionContinueInfo(sceneId, selfId, targetId, x207017_g_ScriptId, x207017_g_MissionId)

		 end
		
        elseif x207017_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			
		x888888_PrintInfo(sceneId, x207017_g_MissionName, x207017_g_MissionInfo, x207017_g_MissionTarget, x207017_g_ItemBonus, x207017_g_MoneyBonus)

		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207017_g_ScriptId, x207017_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207017_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207017_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207017_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207017_g_ScriptId, x207017_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207017_CheckAccept(sceneId, selfId, targetId)

	if IsMissionHaveDone(sceneId, selfId, x207017_g_MissionIdPre) > 0 then
	    return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207017_CheckPushList(sceneId, selfId, targetId)
        if IsMissionHaveDone(sceneId, selfId, x207017_g_MissionIdPre) > 0 then
                    return 1
        end
	return 0
	
end

--**********************************

--接受

--**********************************

function x207017_OnAccept(sceneId, selfId)

	--加入任务到玩家列表
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x207017_g_MissionId, x207017_g_ScriptId, 1, 0, 0)
end



--**********************************

--放弃

--**********************************

function x207017_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207017_g_MissionId)

end



--**********************************

--继续

--**********************************

function x207017_OnContinue(sceneId, selfId, targetId)

	--提交任务时的说明信息
	BeginEvent(sceneId)
	
	AddText(sceneId, x207017_g_MissionName)
        AddText(sceneId,x207017_g_MissionComplete)
        AddMoneyBonus(sceneId, x207017_g_MoneyBonus)
        for i, item in x207017_g_ItemBonus do
	AddItemBonus(sceneId, item.id, item.num)
	for i, item in x207017_g_RadioItemBonus do
	AddRadioItemBonus(sceneId, item.id, item.num)
		end
	end
        EndEvent()

	DispatchMissionContinueInfo(sceneId, selfId, targetId, x207017_g_ScriptId, x207017_g_MissionId)

end


--**********************************

--检测是否可以提交

--**********************************

function x207017_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,12090008)==1 then
		return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207017_OnSubmit(sceneId, selfId, targetId, selectRadioId)
 
        if x207017_CheckSubmit( sceneId, selfId, selectRadioId ) then            
    	BeginAddItem(sceneId)                                                    
			for i, item in x207017_g_ItemBonus do                    
				AddItem( sceneId,item.id, item.num )             
			end                                                      
			for i, item in x207017_g_RadioItemBonus do               
				if item.id == selectRadioId then                 
					AddItem( sceneId,item.id, item.num )     
				end                                              
			end                                                      
		ret = EndAddItem(sceneId,selfId)                                 
		--添加任务奖励                                                   
		if ret > 0 then                                                  
		  ret = DelMission( sceneId, selfId, x207017_g_MissionId ) 
			if ret > 0 then                                   
				MissionCom( sceneId,selfId, x207017_g_MissionId )
				AddExp(sceneId, selfId, x207017_g_ExpBonus)   
	                        AddMoney(sceneId, selfId, x207017_g_MoneyBonus)
	                        AddItemListToHuman(sceneId,selfId)
	                        for i, item in x207017_g_MissionItem do
			        DelItem(sceneId, selfId, item.id, item.num)
		                end
			end                                               
		else                                                             
		--任务奖励没有加成功                                             
			BeginEvent(sceneId)                                      
				AddText(sceneId,"物品栏已满，请整理下再来！");                        
			EndEvent(sceneId)                                        
			DispatchMissionTips(sceneId,selfId)                      
		end                                                              
	end                                                                      
	     EndEvent(sceneId)
	     DispatchMissionTips(sceneId,selfId)
	     
end


                                                                                                 
function x207017_OnKillObject(sceneId, selfId, objdataId)     
        if objdataId == x207017_g_DemandKill[1].id then
               if LuaFnGetItemCount(sceneId,selfId,12090008)==0 then
             x888888_DeleteAndAddItem(sceneId, selfId, nil, x207017_g_MissionItem, x207017_g_MissionAddItem, x207017_g_szBackageFull)   
             end
         end
end                    




--**********************************

--进入区域事件

--**********************************

function x207017_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207017_OnItemChanged(sceneId, selfId, itemdataId)

end

