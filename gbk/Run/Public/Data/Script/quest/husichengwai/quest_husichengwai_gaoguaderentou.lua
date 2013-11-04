--高挂的人头

--MisDescBegin
x204006_g_ScriptId = 204006
x204006_g_MissionIdPre =100
x204006_g_MissionId = 101
x204006_g_MissionKind = 9
x204006_g_MissionLevel = 45
--x204006_g_ScriptIdNext = {ScriptId = 205005 ,LV = 1 }
x204006_g_Name	="哲别" 
x204006_g_DemandItem ={{id=13010034,num=10}}
x204006_g_noDemandKill ={{id=356,num=1}}	

x204006_g_MissionName="高挂的人头"
x204006_g_MissionInfo="    你听到那些欢呼声了吗，那是西辽的百姓们欢迎我们的声音。\n \n    我们不是侵略者，我们只是为了追杀屈出律这个逃跑的乃蛮部王子而来。\n \n    屈出律当上这里的国王之后，要穆斯林改奉佛教，至少要穿戴契丹人的服装，并强制推行，引起人民群众的普遍不满。\n \n    我接到成吉思汗的命令，开放所有的清真寺，让所有人有宗教自由。\n \n     <哲别开心的笑道>听，那些声音是来自清真寺的声音，恩，"  --任务描述
x204006_g_MissionInfo2="，我给你安排了一个神圣而又光荣的任务。屈出律要毁掉所有的清真寺，他们派去的人已经在路上了，你要赶去，阻止他们……最好的方法，就是把他们20人给杀了，把人头拿回来，我会悬挂在高高的城门上。"
x204006_g_MissionTarget="    到南岭东去杀死屈出律派去的#R西辽骑兵#W，带回10颗#c0080C0西辽骑兵的头#W，#G哲别#W将军要把它们挂在城墙上向屈出律示威。"		
x204006_g_MissionComplete="    我已经派人把他们的人头都挂起来，震慑屈出律。"					--完成任务npc说话的话
x204006_g_ContinueInfo="    那些西辽骑兵的人头呢？"
--任务奖励
x204006_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x204006_g_ItemBonus={}

--可选物品奖励，最多8种
x204006_g_RadioItemBonus={}

--MisDescEnd
x204006_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x204006_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x204006_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x204006_g_MissionId) > 0 then
		if x204006_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x204006_g_MissionName)
			AddText(sceneId,x204006_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x204006_g_MissionTarget) 
			AddText(sceneId,format("\n    西辽骑兵的头   %d/%d", LuaFnGetItemCount(sceneId,selfId,x204006_g_DemandItem[1].id),x204006_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x204006_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x204006_g_MissionName)
		     AddText(sceneId,x204006_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in x204006_g_DemandItem do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x204006_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x204006_g_ScriptId, x204006_g_MissionId)
                end

        elseif x204006_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x204006_g_MissionName)
                AddText(sceneId,x204006_g_MissionInfo..GetName(sceneId, selfId)..x204006_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x204006_g_MissionTarget) 
		AddMoneyBonus(sceneId, x204006_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x204006_g_ScriptId, x204006_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x204006_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x204006_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x204006_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x204006_g_ScriptId, x204006_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x204006_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x204006_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x204006_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==4) then
        	if IsMissionHaveDone(sceneId, selfId, x204006_g_MissionIdPre) > 0 then
        	         return 1
        	end
		
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x204006_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x204006_g_MissionId, x204006_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x204006_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x204006_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x204006_g_MissionId)
	for i, item in x204006_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x204006_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x204006_g_DemandItem[1].id) == x204006_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x204006_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x204006_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x204006_g_MissionId)
		AddExp(sceneId, selfId, x204006_g_ExpBonus)
		AddMoney(sceneId, selfId, x204006_g_MoneyBonus)
		for i, item in x204006_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x204006_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x204006_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x204006_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x204006_g_MissionId) >= 0 then                                       
       		 if objdataId == x204006_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x204006_g_DemandItem[1].id) < x204006_g_DemandItem[1].num then
       		         if random(1,100)>0 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x204006_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("西辽骑兵的头   %d/%d", LuaFnGetItemCount(sceneId,selfId,x204006_g_DemandItem[1].id)+1,x204006_g_DemandItem[1].num )) 
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

function x204006_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x204006_OnItemChanged(sceneId, selfId, itemdataId)

end

