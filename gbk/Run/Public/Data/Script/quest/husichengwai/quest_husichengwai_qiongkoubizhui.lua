--穷寇必追

--MisDescBegin
x204001_g_ScriptId = 204001
x204001_g_MissionIdPre =95
x204001_g_MissionId = 96
x204001_g_MissionKind = 9
x204005_g_MissionLevel = 45
--x204001_g_ScriptIdNext = {ScriptId = 205005 ,LV = 1 }
x204001_g_Name	="成吉思汗" 
x204001_g_DemandItem ={{id=13010031,num=5}}
x204001_g_noDemandKill ={{id=347,num=1}}	

x204001_g_MissionName="穷寇必追"
x204001_g_MissionInfo="    在我统一蒙古的各部战争中，屈出律是唯一逃脱的王子，他逃到了西辽后，又派人到大草原上纠集了他的旧部。\n \n    擒贼先擒王，绝对不能让他们再有任何死灰复燃的机会，把北郊西面的乃蛮残部一并消灭，并把他们将领的人头给我带回来。"  --任务描述
x204001_g_MissionTarget="    #G成吉思汗#W要你到北郊西面去，杀死5名#R乃蛮部将领#W，拿回他们的人头。"		
x204001_g_MissionComplete="    很好，杀了他们的将领，他们也不足为惧。"					--完成任务npc说话的话
x204001_g_ContinueInfo="    那些乃蛮将领的人头呢？"
--任务奖励
x204001_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x204001_g_ItemBonus={}

--可选物品奖励，最多8种
x204001_g_RadioItemBonus={}

--MisDescEnd
x204001_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x204001_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x204001_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x204001_g_MissionId) > 0 then
		if x204001_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x204001_g_MissionName)
			AddText(sceneId,x204001_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x204001_g_MissionTarget) 
			AddText(sceneId,format("\n    乃蛮将领的头   %d/%d", LuaFnGetItemCount(sceneId,selfId,x204001_g_DemandItem[1].id),x204001_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x204001_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x204001_g_MissionName)
		     AddText(sceneId,x204001_g_MissionComplete)
		     AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in x204001_g_DemandItem do  
		     --AddItemBonus(sceneId, item.id, item.num)
		    -- end
		     AddMoneyBonus(sceneId, x204001_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x204001_g_ScriptId, x204001_g_MissionId)
                end

        elseif x204001_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x204001_g_MissionName)
                AddText(sceneId,x204001_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x204001_g_MissionTarget) 
		AddMoneyBonus(sceneId, x204001_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x204001_g_ScriptId, x204001_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x204001_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x204001_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x204001_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x204001_g_ScriptId, x204001_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x204001_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x204001_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x204001_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==4) then
        	if IsMissionHaveDone(sceneId, selfId, x204001_g_MissionIdPre) > 0 then
        	         return 1
        	end
		
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x204001_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x204001_g_MissionId, x204001_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x204001_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x204001_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x204001_g_MissionId)
	for i, item in x204001_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x204001_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x204001_g_DemandItem[1].id) == x204001_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x204001_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x204001_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x204001_g_MissionId)
		AddExp(sceneId, selfId, x204001_g_ExpBonus)
		AddMoney(sceneId, selfId, x204001_g_MoneyBonus)
		for i, item in x204001_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x204001_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x204001_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x204001_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x204001_g_MissionId) >= 0 then                                       
       		 if objdataId == x204001_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x204001_g_DemandItem[1].id) < x204001_g_DemandItem[1].num then
       		         if random(1,100)>0 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x204001_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("乃蛮将领的头   %d/%d", LuaFnGetItemCount(sceneId,selfId,x204001_g_DemandItem[1].id)+1,x204001_g_DemandItem[1].num )) 
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

function x204001_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x204001_OnItemChanged(sceneId, selfId, itemdataId)

end

