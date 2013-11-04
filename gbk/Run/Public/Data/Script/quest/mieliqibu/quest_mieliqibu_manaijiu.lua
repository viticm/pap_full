--马奶酒

--MisDescBegin
x201013_g_ScriptId = 201013
x201013_g_MissionIdPre =88
x201013_g_MissionId = 397
x201013_g_MissionKind = 2
x201013_g_MissionLevel = 10
--x201013_g_ScriptIdNext = {ScriptId = 205005 ,LV = 1 }
x201013_g_Name	="诃额仑" 
x201013_g_DemandItem ={{id=13010023,num=10}}
x201013_g_noDemandKill ={{id=342,num=1}}	

x201013_g_MissionName="马奶酒"
x201013_g_MissionInfo="    札木合这孩子，真是有出息，自小铁木真就跟他是安答，这次都亏他出兵帮忙。\n \n    听说他有意再和铁木真结一次安答，这可是草原的又一段佳话，真是太好了！我需要一些马奶酒来庆祝他们，在我们营地不远的处，从#R蔑儿乞牧民#W的身上把#c0080C0马奶酒#W给抢回来。"  --任务描述
x201013_g_MissionTarget="    杀死#G马场#W处的#R蔑里乞牧民#W，从他们身上拿到10袋#c0080C0马奶酒#W给#G诃额仑#W带回来。"		
x201013_g_MissionComplete="    谢谢你，如果还有需要，我会再找你帮忙。"					--完成任务npc说话的话
x201013_g_ContinueInfo="    我需要10袋马奶酒，我想这应该是足够了。"
--任务奖励
x201013_g_MoneyBonus = 2
--固定物品奖励，最多8种
x201013_g_ItemBonus={}

--可选物品奖励，最多8种
x201013_g_RadioItemBonus={}

--MisDescEnd
x201013_g_ExpBonus = 80
--**********************************

--任务入口函数

--**********************************

function x201013_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x201013_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x201013_g_MissionId) > 0 then
		if x201013_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x201013_g_MissionName)
			AddText(sceneId,x201013_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x201013_g_MissionTarget) 
			AddText(sceneId,format("\n    马奶酒   %d/%d", LuaFnGetItemCount(sceneId,selfId,x201013_g_DemandItem[1].id),x201013_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x201013_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x201013_g_MissionName)
		     AddText(sceneId,x201013_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in x201013_g_DemandItem do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x201013_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x201013_g_ScriptId, x201013_g_MissionId)
                end

        elseif x201013_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x201013_g_MissionName)
                AddText(sceneId,x201013_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x201013_g_MissionTarget) 
		AddMoneyBonus(sceneId, x201013_g_MoneyBonus)
		EndEvent()
		DispatchMissionInfo(sceneId, selfId, targetId, x201013_g_ScriptId, x201013_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x201013_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x201013_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x201013_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x201013_g_ScriptId, x201013_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x201013_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x201013_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x201013_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==1) then
        	if IsMissionHaveDone(sceneId, selfId, x201013_g_MissionIdPre) > 0 then
        	         return 1
        	end
		
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x201013_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x201013_g_MissionId, x201013_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x201013_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x201013_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x201013_g_MissionId)
	for i, item in x201013_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x201013_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x201013_g_DemandItem[1].id) == x201013_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x201013_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x201013_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x201013_g_MissionId)
		AddExp(sceneId, selfId, x201013_g_ExpBonus)
		AddMoney(sceneId, selfId, x201013_g_MoneyBonus)
		for i, item in x201013_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x201013_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x201013_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end

	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x201013_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x201013_g_MissionId) >= 0 then                                       
       		 if objdataId == x201013_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x201013_g_DemandItem[1].id) < x201013_g_DemandItem[1].num then
       		         if random(1,100)>20 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x201013_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("马奶酒   %d/%d", LuaFnGetItemCount(sceneId,selfId,x201013_g_DemandItem[1].id)+1,x201013_g_DemandItem[1].num )) 
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

function x201013_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x201013_OnItemChanged(sceneId, selfId, itemdataId)

end

