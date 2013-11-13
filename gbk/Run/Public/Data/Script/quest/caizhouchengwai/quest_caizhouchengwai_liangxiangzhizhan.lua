--粮饷之战

--MisDescBegin
x207004_g_ScriptId = 207004
x207004_g_MissionIdPre =265
x207004_g_MissionId = 266
x207004_g_MissionKind = 18
x207004_g_MissionLevel = 75
x207004_g_ScriptIdNext = {ScriptId = 207005 ,LV = 1 }
x207004_g_Name	="塔察儿"
x207004_g_DemandItem ={}
x207004_g_DemandKill ={{id=414,num=15}}

x207004_g_MissionName="粮饷之战"
x207004_g_MissionInfo="    古老神秘的宋国，为我们的诚心所打动，他们已经同意跟我们联手，一起灭金国，并在此划地为界，蔡州以及以南之地，均属宋国，这个要求虽然不合理，但是我们没有选择的余地。\n \n    宋将孟珙率兵2万、运粮30万石来支援我们，我们要清楚沿途的金兵给他们开道。"  --任务描述
x207004_g_MissionInfo2="，驿站西边一带的金兵就交给你了，杀了他们的头目，然后回来给我一起迎接宋国大将。"
x207004_g_MissionTarget="    #G塔察儿#W命你到驿站西边去杀死15个#R金兵头目#W来迎接宋国大将。"		                                                                                               
x207004_g_MissionComplete="    有了这批粮草，破城在望。"					--完成任务npc说话的话
x207004_g_ContinueInfo="    杀死金兵头目了吗？"
--任务奖励
x207004_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x207004_g_ItemBonus={}

--可选物品奖励，最多8种
x207004_g_RadioItemBonus={}

--MisDescEnd
x207004_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x207004_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207004_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207004_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x207004_g_MissionId)
		if x207004_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x207004_g_MissionName)
			AddText(sceneId,x207004_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x207004_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死金兵头目   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x207004_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x207004_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x207004_g_MissionName)
		     AddText(sceneId,x207004_g_MissionComplete)
		     AddMoneyBonus(sceneId, x207004_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x207004_g_ScriptId, x207004_g_MissionId)
                end

        elseif x207004_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x207004_g_MissionName)
                AddText(sceneId,x207004_g_MissionInfo..GetName(sceneId, selfId)..x207004_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x207004_g_MissionTarget) 
		AddMoneyBonus(sceneId, x207004_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207004_g_ScriptId, x207004_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207004_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207004_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207004_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207004_g_ScriptId, x207004_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207004_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207004_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207004_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==7) then
		if IsMissionHaveDone(sceneId, selfId, x207004_g_MissionIdPre) > 0 then
					return 1
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x207004_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x207004_g_MissionId, x207004_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x207004_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x207004_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207004_g_MissionId)
	for i, item in pairs(x207004_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x207004_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x207004_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x207004_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207004_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207004_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207004_g_MissionId)
		AddExp(sceneId, selfId, x207004_g_ExpBonus)
		AddMoney(sceneId, selfId, x207004_g_MoneyBonus)
		for i, item in pairs(x207004_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x207004_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x207004_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207004_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x207004_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x207004_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x207004_g_DemandKill[1].id then 
       		    if num < x207004_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死金兵头目   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x207004_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x207004_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207004_OnItemChanged(sceneId, selfId, itemdataId)

end

