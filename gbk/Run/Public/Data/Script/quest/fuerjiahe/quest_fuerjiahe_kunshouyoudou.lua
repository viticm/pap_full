--困兽犹斗

--MisDescBegin
x223003_g_ScriptId = 223003
x223003_g_MissionIdPre =294
x223003_g_MissionId = 295
x223003_g_MissionKind = 20
x223003_g_MissionLevel = 100
x223003_g_ScriptIdNext = {ScriptId = 223004 ,LV = 1 }
x223003_g_Name	="蒙哥" 
x223003_g_DemandItem ={{id=13010065,num=1}}
x223003_g_DemandKill ={{id=441,num=10}}
x223003_g_noDemandKill ={{id=442,num=1}}

x223003_g_MissionName="困兽犹斗"
x223003_g_MissionInfo="    这是消灭钦察人首领的好机会，八赤蛮的援军受阻，他的护卫又被我们所消灭，敌人已经完全丧失了信心。\n \n    "  --任务描述
x223003_g_MissionInfo2="，让别人等待是很不礼貌的事情，冲进敌营吧，把#R八赤蛮#W的头给我带回来，消灭他身边的#R钦察精锐兵#W，我可不想看到有人在组织他们抵抗。"
x223003_g_MissionTarget="    到山谷中杀死10个#R钦察精锐兵#W，把#R八赤蛮#W的头给#G蒙哥#W带回来"		                                                                                               
x223003_g_MissionComplete="    谢谢你勇士！这场包围战中我是指挥，但这也意味着我不能冒险冲在最前端。而在你这种勇士的帮助下，我可以安全而专注的指挥以获得胜利。谨慎的指挥官与英勇的战士，这才是胜利的保障！"					--完成任务npc说话的话
x223003_g_ContinueInfo="    还没找到八赤蛮吗？速度要快！我向敌人承诺过不会让他们再度过一个寒冷的夜晚了。所以天黑之前把敌人送到他们的地狱去！"
--任务奖励
x223003_g_MoneyBonus = 500

--固定物品奖励，最多8种
x223003_g_ItemBonus={}

--可选物品奖励，最多8种
x223003_g_RadioItemBonus={}

--MisDescEnd
x223003_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x223003_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x223003_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x223003_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x223003_g_MissionId)
		if x223003_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x223003_g_MissionName)
			AddText(sceneId,x223003_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x223003_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死钦察精锐兵   %d/%d\n    八赤蛮的头   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x223003_g_DemandKill[1].num,LuaFnGetItemCount(sceneId,selfId,x223003_g_DemandItem[1].id),x223003_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x223003_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x223003_g_MissionName)
		     AddText(sceneId,x223003_g_MissionComplete)
		     AddMoneyBonus(sceneId, x223003_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x223003_g_ScriptId, x223003_g_MissionId)
                end

        elseif x223003_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x223003_g_MissionName)
                AddText(sceneId,x223003_g_MissionInfo..GetName(sceneId, selfId)..x223003_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x223003_g_MissionTarget) 
		AddMoneyBonus(sceneId, x223003_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x223003_g_ScriptId, x223003_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x223003_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x223003_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x223003_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x223003_g_ScriptId, x223003_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x223003_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x223003_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x223003_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==17) then
		if IsMissionHaveDone(sceneId, selfId, x223003_g_MissionIdPre) > 0 then
        	    	return 1
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x223003_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x223003_g_MissionId, x223003_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x223003_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x223003_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x223003_g_MissionId)
	for i, item in pairs(x223003_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x223003_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x223003_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x223003_g_DemandKill[1].num then
		if LuaFnGetItemCount(sceneId,selfId,x223003_g_DemandItem[1].id) == x223003_g_DemandItem[1].num then
	        	return 1
	        end
	end
	return 0

end



--**********************************

--提交

--**********************************

function x223003_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x223003_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x223003_g_MissionId)
		AddExp(sceneId, selfId, x223003_g_ExpBonus)
		AddMoney(sceneId, selfId, x223003_g_MoneyBonus)
		for i, item in pairs(x223003_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x223003_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x223003_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x223003_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x223003_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x223003_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x223003_g_DemandKill[1].id then 
       		    if num < x223003_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死钦察精锐兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x223003_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 if objdataId == x223003_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x223003_g_DemandItem[1].id) < x223003_g_DemandItem[1].num then
       		         if random(1,100)>0 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x223003_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("八赤蛮的头   %d/%d", LuaFnGetItemCount(sceneId,selfId,x223003_g_DemandItem[1].id)+1,x223003_g_DemandItem[1].num )) 
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

function x223003_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x223003_OnItemChanged(sceneId, selfId, itemdataId)

end

