--军情密卷

--成吉思汗

--脚本号
x207019_g_ScriptId = 207019

--上一个任务的ID
x207019_g_MissionIdPre =18

--任务号
x207019_g_MissionId = 22

--任务目标npc
x207019_g_Name	="赤老温" 

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************

--任务需要的物品
--x207019_g_DemandItem = {{id=10400001,num=1}}

--任务需要提交的物品
x207019_g_DeleteItem = {{id=12090010,num=10}}

--任务发放的物品
x207019_g_MissionItem = {{id=12090010,num=1}}

--任务需要杀死的怪
x207019_g_DemandKill ={{id=3350,num=1},{id=3351,num=1},{id=3352,num=1}}	

--以上是动态**************************************************************

--任务文本描述
x207019_g_MissionName="追查神秘人"
x207019_g_MissionInfo="拖雷不听我劝告，去追杀术虎的时候，在东侧被一群神秘人(200,50)所伤。请你去追查这群人的下落。带回一些他们贴身的物件。"  --任务描述
x207019_g_MissionTarget="给赤老温带回10封潦草的信"		--任务目标
x207019_g_ContinueInfo="那些神秘人身手不凡，应该不是普通护卫，请务必查清楚。"		--未完成任务的npc对话
x207019_g_MissionComplete="原来这些神秘人就是鬼仆，他们是皇帝身边养的一群高手。金国皇帝疑心太重，而且胆小懦弱，养这么一批人，一来可以保护派出去的大臣，而来可以监督这些大臣，怕他们起叛逆之心。我要马上告诉大汗！"					--完成任务npc说话的话
x207019_g_szBackageFull = "背包已满！"
--任务奖励
x207019_g_MoneyBonus=20000
x207019_g_ItemBonus={}
x207019_g_RadioItemBonus={}
x207019_g_ExpBonus = 1000


--**********************************

--任务入口函数

--**********************************

function x207019_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207019_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207019_g_MissionId) > 0 then
	       if x207019_CheckSubmit(sceneId, selfId, targetId) <= 0 then
		     BeginEvent(sceneId)
		     AddText(sceneId, x207019_g_MissionName)
                     AddText(sceneId,x207019_g_ContinueInfo) 
		     AddText(sceneId,"需要物品")  
                     for i, item in pairs(x207019_g_MissionItem) do
		     AddItemBonus(sceneId, item.id, item.num)
		     EndEvent()
		     end
		     local bDone = x207019_CheckSubmit(sceneId, selfId, targetId)
		     DispatchMissionDemandInfo(sceneId, selfId, targetId, x207019_g_ScriptId, x207019_g_MissionId, bDone)
	       end
	       if x207019_CheckSubmit(sceneId, selfId, targetId) > 0 then
		     BeginEvent(sceneId)
		     AddText(sceneId, x207019_g_MissionName)
		     AddText(sceneId,x207019_g_MissionComplete)
		     AddMoneyBonus(sceneId, x207019_g_MoneyBonus)
		     EndEvent()
		     DispatchMissionContinueInfo(sceneId, selfId, targetId, x207019_g_ScriptId, x207019_g_MissionId)
	       end
		
        elseif x207019_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			
		x888888_PrintInfo(sceneId, x207019_g_MissionName, x207019_g_MissionInfo, x207019_g_MissionTarget, x207019_g_ItemBonus, x207019_g_MoneyBonus)

		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207019_g_ScriptId, x207019_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207019_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207019_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207019_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207019_g_ScriptId, x207019_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207019_CheckAccept(sceneId, selfId, targetId)

	if IsMissionHaveDone(sceneId, selfId, x207019_g_MissionIdPre) > 0 then
	    return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207019_CheckPushList(sceneId, selfId, targetId)
        if IsMissionHaveDone(sceneId, selfId, x207019_g_MissionIdPre) > 0 then
                    return 1
        end
	return 0
	
end

--**********************************

--接受

--**********************************

function x207019_OnAccept(sceneId, selfId)

	--加入任务到玩家列表
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x207019_g_MissionId, x207019_g_ScriptId, 1, 0, 0)
                                  
	    
end



--**********************************

--放弃

--**********************************

function x207019_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207019_g_MissionId)

end



--**********************************

--检测是否可以提交

--**********************************

function x207019_CheckSubmit( sceneId, selfId, targetId)

	if IsHaveMission(sceneId, selfId, x207019_g_MissionId) >= 0 then
	     if LuaFnGetItemCount(sceneId,selfId,12090010)==10 then
		return 1
	     end
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207019_OnSubmit(sceneId, selfId, targetId, selectRadioId)
 
        MissionCom( sceneId,selfId, x207019_g_MissionId )
        DelMission( sceneId, selfId, x207019_g_MissionId )
	AddExp(sceneId, selfId, x207019_g_ExpBonus)   
	AddMoney(sceneId, selfId, x207019_g_MoneyBonus)
	for i, item in pairs(x207019_g_DeleteItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
	
			
	     
end


--**********************************

--杀死怪物或玩家

--**********************************

function x207019_OnKillObject(sceneId, selfId, objdataId) 
      if IsHaveMission(sceneId, selfId, x207019_g_MissionId) >= 0 then                                       
         if objdataId == x207019_g_DemandKill[1].id then 
            if LuaFnGetItemCount(sceneId,selfId,12090010) < 10 then
                 if random(1,100)>20 then
                 strText = format("潦草的信%d/10", LuaFnGetItemCount(sceneId,selfId,12090010)+1 ) 
                 x888888_DeleteAndAddItem(sceneId, selfId, nil, x207019_g_MissionItem, strText, x207019_g_szBackageFull)
                 end
            end
         end
         if objdataId == x207019_g_DemandKill[2].id then 
            if LuaFnGetItemCount(sceneId,selfId,12090010) < 10 then
                 if random(1,100)>20 then
                 strText = format("潦草的信%d/10", LuaFnGetItemCount(sceneId,selfId,12090010)+1 ) 
                 x888888_DeleteAndAddItem(sceneId, selfId, nil, x207019_g_MissionItem, strText, x207019_g_szBackageFull)
                 end
            end
         end
         if objdataId == x207019_g_DemandKill[3].id then 
            if LuaFnGetItemCount(sceneId,selfId,12090010) < 10 then
                 if random(1,100)>20 then
                 strText = format("潦草的信%d/10", LuaFnGetItemCount(sceneId,selfId,12090010)+1 ) 
                 x888888_DeleteAndAddItem(sceneId, selfId, nil, x207019_g_MissionItem, strText, x207019_g_szBackageFull)
                 end
            end
         end
      end                                    
            
end                                                                                                   
                  




--**********************************

--进入区域事件

--**********************************

function x207019_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207019_OnItemChanged(sceneId, selfId, itemdataId)

end

