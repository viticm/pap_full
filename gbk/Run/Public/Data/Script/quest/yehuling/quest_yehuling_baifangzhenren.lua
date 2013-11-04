--军情密卷

--成吉思汗

--脚本号
x207023_g_ScriptId = 207023

--上一个任务的ID
x207023_g_MissionIdPre =14

--任务号
x207023_g_MissionId = 24

--任务目标npc
x207023_g_Name	="术赤" 
x207023_g_Name1	="丘处机" 
x207023_g_Name2	="豁儿赤" 
--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************


x207023_g_MissionItem = {{id=12090004,num=1}}
x207023_g_DemandKill ={{id=4000,num=1}}	

--以上是动态**************************************************************

--任务文本描述
x207023_g_MissionName="拜访真人"
x207023_g_MissionInfo="可敬的勇士，你在这太好了，豁儿赤在西边(110,120)见到一个老道士在采药，仙风道骨的，不知道是不是赤老温口中说的丘处机，你去帮他查探一下。    "  --任务描述
x207023_g_MissionTarget="弄清楚老道的身份后告诉豁儿赤"		--任务目标
x207023_g_ContinueInfo="找到邱真人了吗？"		--未完成任务的npc对话
x207023_g_ContinueInfo2="你要想知道我谁，先要看看你有多大本事。我养了一只雕，你去会会它吧。 "
x207023_g_ContinueInfo3="不要害怕，金雕虽然凶猛，但是却被郭靖那傻小子训练得通了人性。 "
x207023_g_ContinueInfo4="贫道丘处机，山野之人，理应跳出五行之中，只是连年征战，民不聊生，希望成吉思汗能一统天下。 "
x207023_g_MissionComplete="那老道士真的是丘处机真人！据说他活了三百多了，是一位老神仙啊。"					--完成任务npc说话的话
x207023_g_ShowMissionTarget="弄清老道身份   1/1"
--任务奖励
x207023_g_MoneyBonus=200
x207023_g_ItemBonus={}
x207023_g_RadioItemBonus={}
x207023_g_ExpBonus = 1000


--**********************************

--任务入口函数

--**********************************

function x207023_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207023_g_MissionId) > 0 then
		if (GetName(sceneId,targetId)==x207023_g_Name2) then
		   if  x207023_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,x207023_g_ContinueInfo)
                     EndEvent()
		     local bDone = x207023_CheckSubmit(sceneId, selfId, targetId)
		     DispatchMissionDemandInfo(sceneId, selfId,targetId,x207023_g_ScriptId, x207023_g_MissionId, bDone)
		   end
		   if  x207023_CheckSubmit(sceneId, selfId, targetId) > 0 then
		     BeginEvent(sceneId)
    	             AddText(sceneId, x207023_g_MissionName)
                     AddText(sceneId,x207023_g_MissionComplete)
                     AddMoneyBonus(sceneId, x207023_g_MoneyBonus) 
    	             EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x207023_g_ScriptId, x207023_g_MissionId)
                   end
                end
               	if (GetName(sceneId,targetId)==x207023_g_Name1) then
               	misIndex = GetMissionIndexByID(sceneId,selfId,x207023_g_MissionId)
               	   if (GetMissionParam(sceneId,selfId,misIndex,0)==1) then
		   BeginEvent(sceneId)
                   AddText(sceneId,x207023_g_ContinueInfo3)
                   EndEvent()
		   DispatchEventList(sceneId, selfId, targetId) 
		   end
		   if (GetMissionParam(sceneId,selfId,misIndex,0)==0) then
		   BeginEvent(sceneId)
                   AddText(sceneId,x207023_g_ContinueInfo2)
                   EndEvent()
		   DispatchEventList(sceneId, selfId, targetId) 
		   SetMissionByIndex(sceneId,selfId,misIndex,0,1)
		   end
		   if (GetMissionParam(sceneId,selfId,misIndex,0)==2) then
		   BeginEvent(sceneId)
                   AddText(sceneId,x207023_g_ContinueInfo4)
                   EndEvent()
		   DispatchEventList(sceneId, selfId, targetId) 
		   BeginEvent(sceneId)
     		   AddText(sceneId, x207023_g_ShowMissionTarget)
     		   EndEvent()
     		   DispatchMissionTips(sceneId, selfId)
     		   SetMissionByIndex(sceneId,selfId,misIndex,0,3)
		   end
		 end
		   
	elseif x207023_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			
		x888888_PrintInfo(sceneId, x207023_g_MissionName, x207023_g_MissionInfo, x207023_g_MissionTarget, x207023_g_ItemBonus, x207023_g_MoneyBonus)

		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207023_g_ScriptId, x207023_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207023_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207023_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207023_CheckPushList(sceneId, selfId, targetId) > 0 then
              if IsMissionHaveDone(sceneId, selfId, x207023_g_MissionIdPre) > 0 then
		AddNumText(sceneId, x207023_g_ScriptId, x207023_g_MissionName)
              end
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207023_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207023_g_Name) then
					return 1
		
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207023_CheckPushList(sceneId, selfId, targetId)
        misIndex = GetMissionIndexByID(sceneId,selfId,x207023_g_MissionId)
        if (GetName(sceneId,targetId)==x207023_g_Name) then
             if IsHaveMission(sceneId,selfId, x207023_g_MissionId) <= 0 then
             return 1
             end
        end
        if (GetName(sceneId,targetId)==x207023_g_Name1) then
             if IsHaveMission(sceneId,selfId, x207023_g_MissionId) > 0 then
                if (GetMissionParam(sceneId,selfId,misIndex,0)<3) then
                return 1
                end
             end
        end
	if (GetName(sceneId,targetId)==x207023_g_Name2) then
		    if IsHaveMission(sceneId,selfId, x207023_g_MissionId) > 0 then
		    return 1
                    end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x207023_OnAccept(sceneId, selfId)

	--加入任务到玩家列表
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x207023_g_MissionId, x207023_g_ScriptId, 1, 0, 0)
	misIndex = GetMissionIndexByID(sceneId,selfId,x207023_g_MissionId)		--添加任务                                           
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)
end



--**********************************

--放弃

--**********************************

function x207023_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207023_g_MissionId)

end



--**********************************

--检测是否可以提交

--**********************************

function x207023_CheckSubmit( sceneId, selfId, targetId)

	if IsHaveMission(sceneId, selfId, x207023_g_MissionId) >= 0 then
		if (GetMissionParam(sceneId,selfId,misIndex,0)==3) then
			return 1
		end
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207023_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207023_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207023_g_MissionId)
		AddExp(sceneId, selfId, x207023_g_ExpBonus)
		AddMoney(sceneId, selfId, x207023_g_MoneyBonus)
		for i, item in x207023_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x207023_g_MissionItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
	end
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207023_OnKillObject(sceneId, selfId, objdataId) 
      if IsHaveMission(sceneId, selfId, x207023_g_MissionId) >= 0 then                                       
         if objdataId == x207023_g_DemandKill[1].id then 
            misIndex = GetMissionIndexByID(sceneId,selfId,x207023_g_MissionId)
            if (GetMissionParam(sceneId,selfId,misIndex,0)==1) then
               SetMissionByIndex(sceneId,selfId,misIndex,0,2)
            end
         end
         
      end                                    
            
end          



--**********************************

--进入区域事件

--**********************************

function x207023_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207023_OnItemChanged(sceneId, selfId, itemdataId)

end

