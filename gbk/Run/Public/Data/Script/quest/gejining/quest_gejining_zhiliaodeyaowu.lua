--治疗的药物

--MisDescBegin
x215010_g_ScriptId = 215010
x215010_g_MissionIdPre =140
x215010_g_MissionId = 141
x215010_g_MissionKind = 14
x215010_g_MissionLevel = 55
--x215010_g_ScriptIdNext = {ScriptId = 204011 ,LV = 1 }
x215010_g_Name	="术赤" 
x215010_g_DemandItem ={{id=13010030,num=10}}
x215010_g_noDemandKill ={{id=384,num=1}}	

x215010_g_MissionName="治疗的药物"
x215010_g_MissionInfo="    我们救下来的那些卫兵浑身是伤，伤口已经有了脓痂，需要一些外伤的药。\n \n    哲别刚刚给我稍来消息，他告诉我，伊拉克营地的那些头目身上都随身带有治伤的药物。\n \n    这件事非常紧急，你要赶紧去做。"  --任务描述
x215010_g_MissionTarget="    从#R伊拉克头目#W身上收集10个#c0080C0伊拉克秘药#W，将它们拿给#G术赤#W来治疗勇士们的伤口。"		
x215010_g_MissionComplete="    我代表所有伤兵向你致谢。"					--完成任务npc说话的话
x215010_g_ContinueInfo="    我们十分急需这些药物，你给我带来了吗？"
--任务奖励
x215010_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x215010_g_ItemBonus={}

--可选物品奖励，最多8种
x215010_g_RadioItemBonus={}

--MisDescEnd
x215010_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x215010_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x215010_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x215010_g_MissionId) > 0 then
		if x215010_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x215010_g_MissionName)
			AddText(sceneId,x215010_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x215010_g_MissionTarget) 
			AddText(sceneId,format("\n    伊拉克秘药   %d/%d", LuaFnGetItemCount(sceneId,selfId,x215010_g_DemandItem[1].id),x215010_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x215010_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x215010_g_MissionName)
		     AddText(sceneId,x215010_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in pairs(x215010_g_DemandItem) do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x215010_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x215010_g_ScriptId, x215010_g_MissionId)
                end

        elseif x215010_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x215010_g_MissionName)
                AddText(sceneId,x215010_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x215010_g_MissionTarget) 
		AddMoneyBonus(sceneId, x215010_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x215010_g_ScriptId, x215010_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x215010_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x215010_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x215010_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x215010_g_ScriptId, x215010_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x215010_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x215010_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x215010_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==15) then
        	if IsMissionHaveDone(sceneId, selfId, x215010_g_MissionIdPre) > 0 then
        				return 1
        	end
		
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x215010_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x215010_g_MissionId, x215010_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x215010_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x215010_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x215010_g_MissionId)
	for i, item in pairs(x215010_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x215010_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x215010_g_DemandItem[1].id) == x215010_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x215010_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x215010_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x215010_g_MissionId)
		AddExp(sceneId, selfId, x215010_g_ExpBonus)
		AddMoney(sceneId, selfId, x215010_g_MoneyBonus)
		for i, item in pairs(x215010_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x215010_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x215010_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x215010_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x215010_g_MissionId) >= 0 then                                       
       		 if objdataId == x215010_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x215010_g_DemandItem[1].id) < x215010_g_DemandItem[1].num then
       		         if random(1,100)>20 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x215010_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("伊拉克秘药   %d/%d", LuaFnGetItemCount(sceneId,selfId,x215010_g_DemandItem[1].id)+1,x215010_g_DemandItem[1].num )) 
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

function x215010_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x215010_OnItemChanged(sceneId, selfId, itemdataId)

end

