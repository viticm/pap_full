--斩草除根

--MisDescBegin
x214006_g_ScriptId = 214006
--x214006_g_MissionIdPre =41
x214006_g_MissionId = 113
x214006_g_MissionKind = 3
x214006_g_MissionLevel = 15
--x214006_g_ScriptIdNext = {ScriptId = 204001 ,LV = 1 }
x214006_g_Name	="阿勒坛" 
x214006_g_DemandItem ={}
x214006_g_DemandKill ={{id=361,num=10}}

x214006_g_MissionName="斩草除根"
x214006_g_MissionInfo="    低贱的蔑里乞人曾经偷袭过我们，抢走了铁木真的妻子，现在，那些残兵败将又投靠了札木合。\n \n    他们肮脏的灵魂，是不会得到好下藏的，"  --任务描述
x214006_g_MissionInfo2="，我们要铲草除根，不能放过他们，他们就集中在e处。"
x214006_g_MissionTarget="    蔑里乞人人投靠了札木合，他们集中在e处一带，#G阿勒坛#W将军要你去杀死10个#R蔑里乞勇士#W。"		                                                                                               
x214006_g_MissionComplete="    很高兴能看到你安全的回来。"					--完成任务npc说话的话
x214006_g_ContinueInfo="    不要放过蔑里乞人，我需要他们的人头。"
--任务奖励
x214006_g_MoneyBonus = 200
--固定物品奖励，最多8种
x214006_g_ItemBonus={}

--可选物品奖励，最多8种
x214006_g_RadioItemBonus={}

--MisDescEnd
x214006_g_ExpBonus = 1500
--**********************************

--任务入口函数

--**********************************

function x214006_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x214006_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x214006_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x214006_g_MissionId)
		if x214006_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x214006_g_MissionName)
			AddText(sceneId,x214006_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x214006_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死蔑里乞勇士   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x214006_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x214006_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x214006_g_MissionName)
		     AddText(sceneId,x214006_g_MissionComplete)
		     AddMoneyBonus(sceneId, x214006_g_MoneyBonus)	
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x214006_g_ScriptId, x214006_g_MissionId)
                end

        elseif x214006_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x214006_g_MissionName)
                AddText(sceneId,x214006_g_MissionInfo..GetName(sceneId, selfId)..x214006_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x214006_g_MissionTarget) 
		AddMoneyBonus(sceneId, x214006_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x214006_g_ScriptId, x214006_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x214006_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x214006_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x214006_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x214006_g_ScriptId, x214006_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x214006_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x214006_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x214006_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==14) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x214006_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x214006_g_MissionId, x214006_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x214006_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x214006_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x214006_g_MissionId)
	for i, item in pairs(x214006_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x214006_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x214006_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x214006_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x214006_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x214006_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x214006_g_MissionId)
		AddExp(sceneId, selfId, x214006_g_ExpBonus)
		AddMoney(sceneId, selfId, x214006_g_MoneyBonus)
		for i, item in pairs(x214006_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x214006_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x214006_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x214006_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x214006_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x214006_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x214006_g_DemandKill[1].id then 
       		    if num < x214006_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死蔑里乞勇士   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x214006_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x214006_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x214006_OnItemChanged(sceneId, selfId, itemdataId)

end

