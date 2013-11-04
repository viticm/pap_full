--白鹿之杖

--MisDescBegin
x202002_g_ScriptId = 202002
x202002_g_MissionIdPre =120
x202002_g_MissionId = 121
x202002_g_MissionKind = 4
x202002_g_MissionLevel = 20
x202002_g_ScriptIdNext = {ScriptId = 202003 ,LV = 1 }
x202002_g_Name	="铁木真" 
x202002_g_DemandItem ={{id=13010040,num=1}}
x202002_g_noDemandKill ={{id=368,num=1}}	

x202002_g_MissionName="白鹿之杖"
x202002_g_MissionInfo="    #c0080C0白鹿之杖#W象征着一种威严，这是克烈部最高的信物，它就藏在王汗的身上。我们不能让这个东西流露出去，断绝了他们东山再起的念头。王汗就在他们营帐里，"  --任务描述
x202002_g_MissionInfo2="，你要帮我从他身上得到这个信物。"
x202002_g_MissionTarget="    到王汗营帐里找到#R王汗#W，从他身上拿到#c0080C0白鹿之杖#W，把它交给#G铁木真#W。"		
x202002_g_MissionComplete="    做的好！虽然王汗被人救走，但是，我们会再找到他的。"					--完成任务npc说话的话
x202002_g_ContinueInfo="    拿到白鹿之杖了吗？"
--任务奖励
x202002_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x202002_g_ItemBonus={}

--可选物品奖励，最多8种
x202002_g_RadioItemBonus={}

--MisDescEnd
x202002_g_ExpBonus = 6500
--**********************************

--任务入口函数

--**********************************

function x202002_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x202002_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x202002_g_MissionId) > 0 then
		if x202002_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x202002_g_MissionName)
			AddText(sceneId,x202002_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x202002_g_MissionTarget) 
			AddText(sceneId,format("\n    白鹿之杖   %d/%d", LuaFnGetItemCount(sceneId,selfId,x202002_g_DemandItem[1].id),x202002_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x202002_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x202002_g_MissionName)
		     AddText(sceneId,x202002_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in x202002_g_DemandItem do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x202002_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x202002_g_ScriptId, x202002_g_MissionId)
                end

        elseif x202002_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x202002_g_MissionName)
                AddText(sceneId,x202002_g_MissionInfo..GetName(sceneId, selfId)..x202002_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x202002_g_MissionTarget) 
		AddMoneyBonus(sceneId, x202002_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x202002_g_ScriptId, x202002_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x202002_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x202002_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x202002_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x202002_g_ScriptId, x202002_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x202002_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x202002_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x202002_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==2) then
        	if IsMissionHaveDone(sceneId,selfId, x202002_g_MissionIdPre) > 0 then
        	         return 1
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x202002_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x202002_g_MissionId, x202002_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x202002_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x202002_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x202002_g_MissionId)
	for i, item in x202002_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x202002_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x202002_g_DemandItem[1].id) == x202002_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x202002_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x202002_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x202002_g_MissionId)
		AddExp(sceneId, selfId, x202002_g_ExpBonus)
		AddMoney(sceneId, selfId, x202002_g_MoneyBonus)
		for i, item in x202002_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x202002_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x202002_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x202002_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x202002_g_MissionId) >= 0 then                                       
       		 if objdataId == x202002_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x202002_g_DemandItem[1].id) < x202002_g_DemandItem[1].num then
       		         if random(1,100)>0 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x202002_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("白鹿之杖   %d/%d", LuaFnGetItemCount(sceneId,selfId,x202002_g_DemandItem[1].id)+1,x202002_g_DemandItem[1].num )) 
				 	EndEvent()
				 	DispatchMissionTips(sceneId, selfId)
				 	AddItemListToHuman(sceneId,selfId) 
		        	 else                                                             
		        	 	BeginEvent(sceneId)                                      
				     	AddText(sceneId,"物品栏已满！")                    
				        EndEvent(sceneId)                                        
				        DispatchMissionTips(sceneId,selfId) 
				 end                     
		         end             
       		    end
       		 end
       		 
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x202002_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x202002_OnItemChanged(sceneId, selfId, itemdataId)

end

