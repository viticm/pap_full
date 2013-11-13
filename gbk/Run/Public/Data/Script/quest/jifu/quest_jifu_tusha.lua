--屠杀

--MisDescBegin
x225008_g_ScriptId = 225008
--x225008_g_MissionIdPre =41
x225008_g_MissionId = 330
x225008_g_MissionKind = 22
x225008_g_MissionLevel = 110
x225008_g_ScriptIdNext = {ScriptId = 225009 ,LV = 1 }
x225008_g_Name	="贵由" 
x225008_g_DemandItem ={}
x225008_g_DemandKill ={{id=434,num=25}}

x225008_g_MissionName="屠杀"
x225008_g_MissionInfo="    拔都这个野种，他根本不是成吉思汗的子孙，凭什么他当主帅。更过分的是他居然把清理贵族区域地点的任务交给了他的亲信蒙哥，给我的只是洗劫贫民窟。\n \n    好事都给他自己留着了，洗劫#G贫民窟#W能得到什么呢？你去帮我杀了25个#R绝望的贫民#W吧，我懒得理他们了。"  --任务描述
x225008_g_MissionTarget="    #G贵由#W让你去#G贫民窟#W杀掉25个#R绝望的贫民#W。"		                                                                                               
x225008_g_MissionComplete="    好了，我知道了。"					--完成任务npc说话的话
x225008_g_ContinueInfo="    那些贫民还没有被杀干净吗？"
--任务奖励
x225008_g_MoneyBonus = 500

--固定物品奖励，最多8种
x225008_g_ItemBonus={}

--可选物品奖励，最多8种
x225008_g_RadioItemBonus={}

--MisDescEnd
x225008_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x225008_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x225008_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x225008_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x225008_g_MissionId)
		if x225008_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x225008_g_MissionName)
			AddText(sceneId,x225008_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x225008_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死绝望的贫民   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x225008_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x225008_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x225008_g_MissionName)
		     AddText(sceneId,x225008_g_MissionComplete)
		     AddMoneyBonus(sceneId, x225008_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x225008_g_ScriptId, x225008_g_MissionId)
                end

        elseif x225008_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x225008_g_MissionName)
                AddText(sceneId,x225008_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x225008_g_MissionTarget) 
		AddMoneyBonus(sceneId, x225008_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x225008_g_ScriptId, x225008_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x225008_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x225008_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x225008_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x225008_g_ScriptId, x225008_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x225008_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x225008_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x225008_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==16) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x225008_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x225008_g_MissionId, x225008_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x225008_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x225008_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x225008_g_MissionId)
	for i, item in pairs(x225008_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x225008_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x225008_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x225008_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x225008_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x225008_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x225008_g_MissionId)
		AddExp(sceneId, selfId, x225008_g_ExpBonus)
		AddMoney(sceneId, selfId, x225008_g_MoneyBonus)
		for i, item in pairs(x225008_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x225008_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x225008_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x225008_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x225008_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x225008_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x225008_g_DemandKill[1].id then 
       		    if num < x225008_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死绝望的贫民   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x225008_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x225008_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x225008_OnItemChanged(sceneId, selfId, itemdataId)

end

