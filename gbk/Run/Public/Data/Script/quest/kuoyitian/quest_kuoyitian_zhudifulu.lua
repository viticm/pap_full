--驻地俘虏

--MisDescBegin
x214004_g_ScriptId = 214004
--x214004_g_MissionIdPre =41
x214004_g_MissionId = 111
x214004_g_MissionKind = 3
x214004_g_MissionLevel = 15
--x214004_g_ScriptIdNext = {ScriptId = 204001 ,LV = 1 }
x214004_g_Name	="铁木真" 
x214004_g_DemandItem ={}
x214004_g_DemandKill ={{id=360,num=15}}

x214004_g_MissionName="驻地俘虏"
x214004_g_MissionInfo="    我和札木合的友谊彻底的完了，三次结为安答的情意，就在这场战争中结束了。\n \n    札木合联合了是十三个部落，对我乞颜部进行偷袭，勇敢的将士们为了让我们成功的撤退了，他们牺牲了自己，沦为了札木合的俘虏。\n \n    他们舍弃了性命，付出了一切，我们不能扔下他们不管！\n \n   探子已经打听到了一些消息，部分将士被关在离我们营地不远的A处，那里守卫非常森严。\n \n    "  --任务描述
x214004_g_MissionInfo2="，请你把A处的15名#R札答阑哨兵#W给杀了。"
x214004_g_MissionTarget="    离营地不远处的A处关着#G成吉思汗#W的将士，你负责解决掉15名#R札答阑哨兵#W。"		                                                                                               
x214004_g_MissionComplete="    干掉了哨兵我们就可以实施营救计划了！"					--完成任务npc说话的话
x214004_g_ContinueInfo="    那些哨兵解决了吗？"
--任务奖励
x214004_g_MoneyBonus = 600
--固定物品奖励，最多8种
x214004_g_ItemBonus={}

--可选物品奖励，最多8种
x214004_g_RadioItemBonus={}

--MisDescEnd
x214004_g_ExpBonus = 6500
--**********************************

--任务入口函数

--**********************************

function x214004_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x214004_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x214004_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x214004_g_MissionId)
		if x214004_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x214004_g_MissionName)
			AddText(sceneId,x214004_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x214004_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死札答阑哨兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x214004_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x214004_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x214004_g_MissionName)
		     AddText(sceneId,x214004_g_MissionComplete)
		     AddMoneyBonus(sceneId, x214004_g_MoneyBonus)	
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x214004_g_ScriptId, x214004_g_MissionId)
                end

        elseif x214004_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x214004_g_MissionName)
                AddText(sceneId,x214004_g_MissionInfo..GetName(sceneId, selfId)..x214004_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x214004_g_MissionTarget) 
		AddMoneyBonus(sceneId, x214004_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x214004_g_ScriptId, x214004_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x214004_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x214004_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x214004_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x214004_g_ScriptId, x214004_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x214004_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x214004_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x214004_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==14) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x214004_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x214004_g_MissionId, x214004_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x214004_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x214004_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x214004_g_MissionId)
	for i, item in x214004_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x214004_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x214004_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x214004_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x214004_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x214004_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x214004_g_MissionId)
		AddExp(sceneId, selfId, x214004_g_ExpBonus)
		AddMoney(sceneId, selfId, x214004_g_MoneyBonus)
		for i, item in x214004_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x214004_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x214004_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x214004_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x214004_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x214004_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x214004_g_DemandKill[1].id then 
       		    if num < x214004_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死札答阑哨兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x214004_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x214004_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x214004_OnItemChanged(sceneId, selfId, itemdataId)

end

