--落马

--MisDescBegin
x212005_g_ScriptId = 212005
--x212005_g_MissionIdPre =247
x212005_g_MissionId = 252
x212005_g_MissionKind = 17
x212005_g_MissionLevel = 70
--x212005_g_ScriptIdNext = {ScriptId = 212002 ,LV = 1 }
x212005_g_Name	="窝阔台" 
x212005_g_DemandItem ={{id=13010054,num=5}}
x212005_g_noDemandKill ={{id=425,num=1}}	

x212005_g_MissionName="落马"
x212005_g_MissionInfo="    父汗在围猎的时候不慎落马，我很担心他的伤势！据说#c0080C0妙手回春丸#W治疗伤势是非常有效的。\n \n    难道妙手回春丸就真的这么稀有吗？不管如何，我一定要拿到一些。恩，就这样决定了，从炼药的#R西夏巫师#W身上，应该能得到一些，我并不担心，只需要5颗而已。"  --任务描述
x212005_g_MissionTarget="    从#G恶狼堤#W的#R西夏巫师#W身上收集5颗#c0080C0妙手回春丸#W。"		
x212005_g_MissionComplete="    你帮了我很大的忙！"					--完成任务npc说话的话
x212005_g_ContinueInfo="    这药是给我父汗治伤的，请你加紧一点。"
--任务奖励
x212005_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x212005_g_ItemBonus={}

--可选物品奖励，最多8种
x212005_g_RadioItemBonus={}

--MisDescEnd
x212005_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x212005_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x212005_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x212005_g_MissionId) > 0 then
		if x212005_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x212005_g_MissionName)
			AddText(sceneId,x212005_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x212005_g_MissionTarget) 
			AddText(sceneId,format("\n    妙手回春丸   %d/%d", LuaFnGetItemCount(sceneId,selfId,x212005_g_DemandItem[1].id),x212005_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x212005_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x212005_g_MissionName)
		     AddText(sceneId,x212005_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in x212005_g_DemandItem do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x212005_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x212005_g_ScriptId, x212005_g_MissionId)
                end

        elseif x212005_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x212005_g_MissionName)
                AddText(sceneId,x212005_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x212005_g_MissionTarget) 
		AddMoneyBonus(sceneId, x212005_g_MoneyBonus)
		EndEvent()
		DispatchMissionInfo(sceneId, selfId, targetId, x212005_g_ScriptId, x212005_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x212005_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x212005_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x212005_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x212005_g_ScriptId, x212005_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x212005_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x212005_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x212005_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==12) then
        		 		return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x212005_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x212005_g_MissionId, x212005_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x212005_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x212005_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x212005_g_MissionId)
	for i, item in x212005_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x212005_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x212005_g_DemandItem[1].id) == x212005_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x212005_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x212005_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x212005_g_MissionId)
		AddExp(sceneId, selfId, x212005_g_ExpBonus)
		AddMoney(sceneId, selfId, x212005_g_MoneyBonus)
		for i, item in x212005_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x212005_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x212005_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end

	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x212005_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x212005_g_MissionId) >= 0 then                                       
       		 if objdataId == x212005_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x212005_g_DemandItem[1].id) < x212005_g_DemandItem[1].num then
       		         if random(1,100)>30 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x212005_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("妙手回春丸   %d/%d", LuaFnGetItemCount(sceneId,selfId,x212005_g_DemandItem[1].id)+1,x212005_g_DemandItem[1].num )) 
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

function x212005_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x212005_OnItemChanged(sceneId, selfId, itemdataId)

end

