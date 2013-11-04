--惩罚叛军

--MisDescBegin
x207000_g_ScriptId = 207000
--x207000_g_MissionIdPre =120
x207000_g_MissionId = 262
x207000_g_MissionKind = 18
x207000_g_MissionLevel = 75
--x207000_g_ScriptIdNext = {ScriptId = 202003 ,LV = 1 }
x207000_g_Name	="窝阔台" 
x207000_g_DemandItem ={{id=13010050,num=1}}
x207000_g_noDemandKill ={{id=407,num=1}}	

x207000_g_MissionName="惩罚叛军"
x207000_g_MissionInfo="    镇龙台北面处的首领#R武仙#W，曾经是木华黎叔叔部下，任河北西路兵马副元帅，七年前他背叛了我们，投奔金军。\n \n    <窝阔台微微闭上了眼睛，向天祈祷>长生天在上，窝阔台，要为大蒙古国清楚叛党，望木华黎叔叔泉下有知！    "  --任务描述
x207000_g_MissionInfo2="，你是我最信任的人，这件事就由你来做吧，杀了他之后，把他身上的#c0080C0飞虎令#W拿回来。"
x207000_g_MissionTarget="    到镇龙台的北面杀死#R武仙#W，从他身上拿到#c0080C0飞虎令#W，交给#G窝阔台#W。"		
x207000_g_MissionComplete="    做的好！虽然王汗被人救走，但是，我们会再找到他的。"					--完成任务npc说话的话
x207000_g_ContinueInfo="    拿到飞虎令了吗？"
--任务奖励
x207000_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x207000_g_ItemBonus={}

--可选物品奖励，最多8种
x207000_g_RadioItemBonus={}

--MisDescEnd
x207000_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x207000_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207000_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207000_g_MissionId) > 0 then
		if x207000_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x207000_g_MissionName)
			AddText(sceneId,x207000_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x207000_g_MissionTarget) 
			AddText(sceneId,format("\n    飞虎令   %d/%d", LuaFnGetItemCount(sceneId,selfId,x207000_g_DemandItem[1].id),x207000_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x207000_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x207000_g_MissionName)
		     AddText(sceneId,x207000_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in x207000_g_DemandItem do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x207000_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x207000_g_ScriptId, x207000_g_MissionId)
                end

        elseif x207000_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x207000_g_MissionName)
                AddText(sceneId,x207000_g_MissionInfo..GetName(sceneId, selfId)..x207000_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x207000_g_MissionTarget) 
		AddMoneyBonus(sceneId, x207000_g_MoneyBonus)	
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
		AddNumText(sceneId, x207000_g_ScriptId, x207000_g_MissionName)
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
        if (sceneId==7) then
        	         return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x207000_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x207000_g_MissionId, x207000_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x207000_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x207000_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207000_g_MissionId)
	for i, item in x207000_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x207000_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x207000_g_DemandItem[1].id) == x207000_g_DemandItem[1].num then
	        return 1
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

		for i, item in x207000_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x207000_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207000_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x207000_g_MissionId) >= 0 then                                       
       		 if objdataId == x207000_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x207000_g_DemandItem[1].id) < x207000_g_DemandItem[1].num then
       		         if random(1,100)>0 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x207000_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("飞虎令   %d/%d", LuaFnGetItemCount(sceneId,selfId,x207000_g_DemandItem[1].id)+1,x207000_g_DemandItem[1].num )) 
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

function x207000_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207000_OnItemChanged(sceneId, selfId, itemdataId)

end

