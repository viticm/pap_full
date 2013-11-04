--东营敌兵

--MisDescBegin
x201005_g_ScriptId = 201005
--x201005_g_MissionIdPre =41
x201005_g_MissionId = 87
x201005_g_MissionKind = 2
x201005_g_MissionLevel = 10
x201005_g_ScriptIdNext = {ScriptId = 201006 ,LV = 1 }
x201005_g_Name	="札木合" 
x201005_g_DemandItem ={}
x201005_g_DemandKill ={{id=472,num=20}}

x201005_g_MissionName="东营敌兵"
x201005_g_MissionInfo="    铁木真是我的安答，我们俩小时候对着长生天盟誓，两次结为安答，兄弟之情，比罕难河还深，比天上的白云还多！\n \n    谁要对付铁木真，就是对付我，我札答兰部两万精兵已经包围了整个蔑里乞东部。\n \n    "  --任务描述
x201005_g_MissionInfo2="，进攻蔑里乞部#G东营#W，消灭那里的#R蔑里乞刀手#W！"
x201005_g_MissionTarget="    #G扎木合#W命你到东营去去，把20名#R蔑里乞刀手#W给杀了。"		                                                                                               
x201005_g_MissionComplete="    我们成功的拿下了他们的东营，但是依旧找不到孛儿帖。"					--完成任务npc说话的话
x201005_g_ContinueInfo="    拿起你的武器，进攻他们的东营。"
--任务奖励
x201005_g_MoneyBonus = 1
--固定物品奖励，最多8种
x201005_g_ItemBonus={}

--可选物品奖励，最多8种
x201005_g_RadioItemBonus={}

--MisDescEnd
x201005_g_ExpBonus = 50
--**********************************

--任务入口函数

--**********************************

function x201005_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	--检测列出条件
	if x201005_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x201005_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x201005_g_MissionId)
		if x201005_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x201005_g_MissionName)
			AddText(sceneId,x201005_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x201005_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死蔑里乞刀手   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x201005_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x201005_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x201005_g_MissionName)
		     AddText(sceneId,x201005_g_MissionComplete)
		     AddMoneyBonus(sceneId, x201005_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x201005_g_ScriptId, x201005_g_MissionId)
                end

        elseif x201005_CheckAccept(sceneId, selfId, targetId) > 0 then
	 	--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x201005_g_MissionName)
                AddText(sceneId,x201005_g_MissionInfo..GetName(sceneId, selfId)..x201005_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x201005_g_MissionTarget) 
		AddMoneyBonus(sceneId, x201005_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x201005_g_ScriptId, x201005_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x201005_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x201005_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x201005_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x201005_g_ScriptId, x201005_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x201005_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x201005_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x201005_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==1) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x201005_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x201005_g_MissionId, x201005_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x201005_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x201005_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x201005_g_MissionId)
	for i, item in x201005_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x201005_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x201005_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x201005_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x201005_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x201005_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x201005_g_MissionId)
		AddExp(sceneId, selfId, x201005_g_ExpBonus)
		AddMoney(sceneId, selfId, x201005_g_MoneyBonus)
		for i, item in x201005_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x201005_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x201005_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x201005_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x201005_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x201005_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x201005_g_DemandKill[1].id then 
       		    if num < x201005_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死蔑里乞刀手   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x201005_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x201005_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x201005_OnItemChanged(sceneId, selfId, itemdataId)

end

