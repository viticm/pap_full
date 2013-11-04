--玉玺

--MisDescBegin
x215001_g_ScriptId = 215001
x215001_g_MissionIdPre =131
x215001_g_MissionId = 132
x215001_g_MissionKind = 14
x215001_g_MissionLevel = 55
x215001_g_ScriptIdNext = {ScriptId = 215002 ,LV = 1 }
x215001_g_Name	="扎兰丁" 
x215001_g_DemandItem ={{id=13010026,num=1}}
x215001_g_noDemandKill ={{id=379,num=1}}	

x215001_g_MissionName="玉玺"
x215001_g_MissionInfo="    <王子注视着你，他的两眼似乎能看穿你的心>\n \n    "  --任务描述
x215001_g_MissionInfo2="你是一个英雄，我不想瞒你，我真实的身份是花剌子模帝国的新国王。\n \n    我召集的部众已经陆续聚集在这里，即将和远来的蒙古骑兵决一死战。在战场上，唯一的真理就是，谁的实力更强，谁就能活下去，胜者为王！\n \n    我要会会成吉思汗这样的英雄，即使是死在他的刀下，我也愿意。可是，那些召集来的人，想躲我国王的宝座，如果能找到先皇的玉玺，那一切都好办了。\n \n    #c0080C0玉玺#W一直被#R泰克#W将军保管，他起了背叛之心，你一定要帮我抢回来。"
x215001_g_MissionTarget="    到骑士兵团的驻地打败#R泰克#W，从他身上拿到#c0080C0玉玺#W，交给#G扎兰丁#W。"		
x215001_g_MissionComplete="    太感谢你了，这玉玺对我非常重要。"					--完成任务npc说话的话
x215001_g_ContinueInfo="    玉玺对我很重要，你一定要从泰克的身上拿回来。"
--任务奖励
x215001_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x215001_g_ItemBonus={}

--可选物品奖励，最多8种
x215001_g_RadioItemBonus={}

--MisDescEnd
x215001_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x215001_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x215001_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x215001_g_MissionId) > 0 then
		if x215001_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x215001_g_MissionName)
			AddText(sceneId,x215001_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x215001_g_MissionTarget) 
			AddText(sceneId,format("\n    玉玺   %d/%d", LuaFnGetItemCount(sceneId,selfId,x215001_g_DemandItem[1].id),x215001_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x215001_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x215001_g_MissionName)
		     AddText(sceneId,x215001_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in x215001_g_DemandItem do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x215001_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x215001_g_ScriptId, x215001_g_MissionId)
                end

        elseif x215001_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x215001_g_MissionName)
                AddText(sceneId,x215001_g_MissionInfo..GetName(sceneId, selfId)..x215001_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x215001_g_MissionTarget) 
		AddMoneyBonus(sceneId, x215001_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x215001_g_ScriptId, x215001_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x215001_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x215001_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x215001_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x215001_g_ScriptId, x215001_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x215001_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x215001_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x215001_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==15) then
        	if IsMissionHaveDone(sceneId, selfId, x215001_g_MissionIdPre) > 0 then
        	         return 1
        	end
		
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x215001_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x215001_g_MissionId, x215001_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x215001_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x215001_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x215001_g_MissionId)
	for i, item in x215001_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x215001_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x215001_g_DemandItem[1].id) == x215001_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x215001_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x215001_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x215001_g_MissionId)
		AddExp(sceneId, selfId, x215001_g_ExpBonus)
		AddMoney(sceneId, selfId, x215001_g_MoneyBonus)
		for i, item in x215001_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x215001_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x215001_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x215001_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x215001_g_MissionId) >= 0 then                                       
       		 if objdataId == x215001_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x215001_g_DemandItem[1].id) < x215001_g_DemandItem[1].num then
       		         if random(1,100)>0 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x215001_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("玉玺   %d/%d", LuaFnGetItemCount(sceneId,selfId,x215001_g_DemandItem[1].id)+1,x215001_g_DemandItem[1].num )) 
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

function x215001_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x215001_OnItemChanged(sceneId, selfId, itemdataId)

end

