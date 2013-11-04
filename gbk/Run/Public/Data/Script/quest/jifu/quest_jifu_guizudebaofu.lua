--贵族的包袱

--MisDescBegin
x225005_g_ScriptId = 225005
x225005_g_MissionIdPre =326
x225005_g_MissionId = 327
x225005_g_MissionKind = 22
x225005_g_MissionLevel = 110
x225005_g_ScriptIdNext = {ScriptId = 225006 ,LV = 1 }
x225005_g_Name	="蒙哥" 
x225005_g_DemandItem ={{id=13010061,num=10}}
x225005_g_noDemandKill ={{id=432,num=1}}	

x225005_g_MissionName="贵族的包袱"
x225005_g_MissionInfo="    我们洗劫了贫民窟，可是他们太穷了，没有太大的收获。贵族区应该会有很多财物。你去贵族区，杀了那些贵族，把他们身上的包袱给我带回来。"  --任务描述
x225005_g_MissionTarget="    给#G蒙哥#W带回10个#R基辅贵族#W身上的包袱。"		
x225005_g_MissionComplete="    好东西还真不少，可以用它们来鼓励我蒙古勇士了。"					--完成任务npc说话的话
x225005_g_ContinueInfo="    贵族的身上一定有不少的财物。"
--任务奖励
x225005_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x225005_g_ItemBonus={}

--可选物品奖励，最多8种
x225005_g_RadioItemBonus={}

--MisDescEnd
x225005_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x225005_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x225005_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x225005_g_MissionId) > 0 then
		if x225005_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x225005_g_MissionName)
			AddText(sceneId,x225005_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x225005_g_MissionTarget) 
			AddText(sceneId,format("\n    贵族的包袱   %d/%d", LuaFnGetItemCount(sceneId,selfId,x225005_g_DemandItem[1].id),x225005_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x225005_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x225005_g_MissionName)
		     AddText(sceneId,x225005_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in x225005_g_DemandItem do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x225005_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x225005_g_ScriptId, x225005_g_MissionId)
                end

        elseif x225005_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x225005_g_MissionName)
                AddText(sceneId,x225005_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x225005_g_MissionTarget) 
		AddMoneyBonus(sceneId, x225005_g_MoneyBonus)
		EndEvent()
		DispatchMissionInfo(sceneId, selfId, targetId, x225005_g_ScriptId, x225005_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x225005_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x225005_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x225005_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x225005_g_ScriptId, x225005_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x225005_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x225005_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x225005_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==16) then
        	if IsMissionHaveDone(sceneId, selfId, x225005_g_MissionIdPre) > 0 then
        	         return 1
        	end
		
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x225005_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x225005_g_MissionId, x225005_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x225005_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x225005_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x225005_g_MissionId)
	for i, item in x225005_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x225005_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x225005_g_DemandItem[1].id) == x225005_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x225005_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x225005_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x225005_g_MissionId)
		AddExp(sceneId, selfId, x225005_g_ExpBonus)
		AddMoney(sceneId, selfId, x225005_g_MoneyBonus)
		for i, item in x225005_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x225005_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x225005_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end

	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x225005_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x225005_g_MissionId) >= 0 then                                       
       		 if objdataId == x225005_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x225005_g_DemandItem[1].id) < x225005_g_DemandItem[1].num then
       		         if random(1,100)>20 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x225005_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("贵族的包袱   %d/%d", LuaFnGetItemCount(sceneId,selfId,x225005_g_DemandItem[1].id)+1,x225005_g_DemandItem[1].num ))
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

function x225005_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x225005_OnItemChanged(sceneId, selfId, itemdataId)

end

