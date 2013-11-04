--胆量的试炼

--MisDescBegin
x204007_g_ScriptId = 204007
--x204007_g_MissionIdPre =41
x204007_g_MissionId = 102
x204007_g_MissionKind = 9
x204007_g_MissionLevel = 45
--x204007_g_ScriptIdNext = {ScriptId = 204001 ,LV = 1 }
x204007_g_Name	="哲别" 
x204007_g_DemandItem ={}
x204007_g_DemandKill ={{id=351,num=5},{id=352,num=5},{id=353,num=5}}

x204007_g_MissionName="胆量的试炼"
x204007_g_MissionInfo="    西辽的那些契丹勇士们，跟我们大草原的勇士一样，有着强悍、剽勇、矫健的身躯！见到了他们，我就想起了跟大汗征战各部落的情景……\n \n    <哲别看着远方的战火，不屑一顾的说>那边的契丹勇士是屈出律的精兵，他们的弓箭和马刀跟我们一样的狠毒，他们那些诡异的巫师躲在暗处对你施法，"  --任务描述
x204007_g_MissionInfo2="，你可有胆量，把他们的性命取来。"
x204007_g_MissionTarget="    #G哲别#W要你取5个#R契丹弓箭手#W，5个#R契丹刀手#W和5个#R契丹巫师#W的性命。"		                                                                                               
x204007_g_MissionComplete="    你很勇敢，我为你高兴。"					--完成任务npc说话的话
x204007_g_ContinueInfo="    你的任务完成了吗？"
--任务奖励
x204007_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x204007_g_ItemBonus={}

--可选物品奖励，最多8种
x204007_g_RadioItemBonus={}

--MisDescEnd
x204007_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x204007_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x204007_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x204007_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x204007_g_MissionId)
		if x204007_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x204007_g_MissionName)
			AddText(sceneId,x204007_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x204007_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死契丹弓箭手   %d/5\n    杀死契丹刀手   %d/5\n    杀死契丹巫师   %d/5", GetMissionParam(sceneId,selfId,misIndex,0), GetMissionParam(sceneId,selfId,misIndex,1), GetMissionParam(sceneId,selfId,misIndex,2) ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x204007_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x204007_g_MissionName)
		     AddText(sceneId,x204007_g_MissionComplete)
		     AddMoneyBonus(sceneId, x204007_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x204007_g_ScriptId, x204007_g_MissionId)
                end

        elseif x204007_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x204007_g_MissionName)
                AddText(sceneId,x204007_g_MissionInfo..GetName(sceneId, selfId)..x204007_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x204007_g_MissionTarget) 
		AddMoneyBonus(sceneId, x204007_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x204007_g_ScriptId, x204007_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x204007_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x204007_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x204007_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x204007_g_ScriptId, x204007_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x204007_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x204007_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x204007_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==4) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x204007_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x204007_g_MissionId, x204007_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x204007_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x204007_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x204007_g_MissionId)
	for i, item in x204007_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x204007_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x204007_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x204007_g_DemandKill[1].num then
		if GetMissionParam(sceneId,selfId,misIndex,1) == x204007_g_DemandKill[2].num then
			if GetMissionParam(sceneId,selfId,misIndex,2) == x204007_g_DemandKill[3].num then
	        		return 1
	        	end
	        end
	end
	return 0

end



--**********************************

--提交

--**********************************

function x204007_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x204007_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x204007_g_MissionId)
		AddExp(sceneId, selfId, x204007_g_ExpBonus)
		AddMoney(sceneId, selfId, x204007_g_MoneyBonus)
		for i, item in x204007_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x204007_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x204007_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x204007_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x204007_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x204007_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 num1 = GetMissionParam(sceneId,selfId,misIndex,1)
	 num2 = GetMissionParam(sceneId,selfId,misIndex,2)
	 	 if objdataId == x204007_g_DemandKill[1].id then 
       		    if num < x204007_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死契丹弓箭手   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x204007_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 if objdataId == x204007_g_DemandKill[2].id then 
       		    if num1 < x204007_g_DemandKill[2].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,1,num1+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死契丹刀手   %d/%d", GetMissionParam(sceneId,selfId,misIndex,1),x204007_g_DemandKill[2].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 if objdataId == x204007_g_DemandKill[3].id then 
       		    if num2 < x204007_g_DemandKill[3].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,2,num2+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死契丹巫师   %d/%d", GetMissionParam(sceneId,selfId,misIndex,2),x204007_g_DemandKill[3].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x204007_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x204007_OnItemChanged(sceneId, selfId, itemdataId)

end

