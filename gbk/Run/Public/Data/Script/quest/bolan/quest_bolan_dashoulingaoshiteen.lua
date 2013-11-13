--大首领奥施特恩

--MisDescBegin
x226009_g_ScriptId = 226009
x226009_g_MissionIdPre =344
x226009_g_MissionId = 345
x226009_g_MissionKind = 23
x226009_g_MissionLevel = 115
x226009_g_ScriptIdNext = {ScriptId = 226009 ,LV = 1 }
x226009_g_Name	="随军巫师" 
x226009_g_DemandItem ={{id=13010075,num=1}}
x226009_g_noDemandKill ={{id=484,num=1}}	

x226009_g_MissionName="大首领奥施特恩"
x226009_g_MissionInfo="    <巫师在你身上洒了一些奇怪的药水>\n \n    有了这个药水你就可以和#R奥施特恩#W公平的决斗了。不过要小心，即时他没有了防御，也是很难缠的对手。去杀了他，把他身上#c0080C0金十字架带#W回来给我。"  --任务描述
x226009_g_MissionTarget="    杀了#R奥施特恩#W，得到#c0080C0金十字架#W带给#G随军巫师#W。"		
x226009_g_MissionComplete="    <看到了金十字架，巫师的眼睛放出异样的光彩>\n \n    就是这个，好了我要开始研究了，不要打扰我！"					--完成任务npc说话的话
x226009_g_ContinueInfo="    据说金十字架上有很强的魔力，我要研究一下。"
--任务奖励
x226009_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x226009_g_ItemBonus={}

--可选物品奖励，最多8种
x226009_g_RadioItemBonus={}

--MisDescEnd
x226009_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x226009_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x226009_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x226009_g_MissionId) > 0 then
		if x226009_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x226009_g_MissionName)
			AddText(sceneId,x226009_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x226009_g_MissionTarget) 
			AddText(sceneId,format("\n    金十字架   %d/%d", LuaFnGetItemCount(sceneId,selfId,x226009_g_DemandItem[1].id),x226009_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x226009_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x226009_g_MissionName)
		     AddText(sceneId,x226009_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in pairs(x226009_g_DemandItem) do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x226009_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x226009_g_ScriptId, x226009_g_MissionId)
                end

        elseif x226009_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x226009_g_MissionName)
                AddText(sceneId,x226009_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x226009_g_MissionTarget) 
		AddMoneyBonus(sceneId, x226009_g_MoneyBonus)
		EndEvent()
		DispatchMissionInfo(sceneId, selfId, targetId, x226009_g_ScriptId, x226009_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x226009_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x226009_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x226009_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x226009_g_ScriptId, x226009_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x226009_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x226009_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x226009_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==22) then
        	if IsMissionHaveDone(sceneId, selfId, x226009_g_MissionIdPre) > 0 then
        	         return 1
        	end
		
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x226009_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x226009_g_MissionId, x226009_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x226009_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x226009_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x226009_g_MissionId)
	for i, item in pairs(x226009_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x226009_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x226009_g_DemandItem[1].id) == x226009_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x226009_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x226009_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x226009_g_MissionId)
		AddExp(sceneId, selfId, x226009_g_ExpBonus)
		AddMoney(sceneId, selfId, x226009_g_MoneyBonus)
		for i, item in pairs(x226009_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x226009_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x226009_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end

	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x226009_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x226009_g_MissionId) >= 0 then                                       
       		 if objdataId == x226009_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x226009_g_DemandItem[1].id) < x226009_g_DemandItem[1].num then
       		         if random(1,100)>0 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x226009_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("金十字架   %d/%d", LuaFnGetItemCount(sceneId,selfId,x226009_g_DemandItem[1].id)+1,x226009_g_DemandItem[1].num ))
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

function x226009_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x226009_OnItemChanged(sceneId, selfId, itemdataId)

end

