--圣殿骑士

--MisDescBegin
x213003_g_ScriptId = 213003
--x213003_g_MissionIdPre =41
x213003_g_MissionId = 148
x213003_g_MissionKind = 24
x213003_g_MissionLevel = 125
x213003_g_ScriptIdNext = {ScriptId = 213004 ,LV = 1 }
x213003_g_Name	="合丹" 
x213003_g_DemandItem ={}
x213003_g_DemandKill ={{id=389,num=15}}

x213003_g_MissionName="圣殿骑士"
x213003_g_MissionInfo="    有一队匈牙利骑兵出城迎战，经调查他们属于圣殿骑士团。虽然他们的装备精良，骑士很英勇，不过脑袋没那么灵活，只知道向前冲。\n \n    现在他们已经被困在北谷里，在那里重骑兵的优势完全发挥不出来。你去消灭他们吧。"  --任务描述
x213003_g_MissionTarget="    #G拔都#W命你杀死15名#R圣殿骑士#W。"		                                                                                               
x213003_g_MissionComplete="    这么厚的盔甲，如果穿着盔甲摔到了水里会有什么后果？我猜就算只有没腰的水就能淹死他们吧，哈哈。"					--完成任务npc说话的话
x213003_g_ContinueInfo="    圣殿骑士是他们的精锐骑兵，能消灭他们再好不过了。"
--任务奖励
x213003_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x213003_g_ItemBonus={}

--可选物品奖励，最多8种
x213003_g_RadioItemBonus={}

--MisDescEnd
x213003_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x213003_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x213003_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x213003_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x213003_g_MissionId)
		if x213003_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x213003_g_MissionName)
			AddText(sceneId,x213003_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x213003_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死圣殿骑士   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x213003_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x213003_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x213003_g_MissionName)
		     AddText(sceneId,x213003_g_MissionComplete)
		     AddMoneyBonus(sceneId, x213003_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x213003_g_ScriptId, x213003_g_MissionId)
                end

        elseif x213003_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x213003_g_MissionName)
                AddText(sceneId,x213003_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x213003_g_MissionTarget) 
		AddMoneyBonus(sceneId, x213003_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x213003_g_ScriptId, x213003_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x213003_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x213003_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x213003_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x213003_g_ScriptId, x213003_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x213003_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x213003_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x213003_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==13) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x213003_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x213003_g_MissionId, x213003_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x213003_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x213003_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x213003_g_MissionId)
	for i, item in x213003_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x213003_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x213003_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x213003_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x213003_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x213003_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x213003_g_MissionId)
		AddExp(sceneId, selfId, x213003_g_ExpBonus)
		AddMoney(sceneId, selfId, x213003_g_MoneyBonus)
		for i, item in x213003_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x213003_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x213003_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x213003_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x213003_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x213003_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x213003_g_DemandKill[1].id then 
       		    if num < x213003_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死圣殿骑士   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x213003_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x213003_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x213003_OnItemChanged(sceneId, selfId, itemdataId)

end

