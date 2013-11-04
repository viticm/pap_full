--主教的箱子

--MisDescBegin
x225002_g_ScriptId = 225002
x225002_g_MissionIdPre =323
x225002_g_MissionId = 324
x225002_g_MissionKind = 22
x225002_g_MissionLevel = 110
--x225002_g_ScriptIdNext = {ScriptId = 205005 ,LV = 1 }
x225002_g_Name	="速不台" 
x225002_g_DemandItem ={{id=13010060,num=1}}
x225002_g_noDemandItem ={{id=13010059,num=1}}
x225002_g_noDemandKill ={{id=437,num=1}}	

x225002_g_MissionName="主教的箱子"
x225002_g_MissionInfo="    看来他是想把箱子埋起来不让我们发现。里面一定有许多财宝。\n \n    去把箱子里的东西给我带回来，屠城结束后分给将士们。那个箱子可能不会那么容易打开，如果锁上了就到那个主教身上搜索一下，他应该会有钥匙。"  --任务描述
x225002_g_MissionTarget="    去#G贵族花园#W杀死#G基辅主教#W拿到钥匙，打开主教的箱子得到其中物品。"		
x225002_g_MissionComplete="    搞了半天只有这么一个杯子，而且还不是金子做的，基辅主教的脑袋坏掉了吗？居然埋这么一个东西。"					--完成任务npc说话的话
x225002_g_ContinueInfo="    看主教紧张的样子，箱子里面一定很多财宝。"
--任务奖励
x225002_g_MoneyBonus = 600
--固定物品奖励，最多8种
x225002_g_ItemBonus={}

--可选物品奖励，最多8种
x225002_g_RadioItemBonus={{id=12010001,num=1},{id=12010001,num=1},{id=12010001,num=1}}

--MisDescEnd
x225002_g_ExpBonus = 6500
--**********************************

--任务入口函数

--**********************************

function x225002_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x225002_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x225002_g_MissionId) > 0 then
			if x225002_CheckSubmit(sceneId, selfId, targetId) <= 0 then
	                        BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x225002_g_MissionName)
				AddText(sceneId,x225002_g_ContinueInfo)
			        AddText(sceneId,"#Y任务目标#W") 
				AddText(sceneId,x225002_g_MissionTarget) 
				AddText(sceneId,format("\n    箱中包裹   %d/%d", LuaFnGetItemCount(sceneId,selfId,x225002_g_DemandItem[1].id),x225002_g_DemandItem[1].num ))
				EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
			end
	
			     
	                if x225002_CheckSubmit(sceneId, selfId, targetId) > 0 then
	                     BeginEvent(sceneId)
	                     AddText(sceneId,"#Y"..x225002_g_MissionName)
			     AddText(sceneId,x225002_g_MissionComplete)
			     AddMoneyBonus(sceneId, x225002_g_MoneyBonus)
			     for i, item in x225002_g_ItemBonus do
		             	AddItemBonus(sceneId, item.id, item.num)
		             end
			     for i, item in x225002_g_RadioItemBonus do
		            	 AddRadioItemBonus(sceneId, item.id, item.num)
		             end
			     EndEvent()
	                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x225002_g_ScriptId, x225002_g_MissionId)
	                end
	     

        elseif x225002_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x225002_g_MissionName)
                AddText(sceneId,x225002_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x225002_g_MissionTarget) 
		AddMoneyBonus(sceneId, x225002_g_MoneyBonus)	
		for i, item in x225002_g_ItemBonus do
	             	AddItemBonus(sceneId, item.id, item.num)
	        end
		for i, item in x225002_g_RadioItemBonus do
	            	 AddRadioItemBonus(sceneId, item.id, item.num)
	        end	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x225002_g_ScriptId, x225002_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x225002_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x225002_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x225002_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x225002_g_ScriptId, x225002_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x225002_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x225002_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x225002_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==16) then
        	if IsMissionHaveDone(sceneId, selfId, x225002_g_MissionIdPre) > 0 then
        	            	return 1
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x225002_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x225002_g_MissionId, x225002_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x225002_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x225002_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x225002_g_MissionId)
	for i, item in x225002_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end
	for i, item in x225002_g_noDemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x225002_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x225002_g_DemandItem[1].id) == x225002_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x225002_OnSubmit(sceneId, selfId, targetId, selectRadioId)

		BeginAddItem(sceneId)                                                    
			for i, item in x225002_g_ItemBonus do                    
				AddItem( sceneId,item.id, item.num )             
			end                                                      
			for i, item in x225002_g_RadioItemBonus do               
				if item.id == selectRadioId then                 
					AddItem( sceneId,item.id, item.num )     
				end                                              
			end                                                      
		ret = EndAddItem(sceneId,selfId)                                 
		if ret > 0 then                                                  
		  ret = DelMission( sceneId, selfId, x225002_g_MissionId ) 
			if ret > 0 then                                   
				MissionCom( sceneId,selfId, x225002_g_MissionId )
				AddExp(sceneId, selfId, x225002_g_ExpBonus)   
	                        AddMoney(sceneId, selfId, x225002_g_MoneyBonus)
	                        AddItemListToHuman(sceneId,selfId)
	                        for i, item in x225002_g_DemandItem do
					DelItem(sceneId, selfId, item.id, item.num)
				end
			end                                               
		else                                                             
			BeginEvent(sceneId)                                      
				AddText(sceneId,"物品栏已满，请整理下再来！");                        
			EndEvent(sceneId)                                        
			DispatchMissionTips(sceneId,selfId)                      
		end 
		--CallScriptFunction( x225002_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x225002_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x225002_g_MissionId) >= 0 then                                       
       		 if objdataId == x225002_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x225002_g_noDemandItem[1].id) < x225002_g_noDemandItem[1].num then
       		         if LuaFnGetItemCount(sceneId,selfId,x225002_g_DemandItem[1].id) < x225002_g_DemandItem[1].num then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x225002_g_noDemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("得到主教的钥匙   %d/%d", LuaFnGetItemCount(sceneId,selfId,x225002_g_DemandItem[1].id)+1,x225002_g_DemandItem[1].num ))
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

function x225002_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x225002_OnItemChanged(sceneId, selfId, itemdataId)

end

