--绿洲

--MisDescBegin
x205005_g_ScriptId = 205005
x205005_g_MissionIdPre =44
x205005_g_MissionId = 45
x205005_g_MissionKind = 11
x205005_g_MissionLevel = 55
--x205005_g_ScriptIdNext = {ScriptId = 205005 ,LV = 1 }
x205005_g_Name	="哈撒儿" 
x205005_g_DemandItem ={{id=13010005,num=5}}
x205005_g_noDemandItem ={{id=13010004,num=5}}
--x205005_g_noDemandKill ={{id=304,num=1}}	

x205005_g_MissionName="绿洲"
x205005_g_MissionInfo="    <哈撒儿转身，把他受伤的臂膀露给你看，咬牙切齿的说>\n \n    你看！你看！这些该死的花剌子模人！我只是去四周看了看，就中了他们一箭，他们应该知道，我是成吉思汗的弟弟，我一定要灭了他们！不留活口，一个不留！<他对你咆哮了半响，才开始跟你说起正事>\n \n    没有了水，我们的一些士兵因为饥渴而产生了幻觉，幸好巴吉这小子聪明，帮我们弄到了水囊，在（164，106）处有一绿洲，请你帮我们盛5个水囊的水来吧。"  --任务描述
x205005_g_MissionTarget="    拿着#G哈撒儿#W给的5个水囊，到（164，106）处的绿洲把水囊给灌满水。"		
x205005_g_MissionComplete="    有了水，我们才能生存。请相信我……我是成吉思汗的弟弟！我也是长生天的儿子！"					--完成任务npc说话的话
x205005_g_ContinueInfo="    沿着这条路下去，就是绿洲了，赶紧去给我们盛水吧。"
--任务奖励
x205005_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x205005_g_ItemBonus={}

--可选物品奖励，最多8种
x205005_g_RadioItemBonus={}

--MisDescEnd
x205005_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x205005_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x205005_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x205005_g_MissionId) > 0 then
		if x205005_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x205005_g_MissionName)
			AddText(sceneId,x205005_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x205005_g_MissionTarget) 
			AddText(sceneId,format("\n    盛满的水囊   %d/%d", LuaFnGetItemCount(sceneId,selfId,x205005_g_DemandItem[1].id),x205005_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x205005_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x205005_g_MissionName)
		     AddText(sceneId,x205005_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in x205005_g_DemandItem do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x205005_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x205005_g_ScriptId, x205005_g_MissionId)
                end

        elseif x205005_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x205005_g_MissionName)
                AddText(sceneId,x205005_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x205005_g_MissionTarget) 
		AddMoneyBonus(sceneId, x205005_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x205005_g_ScriptId, x205005_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x205005_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x205005_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x205005_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x205005_g_ScriptId, x205005_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x205005_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x205005_g_Name) then 
			return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x205005_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==5) then
        	if IsMissionHaveDone(sceneId, selfId, x205005_g_MissionIdPre) > 0 then
        	            	return 1
        	end
		
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x205005_OnAccept(sceneId, selfId)

	                                                  
	BeginAddItem(sceneId)                                                    
	AddItem( sceneId,x205005_g_noDemandItem[1].id, x205005_g_noDemandItem[1].num )             
		ret = EndAddItem(sceneId,selfId)                                 
	        if ret > 0 then                                                  
	        	BeginEvent(sceneId)
			AddMission( sceneId, selfId, x205005_g_MissionId, x205005_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x205005_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)
			AddItemListToHuman(sceneId,selfId) 
	        else                                                             
		     BeginEvent(sceneId)                                      
		     AddText(sceneId,"物品栏已满，请整理下再来！")                    
		     EndEvent(sceneId)                                        
		     DispatchMissionTips(sceneId,selfId)                      
	        end           	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x205005_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x205005_g_MissionId)
	for i, item in x205005_g_noDemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end
	for i, item in x205005_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x205005_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x205005_g_DemandItem[1].id) == x205005_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x205005_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x205005_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x205005_g_MissionId)
		AddExp(sceneId, selfId, x205005_g_ExpBonus)
		AddMoney(sceneId, selfId, x205005_g_MoneyBonus)
		for i, item in x205005_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x205005_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x205005_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x205005_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x205005_OnEnterArea(sceneId, selfId, zoneId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x205005_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,0,1)

end

function x205005_OnLeaveArea(sceneId, selfId )
	misIndex = GetMissionIndexByID(sceneId,selfId,x205005_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)
end

function x205005_OnTimer(sceneId, selfId )

end

--**********************************

--道具改变

--**********************************

function x205005_OnItemChanged(sceneId, selfId, itemdataId)

end

