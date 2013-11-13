--军情密卷

--成吉思汗

--脚本号
x207020_g_ScriptId = 207020

--上一个任务的ID
x207020_g_MissionIdPre =12

--任务号
x207020_g_MissionId = 21

--任务目标npc
x207020_g_Name	="术赤" 

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************

--任务需要的物品
--x207020_g_DemandItem = {{id=10400001,num=1}}

--任务需要提交的物品
--x207020_g_DeleteItem = {{id=10400001,num=1}}

--任务发放的物品
--x207020_g_MissionItem = {{id=10400001,num=1}}

--任务需要杀死的怪
x207020_g_DemandKill ={{id=4002,num=1}}	

--以上是动态**************************************************************

--任务文本描述
x207020_g_MissionName="火烧粮草营"
x207020_g_MissionInfo="兵马未动，粮草先行，这是兵之大计。要想打赢战争，必须保证充足的粮草、畅通的粮道，我得到密报，（70，170）处是金兵的粮草营，那里看守的人虽然不多，但是个个都是千里挑一的高手，尤其是薛将军。只要我们能把粮草营给烧了，金兵不战死也会饿死！"  --任务描述
x207020_g_MissionTarget="杀死薛将军，并点燃3堆金兵的粮草"		--任务目标
x207020_g_ContinueInfo="金兵虽然厉害，但是我们的弯刀也不弱，大好男儿理当以躯报国。"		--未完成任务的npc对话
x207020_g_MissionComplete="术虎的粮草营给我们烧了，金兵就等着喝西北风吧，哈哈哈！！！"					--完成任务npc说话的话
--x207020_g_MissionAddItem="得到军情密报"		
--x207020_g_szBackageFull = "背包已满！"
--任务奖励
x207020_g_MoneyBonus=20000
x207020_g_ItemBonus={{id=12040002,num=1}}
x207020_g_RadioItemBonus={{id=12010001,num=1},{id=12020001,num=1}}
x207020_g_ExpBonus = 1000


--**********************************

--任务入口函数

--**********************************

function x207020_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207020_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207020_g_MissionId) > 0 then
	        if x207020_CheckSubmit(sceneId, selfId, targetId) <= 0 then
		     BeginEvent(sceneId)
		     AddText(sceneId,x207020_g_ContinueInfo) 
		     EndEvent()
		     local bDone = x207020_CheckSubmit(sceneId, selfId, targetId)
		     DispatchMissionDemandInfo(sceneId, selfId, targetId, x207020_g_ScriptId, x207020_g_MissionId, bDone)
	        end
	        if x207020_CheckSubmit(sceneId, selfId, targetId) > 0 then
		     --提交任务时的说明信息
                	BeginEvent(sceneId)
                	
                	AddText(sceneId, x207020_g_MissionName)
                        AddText(sceneId,x207020_g_MissionComplete)
                        AddMoneyBonus(sceneId, x207020_g_MoneyBonus)
                        for i, item in pairs(x207020_g_ItemBonus) do
                	AddItemBonus(sceneId, item.id, item.num)
                	for i, item in pairs(x207020_g_RadioItemBonus) do
                	AddRadioItemBonus(sceneId, item.id, item.num)
                	end
                	end
                        EndEvent()
                
                	DispatchMissionContinueInfo(sceneId, selfId, targetId, x207020_g_ScriptId, x207020_g_MissionId)

	        end
		
        elseif x207020_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			
		x888888_PrintInfo(sceneId, x207020_g_MissionName, x207020_g_MissionInfo, x207020_g_MissionTarget, x207020_g_ItemBonus, x207020_g_MoneyBonus)

		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207020_g_ScriptId, x207020_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207020_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207020_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207020_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207020_g_ScriptId, x207020_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207020_CheckAccept(sceneId, selfId, targetId)

	if IsMissionHaveDone(sceneId, selfId, x207020_g_MissionIdPre) > 0 then
	    return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207020_CheckPushList(sceneId, selfId, targetId)
        if IsMissionHaveDone(sceneId, selfId, x207020_g_MissionIdPre) > 0 then
                    return 1
        end
	return 0
	
end

--**********************************

--接受

--**********************************

function x207020_OnAccept(sceneId, selfId)

	--加入任务到玩家列表
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x207020_g_MissionId, x207020_g_ScriptId, 1, 0, 0)
	misIndex = GetMissionIndexByID(sceneId,selfId,x207020_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)		--添加任务
	SetMissionByIndex(sceneId,selfId,misIndex,1,0)
end



--**********************************

--放弃

--**********************************

function x207020_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207020_g_MissionId)

end






--**********************************

--检测是否可以提交

--**********************************

function x207020_CheckSubmit( sceneId, selfId, targetId)

	if IsHaveMission(sceneId, selfId, x207020_g_MissionId) >= 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x207020_g_MissionId)
	     if (GetMissionParam(sceneId,selfId,misIndex,0)==1) then
	        if (GetMissionParam(sceneId,selfId,misIndex,1)==3) then
		return 1
		end
	     end
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207020_OnSubmit(sceneId, selfId, targetId, selectRadioId)
 
        if x207020_CheckSubmit( sceneId, selfId, selectRadioId ) then            
    	BeginAddItem(sceneId)                                                    
			for i, item in pairs(x207020_g_ItemBonus) do                    
				AddItem( sceneId,item.id, item.num )             
			end                                                      
			for i, item in pairs(x207020_g_RadioItemBonus) do               
				if item.id == selectRadioId then                 
					AddItem( sceneId,item.id, item.num )     
				end                                              
			end                                                      
		ret = EndAddItem(sceneId,selfId)                                 
		--添加任务奖励                                                   
		if ret > 0 then                                                  
		  ret = DelMission( sceneId, selfId, x207020_g_MissionId ) 
			if ret > 0 then                                   
				MissionCom( sceneId,selfId, x207020_g_MissionId )
				               
				AddExp(sceneId, selfId, x207020_g_ExpBonus)   
	                        AddMoney(sceneId, selfId, x207020_g_MoneyBonus)
	                        AddItemListToHuman(sceneId,selfId)
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
	     
end


                                                                                                 
function x207020_OnKillObject(sceneId, selfId, objdataId)                                        
         if objdataId == x207020_g_DemandKill[1].id then 
         misIndex = GetMissionIndexByID(sceneId,selfId,x207020_g_MissionId)                                        
         num = GetMissionParam(sceneId,selfId,misIndex,0)                                        
             if num<=0  then                                                                     
             BeginEvent(sceneId)                                                                 
             SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)                                  
	     strText = "已杀死薛将军   1/1"
	     AddText(sceneId, strText) 
             EndEvent()
	   DispatchMissionTips(sceneId, selfId)
             end
         end
end                    




--**********************************

--进入区域事件

--**********************************

function x207020_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207020_OnItemChanged(sceneId, selfId, itemdataId)

end

