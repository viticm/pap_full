--金兵的伏击

--MisDescBegin
x207003_g_ScriptId = 207003
x207003_g_MissionIdPre =264
x207003_g_MissionId = 265
x207003_g_MissionKind = 18
x207003_g_MissionLevel = 75
x207003_g_ScriptIdNext = {ScriptId = 207003 ,LV = 1 }
x207003_g_Name	="王楫"
x207003_g_Name2	="塔察儿"
x207003_g_DemandItem ={}
x207003_g_DemandKill ={{id=409,num=15}}

x207003_g_MissionName="金兵的伏击"
x207003_g_MissionInfo="    驿站的通道已经畅通无阻了，我即将启程，但是有一件事我必须告诉你。\n \n    有一队#R金国游骑兵#W在昨夜通过密道出了蔡州城，他们藏及在潜龙岭西边，打算伏击我们的火炮队，你要立即阻止他们。"  --任务描述
x207003_g_MissionTarget="    王楫提供信息说潜龙岭西边有一队#R金国游骑兵#W,你要解决掉他们之后告诉#G塔察儿#W这个消息。"		                                                                                               
x207003_g_MissionComplete="    这件事你做的很好，我们的炮兵队一定不能出事，攻城都要靠他们。"					--完成任务npc说话的话
x207003_g_ContinueInfo="    你解决金国游骑兵了吗？"
--任务奖励
x207003_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x207003_g_ItemBonus={}

--可选物品奖励，最多8种
x207003_g_RadioItemBonus={}

--MisDescEnd
x207003_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x207003_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207003_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207003_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x207003_g_MissionId)
		if x207003_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x207003_g_MissionName)
			AddText(sceneId,x207003_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x207003_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死金国游骑兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x207003_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x207003_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x207003_g_MissionName)
		     AddText(sceneId,x207003_g_MissionComplete)
		     AddMoneyBonus(sceneId, x207003_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x207003_g_ScriptId, x207003_g_MissionId)
                end

        elseif x207003_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x207003_g_MissionName)
                AddText(sceneId,x207003_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x207003_g_MissionTarget) 
		AddMoneyBonus(sceneId, x207003_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207003_g_ScriptId, x207003_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207003_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207003_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207003_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207003_g_ScriptId, x207003_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207003_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207003_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207003_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==7) then
		if IsMissionHaveDone(sceneId, selfId, x207003_g_MissionIdPre) > 0 then
			if (GetName(sceneId,targetId)==x207003_g_Name) then
				 if IsHaveMission(sceneId,selfId, x207003_g_MissionId) <= 0 then
					return 1
				 end
			end
			if (GetName(sceneId,targetId)==x207003_g_Name2) then
				 if IsHaveMission(sceneId,selfId, x207003_g_MissionId) > 0 then
					return 1
				 end
			end
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x207003_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x207003_g_MissionId, x207003_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x207003_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x207003_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207003_g_MissionId)
	for i, item in x207003_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x207003_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x207003_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x207003_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207003_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207003_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207003_g_MissionId)
		AddExp(sceneId, selfId, x207003_g_ExpBonus)
		AddMoney(sceneId, selfId, x207003_g_MoneyBonus)
		for i, item in x207003_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x207003_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x207003_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207003_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x207003_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x207003_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x207003_g_DemandKill[1].id then 
       		    if num < x207003_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死金国游骑兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x207003_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x207003_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207003_OnItemChanged(sceneId, selfId, itemdataId)

end

