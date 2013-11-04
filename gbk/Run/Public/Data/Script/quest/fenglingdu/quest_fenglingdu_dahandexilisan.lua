--大汗的洗礼三

--MisDescBegin
x212011_g_ScriptId = 212011
x212011_g_MissionIdPre =257
x212011_g_MissionId = 258
x212011_g_MissionKind = 1
x212011_g_MissionLevel = 70
x212011_g_ScriptIdNext = {ScriptId = 212012 ,LV = 1 }
x212011_g_Name	="丘处机" 
x212011_g_DemandItem ={{id=13010055,num=5}}
x212011_g_noDemandKill ={{id=430,num=1}}	

x212011_g_MissionName="大汗的洗礼三"
x212011_g_MissionInfo="     我需要一些羊皮，恩，这不是普通的羊皮，而是那种能长期保存，即使被水淋过，被火烧过也不容易损坏的麻羊皮。\n \n    这些羊皮，将会记载着成吉思汗对他后人留下的训言，让他的子孙时时刻刻不要忘记他的话。\n \n    "  --任务描述
x212011_g_MissionInfo2="，#R西夏皇宫禁卫#W身上就有这样的#c0080C0麻羊皮#W，你替我收集5张来吧。"
x212011_g_MissionTarget="    从西夏的皇宫禁卫身上弄5张#c0080C0麻羊皮#W带给丘处机。"		
x212011_g_MissionComplete="    谢谢你冒着这么大的危险来帮我。"					--完成任务npc说话的话
x212011_g_ContinueInfo="    拿到麻羊皮了吗？"
--任务奖励
x212011_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x212011_g_ItemBonus={}

--可选物品奖励，最多8种
x212011_g_RadioItemBonus={}

--MisDescEnd
x212011_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x212011_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x212011_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x212011_g_MissionId) > 0 then
		if x212011_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x212011_g_MissionName)
			AddText(sceneId,x212011_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x212011_g_MissionTarget) 
			AddText(sceneId,format("\n    麻羊皮   %d/%d", LuaFnGetItemCount(sceneId,selfId,x212011_g_DemandItem[1].id),x212011_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x212011_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x212011_g_MissionName)
		     AddText(sceneId,x212011_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in x212011_g_DemandItem do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x212011_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x212011_g_ScriptId, x212011_g_MissionId)
                end

        elseif x212011_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x212011_g_MissionName)
                AddText(sceneId,x212011_g_MissionInfo..GetName(sceneId, selfId)..x212011_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x212011_g_MissionTarget) 
		AddMoneyBonus(sceneId, x212011_g_MoneyBonus)
		EndEvent()
		DispatchMissionInfo(sceneId, selfId, targetId, x212011_g_ScriptId, x212011_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x212011_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x212011_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x212011_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x212011_g_ScriptId, x212011_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x212011_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x212011_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x212011_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==12) then
        	if IsMissionHaveDone(sceneId, selfId, x212011_g_MissionIdPre) > 0 then
        		 		return 1
        	end
		
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x212011_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x212011_g_MissionId, x212011_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x212011_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x212011_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x212011_g_MissionId)
	for i, item in x212011_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x212011_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x212011_g_DemandItem[1].id) == x212011_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x212011_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x212011_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x212011_g_MissionId)
		AddExp(sceneId, selfId, x212011_g_ExpBonus)
		AddMoney(sceneId, selfId, x212011_g_MoneyBonus)
		for i, item in x212011_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x212011_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x212011_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end

	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x212011_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x212011_g_MissionId) >= 0 then                                       
       		 if objdataId == x212011_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x212011_g_DemandItem[1].id) < x212011_g_DemandItem[1].num then
       		         if random(1,100)>50 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x212011_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("麻羊皮   %d/%d", LuaFnGetItemCount(sceneId,selfId,x212011_g_DemandItem[1].id)+1,x212011_g_DemandItem[1].num )) 
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

function x212011_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x212011_OnItemChanged(sceneId, selfId, itemdataId)

end

