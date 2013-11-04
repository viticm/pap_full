--驿站通道

--MisDescBegin
x207002_g_ScriptId = 207002
x207002_g_MissionIdPre =263
x207002_g_MissionId = 264
x207002_g_MissionKind = 18
x207002_g_MissionLevel = 75
x207002_g_ScriptIdNext = {ScriptId = 207003 ,LV = 1 }
x207002_g_Name	="王楫"
x207002_g_DemandItem ={}
x207002_g_DemandKill ={{id=408,num=15}}

x207002_g_MissionName="冲锋陷阵"
x207002_g_MissionInfo="    能为大汗效力，我很荣幸，我已经做好了出使宋国的准备。\n \n    但是……，我很担心，我们身边有内奸，出使宋国的事情被泄露了！\n \n    "  --任务描述
x207002_g_MissionInfo2="，一伙#R女真弓手#W守住了从驿站通往宋国的必经之路，我希望你能帮我扫清去往宋国的道路。"
x207002_g_MissionTarget="    潜龙岭东面的小路是去往宋国的必经之路，#G王楫#W拜托你去解决守在那的15名#R女真弓手#W。"		                                                                                               
x207002_g_MissionComplete="    解决了他们，我就安全了。"					--完成任务npc说话的话
x207002_g_ContinueInfo="    不能耽误我出使的时间，请你尽快把驿站通道的女真弓手给解决了。"
--任务奖励
x207002_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x207002_g_ItemBonus={}

--可选物品奖励，最多8种
x207002_g_RadioItemBonus={}

--MisDescEnd
x207002_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x207002_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207002_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207002_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x207002_g_MissionId)
		if x207002_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x207002_g_MissionName)
			AddText(sceneId,x207002_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x207002_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死女真弓手   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x207002_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x207002_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x207002_g_MissionName)
		     AddText(sceneId,x207002_g_MissionComplete)
		     AddMoneyBonus(sceneId, x207002_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x207002_g_ScriptId, x207002_g_MissionId)
                end

        elseif x207002_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x207002_g_MissionName)
                AddText(sceneId,x207002_g_MissionInfo..GetName(sceneId, selfId)..x207002_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x207002_g_MissionTarget) 
		AddMoneyBonus(sceneId, x207002_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207002_g_ScriptId, x207002_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207002_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207002_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207002_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207002_g_ScriptId, x207002_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207002_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207002_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207002_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==7) then
		if IsMissionHaveDone(sceneId, selfId, x207002_g_MissionIdPre) > 0 then
					return 1
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x207002_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x207002_g_MissionId, x207002_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x207002_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x207002_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207002_g_MissionId)
	for i, item in x207002_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x207002_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x207002_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x207002_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207002_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207002_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207002_g_MissionId)
		AddExp(sceneId, selfId, x207002_g_ExpBonus)
		AddMoney(sceneId, selfId, x207002_g_MoneyBonus)
		for i, item in x207002_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x207002_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x207002_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207002_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x207002_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x207002_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x207002_g_DemandKill[1].id then 
       		    if num < x207002_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死女真弓手   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x207002_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x207002_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207002_OnItemChanged(sceneId, selfId, itemdataId)

end

