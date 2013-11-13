--邪恶萨满的老巢

--MisDescBegin
x201012_g_ScriptId = 201012
x201012_g_MissionIdPre =86
x201012_g_MissionId = 94
x201012_g_MissionKind = 2
x201012_g_MissionLevel = 10
--x201012_g_ScriptIdNext = {ScriptId = 205005 ,LV = 1 }
x201012_g_Name	="博尔术" 
x201012_g_DemandItem ={{id=13010025,num=1}}
x201012_g_noDemandKill ={{id=343,num=1}}	

x201012_g_MissionName="邪恶萨满的老巢"
x201012_g_MissionInfo="    这些邪恶的萨满，是 脱黑脱 最邪恶，最狠毒的奇兵。要灭蔑里乞部，一定要把萨满的老巢给端掉。\n \n    蔑里乞马场的右边，就是萨满的老巢，邪恶萨满的教主巴诃儿就躲在他的老巢里。\n \n    只有得到法杖，才能统驭这些邪恶的萨满。争取时间，把#R巴诃儿#W给杀了，拿到他的法杖！"
x201012_g_MissionTarget="    杀死#G跑马坡#W的萨满头目#R巴诃儿#W，把他的头带给#G博尔术#W。"		
x201012_g_MissionComplete="    这看起来没有任何奇异的木棍，就是萨满教的法杖，真是不可思议。"					--完成任务npc说话的话
x201012_g_ContinueInfo="    法杖是任何一个萨满教主的身份象征，一定要拿到。"
--任务奖励
x201012_g_MoneyBonus = 3
--固定物品奖励，最多8种
x201012_g_ItemBonus={}

--可选物品奖励，最多8种
x201012_g_RadioItemBonus={{id=10016001,num=1},{id=10026001,num=1},{id=10036001,num=1},{id=10046001,num=1},{id=10056001,num=1},{id=10066001,num=1}}
--MisDescEnd
x201004_g_ExpBonus = 120
--**********************************

--任务入口函数

--**********************************

function x201012_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x201012_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x201012_g_MissionId) > 0 then
		if x201012_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x201012_g_MissionName)
			AddText(sceneId,x201012_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x201012_g_MissionTarget) 
			AddText(sceneId,format("\n    巴诃儿的法杖   %d/%d", LuaFnGetItemCount(sceneId,selfId,x201012_g_DemandItem[1].id),x201012_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x201012_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x201012_g_MissionName)
		     AddText(sceneId,x201012_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in pairs(x201012_g_DemandItem) do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x201012_g_MoneyBonus)
		     for i, item in pairs(x201012_g_ItemBonus) do
	             	AddItemBonus(sceneId, item.id, item.num)
	             end
		     for i, item in pairs(x201012_g_RadioItemBonus) do
	            	 AddRadioItemBonus(sceneId, item.id, item.num)
	             end
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x201012_g_ScriptId, x201012_g_MissionId)
                end

        elseif x201012_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x201012_g_MissionName)
                AddText(sceneId,x201012_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x201012_g_MissionTarget) 
		AddMoneyBonus(sceneId, x201012_g_MoneyBonus)
		for i, item in pairs(x201012_g_ItemBonus) do
	             	AddItemBonus(sceneId, item.id, item.num)
	        end
		for i, item in pairs(x201012_g_RadioItemBonus) do
	            	 AddRadioItemBonus(sceneId, item.id, item.num)
	        end	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x201012_g_ScriptId, x201012_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x201012_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x201012_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x201012_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x201012_g_ScriptId, x201012_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x201012_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x201012_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x201012_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==1) then
        	if IsMissionHaveDone(sceneId, selfId, x201012_g_MissionIdPre) > 0 then
        		     		return 1
        	         	end
        	         end
        	return 0
	
end

--**********************************

--接受

--**********************************

function x201012_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x201012_g_MissionId, x201012_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x201012_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x201012_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x201012_g_MissionId)
	for i, item in pairs(x201012_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x201012_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x201012_g_DemandItem[1].id) == x201012_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x201012_OnSubmit(sceneId, selfId, targetId, selectRadioId)

			BeginAddItem(sceneId)                                                    
			for i, item in pairs(x201012_g_ItemBonus) do                    
			AddItem( sceneId,item.id, item.num )             
			end                                                      
			for i, item in pairs(x201012_g_RadioItemBonus) do               
				if item.id == selectRadioId then                 
					AddItem( sceneId,item.id, item.num )     
				end                                              
			end                                                      
			ret = EndAddItem(sceneId,selfId)                                 
			if ret > 0 then                                                  
		  	ret = DelMission( sceneId, selfId, x201012_g_MissionId ) 
				if ret > 0 then                                   
				MissionCom( sceneId,selfId, x201012_g_MissionId )
				AddExp(sceneId, selfId, x201012_g_ExpBonus)   
	      AddMoney(sceneId, selfId, x201012_g_MoneyBonus)
	      AddItemListToHuman(sceneId,selfId)
	      for i, item in pairs(x201012_g_DemandItem) do
						DelItem(sceneId, selfId, item.id, item.num)
				end
				end                                               
			else                                                             
				BeginEvent(sceneId)                                      
				AddText(sceneId,"物品栏已满，请整理下再来！");                        
				EndEvent(sceneId)                                        
				DispatchMissionTips(sceneId,selfId)                      
			end   
		--CallScriptFunction( x201012_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x201012_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x201012_g_MissionId) >= 0 then                                       
       		 if objdataId == x201012_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x201012_g_DemandItem[1].id) < x201012_g_DemandItem[1].num then
       		         if random(1,100)>0 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x201012_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("巴诃儿的法杖   %d/%d", LuaFnGetItemCount(sceneId,selfId,x201012_g_DemandItem[1].id)+1,x201012_g_DemandItem[1].num )) 
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

function x201012_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x201012_OnItemChanged(sceneId, selfId, itemdataId)

end

