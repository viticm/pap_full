--干净的泉水

--MisDescBegin
x215005_g_ScriptId = 215005
x215005_g_MissionIdPre =135
x215005_g_MissionId = 136
x215005_g_MissionKind = 14
x215005_g_MissionLevel = 55
x215005_g_ScriptIdNext = {ScriptId = 215006 ,LV = 1 }
x215005_g_Name	="老牧师" 
x215005_g_Name2	="木华花小姐" 
x215005_g_DemandItem ={{id=13010028,num=12}}
x215005_g_noDemandKill ={{id=380,num=1}}	

x215005_g_MissionName="干净的泉水"
x215005_g_MissionInfo="    <老牧师轻轻的闻了闻杯中的水，脸色在瞬间变得沉沉的。>这太疯狂了！一定是那些来自伊拉克的士兵在这河流的上游下了泻药，让我们教会的教友和一些教徒上吐下泻，浑身无力。如果这样下去，我们根本没有力气做礼拜，最可恶的是，我们这里的厕纸严重的稀缺……。\n \n    我需要干净的泉水来给他们解毒，只是装水的器皿不足。需要从阿富汗士兵的身上收集能装水的器皿，把这些器皿交给#G木花花小姐#W。"  --任务描述
x215005_g_MissionTarget="    从#R伊拉克士兵#W身上收集12个#c0080C0装水的葫芦#W，将它们交给#G木花花小姐#W。"		
x215005_g_MissionComplete="    泻药真的下得很重，请你快一点！"					--完成任务npc说话的话
x215005_g_ContinueInfo="    我等你很久了。"
--任务奖励
x215005_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x215005_g_ItemBonus={}

--可选物品奖励，最多8种
x215005_g_RadioItemBonus={}

--MisDescEnd
x215005_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x215005_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x215005_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x215005_g_MissionId) > 0 then
		if x215005_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x215005_g_MissionName)
			AddText(sceneId,x215005_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x215005_g_MissionTarget) 
			AddText(sceneId,format("\n    装水的葫芦   %d/%d", LuaFnGetItemCount(sceneId,selfId,x215005_g_DemandItem[1].id),x215005_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x215005_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x215005_g_MissionName)
		     AddText(sceneId,x215005_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in pairs(x215005_g_DemandItem) do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x215005_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x215005_g_ScriptId, x215005_g_MissionId)
                end

        elseif x215005_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x215005_g_MissionName)
                AddText(sceneId,x215005_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x215005_g_MissionTarget) 
		AddMoneyBonus(sceneId, x215005_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x215005_g_ScriptId, x215005_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x215005_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x215005_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x215005_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x215005_g_ScriptId, x215005_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x215005_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x215005_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x215005_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==15) then
        	if IsMissionHaveDone(sceneId, selfId, x215005_g_MissionIdPre) > 0 then
        		if (GetName(sceneId,targetId)==x215005_g_Name) then
        			if IsHaveMission(sceneId,selfId, x215005_g_MissionId) <= 0 then 
        	         		return 1
        	         	end
        	        end
        	        if (GetName(sceneId,targetId)==x215005_g_Name2) then
        			if IsHaveMission(sceneId,selfId, x215005_g_MissionId) > 0 then 
        	         		return 1
        	         	end
        	        end
        	end
		
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x215005_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x215005_g_MissionId, x215005_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x215005_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x215005_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x215005_g_MissionId)
	for i, item in pairs(x215005_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x215005_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x215005_g_DemandItem[1].id) == x215005_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x215005_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x215005_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x215005_g_MissionId)
		AddExp(sceneId, selfId, x215005_g_ExpBonus)
		AddMoney(sceneId, selfId, x215005_g_MoneyBonus)
		for i, item in pairs(x215005_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x215005_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x215005_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x215005_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x215005_g_MissionId) >= 0 then                                       
       		 if objdataId == x215005_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x215005_g_DemandItem[1].id) < x215005_g_DemandItem[1].num then
       		         if random(1,100)>20 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x215005_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("装水的葫芦   %d/%d", LuaFnGetItemCount(sceneId,selfId,x215005_g_DemandItem[1].id)+1,x215005_g_DemandItem[1].num )) 
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

function x215005_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x215005_OnItemChanged(sceneId, selfId, itemdataId)

end

