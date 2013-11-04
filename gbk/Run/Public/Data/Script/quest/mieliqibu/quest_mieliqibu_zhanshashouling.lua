--斩杀首领

--MisDescBegin
x201008_g_ScriptId = 201008
x201008_g_MissionIdPre =91
x201008_g_MissionId = 90
x201008_g_MissionKind = 2
x201008_g_MissionLevel = 10
--x201008_g_ScriptIdNext = {ScriptId = 201001 ,LV = 1 }
x201008_g_Name	="王汗" 
x201008_g_DemandItem ={}
x201008_g_DemandKill ={{id=344,num=1}}

x201008_g_MissionName="斩杀首领"
x201008_g_MissionInfo="    铁木真的父亲也速该，是草原上的英雄，他用草原上最传统的抢亲方式，抢了赤列的新娘诃额仑，这就是铁木真的母亲。\n \n    蔑里乞首领#R脱黑脱#W，是赤列的哥哥，他打着报仇的名义烧杀抢夺！真主会惩罚他这种贪婪的人。\n \n    我发现了脱黑脱的踪迹，他藏在阴山脚下的某处，"  --任务描述
x201008_g_MissionInfo2="，你去杀了他。"
x201008_g_MissionTarget="    #G王汗#W让你杀了#G东营#W北面的蔑里乞首领#R脱黑脱#W。"		                                                                                               
x201008_g_MissionComplete="    真主是最公平的，这就是他对我义子铁木真偷袭所要付出的代价。"					--完成任务npc说话的话
x201008_g_ContinueInfo="    脱黑脱是他们的首领，你不能放过他。"
--任务奖励
x201008_g_MoneyBonus = 2
--固定物品奖励，最多8种
x201008_g_ItemBonus={}

--可选物品奖励，最多8种
x201008_g_RadioItemBonus={}

--MisDescEnd
x201008_g_ExpBonus = 100
--**********************************

--任务入口函数

--**********************************

function x201008_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x201008_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x201008_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x201008_g_MissionId)
		if x201008_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x201008_g_MissionName)
			AddText(sceneId,x201008_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x201008_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死脱黑脱   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x201008_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x201008_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x201008_g_MissionName)
		     AddText(sceneId,x201008_g_MissionComplete)
		     AddMoneyBonus(sceneId, x201008_g_MoneyBonus)
		     		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x201008_g_ScriptId, x201008_g_MissionId)
                end

        elseif x201008_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x201008_g_MissionName)
                AddText(sceneId,x201008_g_MissionInfo..GetName(sceneId, selfId)..x201008_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x201008_g_MissionTarget) 
		AddMoneyBonus(sceneId, x201008_g_MoneyBonus)	
				EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x201008_g_ScriptId, x201008_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x201008_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x201008_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x201008_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x201008_g_ScriptId, x201008_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x201008_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x201008_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x201008_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==1) then
			if IsMissionHaveDone(sceneId, selfId, x201008_g_MissionIdPre) > 0 then
        	    	return 1
        end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x201008_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x201008_g_MissionId, x201008_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x201008_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x201008_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x201008_g_MissionId)
	for i, item in x201008_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x201008_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x201008_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x201008_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x201008_OnSubmit(sceneId, selfId, targetId, selectRadioId)

		                             
		ret = DelMission( sceneId, selfId, x201008_g_MissionId ) 
			if ret > 0 then                                   
				MissionCom( sceneId,selfId, x201008_g_MissionId )
				AddExp(sceneId, selfId, x201008_g_ExpBonus)   
	                        AddMoney(sceneId, selfId, x201008_g_MoneyBonus)
	   	end                                               
		
		--CallScriptFunction( x201008_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )

	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x201008_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x201008_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x201008_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x201008_g_DemandKill[1].id then 
       		    if num < x201008_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死脱黑脱   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x201008_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x201008_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x201008_OnItemChanged(sceneId, selfId, itemdataId)

end

