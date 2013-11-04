--主教乌古兰

--MisDescBegin
x213004_g_ScriptId = 213004
x213004_g_MissionIdPre =148
x213004_g_MissionId = 149
x213004_g_MissionKind = 24
x213004_g_MissionLevel = 125
--x213004_g_ScriptIdNext = {ScriptId = 205005 ,LV = 1 }
x213004_g_Name	="合丹" 
x213004_g_DemandItem ={{id=13010044,num=1}}
x213004_g_noDemandKill ={{id=390,num=1}}	

x213004_g_MissionName="主教乌古兰"
x213004_g_MissionInfo="    听说主教#R乌古兰#W不满意贝拉的守城策略，独自带着圣殿骑士团冲出城来。结果被我们围在北谷中，这个头脑不冷静的人给我们带来了大大的方便。我们也给他行行方便，让他早些去见他的上帝吧。\n \n    听说乌古兰的十字架上有一颗宝石，我很感兴趣，你杀了他之后把十字架给我带回来吧。"  --任务描述
x213004_g_MissionTarget="    杀死#R乌古兰#W，把#c0080C0乌古兰的十字架#W带给#G合丹#W。"		
x213004_g_MissionComplete="    这个十字架果然做工精良，不知道乌古兰见他的上帝时没有十字架会不会受到惩罚，哈哈！"					--完成任务npc说话的话
x213004_g_ContinueInfo="    找到乌古兰了吗？"
--任务奖励
x213004_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x213004_g_ItemBonus={}

--可选物品奖励，最多8种
x213004_g_RadioItemBonus={}

--MisDescEnd
x213004_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x213004_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x213004_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x213004_g_MissionId) > 0 then
		if x213004_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x213004_g_MissionName)
			AddText(sceneId,x213004_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x213004_g_MissionTarget) 
			AddText(sceneId,format("\n    乌古兰的十字架   %d/%d", LuaFnGetItemCount(sceneId,selfId,x213004_g_DemandItem[1].id),x213004_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x213004_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x213004_g_MissionName)
		     AddText(sceneId,x213004_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in x213004_g_DemandItem do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x213004_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x213004_g_ScriptId, x213004_g_MissionId)
                end

        elseif x213004_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x213004_g_MissionName)
                AddText(sceneId,x213004_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x213004_g_MissionTarget) 
		AddMoneyBonus(sceneId, x213004_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x213004_g_ScriptId, x213004_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x213004_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x213004_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x213004_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x213004_g_ScriptId, x213004_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x213004_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x213004_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x213004_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==13) then
        	if IsMissionHaveDone(sceneId, selfId, x213004_g_MissionIdPre) > 0 then
        	         return 1
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x213004_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x213004_g_MissionId, x213004_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x213004_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x213004_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x213004_g_MissionId)
	for i, item in x213004_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x213004_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x213004_g_DemandItem[1].id) == x213004_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x213004_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x213004_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x213004_g_MissionId)
		AddExp(sceneId, selfId, x213004_g_ExpBonus)
		AddMoney(sceneId, selfId, x213004_g_MoneyBonus)
		for i, item in x213004_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x213004_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x213004_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x213004_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x213004_g_MissionId) >= 0 then                                       
       		 if objdataId == x213004_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x213004_g_DemandItem[1].id) < x213004_g_DemandItem[1].num then
       		         if random(1,100)>0 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x213004_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("乌古兰的十字架   %d/1", LuaFnGetItemCount(sceneId,selfId,x213004_g_DemandItem[1].id)+1,x213004_g_DemandItem[1].num )) 
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

function x213004_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x213004_OnItemChanged(sceneId, selfId, itemdataId)

end

