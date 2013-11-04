--十字军

--MisDescBegin
x226002_g_ScriptId = 226002
x226002_g_MissionIdPre =338
x226002_g_MissionId = 339
x226002_g_MissionKind = 23
x226002_g_MissionLevel = 115
x226002_g_ScriptIdNext = {ScriptId = 226002 ,LV = 1 }
x226002_g_Name	="贝达尔" 
x226002_g_DemandItem ={}
x226002_g_DemandKill ={{id=478,num=30}}

x226002_g_MissionName="十字军"
x226002_g_MissionInfo="    敌人的步兵几乎都没有战斗力了，可是出乎意料的是有一支步兵居然还在顽抗。\n \n    他们胸前都有一个十字标志，应该是十字军，这些人战斗起来都非常狂热，不能让他们活下来。"  --任务描述
x226002_g_MissionTarget="    替#G贝达尔#W杀死30个的#R十字军狂热者#W。"		                                                                                               
x226002_g_MissionComplete="    完美的突袭，看来除了狂热之外，这些十字军一无是处。"					--完成任务npc说话的话
x226002_g_ContinueInfo="    让他们见上帝去吧。"
--任务奖励
x226002_g_MoneyBonus = 500

--固定物品奖励，最多8种
x226002_g_ItemBonus={}

--可选物品奖励，最多8种
x226002_g_RadioItemBonus={}

--MisDescEnd
x226002_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x226002_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x226002_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x226002_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x226002_g_MissionId)
		if x226002_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x226002_g_MissionName)
			AddText(sceneId,x226002_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x226002_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死十字军狂热者   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x226002_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x226002_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x226002_g_MissionName)
		     AddText(sceneId,x226002_g_MissionComplete)
		     AddMoneyBonus(sceneId, x226002_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x226002_g_ScriptId, x226002_g_MissionId)
                end

        elseif x226002_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x226002_g_MissionName)
                AddText(sceneId,x226002_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x226002_g_MissionTarget) 
		AddMoneyBonus(sceneId, x226002_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x226002_g_ScriptId, x226002_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x226002_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x226002_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x226002_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x226002_g_ScriptId, x226002_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x226002_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x226002_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x226002_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==22) then
		if IsMissionHaveDone(sceneId, selfId, x226002_g_MissionIdPre) > 0 then
        	    	return 1
        end
  end
        return 0
	
end

--**********************************

--接受

--**********************************

function x226002_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x226002_g_MissionId, x226002_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x226002_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x226002_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x226002_g_MissionId)
	for i, item in x226002_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x226002_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x226002_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x226002_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x226002_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x226002_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x226002_g_MissionId)
		AddExp(sceneId, selfId, x226002_g_ExpBonus)
		AddMoney(sceneId, selfId, x226002_g_MoneyBonus)
		--CallScriptFunction( x226002_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x226002_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x226002_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x226002_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x226002_g_DemandKill[1].id then 
       		    if num < x226002_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死十字军狂热者   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x226002_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x226002_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x226002_OnItemChanged(sceneId, selfId, itemdataId)

end

