--条顿骑士团

--MisDescBegin
x226007_g_ScriptId = 226007
x226007_g_MissionIdPre =342
x226007_g_MissionId = 343
x226007_g_MissionKind = 23
x226007_g_MissionLevel = 115
x226007_g_ScriptIdNext = {ScriptId = 226008 ,LV = 1 }
x226007_g_Name	="随军巫师" 
x226007_g_DemandItem ={{id=13010073,num=10}}
x226007_g_noDemandKill ={{id=482,num=1}}	

x226007_g_MissionName="条顿骑士团"
x226007_g_MissionInfo="    在被包围的骑士中，有一队穿着饰有黑色十字架的白色外套的战士。他们是条顿骑士团的人，据说他们的首领奥施特恩能力很强，平凡的人无法接近他。\n \n    但是很不巧他遇到了我。我只需要一些材料就可以破除他的防御，让你打败他。\n \n    首先我需要他手下的心，你就去杀几个#R条顿武士#W，取出他们的心，给我带回来。"  --任务描述
x226007_g_MissionTarget="    给#G随军巫师#W带回10颗#R条顿武士#W的心。"		
x226007_g_MissionComplete="    很新鲜的心呢。"					--完成任务npc说话的话
x226007_g_ContinueInfo="    用他手下的心来破坏他的心灵力量，应该很有效果。"
--任务奖励
x226007_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x226007_g_ItemBonus={}

--可选物品奖励，最多8种
x226007_g_RadioItemBonus={}

--MisDescEnd
x226007_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x226007_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x226007_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x226007_g_MissionId) > 0 then
		if x226007_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x226007_g_MissionName)
			AddText(sceneId,x226007_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x226007_g_MissionTarget) 
			AddText(sceneId,format("\n    条顿武士的心   %d/%d", LuaFnGetItemCount(sceneId,selfId,x226007_g_DemandItem[1].id),x226007_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x226007_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x226007_g_MissionName)
		     AddText(sceneId,x226007_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in x226007_g_DemandItem do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x226007_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x226007_g_ScriptId, x226007_g_MissionId)
                end

        elseif x226007_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x226007_g_MissionName)
                AddText(sceneId,x226007_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x226007_g_MissionTarget) 
		AddMoneyBonus(sceneId, x226007_g_MoneyBonus)
		EndEvent()
		DispatchMissionInfo(sceneId, selfId, targetId, x226007_g_ScriptId, x226007_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x226007_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x226007_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x226007_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x226007_g_ScriptId, x226007_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x226007_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x226007_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x226007_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==22) then
        	--if IsMissionHaveDone(sceneId, selfId, x226007_g_MissionIdPre) > 0 then
        	         return 1
        	--end
		
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x226007_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x226007_g_MissionId, x226007_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x226007_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x226007_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x226007_g_MissionId)
	for i, item in x226007_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x226007_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x226007_g_DemandItem[1].id) == x226007_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x226007_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x226007_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x226007_g_MissionId)
		AddExp(sceneId, selfId, x226007_g_ExpBonus)
		AddMoney(sceneId, selfId, x226007_g_MoneyBonus)
		for i, item in x226007_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x226007_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x226007_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end

	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x226007_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x226007_g_MissionId) >= 0 then                                       
       		 if objdataId == x226007_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x226007_g_DemandItem[1].id) < x226007_g_DemandItem[1].num then
       		         if random(1,100)>20 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x226007_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("条顿武士的心   %d/%d", LuaFnGetItemCount(sceneId,selfId,x226007_g_DemandItem[1].id)+1,x226007_g_DemandItem[1].num ))
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

function x226007_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x226007_OnItemChanged(sceneId, selfId, itemdataId)

end

