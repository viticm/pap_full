--夺妻之恨

--MisDescBegin
x201000_g_ScriptId = 201000
--x201000_g_MissionIdPre =41
x201000_g_MissionId = 82
x201000_g_MissionKind = 2
x201000_g_MissionLevel = 10
x201000_g_ScriptIdNext = {ScriptId = 201001 ,LV = 1 }
x201000_g_Name	="铁木真" 
x201000_g_DemandItem ={}
x201000_g_DemandKill ={{id=337,num=20}}

x201000_g_MissionName="夺妻之恨"
x201000_g_MissionInfo="    苍狼白鹿的子孙们，我们来了，在蔑里乞部的牧场上，我们不仅来了，还要打败他们，让蔑里乞部从此消失在草原上，让这里成为我们永远的牧场。\n \n    那些踏贱过我铁木真家族，抢我妻子的敌人，今天便要他们血债血偿！\n \n    向#G西营#W进攻，消灭#R蔑里乞士兵#W。"  --任务描述
x201000_g_MissionTarget="    杀死20名#G西营#W附近的#R蔑里乞士兵#B#aB{蔑里乞士兵_1}[39,133]#aE#W，回来向#G铁木真#B#aB{铁木真_2}[79,128]#aE#W复命。"		                                                                                               
x201000_g_MissionComplete="    勇士，擦亮你的眼睛，磨好你的武器，准备好下一场的冲锋！"					--完成任务npc说话的话
x201000_g_ContinueInfo="    蔑里乞士兵都消灭了吗？"



--自动寻路的定义
x201000_g_AutoFindPath =  {{sid=1,x=39,z=133,speak=0},{sid=1,x=79,z=128,speak=1}}

--任务奖励
x201000_g_MoneyBonus = 1

--固定物品奖励，最多8种
x201000_g_ItemBonus={}

--可选物品奖励，最多8种
x201000_g_RadioItemBonus={}

--MisDescEnd
x201000_g_ExpBonus = 50
--**********************************

--任务入口函数

--**********************************

function x201000_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x201000_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x201000_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x201000_g_MissionId)
		if x201000_CheckSubmit(sceneId, selfId, targetId) <= 0 then
     	  BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x201000_g_MissionName)
				AddText(sceneId,x201000_g_ContinueInfo)
		  	AddText(sceneId,"#Y任务目标#W") 
				AddText(sceneId,x201000_g_MissionTarget) 
				AddText(sceneId,format("\n    杀死蔑里乞士兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,1),x201000_g_DemandKill[1].num ))
				EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
		end

		if x201000_CheckSubmit(sceneId, selfId, targetId) > 0 then
        BeginEvent(sceneId)
        AddText(sceneId,"#Y"..x201000_g_MissionName)
		    AddText(sceneId,x201000_g_MissionComplete)
		    AddMoneyBonus(sceneId, x201000_g_MoneyBonus)
		    EndEvent()
        DispatchMissionContinueInfo(sceneId, selfId, targetId, x201000_g_ScriptId, x201000_g_MissionId)
    end

  elseif x201000_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x201000_g_MissionName)
      AddText(sceneId,x201000_g_MissionInfo) 
			AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x201000_g_MissionTarget) 
			AddMoneyBonus(sceneId, x201000_g_MoneyBonus)
			EndEvent()
			DispatchMissionInfo(sceneId, selfId, targetId, x201000_g_ScriptId, x201000_g_MissionId)
  end
	
end



--**********************************

--列举事件

--**********************************

function x201000_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x201000_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x201000_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x201000_g_ScriptId, x201000_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x201000_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x201000_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x201000_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==1) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x201000_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x201000_g_MissionId, x201000_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x201000_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x201000_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x201000_g_MissionId)
	for i, item in x201000_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x201000_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x201000_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,1) == x201000_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x201000_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x201000_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x201000_g_MissionId)
		AddExp(sceneId, selfId, x201000_g_ExpBonus)
		AddMoney(sceneId, selfId, x201000_g_MoneyBonus)
		for i, item in x201000_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x201000_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x201000_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x201000_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x201000_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x201000_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,1) 
	 	 if objdataId == x201000_g_DemandKill[1].id then 
       		    if num < x201000_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,1,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死蔑里乞士兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,1),x201000_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    else
		    	SetMissionByIndex(sceneId,selfId,misIndex,0,1)
		    end
		    
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x201000_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x201000_OnItemChanged(sceneId, selfId, itemdataId)

end

