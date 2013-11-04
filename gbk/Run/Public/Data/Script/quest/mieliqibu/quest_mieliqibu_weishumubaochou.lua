--为庶母报仇

--MisDescBegin
x201010_g_ScriptId = 201010
--x201010_g_MissionIdPre =41
x201010_g_MissionId = 92
x201010_g_MissionKind = 2
x201010_g_MissionLevel = 10
x201010_g_ScriptIdNext = {ScriptId = 201011 ,LV = 1 }
x201010_g_Name	="诃额仑" 
x201010_g_Name2	="别勒古台"
x201010_g_DemandItem ={{id=13010071,num=10}}
x201010_g_noDemandKill ={{id=475,num=1}}

x201010_g_MissionName="为庶母报仇"
x201010_g_MissionInfo="    铁木真的庶母速赤被蔑里乞人所辱，她无颜见我们，已经投河自尽了。\n \n    我们要为她报仇，所有的蔑里乞人都该死，"  --任务描述
x201010_g_MissionInfo2="，讨还血债的时候到了，杀死跑马坡的那些骑兵，把他们的人头拿去给#G别勒古台#W。"
x201010_g_MissionTarget="    消灭#G跑马坡#W的#R蔑里乞骑兵#W，为速赤报仇，带回10颗#c0080C0蔑里乞骑兵的头#W给#G别勒古台#W。"		                                                                                               
x201010_g_MissionComplete="    这些……，远远不够！"					--完成任务npc说话的话
x201010_g_ContinueInfo="    我需要蔑里乞人的人头来祭奠我的亲人！"
--任务奖励
x201010_g_MoneyBonus = 1
--固定物品奖励，最多8种
x201010_g_ItemBonus={}

--可选物品奖励，最多8种
x201010_g_RadioItemBonus={}

--MisDescEnd
x201010_g_ExpBonus = 50
--**********************************

--任务入口函数

--**********************************

function x201010_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x201010_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x201010_g_MissionId) > 0 then
		if x201010_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x201010_g_MissionName)
			AddText(sceneId,x201010_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x201010_g_MissionTarget) 
			AddText(sceneId,format("\n    蔑里乞骑兵的头   %d/%d", LuaFnGetItemCount(sceneId,selfId,x201010_g_DemandItem[1].id),x201010_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x201010_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x201010_g_MissionName)
		     AddText(sceneId,x201010_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in x201010_g_DemandItem do  
		     --	AddItemDemand(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x201010_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x201010_g_ScriptId, x201010_g_MissionId)
                end

        elseif x201010_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x201010_g_MissionName)
                AddText(sceneId,x201010_g_MissionInfo..GetName(sceneId, selfId)..x201010_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x201010_g_MissionTarget) 
		AddMoneyBonus(sceneId, x201010_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x201010_g_ScriptId, x201010_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x201010_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x201010_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x201010_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x201010_g_ScriptId, x201010_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x201010_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x201010_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x201010_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==1) then
        	if (GetName(sceneId,targetId)==x201010_g_Name) then
        		if IsHaveMission(sceneId,selfId, x201010_g_MissionId) <= 0 then 
        	        	return 1
        	        end
        	end
        	if (GetName(sceneId,targetId)==x201010_g_Name2) then
        		if IsHaveMission(sceneId,selfId, x201010_g_MissionId) > 0 then 
        	        	return 1
        	        end
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x201010_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x201010_g_MissionId, x201010_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x201010_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x201010_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x201010_g_MissionId)
	for i, item in x201010_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x201010_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x201010_g_DemandItem[1].id) == x201010_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x201010_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x201010_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x201010_g_MissionId)
		AddExp(sceneId, selfId, x201010_g_ExpBonus)
		AddMoney(sceneId, selfId, x201010_g_MoneyBonus)
		for i, item in x201010_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x201010_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x201010_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x201010_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x201010_g_MissionId) >= 0 then                                       
       		 if objdataId == x201010_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x201010_g_DemandItem[1].id) < x201010_g_DemandItem[1].num then
       		         if random(1,100)>0then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x201010_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("蔑里乞骑兵的头   %d/%d", LuaFnGetItemCount(sceneId,selfId,x201010_g_DemandItem[1].id)+1,x201010_g_DemandItem[1].num )) 
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

function x201010_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x201010_OnItemChanged(sceneId, selfId, itemdataId)

end