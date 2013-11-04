--追杀叛徒

--MisDescBegin
x215012_g_ScriptId = 215012
x215012_g_MissionIdPre =142
x215012_g_MissionId = 143
x215012_g_MissionKind = 14
x215012_g_MissionLevel = 55
x215012_g_ScriptIdNext = {ScriptId = 215013 ,LV = 1 }
x215012_g_Name	="忽都虎" 
x215012_g_DemandItem ={{id=13010042,num=1}}
x215012_g_noDemandKill ={{id=386,num=1}}	

x215012_g_MissionName="追杀叛徒"
x215012_g_MissionInfo="    那个猥琐的花剌子模将领，假装投降了我们大汗，然后在战争最关键的时候，他背叛了我们……！\n \n   这个人，就是我的助手#R乌鲁#W！\n \n    <忽都虎咬牙切齿的说>杀了他，把他的人头给我拿回来，我要把他的人头挂在我们的苏鲁锭上，让所有人都知道，背叛我们大汗的人，他的下场是怎么样的！"  --任务描述
x215012_g_MissionTarget="    杀了#R乌鲁#W，把他们的人头拿回来给#G忽都虎#W。"		
x215012_g_MissionComplete="    即使他死了，永恒的长生天也会惩罚他的灵魂。"					--完成任务npc说话的话
x215012_g_ContinueInfo="     我要看到背叛者的人头。"
--任务奖励
x215012_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x215012_g_ItemBonus={}

--可选物品奖励，最多8种
x215012_g_RadioItemBonus={}

--MisDescEnd
x215012_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x215012_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x215012_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x215012_g_MissionId) > 0 then
		if x215012_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x215012_g_MissionName)
			AddText(sceneId,x215012_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x215012_g_MissionTarget) 
			AddText(sceneId,format("\n    乌鲁的头   %d/%d", LuaFnGetItemCount(sceneId,selfId,x215012_g_DemandItem[1].id),x215012_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x215012_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x215012_g_MissionName)
		     AddText(sceneId,x215012_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in x215012_g_DemandItem do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x215012_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x215012_g_ScriptId, x215012_g_MissionId)
                end

        elseif x215012_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x215012_g_MissionName)
                AddText(sceneId,x215012_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x215012_g_MissionTarget) 
		AddMoneyBonus(sceneId, x215012_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x215012_g_ScriptId, x215012_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x215012_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x215012_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x215012_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x215012_g_ScriptId, x215012_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x215012_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x215012_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x215012_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==15) then
        	if IsMissionHaveDone(sceneId, selfId, x215012_g_MissionIdPre) > 0 then
        	         return 1
        	end
		
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x215012_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x215012_g_MissionId, x215012_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x215012_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x215012_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x215012_g_MissionId)
	for i, item in x215012_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x215012_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x215012_g_DemandItem[1].id) == x215012_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x215012_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x215012_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x215012_g_MissionId)
		AddExp(sceneId, selfId, x215012_g_ExpBonus)
		AddMoney(sceneId, selfId, x215012_g_MoneyBonus)
		for i, item in x215012_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x215012_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x215012_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x215012_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x215012_g_MissionId) >= 0 then                                       
       		 if objdataId == x215012_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x215012_g_DemandItem[1].id) < x215012_g_DemandItem[1].num then
       		         if random(1,100)>0 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x215012_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("乌鲁的头   %d/%d", LuaFnGetItemCount(sceneId,selfId,x215012_g_DemandItem[1].id)+1,x215012_g_DemandItem[1].num )) 
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

function x215012_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x215012_OnItemChanged(sceneId, selfId, itemdataId)

end

