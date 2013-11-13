--为丈夫报仇

--MisDescBegin
x214003_g_ScriptId = 214003
x214003_g_MissionIdPre =109
x214003_g_MissionId = 110
x214003_g_MissionKind = 3
x214003_g_MissionLevel = 15
--x214003_g_ScriptIdNext = {ScriptId = 204001 ,LV = 1 }
x214003_g_Name	="铁木真" 
x214003_g_DemandItem ={}
x214003_g_DemandKill ={{id=359,num=20}}

x214003_g_MissionName="为丈夫报仇"
x214003_g_MissionInfo="    "  --任务描述
x214003_g_MissionInfo2="，合答安的丈夫跟札答阑部的士兵在O处血战，我不想让合答安伤心，你速速赶去O处，把札答阑的士兵给杀了。"
x214003_g_MissionTarget="    到O处去杀死20名#R札答阑士兵#W，然后回来跟#G铁木真#W复命。"		                                                                                               
x214003_g_MissionComplete="    是天意，合答安的丈夫被人杀死了……，辛苦你跑了一趟，我会亲自去接合答安回来。"					--完成任务npc说话的话
x214003_g_ContinueInfo="    你的任务完成了吗？"
--任务奖励
x214003_g_MoneyBonus = 600
--固定物品奖励，最多8种
x214003_g_ItemBonus={}

--可选物品奖励，最多8种
x214003_g_RadioItemBonus={{id=10216001,num=1},{id=10216002,num=1},{id=10216003,num=1}}

--MisDescEnd
x214003_g_ExpBonus = 6500
--**********************************

--任务入口函数

--**********************************

function x214003_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x214003_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x214003_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x214003_g_MissionId)
		if x214003_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x214003_g_MissionName)
			AddText(sceneId,x214003_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x214003_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死札答阑士兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x214003_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x214003_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x214003_g_MissionName)
		     AddText(sceneId,x214003_g_MissionComplete)
		     AddMoneyBonus(sceneId, x214003_g_MoneyBonus)
		     for i, item in pairs(x214003_g_ItemBonus) do
	             	AddItemBonus(sceneId, item.id, item.num)
	             end
		     for i, item in pairs(x214003_g_RadioItemBonus) do
	            	 AddRadioItemBonus(sceneId, item.id, item.num)
	             end
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x214003_g_ScriptId, x214003_g_MissionId)
                end

        elseif x214003_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x214003_g_MissionName)
                AddText(sceneId,x214003_g_MissionInfo..GetName(sceneId, selfId)..x214003_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x214003_g_MissionTarget) 
		AddMoneyBonus(sceneId, x214003_g_MoneyBonus)	
		for i, item in pairs(x214003_g_ItemBonus) do
	             	AddItemBonus(sceneId, item.id, item.num)
	        end
		for i, item in pairs(x214003_g_RadioItemBonus) do
	            	 AddRadioItemBonus(sceneId, item.id, item.num)
	        end	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x214003_g_ScriptId, x214003_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x214003_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x214003_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x214003_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x214003_g_ScriptId, x214003_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x214003_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x214003_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x214003_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==14) then
		if IsMissionHaveDone(sceneId, selfId, x214003_g_MissionIdPre) > 0 then
        	    	return 1
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x214003_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x214003_g_MissionId, x214003_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x214003_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x214003_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x214003_g_MissionId)
	for i, item in pairs(x214003_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x214003_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x214003_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x214003_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x214003_OnSubmit(sceneId, selfId, targetId, selectRadioId)

		BeginAddItem(sceneId)                                                    
			for i, item in pairs(x214003_g_ItemBonus) do                    
				AddItem( sceneId,item.id, item.num )             
			end                                                      
			for i, item in pairs(x214003_g_RadioItemBonus) do               
				if item.id == selectRadioId then                 
					AddItem( sceneId,item.id, item.num )     
				end                                              
			end                                                      
		ret = EndAddItem(sceneId,selfId)                                 
		if ret > 0 then                                                  
		  ret = DelMission( sceneId, selfId, x214003_g_MissionId ) 
			if ret > 0 then                                   
				MissionCom( sceneId,selfId, x214003_g_MissionId )
				AddExp(sceneId, selfId, x214003_g_ExpBonus)   
	                        AddMoney(sceneId, selfId, x214003_g_MoneyBonus)
	                        AddItemListToHuman(sceneId,selfId)
			end                                               
		else                                                             
			BeginEvent(sceneId)                                      
				AddText(sceneId,"物品栏已满，请整理下再来！");                        
			EndEvent(sceneId)                                        
			DispatchMissionTips(sceneId,selfId)                      
		end 
		--CallScriptFunction( x214003_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )

	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x214003_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x214003_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x214003_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x214003_g_DemandKill[1].id then 
       		    if num < x214003_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死札答阑士兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x214003_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x214003_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x214003_OnItemChanged(sceneId, selfId, itemdataId)

end

