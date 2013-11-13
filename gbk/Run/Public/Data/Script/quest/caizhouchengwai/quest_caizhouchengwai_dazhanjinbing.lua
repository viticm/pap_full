--大战金兵

--MisDescBegin
x207006_g_ScriptId = 207006
x207006_g_MissionIdPre =267
x207006_g_MissionId = 268
x207006_g_MissionKind = 18
x207006_g_MissionLevel = 75
--x207006_g_ScriptIdNext = {ScriptId = 202002 ,LV = 1 }
x207006_g_Name	="孛鲁" 
x207006_g_DemandItem ={{id=13010052,num=10}}
x207006_g_noDemandKill ={{id=410,num=1}}	

x207006_g_MissionName="大战金兵"
x207006_g_MissionInfo="    我们的将士们听到大汗窝阔台亲征，一个个神情激昂，军心大振！\n \n    大汗要我去面见他，我希望能带一些特殊的礼物去给他，恩，就蔡州城门处的#R金国禁卫军#W吧，把他们的耳朵给我割下来。"  --任务描述
x207006_g_MissionTarget="    为#G孛鲁#W消灭蔡州城门处的#R金国禁卫军#W，收集他们的耳朵。"		
x207006_g_MissionComplete="    大汗见到这些礼物，一定比什么都高兴。"					--完成任务npc说话的话
x207006_g_ContinueInfo="    我需要特殊的礼物，那就是金国禁卫军的性命。"
--任务奖励
x207006_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x207006_g_ItemBonus={}

--可选物品奖励，最多8种
x207006_g_RadioItemBonus={}

--MisDescEnd
x207006_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x207006_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207006_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207006_g_MissionId) > 0 then
		if x207006_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x207006_g_MissionName)
			AddText(sceneId,x207006_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x207006_g_MissionTarget) 
			AddText(sceneId,format("\n    禁卫军之耳   %d/%d", LuaFnGetItemCount(sceneId,selfId,x207006_g_DemandItem[1].id),x207006_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x207006_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x207006_g_MissionName)
		     AddText(sceneId,x207006_g_MissionComplete)
		     AddMoneyBonus(sceneId, x207006_g_MoneyBonus)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in pairs(x207006_g_DemandItem) do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x207006_g_ScriptId, x207006_g_MissionId)
                end

        elseif x207006_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x207006_g_MissionName)
                AddText(sceneId,x207006_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x207006_g_MissionTarget) 
		AddMoneyBonus(sceneId, x207006_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207006_g_ScriptId, x207006_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207006_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207006_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207006_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207006_g_ScriptId, x207006_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207006_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207006_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207006_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==7) then
        	if IsMissionHaveDone(sceneId, selfId, x207006_g_MissionIdPre) > 0 then
        	         return 1
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x207006_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x207006_g_MissionId, x207006_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x207006_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x207006_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207006_g_MissionId)
	for i, item in pairs(x207006_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x207006_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x207006_g_DemandItem[1].id) == x207006_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207006_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207006_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207006_g_MissionId)
		AddExp(sceneId, selfId, x207006_g_ExpBonus)
		AddMoney(sceneId, selfId, x207006_g_MoneyBonus)
		for i, item in pairs(x207006_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x207006_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x207006_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207006_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x207006_g_MissionId) >= 0 then                                       
       		 if objdataId == x207006_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x207006_g_DemandItem[1].id) < x207006_g_DemandItem[1].num then
       		         if random(1,100)>10 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x207006_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("禁卫军之耳   %d/%d", LuaFnGetItemCount(sceneId,selfId,x207006_g_DemandItem[1].id)+1,x207006_g_DemandItem[1].num )) 
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

function x207006_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207006_OnItemChanged(sceneId, selfId, itemdataId)

end

