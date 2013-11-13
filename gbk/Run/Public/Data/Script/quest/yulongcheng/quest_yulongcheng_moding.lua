--墨锭

--MisDescBegin
x208013_g_ScriptId = 208013
--x208013_g_MissionIdPre =40
x208013_g_MissionId = 67
x208013_g_MissionKind = 12
x208013_g_MissionLevel = 60
--x208013_g_ScriptIdNext = {ScriptId = 205005 ,LV = 1 }
x208013_g_Name	="耶律楚材" 
x208013_g_DemandItem ={{id=13010016,num=10}}
x208013_g_noDemandKill ={{id=321,num=1}}	

x208013_g_MissionName="墨锭"
x208013_g_MissionInfo="    你能帮我收集一些#c0080C0墨锭#W吗，我非常需要它。伊斯兰教的长老告诉我，那些#R契丹头目#W身上有这样的东西。"  --任务描述
x208013_g_MissionTarget="    从士兵头目身上找到10个#c0080C0墨锭#W,并给#G耶律楚材#W带回来"		
x208013_g_MissionComplete="    这些墨锭在这边非常稀有，谢谢你的帮忙。"					--完成任务npc说话的话
x208013_g_ContinueInfo="    我需要10个墨锭。"
--任务奖励
x208013_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x208013_g_ItemBonus={}

--可选物品奖励，最多8种
x208013_g_RadioItemBonus={}

--MisDescEnd
x208013_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x208013_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x208013_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x208013_g_MissionId) > 0 then
		if x208013_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x208013_g_MissionName)
			AddText(sceneId,x208013_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x208013_g_MissionTarget) 
			AddText(sceneId,format("\n    墨锭   %d/%d", LuaFnGetItemCount(sceneId,selfId,x208013_g_DemandItem[1].id),x208013_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x208013_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x208013_g_MissionName)
		     AddText(sceneId,x208013_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in pairs(x208013_g_DemandItem) do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x208013_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x208013_g_ScriptId, x208013_g_MissionId)
                end

        elseif x208013_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x208013_g_MissionName)
                AddText(sceneId,x208013_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x208013_g_MissionTarget) 
		AddMoneyBonus(sceneId, x208013_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x208013_g_ScriptId, x208013_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x208013_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x208013_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x208013_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x208013_g_ScriptId, x208013_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x208013_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x208013_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x208013_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==8) then
        	            	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x208013_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x208013_g_MissionId, x208013_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x208013_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x208013_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x208013_g_MissionId)
	for i, item in pairs(x208013_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x208013_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x208013_g_DemandItem[1].id) == x208013_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x208013_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x208013_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x208013_g_MissionId)
		AddExp(sceneId, selfId, x208013_g_ExpBonus)
		AddMoney(sceneId, selfId, x208013_g_MoneyBonus)
		for i, item in pairs(x208013_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x208013_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x208013_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x208013_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x208013_g_MissionId) >= 0 then                                       
       		 if objdataId == x208013_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x208013_g_DemandItem[1].id) < x208013_g_DemandItem[1].num then
       		         if random(1,100)>20 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x208013_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("墨锭   %d/%d", LuaFnGetItemCount(sceneId,selfId,x208013_g_DemandItem[1].id)+1,x208013_g_DemandItem[1].num )) 
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

function x208013_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x208013_OnItemChanged(sceneId, selfId, itemdataId)

end

