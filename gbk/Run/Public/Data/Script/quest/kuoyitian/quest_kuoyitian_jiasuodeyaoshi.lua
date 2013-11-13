--枷锁的钥匙

--MisDescBegin
x214007_g_ScriptId = 214007
--x214007_g_MissionIdPre =87
x214007_g_MissionId = 114
x214007_g_MissionKind = 3
x214007_g_MissionLevel = 15
--x214007_g_ScriptIdNext = {ScriptId = 205005 ,LV = 1 }
x214007_g_Name	="忽察儿" 
x214007_g_DemandItem ={{id=13010036,num=1}}
x214007_g_noDemandKill ={{id=362,num=1}}	

x214007_g_MissionName="枷锁的钥匙"
x214007_g_MissionInfo="    "  --任务描述
x214007_g_MissionInfo2="我们在围剿札木合营地的时候，找到了一个铁匠，他被札木合折磨得只浑身是伤，不成人样。\n \n    我多方打听，才知道他叫锁儿罕，曾经救过我们的铁木真大汗，恩，他的女儿叫合答安！\n \n    这是大汗的恩人，我们要帮帮他，他身上的枷锁还没有解开，你要到札答阑部的e处那里，杀死#R脱朵#W，从他身上得到#c0080C0枷锁的钥匙#W。"
x214007_g_MissionTarget="    到札答阑部的e处那里，杀死#R脱朵#W，从他身上得到#c0080C0枷锁的钥匙#W，把钥匙交给#G忽察儿#W。"		
x214007_g_MissionComplete="    铁木真听说你杀死了脱朵，他很高兴。"					--完成任务npc说话的话
x214007_g_ContinueInfo="    枷锁的钥匙呢？"
--任务奖励
x214007_g_MoneyBonus = 800
--固定物品奖励，最多8种
x214007_g_ItemBonus={}

--可选物品奖励，最多8种
x214007_g_RadioItemBonus={}

--MisDescEnd
x214007_g_ExpBonus = 6500
--**********************************

--任务入口函数

--**********************************

function x214007_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x214007_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x214007_g_MissionId) > 0 then
		if x214007_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x214007_g_MissionName)
			AddText(sceneId,x214007_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x214007_g_MissionTarget) 
			AddText(sceneId,format("\n    枷锁的钥匙   %d/%d", LuaFnGetItemCount(sceneId,selfId,x214007_g_DemandItem[1].id),x214007_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x214007_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x214007_g_MissionName)
		     AddText(sceneId,x214007_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in pairs(x214007_g_DemandItem) do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x214007_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x214007_g_ScriptId, x214007_g_MissionId)
                end

        elseif x214007_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x214007_g_MissionName)
                AddText(sceneId,x214007_g_MissionInfo..GetName(sceneId, selfId)..x214007_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x214007_g_MissionTarget) 
		AddMoneyBonus(sceneId, x214007_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x214007_g_ScriptId, x214007_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x214007_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x214007_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x214007_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x214007_g_ScriptId, x214007_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x214007_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x214007_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x214007_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==14) then
        	         return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x214007_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x214007_g_MissionId, x214007_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x214007_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x214007_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x214007_g_MissionId)
	for i, item in pairs(x214007_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x214007_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x214007_g_DemandItem[1].id) == x214007_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x214007_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x214007_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x214007_g_MissionId)
		AddExp(sceneId, selfId, x214007_g_ExpBonus)
		AddMoney(sceneId, selfId, x214007_g_MoneyBonus)
		for i, item in pairs(x214007_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x214007_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x214007_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x214007_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x214007_g_MissionId) >= 0 then                                       
       		 if objdataId == x214007_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x214007_g_DemandItem[1].id) < x214007_g_DemandItem[1].num then
       		         if random(1,100)>0 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x214007_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("枷锁的钥匙   %d/%d", LuaFnGetItemCount(sceneId,selfId,x214007_g_DemandItem[1].id)+1,x214007_g_DemandItem[1].num )) 
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

function x214007_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x214007_OnItemChanged(sceneId, selfId, itemdataId)

end

