--消灭伊拉克骑士

--MisDescBegin
x215009_g_ScriptId = 215009
x215009_g_MissionIdPre =139
x215009_g_MissionId = 140
x215009_g_MissionKind = 14
x215009_g_MissionLevel = 55
x215009_g_ScriptIdNext = {ScriptId = 215010 ,LV = 1 }
x215009_g_Name	="术赤" 
x215009_g_DemandItem ={{id=13010029,num=1}}
x215009_g_noDemandKill ={{id=383,num=1}}	

x215009_g_MissionName="消灭伊拉克骑士"
x215009_g_MissionInfo="    当我们火烧粮仓的战役接近尾声的时候，我们营地的物资库也遭到了来自伊拉克的骑士的攻击。\n \n    扎兰丁带着那些猥琐的伊拉克人占领了物资库之后，我们的卫兵被他们关在地牢里，忍受着皮鞭的鞭笞和盐水的淋浴。\n \n    那些伊拉克骑士的营地就在附近，我必须拯救那些被俘虏了的兄弟们，你要帮我的忙把骑士队长#R穆里黑#W给杀了，从他身上拿到#c0080C0地牢的钥匙#W！"  --任务描述
x215009_g_MissionTarget="    你要杀了#R穆里黑#W，从他身上得到#c0080C0地牢的钥匙#W，交给#G术赤#W。"		
x215009_g_MissionComplete="    真让我惊讶！"					--完成任务npc说话的话
x215009_g_ContinueInfo="     拿到地牢的钥匙了吗？"
--任务奖励
x215009_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x215009_g_ItemBonus={}

--可选物品奖励，最多8种
x215009_g_RadioItemBonus={}

--MisDescEnd
x215009_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x215009_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x215009_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x215009_g_MissionId) > 0 then
		if x215009_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x215009_g_MissionName)
			AddText(sceneId,x215009_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x215009_g_MissionTarget) 
			AddText(sceneId,format("\n    地牢的钥匙   %d/%d", LuaFnGetItemCount(sceneId,selfId,x215009_g_DemandItem[1].id),x215009_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x215009_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x215009_g_MissionName)
		     AddText(sceneId,x215009_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in pairs(x215009_g_DemandItem) do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x215009_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x215009_g_ScriptId, x215009_g_MissionId)
                end

        elseif x215009_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x215009_g_MissionName)
                AddText(sceneId,x215009_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x215009_g_MissionTarget) 
		AddMoneyBonus(sceneId, x215009_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x215009_g_ScriptId, x215009_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x215009_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x215009_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x215009_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x215009_g_ScriptId, x215009_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x215009_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x215009_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x215009_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==15) then
        	if IsMissionHaveDone(sceneId, selfId, x215009_g_MissionIdPre) > 0 then
        	         return 1
        	end
		
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x215009_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x215009_g_MissionId, x215009_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x215009_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x215009_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x215009_g_MissionId)
	for i, item in pairs(x215009_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x215009_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x215009_g_DemandItem[1].id) == x215009_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x215009_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x215009_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x215009_g_MissionId)
		AddExp(sceneId, selfId, x215009_g_ExpBonus)
		AddMoney(sceneId, selfId, x215009_g_MoneyBonus)
		for i, item in pairs(x215009_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x215009_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x215009_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x215009_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x215009_g_MissionId) >= 0 then                                       
       		 if objdataId == x215009_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x215009_g_DemandItem[1].id) < x215009_g_DemandItem[1].num then
       		         if random(1,100)>0 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x215009_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("地牢的钥匙   %d/%d", LuaFnGetItemCount(sceneId,selfId,x215009_g_DemandItem[1].id)+1,x215009_g_DemandItem[1].num )) 
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

function x215009_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x215009_OnItemChanged(sceneId, selfId, itemdataId)

end

