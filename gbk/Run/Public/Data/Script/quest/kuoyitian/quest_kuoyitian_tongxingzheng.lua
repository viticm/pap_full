--通行证

--MisDescBegin
x214008_g_ScriptId = 214008
--x214008_g_MissionIdPre =41
x214008_g_MissionId = 115
x214008_g_MissionKind = 3
x214008_g_MissionLevel = 15
x214008_g_ScriptIdNext = {ScriptId = 214009 ,LV = 1 }
x214008_g_Name	="忽察儿" 
x214008_g_Name2	="者勒蔑"
x214008_g_DemandItem ={{id=13010037,num=1}}
x214008_g_noDemandKill ={{id=363,num=1}}

x214008_g_MissionName="通行证"
x214008_g_MissionInfo="    <忽察儿一脸慌张的向你招手>"  --任务描述
x214008_g_MissionInfo2="，恩，你现在立即到D处的北面，从那些巡逻的塔塔儿人身上拿到一个通行证。然后把#c0080C0通行证#W拿给#G者勒蔑#W。\n \n    记住，一定要记住，千万要偷偷的，不能惊动任何人，下手要狠，动作要快，不要问为什么。"
x214008_g_MissionTarget="    到D处的北面，杀死#R塔塔儿巡逻兵#W找到#c0080C0通行证#W，然后把通行证给#G者勒蔑#W送去。"		                                                                                               
x214008_g_MissionComplete="    太好了，这下就好办了。"					--完成任务npc说话的话
x214008_g_ContinueInfo="    拿到通行证了吗？"
--任务奖励
x214008_g_MoneyBonus = 600
--固定物品奖励，最多8种
x214008_g_ItemBonus={}

--可选物品奖励，最多8种
x214008_g_RadioItemBonus={}

--MisDescEnd
x214008_g_ExpBonus = 6500
--**********************************

--任务入口函数

--**********************************

function x214008_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x214008_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x214008_g_MissionId) > 0 then
		if x214008_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x214008_g_MissionName)
			AddText(sceneId,x214008_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x214008_g_MissionTarget) 
			AddText(sceneId,format("\n    通行证   %d/%d", LuaFnGetItemCount(sceneId,selfId,x214008_g_DemandItem[1].id),x214008_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x214008_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x214008_g_MissionName)
		     AddText(sceneId,x214008_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in pairs(x214008_g_DemandItem) do  
		     	--AddItemDemand(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x214008_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x214008_g_ScriptId, x214008_g_MissionId)
                end

        elseif x214008_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x214008_g_MissionName)
                AddText(sceneId,x214008_g_MissionInfo..GetName(sceneId, selfId)..x214008_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x214008_g_MissionTarget) 
		AddMoneyBonus(sceneId, x214008_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x214008_g_ScriptId, x214008_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x214008_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x214008_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x214008_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x214008_g_ScriptId, x214008_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x214008_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x214008_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x214008_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==14) then
        	if (GetName(sceneId,targetId)==x214008_g_Name) then
        		if IsHaveMission(sceneId,selfId, x214008_g_MissionId) <= 0 then 
        	        	return 1
        	        end
        	end
        	if (GetName(sceneId,targetId)==x214008_g_Name2) then
        		if IsHaveMission(sceneId,selfId, x214008_g_MissionId) > 0 then 
        	        	return 1
        	        end
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x214008_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x214008_g_MissionId, x214008_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x214008_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x214008_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x214008_g_MissionId)
	for i, item in pairs(x214008_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x214008_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x214008_g_DemandItem[1].id) == x214008_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x214008_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x214008_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x214008_g_MissionId)
		AddExp(sceneId, selfId, x214008_g_ExpBonus)
		AddMoney(sceneId, selfId, x214008_g_MoneyBonus)
		for i, item in pairs(x214008_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x214008_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x214008_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x214008_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x214008_g_MissionId) >= 0 then                                       
       		 if objdataId == x214008_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x214008_g_DemandItem[1].id) < x214008_g_DemandItem[1].num then
       		         if random(1,100)>80 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x214008_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("通行证   %d/%d", LuaFnGetItemCount(sceneId,selfId,x214008_g_DemandItem[1].id)+1,x214008_g_DemandItem[1].num )) 
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

function x214008_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x214008_OnItemChanged(sceneId, selfId, itemdataId)

end