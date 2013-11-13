--屈出律的手段

--MisDescBegin
x204010_g_ScriptId = 204010
x204010_g_MissionIdPre =104
x204010_g_MissionId = 105
x204010_g_MissionKind = 9
x204010_g_MissionLevel = 45
--x204010_g_ScriptIdNext = {ScriptId = 205005 ,LV = 1 }
x204010_g_Name	="忽必来" 
x204010_g_DemandItem ={{id=13010035,num=10}}
x204010_g_noDemandKill ={{id=354,num=1}}	

x204010_g_MissionName="屈出律的手段"
x204010_g_MissionInfo="    "  --任务描述
x204010_g_MissionInfo2="，你救出大山的孩子之后，大山告诉了我一些秘密。\n \n    乃蛮部被消灭之后，屈出律跑到西辽，先是诱骗了未成年的纯情公主，然后当上了西辽的驸马，后来联合花剌国推翻了耶律直国王，夺取了政权。\n \n    他借西辽的军队，纠集了旧部，想重建乃蛮，这就是他的野心。\n \n    我已经派人把告示贴出去了，让虎思城的所有居民都能知道真相。屈出律派了一伙士兵，把那些告示撕毁，你替我把那伙西辽士兵给解决，把他们身上没撕毁的告示给抢回来。"
x204010_g_MissionTarget="    那伙#R西辽近卫军#W的营地就在南岭的正南方，你要杀了他们，给#G忽必来#W带回10个#c0080C0完整的告示#W。"		
x204010_g_MissionComplete="    这是耶律楚材先生写的告示，不能有失。"					--完成任务npc说话的话
x204010_g_ContinueInfo="    那些告示很重要，拿回来了吗？"
--任务奖励
x204010_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x204010_g_ItemBonus={}

--可选物品奖励，最多8种
x204010_g_RadioItemBonus={}

--MisDescEnd
x204010_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x204010_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x204010_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x204010_g_MissionId) > 0 then
		if x204010_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x204010_g_MissionName)
			AddText(sceneId,x204010_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x204010_g_MissionTarget) 
			AddText(sceneId,format("\n    完整的告示   %d/%d", LuaFnGetItemCount(sceneId,selfId,x204010_g_DemandItem[1].id),x204010_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x204010_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x204010_g_MissionName)
		     AddText(sceneId,x204010_g_MissionComplete)
		     AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in pairs(x204010_g_DemandItem) do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x204010_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x204010_g_ScriptId, x204010_g_MissionId)
                end

        elseif x204010_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x204010_g_MissionName)
                AddText(sceneId,x204010_g_MissionInfo..GetName(sceneId, selfId)..x204010_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x204010_g_MissionTarget) 
		AddMoneyBonus(sceneId, x204010_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x204010_g_ScriptId, x204010_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x204010_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x204010_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x204010_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x204010_g_ScriptId, x204010_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x204010_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x204010_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x204010_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==4) then
        	if IsMissionHaveDone(sceneId, selfId, x204010_g_MissionIdPre) > 0 then
        	         return 1
        	end
		
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x204010_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x204010_g_MissionId, x204010_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x204010_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x204010_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x204010_g_MissionId)
	for i, item in pairs(x204010_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x204010_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x204010_g_DemandItem[1].id) == x204010_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x204010_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x204010_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x204010_g_MissionId)
		AddExp(sceneId, selfId, x204010_g_ExpBonus)
		AddMoney(sceneId, selfId, x204010_g_MoneyBonus)
		for i, item in pairs(x204010_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x204010_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x204010_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x204010_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x204010_g_MissionId) >= 0 then                                       
       		 if objdataId == x204010_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x204010_g_DemandItem[1].id) < x204010_g_DemandItem[1].num then
       		         if random(1,100)>50 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x204010_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("完整的告示   %d/%d", LuaFnGetItemCount(sceneId,selfId,x204010_g_DemandItem[1].id)+1,x204010_g_DemandItem[1].num )) 
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

function x204010_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x204010_OnItemChanged(sceneId, selfId, itemdataId)

end

