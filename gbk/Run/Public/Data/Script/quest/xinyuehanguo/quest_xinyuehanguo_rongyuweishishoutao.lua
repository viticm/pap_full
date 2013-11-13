--荣誉卫士手套

--MisDescBegin
x211056_g_ScriptId = 211056
x211056_g_MissionId = 395
x211056_g_MissionKind = 1
x211056_g_MissionLevel = 10
--x211056_g_ScriptIdNext = {ScriptId = 205005 ,LV = 1 }
x211056_g_Name	="阿丹" 
x211056_g_DemandItem ={{id=11990003,num=5}}
x211056_g_noDemandKill ={}	

x211056_g_MissionName="荣誉卫士手套"
x211056_g_MissionInfo="    我是大都派来的使者，运送贡品来到贵国。途经野外不幸被土匪劫道，#c0080C0使者密令#W全部丢失。因为没有了这些信，我的车队堵在城外无法进城。如果你能帮我抢回来一些，我将把这把我从大都带过来的精良装备送给你。"
x211056_g_MissionTarget="    收集5个#c0080C0使者密令#W并带给#G阿甘#W"		
x211056_g_MissionComplete="    没有使者密令我的任务就无法完成，拜托你了。"					--完成任务npc说话的话
x211056_g_ContinueInfo="    有了这些使者密令我的损失少了很多，谢谢你。"
--任务奖励
x211056_g_MoneyBonus = 700
--固定物品奖励，最多8种
x211056_g_ItemBonus={{id=10257001,num=1}}

--可选物品奖励，最多8种
x211056_g_RadioItemBonus={}
--MisDescEnd
x201004_g_ExpBonus = 40
--**********************************

--任务入口函数

--**********************************

function x211056_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x211056_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end
	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x211056_g_MissionId) > 0 then
		if x211056_CheckSubmit(sceneId, selfId, targetId) <= 0 then
			local haveitem = 0
			if LuaFnGetItemCount(sceneId,selfId,x211056_g_DemandItem[1].id) >= x211056_g_DemandItem[1].num then
				haveitem = x211056_g_DemandItem[1].num
			else
				haveitem = LuaFnGetItemCount(sceneId,selfId,x211056_g_DemandItem[1].id)
			end
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x211056_g_MissionName)
			AddText(sceneId,x211056_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x211056_g_MissionTarget) 
			AddText(sceneId,format("\n    使者密令   %d/%d", haveitem,x211056_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x211056_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x211056_g_MissionName)
		     AddText(sceneId,x211056_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in pairs(x211056_g_DemandItem) do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x211056_g_MoneyBonus)
		     for i, item in pairs(x211056_g_ItemBonus) do
	             	AddItemBonus(sceneId, item.id, item.num)
	             end
		     for i, item in pairs(x211056_g_RadioItemBonus) do
	            	 AddRadioItemBonus(sceneId, item.id, item.num)
	             end
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x211056_g_ScriptId, x211056_g_MissionId)
                end

        elseif x211056_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x211056_g_MissionName)
                AddText(sceneId,x211056_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x211056_g_MissionTarget) 
		AddMoneyBonus(sceneId, x211056_g_MoneyBonus)
		for i, item in pairs(x211056_g_ItemBonus) do
	             	AddItemBonus(sceneId, item.id, item.num)
	        end
		for i, item in pairs(x211056_g_RadioItemBonus) do
	            	 AddRadioItemBonus(sceneId, item.id, item.num)
	        end	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x211056_g_ScriptId, x211056_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x211056_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x211056_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x211056_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x211056_g_ScriptId, x211056_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x211056_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x211056_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x211056_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==11) then
        	if GetLevel( sceneId, selfId ) >= 10 then
        		return 1
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x211056_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x211056_g_MissionId, x211056_g_ScriptId, 1, 1, 1)
			AddText(sceneId,"接受任务："..x211056_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x211056_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x211056_g_MissionId)
	

end



--**********************************

--检测是否可以提交

--**********************************

function x211056_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x211056_g_DemandItem[1].id) >= x211056_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x211056_OnSubmit(sceneId, selfId, targetId, selectRadioId)

		BeginAddItem(sceneId)                                                    
			for i, item in pairs(x211056_g_ItemBonus) do                    
				AddItem( sceneId,item.id, item.num )             
			end                                                      
			for i, item in pairs(x211056_g_RadioItemBonus) do               
				if item.id == selectRadioId then                 
					AddItem( sceneId,item.id, item.num )     
				end                                              
			end                                                      
		ret = EndAddItem(sceneId,selfId)                                 
		if ret > 0 then                                                  
		  ret = DelMission( sceneId, selfId, x211056_g_MissionId ) 
			if ret > 0 then                                   
				MissionCom( sceneId,selfId, x211056_g_MissionId )
				AddExp(sceneId, selfId, x211056_g_ExpBonus)   
	                        AddMoney(sceneId, selfId, x211056_g_MoneyBonus)
	                        AddItemListToHuman(sceneId,selfId)
	                        for i, item in pairs(x211056_g_DemandItem) do
					DelItem(sceneId, selfId, item.id, item.num)
				end
			end                                               
		else                                                             
			BeginEvent(sceneId)                                      
				AddText(sceneId,"物品栏已满，请整理下再来！");                        
			EndEvent(sceneId)                                        
			DispatchMissionTips(sceneId,selfId)                      
		end   
		--CallScriptFunction( x211056_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211056_OnKillObject(sceneId, selfId, objdataId)
	

end



--**********************************

--进入区域事件

--**********************************

function x211056_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211056_OnItemChanged(sceneId, selfId, itemdataId)
	if itemdataId == x211056_g_DemandItem[1].id then
		local haveitem = 0
		if LuaFnGetItemCount(sceneId,selfId,x211056_g_DemandItem[1].id) <= x211056_g_DemandItem[1].num then
			haveitem = LuaFnGetItemCount(sceneId,selfId,x211056_g_DemandItem[1].id)
			BeginEvent(sceneId)
			AddText(sceneId,format("使者密令   %d/%d", haveitem,x211056_g_DemandItem[1].num )) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)
		end
	end

end

