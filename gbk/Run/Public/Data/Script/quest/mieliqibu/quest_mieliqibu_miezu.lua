--灭族

--MisDescBegin
x201011_g_ScriptId = 201011
x201011_g_MissionIdPre =92
x201011_g_MissionId = 93
x201011_g_MissionKind = 2
x201011_g_MissionLevel = 10
--x201011_g_ScriptIdNext = {ScriptId = 201002 ,LV = 1 }
x201011_g_Name	="别勒古台" 
x201011_g_DemandItem ={}
x201011_g_DemandKill ={{id=476,num=20}}

x201011_g_MissionName="灭族"
x201011_g_MissionInfo="    <别勒古台得知自己的母亲被辱后自杀，疯狂的杀了很多手无寸铁的蔑里乞人，见到你提人头而来，反而冷静了下来，眼里尽是仇恨的怒火>杀尽蔑里乞人，不分男女老少，杀！让他们的部落永远在草原上消失。\n \n    那些自认为是神力通天的#R邪恶巫师#W也不要放过，他们是蔑里乞人，就聚集在#G跑马坡#W右角的一个山窝里。"  --任务描述
x201011_g_MissionTarget="    杀死#G跑马坡#W东南的20名#R邪恶巫师#W来平息#G别勒古台#W的怒火。"		                                                                                               
x201011_g_MissionComplete="    美丽的罕难河，请让我的母亲速赤安息吧。"					--完成任务npc说话的话
x201011_g_ContinueInfo="    不要放走任何一个蔑里乞人，那些巫师也一样。"
--任务奖励
x201011_g_MoneyBonus = 2
--固定物品奖励，最多8种
x201011_g_ItemBonus={}

--可选物品奖励，最多8种
x201011_g_RadioItemBonus={{id=10276001,num=1},{id=10256001,num=1},{id=10246001,num=1}}

--MisDescEnd
x201011_g_ExpBonus = 80
--**********************************

--任务入口函数

--**********************************

function x201011_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x201011_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x201011_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x201011_g_MissionId)
		if x201011_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x201011_g_MissionName)
			AddText(sceneId,x201011_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x201011_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死邪恶巫师   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x201011_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x201011_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x201011_g_MissionName)
		     AddText(sceneId,x201011_g_MissionComplete)
		     AddMoneyBonus(sceneId, x201011_g_MoneyBonus)
		     for i, item in pairs(x201011_g_ItemBonus) do
	             	AddItemBonus(sceneId, item.id, item.num)
	             end
		     for i, item in pairs(x201011_g_RadioItemBonus) do
	            	 AddRadioItemBonus(sceneId, item.id, item.num)
	             end
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x201011_g_ScriptId, x201011_g_MissionId)
                end

        elseif x201011_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x201011_g_MissionName)
                AddText(sceneId,x201011_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x201011_g_MissionTarget) 
		AddMoneyBonus(sceneId, x201011_g_MoneyBonus)	
		for i, item in pairs(x201011_g_ItemBonus) do
	             	AddItemBonus(sceneId, item.id, item.num)
	        end
		for i, item in pairs(x201011_g_RadioItemBonus) do
	            	 AddRadioItemBonus(sceneId, item.id, item.num)
	        end	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x201011_g_ScriptId, x201011_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x201011_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x201011_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x201011_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x201011_g_ScriptId, x201011_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x201011_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x201011_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x201011_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==1) then
		if IsMissionHaveDone(sceneId, selfId, x201011_g_MissionIdPre) > 0 then
        	    	return 1
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x201011_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x201011_g_MissionId, x201011_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x201011_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x201011_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x201011_g_MissionId)
	for i, item in pairs(x201011_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x201011_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x201011_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x201011_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x201011_OnSubmit(sceneId, selfId, targetId, selectRadioId)

		BeginAddItem(sceneId)                                                    
			for i, item in pairs(x201011_g_ItemBonus) do                    
				AddItem( sceneId,item.id, item.num )             
			end                                                      
			for i, item in pairs(x201011_g_RadioItemBonus) do               
				if item.id == selectRadioId then                 
					AddItem( sceneId,item.id, item.num )     
				end                                              
			end                                                      
		ret = EndAddItem(sceneId,selfId)                                 
		if ret > 0 then                                                  
		  ret = DelMission( sceneId, selfId, x201011_g_MissionId ) 
			if ret > 0 then                                   
				MissionCom( sceneId,selfId, x201011_g_MissionId )
				AddExp(sceneId, selfId, x201011_g_ExpBonus)   
	                        AddMoney(sceneId, selfId, x201011_g_MoneyBonus)
	                        AddItemListToHuman(sceneId,selfId)
			end                                               
		else                                                             
			BeginEvent(sceneId)                                      
				AddText(sceneId,"物品栏已满，请整理下再来！");                        
			EndEvent(sceneId)                                        
			DispatchMissionTips(sceneId,selfId)                      
		end
		--CallScriptFunction( x201011_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x201011_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x201011_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x201011_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x201011_g_DemandKill[1].id then 
       		    if num < x201011_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死邪恶巫师   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x201011_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x201011_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x201011_OnItemChanged(sceneId, selfId, itemdataId)

end

