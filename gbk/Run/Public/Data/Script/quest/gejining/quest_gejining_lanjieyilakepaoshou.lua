--拦截伊拉克炮手

--MisDescBegin
x215008_g_ScriptId = 215008
--x215008_g_MissionIdPre =41
x215008_g_MissionId = 139
x215008_g_MissionKind = 14
x215008_g_MissionLevel = 55
x215008_g_ScriptIdNext = {ScriptId = 215009 ,LV = 1 }
x215008_g_Name	="哲别" 
x215008_g_Name2	="术赤" 
x215008_g_DemandItem ={}
x215008_g_DemandKill ={{id=382,num=1}}

x215008_g_MissionName="拦截伊拉克炮手"
x215008_g_MissionInfo="    两军对垒，必须保证充足的粮草、畅通的粮道，因此，粮草之战我们打胜仗最关键的一环。我观察了很久，众多来投靠扎兰丁的军队都带着粮草。\n \n    术赤已经成功的烧了他们的粮仓，正在归途的路上。探子回报，有两队伊拉克火炮手准备伏击术赤。\n \n     这件事就交给你了，要赶在术赤之前，解决了他们。火炮手的火器很厉害，你要安全的回来。"  --任务描述
x215008_g_MissionTarget="    杀死准备伏击#G术赤#W的#R伊拉克火炮手#W。"		                                                                                               
x215008_g_MissionComplete="    谢谢你相救！"					--完成任务npc说话的话
x215008_g_ContinueInfo="    那些火炮手的威胁很大，你要尽快解决了他们。"
--任务奖励
x215008_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x215008_g_ItemBonus={}

--可选物品奖励，最多8种
x215008_g_RadioItemBonus={}

--MisDescEnd
x215008_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x215008_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x215008_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x215008_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x215008_g_MissionId)
		if x215008_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x215008_g_MissionName)
			AddText(sceneId,x215008_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x215008_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死伊拉克火炮手   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x215008_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x215008_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x215008_g_MissionName)
		     AddText(sceneId,x215008_g_MissionComplete)
		     AddMoneyBonus(sceneId, x215008_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x215008_g_ScriptId, x215008_g_MissionId)
                end

        elseif x215008_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x215008_g_MissionName)
                AddText(sceneId,x215008_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x215008_g_MissionTarget) 
		AddMoneyBonus(sceneId, x215008_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x215008_g_ScriptId, x215008_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x215008_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x215008_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x215008_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x215008_g_ScriptId, x215008_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x215008_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x215008_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x215008_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==15) then
		if (GetName(sceneId,targetId)==x215008_g_Name) then
			if IsHaveMission(sceneId,selfId, x215008_g_MissionId) <= 0 then
        	    		return 1
        	    	end
        	end
        	if (GetName(sceneId,targetId)==x215008_g_Name2) then
			if IsHaveMission(sceneId,selfId, x215008_g_MissionId) > 0 then
        	    		return 1
        	    	end
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x215008_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x215008_g_MissionId, x215008_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x215008_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x215008_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x215008_g_MissionId)
	for i, item in x215008_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x215008_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x215008_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x215008_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x215008_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x215008_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x215008_g_MissionId)
		AddExp(sceneId, selfId, x215008_g_ExpBonus)
		AddMoney(sceneId, selfId, x215008_g_MoneyBonus)
		for i, item in x215008_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x215008_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x215008_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x215008_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x215008_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x215008_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x215008_g_DemandKill[1].id then 
       		    if num < x215008_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死伊拉克火炮手   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x215008_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x215008_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x215008_OnItemChanged(sceneId, selfId, itemdataId)

end

