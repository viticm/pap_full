
--脚本号
x207010_g_ScriptId = 207010

--上一个任务的ID
x207010_g_MissionIdPre =23

--任务号
x207010_g_MissionId = 11

--任务目标npc
x207010_g_Name	="拖雷" 
x207010_g_Name2	="木华黎" 

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************

--任务发放的物品
--x207010_g_MissionItem = {{id=10400001,num=1}}

--任务需要杀死的怪
x207010_g_DemandKill ={{id=3150,num=1},{id=3151,num=1}}	

--以上是动态**************************************************************

--任务文本描述
x207010_g_MissionName="攻打黑风口"
x207010_g_MissionInfo="我们的大军一到野狐岭就生病，很影响士气，为了提高勇士们的士气，今晚我们将偷袭黑风口。黑风口是三道关隘里最险峻的一道，对我们非常不利，在黑风口附近有的一个军寨，我需要你帮我把黑风口附近的军寨哨兵(150,130)给消灭。"  --任务描述
x207010_g_MissionTarget="消灭15个军寨哨兵然后向拖雷复命"		--任务目标
x207010_g_ContinueInfo="军寨哨兵都被消灭了吗？"		--未完成任务的npc对话
x207010_g_MissionComplete="战争让很多人成为亡魂，但是为了亡魂能安息，我不惜挑起任何战争。谢谢你为我杀了那些哨兵。"					
--x207010_g_MissionAddItem="得到军情密报"		
--x207010_g_szBackageFull = "背包已满！"
--任务奖励
x207010_g_MoneyBonus=20000
x207010_g_ItemBonus={}
x207010_g_RadioItemBonus={}
x207010_g_ExpBonus = 1000


--**********************************

--任务入口函数

--**********************************

function x207010_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207010_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207010_g_MissionId) > 0 then
	     misIndex = GetMissionIndexByID(sceneId,selfId,x207010_g_MissionId)
	     if (GetMissionParam(sceneId,selfId,misIndex,0)<15) then
	             BeginEvent(sceneId)
		     AddText(sceneId, x207010_g_MissionName)
                     AddText(sceneId,x207010_g_ContinueInfo) 
		     EndEvent()
		     local bDone = x207010_CheckSubmit(sceneId, selfId, targetId)
		     DispatchMissionDemandInfo(sceneId, selfId, targetId, x207010_g_ScriptId, x207010_g_MissionId, bDone)
	     end
	     if (GetMissionParam(sceneId,selfId,misIndex,0)==15) then
	             BeginEvent(sceneId)
	             AddText(sceneId, x207010_g_MissionName)
	             AddText(sceneId,x207010_g_MissionComplete)
	             AddMoneyBonus(sceneId, x207010_g_MoneyBonus)
	             EndEvent()
	             DispatchMissionContinueInfo(sceneId, selfId, targetId, x207010_g_ScriptId, x207010_g_MissionId)
	     end
		
        elseif x207010_CheckAccept(sceneId, selfId, targetId) > 0 then
                BeginEvent(sceneId)
			
		x888888_PrintInfo(sceneId, x207010_g_MissionName, x207010_g_MissionInfo, x207010_g_MissionTarget, x207010_g_ItemBonus, x207010_g_MoneyBonus)

		EndEvent()
		DispatchMissionInfo(sceneId, selfId, targetId, x207010_g_ScriptId, x207010_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207010_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207010_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207010_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207010_g_ScriptId, x207010_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207010_CheckAccept(sceneId, selfId, targetId)

	if IsHaveMission(sceneId,selfId, x207010_g_MissionId) <= 0 then
	    return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207010_CheckPushList(sceneId, selfId, targetId)
        if IsMissionHaveDone(sceneId, selfId, x207010_g_MissionIdPre) > 0 then
           if (GetName(sceneId,targetId)==x207010_g_Name) then
             if IsHaveMission(sceneId,selfId, x207010_g_MissionId) <= 0 then
             return 1
             end
           end
           if (GetName(sceneId,targetId)==x207010_g_Name2) then
             if IsHaveMission(sceneId,selfId, x207010_g_MissionId) > 0 then
             return 1
             end
           end
           
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x207010_OnAccept(sceneId, selfId)

	--加入任务到玩家列表
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x207010_g_MissionId, x207010_g_ScriptId, 1, 0, 0)
	misIndex = GetMissionIndexByID(sceneId,selfId,x207010_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)		--添加任务
end



--**********************************

--放弃

--**********************************

function x207010_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207010_g_MissionId)

end



--**********************************

--继续

--**********************************

function x207010_OnContinue(sceneId, selfId, targetId)

	--提交任务时的说明信息
	BeginEvent(sceneId)
	
	AddText(sceneId, x207010_g_MissionName)
        AddText(sceneId,x207010_g_MissionComplete)
        AddMoneyBonus(sceneId, x207010_g_MoneyBonus)
        EndEvent()

	DispatchMissionContinueInfo(sceneId, selfId, targetId, x207010_g_ScriptId, x207010_g_MissionId)

end


--**********************************

--检测是否可以提交

--**********************************

function x207010_CheckSubmit( sceneId, selfId, targetId)

	if IsHaveMission(sceneId, selfId, x207010_g_MissionId) >= 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x207010_g_MissionId)
	     if (GetMissionParam(sceneId,selfId,misIndex,0)==15) then
		return 1
	     end
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207010_OnSubmit(sceneId, selfId, targetId, selectRadioId)
 
        if x207010_CheckSubmit( sceneId, selfId, selectRadioId ) then            
    	                  MissionCom( sceneId,selfId, x207010_g_MissionId )
    	                  DelMission( sceneId, selfId, x207010_g_MissionId )
			  AddExp(sceneId, selfId, x207010_g_ExpBonus)   
	                  AddMoney(sceneId, selfId, x207010_g_MoneyBonus)
	end                                                                      
	    
	     
end


                                                                                                 
function x207010_OnKillObject(sceneId, selfId, objdataId)                                        
         if objdataId == x207010_g_DemandKill[1].id then 
         misIndex = GetMissionIndexByID(sceneId,selfId,x207010_g_MissionId)                                        
         num = GetMissionParam(sceneId,selfId,misIndex,0)                                        
             if num<=14  then                                                                     
             BeginEvent(sceneId)                                                                 
             SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)                                  
	     strText = format("已杀死军寨哨兵%d/15", GetMissionParam(sceneId,selfId,misIndex,0) ) 
	     AddText(sceneId, strText) 
             EndEvent()
	   DispatchMissionTips(sceneId, selfId)
             end
         end
         if objdataId == x207010_g_DemandKill[2].id then 
         misIndex = GetMissionIndexByID(sceneId,selfId,x207010_g_MissionId)                                        
         num = GetMissionParam(sceneId,selfId,misIndex,0)                                        
             if num<=14  then                                                                     
             BeginEvent(sceneId)                                                                 
             SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)                                  
	     strText = format("已杀死军寨哨兵%d/15", GetMissionParam(sceneId,selfId,misIndex,0) ) 
	     AddText(sceneId, strText) 
             EndEvent()
	   DispatchMissionTips(sceneId, selfId)
             end
         end
end                    




--**********************************

--进入区域事件

--**********************************

function x207010_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207010_OnItemChanged(sceneId, selfId, itemdataId)

end

