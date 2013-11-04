--截杀信使

--MisDescBegin
x204003_g_ScriptId = 204003
--x204003_g_MissionIdPre =95
x204003_g_MissionId = 98
x204003_g_MissionKind = 9
x204003_g_MissionLevel = 45
--x204003_g_ScriptIdNext = {ScriptId = 205005 ,LV = 1 }
x204003_g_Name	="成吉思汗" 
x204003_g_DemandItem ={{id=13010032,num=1}}
x204003_g_noDemandKill ={{id=349,num=1}}	

x204003_g_MissionName="截杀信使"
x204003_g_MissionInfo="    我们的炮火已经打在了他们的城墙上，弓箭已经射向了他们的脖子处，苏鲁锭的光辉永远照射在我们任何一个勇敢的草原勇士身上！\n \n    狡猾的屈出律，他阴谋不会得逞，你要赶到走马道去，把他派遣的信使给截下来，拿回密函，#c0080C0密函#W就在那群#R信使#W中的某一个人身上。"  --任务描述
x204003_g_MissionTarget="    到走马道去截回#R信使#W身上的#c0080C0密函#W，拿回去给#G成吉思汗#W。"		
x204003_g_MissionComplete="    太好了，这是屈出律勾结花剌国的重要证据。"					--完成任务npc说话的话
x204003_g_ContinueInfo="    密函在哪呢？"
--任务奖励
x204003_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x204003_g_ItemBonus={}

--可选物品奖励，最多8种
x204003_g_RadioItemBonus={}

--MisDescEnd
x204003_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x204003_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x204003_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x204003_g_MissionId) > 0 then
		if x204003_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x204003_g_MissionName)
			AddText(sceneId,x204003_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x204003_g_MissionTarget) 
			AddText(sceneId,format("\n    密函   %d/%d", LuaFnGetItemCount(sceneId,selfId,x204003_g_DemandItem[1].id),x204003_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x204003_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x204003_g_MissionName)
		     AddText(sceneId,x204003_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in x204003_g_DemandItem do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x204003_g_MoneyBonus)	
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x204003_g_ScriptId, x204003_g_MissionId)
                end

        elseif x204003_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x204003_g_MissionName)
                AddText(sceneId,x204003_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x204003_g_MissionTarget) 
		AddMoneyBonus(sceneId, x204003_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x204003_g_ScriptId, x204003_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x204003_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x204003_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x204003_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x204003_g_ScriptId, x204003_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x204003_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x204003_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x204003_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==4) then
        	         return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x204003_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x204003_g_MissionId, x204003_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x204003_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x204003_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x204003_g_MissionId)
	for i, item in x204003_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x204003_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x204003_g_DemandItem[1].id) == x204003_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x204003_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x204003_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x204003_g_MissionId)
		AddExp(sceneId, selfId, x204003_g_ExpBonus)
		AddMoney(sceneId, selfId, x204003_g_MoneyBonus)
		for i, item in x204003_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x204003_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x204003_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x204003_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x204003_g_MissionId) >= 0 then                                       
       		 if objdataId == x204003_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x204003_g_DemandItem[1].id) < x204003_g_DemandItem[1].num then
       		         if random(1,100)>90 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x204003_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("密函   %d/%d", LuaFnGetItemCount(sceneId,selfId,x204003_g_DemandItem[1].id)+1,x204003_g_DemandItem[1].num )) 
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

function x204003_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x204003_OnItemChanged(sceneId, selfId, itemdataId)

end

