--药箱

--MisDescBegin
x203012_g_ScriptId = 203012
--x203012_g_MissionIdPre =71
x203012_g_MissionId = 80
x203012_g_MissionKind = 13
x203012_g_MissionLevel = 50
--x203012_g_ScriptIdNext = {ScriptId = 203005 ,LV = 1 }
x203012_g_Name	="速不台" 
x203012_g_DemandItem ={{id=13010022,num=1}}
x203012_g_noDemandKill ={{id=331,num=1}}	

x203012_g_MissionName="药箱"
x203012_g_MissionInfo="    我们大草原的金刀驸马郭靖，从神秘的南国来到了阿碧岛，有他相助，魔诃魔离死已经不远了。我们已经有了新的计划，让岛上的那些士兵吃泻药，让他们一泻千里，浑身无力……，然后我们带兵杀进去！\n \n    听说郭靖的朋友明安是个奇人，能让老鼠帮你做事，郭靖打算让这群老鼠帮忙……\n \n    <哲别捂嘴偷笑，似乎请老鼠来帮忙是一件很搞笑的事情>他的计划已经开始了，我们要跟他们配合。\n \n    我查过了，这群溃败下来的逃兵，只有一名突厥巫师和他的学徒会医术，你要把他们身上的药箱给抢回来。"  --任务描述
x203012_g_MissionTarget="    #G速不台#W让你带回#R突厥巫师#W的#c0080C0药箱#W。"		
x203012_g_MissionComplete="    花剌子模的那些将士支持不了多久的，我们很快就能看到胜利的曙光。"					--完成任务npc说话的话
x203012_g_ContinueInfo="    吩咐你办的事，你办完了吗？"
--任务奖励
x203012_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x203012_g_ItemBonus={}

--可选物品奖励，最多8种
x203012_g_RadioItemBonus={}

--MisDescEnd
x203012_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x203012_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x203012_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x203012_g_MissionId) > 0 then
		if x203012_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x203012_g_MissionName)
			AddText(sceneId,x203012_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x203012_g_MissionTarget) 
			AddText(sceneId,format("\n    药箱   %d/%d", LuaFnGetItemCount(sceneId,selfId,x203012_g_DemandItem[1].id),x203012_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x203012_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x203012_g_MissionName)
		     AddText(sceneId,x203012_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in x203012_g_DemandItem do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x203012_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x203012_g_ScriptId, x203012_g_MissionId)
                end

        elseif x203012_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x203012_g_MissionName)
                AddText(sceneId,x203012_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x203012_g_MissionTarget) 
		AddMoneyBonus(sceneId, x203012_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x203012_g_ScriptId, x203012_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x203012_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x203012_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x203012_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x203012_g_ScriptId, x203012_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x203012_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x203012_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x203012_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==3) then
        				return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x203012_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x203012_g_MissionId, x203012_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x203012_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x203012_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x203012_g_MissionId)
	for i, item in x203012_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x203012_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x203012_g_DemandItem[1].id) == x203012_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x203012_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x203012_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x203012_g_MissionId)
		AddExp(sceneId, selfId, x203012_g_ExpBonus)
		AddMoney(sceneId, selfId, x203012_g_MoneyBonus)
		for i, item in x203012_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x203012_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x203012_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x203012_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x203012_g_MissionId) >= 0 then                                       
       		 if objdataId == x203012_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x203012_g_DemandItem[1].id) < x203012_g_DemandItem[1].num then
       		         if random(1,100)>0 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x203012_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("药箱   %d/%d", LuaFnGetItemCount(sceneId,selfId,x203012_g_DemandItem[1].id)+1,x203012_g_DemandItem[1].num )) 
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

function x203012_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x203012_OnItemChanged(sceneId, selfId, itemdataId)

end

