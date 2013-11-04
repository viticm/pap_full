--解救将士

--MisDescBegin
x214005_g_ScriptId = 214005
--x214005_g_MissionIdPre =40
x214005_g_MissionId = 112
x214005_g_MissionKind = 3
x214005_g_MissionLevel = 15
--x214005_g_ScriptIdNext = {ScriptId = 205005 ,LV = 1 }
x214005_g_Name	="阿勒坛" 
x214005_g_DemandItem ={}
x214005_g_noDemandKill ={}	

x214005_g_MissionName="解救将士"
x214005_g_MissionInfo="    札木合在他们的营地里架起了七十口油锅，要把投靠铁木真的那些将士扔到油锅里。\n \n    这些将士都是诚心诚意来投靠铁木真的，不管需要付出多少代价，我们都要把他们给救出来。\n \n    "  --任务描述
x214005_g_MissionInfo2="，札木合的大本营不难找，沿着大道走，一定能找到，你要去救了他们。"
x214005_g_MissionTarget="    #G阿勒坛#W要你到札木合大本营去救10名被#G俘虏的将士#W。"		
x214005_g_MissionComplete="    谢谢你救下了那些将士。"					--完成任务npc说话的话
x214005_g_ContinueInfo="    那些将士救出来而来吗？"
--任务奖励
x214005_g_MoneyBonus = 600
--固定物品奖励，最多8种
x214005_g_ItemBonus={}

--可选物品奖励，最多8种
x214005_g_RadioItemBonus={{id=10236002,num=1},{id=10246002,num=1},{id=10256002,num=1}}

--MisDescEnd
x214005_g_ExpBonus = 6500
--**********************************

--任务入口函数

--**********************************

function x214005_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x214005_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x214005_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x214005_g_MissionId)
			if x214005_CheckSubmit(sceneId, selfId, targetId) <= 0 then
	                        BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x214005_g_MissionName)
				AddText(sceneId,x214005_g_ContinueInfo)
			        AddText(sceneId,"#Y任务目标#W") 
				AddText(sceneId,x214005_g_MissionTarget) 
				AddText(sceneId,format("\n    解救将士   %d/10", GetMissionParam(sceneId,selfId,misIndex,0) ))
				EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
			end
	
			     
	                if x214005_CheckSubmit(sceneId, selfId, targetId) > 0 then
	                     BeginEvent(sceneId)
	                     AddText(sceneId,"#Y"..x214005_g_MissionName)
			     AddText(sceneId,x214005_g_MissionComplete)
			     AddMoneyBonus(sceneId, x214005_g_MoneyBonus)
			     for i, item in x214005_g_ItemBonus do
		             	AddItemBonus(sceneId, item.id, item.num)
		             end
			     for i, item in x214005_g_RadioItemBonus do
		            	 AddRadioItemBonus(sceneId, item.id, item.num)
		             end
			     EndEvent()
	                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x214005_g_ScriptId, x214005_g_MissionId)
	                end
	     

        elseif x214005_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x214005_g_MissionName)
                AddText(sceneId,x214005_g_MissionInfo..GetName(sceneId, selfId)..x214005_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x214005_g_MissionTarget) 
		AddMoneyBonus(sceneId, x214005_g_MoneyBonus)	
		for i, item in x214005_g_ItemBonus do
	             	AddItemBonus(sceneId, item.id, item.num)
	        end
		for i, item in x214005_g_RadioItemBonus do
	            	 AddRadioItemBonus(sceneId, item.id, item.num)
	        end	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x214005_g_ScriptId, x214005_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x214005_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x214005_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x214005_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x214005_g_ScriptId, x214005_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x214005_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x214005_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x214005_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==14) then
        	            	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x214005_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x214005_g_MissionId, x214005_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x214005_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x214005_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x214005_g_MissionId)
	for i, item in x214005_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x214005_CheckSubmit( sceneId, selfId, targetId)

	misIndex = GetMissionIndexByID(sceneId,selfId,x214005_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == 10 then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x214005_OnSubmit(sceneId, selfId, targetId, selectRadioId)

		BeginAddItem(sceneId)                                                    
			for i, item in x214005_g_ItemBonus do                    
				AddItem( sceneId,item.id, item.num )             
			end                                                      
			for i, item in x214005_g_RadioItemBonus do               
				if item.id == selectRadioId then                 
					AddItem( sceneId,item.id, item.num )     
				end                                              
			end                                                      
		ret = EndAddItem(sceneId,selfId)                                 
		if ret > 0 then                                                  
		  ret = DelMission( sceneId, selfId, x214005_g_MissionId ) 
			if ret > 0 then                                   
				MissionCom( sceneId,selfId, x214005_g_MissionId )
				AddExp(sceneId, selfId, x214005_g_ExpBonus)   
	                        AddMoney(sceneId, selfId, x214005_g_MoneyBonus)
	                        AddItemListToHuman(sceneId,selfId)
			end                                               
		else                                                             
			BeginEvent(sceneId)                                      
				AddText(sceneId,"物品栏已满，请整理下再来！");                        
			EndEvent(sceneId)                                        
			DispatchMissionTips(sceneId,selfId)                      
		end 
		--CallScriptFunction( x214005_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x214005_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x214005_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x214005_OnItemChanged(sceneId, selfId, itemdataId)

end

