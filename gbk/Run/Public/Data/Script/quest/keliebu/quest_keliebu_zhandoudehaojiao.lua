--战斗的号角

--MisDescBegin
x202001_g_ScriptId = 202001
x202001_g_MissionIdPre =119
x202001_g_MissionId = 120
x202001_g_MissionKind = 4
x202001_g_MissionLevel = 20
x202001_g_ScriptIdNext = {ScriptId = 202002 ,LV = 1 }
x202001_g_Name	="铁木真" 
x202001_g_DemandItem ={{id=13010039,num=20}}
x202001_g_noDemandKill ={{id=367,num=1}}	

x202001_g_MissionName="战斗的号角"
x202001_g_MissionInfo="    所有的勇士听着了，王汗的儿子桑昆带着他们的人，凶狠的向我们攻来！我大草原上英勇的战士们！站起来我们一起并肩作战！\n \n    在真沙陀的左边，是他们的左翼军，我们要让那些骄纵的克烈人知道，什么叫做真正的勇士！\n \n    所有人！把你们喝马奶，吃羊肉的力气全部使出来，每个人给我拿回克烈部的20个士兵人头！"  --任务描述
x202001_g_MissionTarget="    杀死西军驻地处的#R克烈士兵#W，割下20颗人头，拿回来给#G铁木真#W！"		
x202001_g_MissionComplete="    每个人都应该为自己的族人出力。"					--完成任务npc说话的话
x202001_g_ContinueInfo="    每一位勇士，都能拿回20颗人头，你呢？"
--任务奖励
x202001_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x202001_g_ItemBonus={}

--可选物品奖励，最多8种
x202001_g_RadioItemBonus={}

--MisDescEnd
x202001_g_ExpBonus = 6500
--**********************************

--任务入口函数

--**********************************

function x202001_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x202001_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x202001_g_MissionId) > 0 then
		if x202001_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x202001_g_MissionName)
			AddText(sceneId,x202001_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x202001_g_MissionTarget) 
			AddText(sceneId,format("\n    克烈人的头   %d/%d", LuaFnGetItemCount(sceneId,selfId,x202001_g_DemandItem[1].id),x202001_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x202001_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x202001_g_MissionName)
		     AddText(sceneId,x202001_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in pairs(x202001_g_DemandItem) do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x202001_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x202001_g_ScriptId, x202001_g_MissionId)
                end

        elseif x202001_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x202001_g_MissionName)
                AddText(sceneId,x202001_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x202001_g_MissionTarget) 
		AddMoneyBonus(sceneId, x202001_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x202001_g_ScriptId, x202001_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x202001_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x202001_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x202001_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x202001_g_ScriptId, x202001_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x202001_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x202001_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x202001_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==2) then
        	if IsMissionHaveDone(sceneId, selfId, x202001_g_MissionIdPre) > 0 then
        	         return 1
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x202001_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x202001_g_MissionId, x202001_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x202001_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x202001_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x202001_g_MissionId)
	for i, item in pairs(x202001_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x202001_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x202001_g_DemandItem[1].id) == x202001_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x202001_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x202001_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x202001_g_MissionId)
		AddExp(sceneId, selfId, x202001_g_ExpBonus)
		AddMoney(sceneId, selfId, x202001_g_MoneyBonus)
		for i, item in pairs(x202001_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x202001_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x202001_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x202001_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x202001_g_MissionId) >= 0 then                                       
       		 if objdataId == x202001_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x202001_g_DemandItem[1].id) < x202001_g_DemandItem[1].num then
       		         if random(1,100)>10 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x202001_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("克烈人的头   %d/%d", LuaFnGetItemCount(sceneId,selfId,x202001_g_DemandItem[1].id)+1,x202001_g_DemandItem[1].num )) 
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

function x202001_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x202001_OnItemChanged(sceneId, selfId, itemdataId)

end

