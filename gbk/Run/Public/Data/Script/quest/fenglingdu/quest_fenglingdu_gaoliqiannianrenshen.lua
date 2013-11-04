--高丽千年人参

--MisDescBegin
x212001_g_ScriptId = 212001
x212001_g_MissionIdPre =247
x212001_g_MissionId = 248
x212001_g_MissionKind = 17
x212001_g_MissionLevel = 70
x212001_g_ScriptIdNext = {ScriptId = 212002 ,LV = 1 }
x212001_g_Name	="速不台" 
x212001_g_Name2	="成吉思汗" 
x212001_g_DemandItem ={{id=13010053,num=1}}
x212001_g_noDemandKill ={{id=421,num=1}}	

x212001_g_MissionName="高丽千年人参"
x212001_g_MissionInfo="    大汗围猎落马，至今未愈，本将军非常担心，为此几夜失眠。只是战事繁忙，不能抽身离开，为由多杀敌人，以报汗恩！\n \n    "  --任务描述
x212001_g_MissionInfo2="，请你找到#c0080C0高丽千年人参#W一株，送到渡口给大汗，这种人参，在#G风陵渔村#W东北方的#R西夏水军统领身#W上就有。"
x212001_g_MissionTarget="    从#G风陵渔村#W东北处的#R西夏水军统领#W身上得到#c0080C0高丽千年人参#W，并把人参送去给#G成吉思汗#W。"		
x212001_g_MissionComplete="    很好，速不台将军战事繁忙之际还能挂念我，足见他的忠心。"					--完成任务npc说话的话
x212001_g_ContinueInfo="    高丽千年人参呢？"
--任务奖励
x212001_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x212001_g_ItemBonus={}

--可选物品奖励，最多8种
x212001_g_RadioItemBonus={}

--MisDescEnd
x212001_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x212001_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x212001_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x212001_g_MissionId) > 0 then
		if x212001_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x212001_g_MissionName)
			AddText(sceneId,x212001_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x212001_g_MissionTarget) 
			AddText(sceneId,format("\n    高丽千年人参   %d/%d", LuaFnGetItemCount(sceneId,selfId,x212001_g_DemandItem[1].id),x212001_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x212001_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x212001_g_MissionName)
		     AddText(sceneId,x212001_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in x212001_g_DemandItem do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x212001_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x212001_g_ScriptId, x212001_g_MissionId)
                end

        elseif x212001_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x212001_g_MissionName)
                AddText(sceneId,x212001_g_MissionInfo..GetName(sceneId, selfId)..x212001_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x212001_g_MissionTarget) 
		AddMoneyBonus(sceneId, x212001_g_MoneyBonus)
		EndEvent()
		DispatchMissionInfo(sceneId, selfId, targetId, x212001_g_ScriptId, x212001_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x212001_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x212001_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x212001_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x212001_g_ScriptId, x212001_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x212001_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x212001_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x212001_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==12) then
        	if IsMissionHaveDone(sceneId, selfId, x212001_g_MissionIdPre) > 0 then
        		if (GetName(sceneId,targetId)==x212001_g_Name) then
        			if IsHaveMission(sceneId,selfId, x212001_g_MissionId) <= 0 then 
        	         		return 1
        	         	end
        	        end
        	        if (GetName(sceneId,targetId)==x212001_g_Name2) then
        			if IsHaveMission(sceneId,selfId, x212001_g_MissionId) > 0 then 
        	         		return 1
        	         	end
        	        end
        	end
		
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x212001_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x212001_g_MissionId, x212001_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x212001_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x212001_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x212001_g_MissionId)
	for i, item in x212001_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x212001_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x212001_g_DemandItem[1].id) == x212001_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x212001_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x212001_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x212001_g_MissionId)
		AddExp(sceneId, selfId, x212001_g_ExpBonus)
		AddMoney(sceneId, selfId, x212001_g_MoneyBonus)
		for i, item in x212001_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x212001_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x212001_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end

	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x212001_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x212001_g_MissionId) >= 0 then                                       
       		 if objdataId == x212001_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x212001_g_DemandItem[1].id) < x212001_g_DemandItem[1].num then
       		         if random(1,100)>0 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x212001_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("高丽千年人参   %d/%d", LuaFnGetItemCount(sceneId,selfId,x212001_g_DemandItem[1].id)+1,x212001_g_DemandItem[1].num )) 
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

function x212001_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x212001_OnItemChanged(sceneId, selfId, itemdataId)

end

