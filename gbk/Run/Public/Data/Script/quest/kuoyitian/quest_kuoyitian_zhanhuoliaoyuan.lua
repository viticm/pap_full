--战火燎原

--MisDescBegin
x214000_g_ScriptId = 214000
--x214000_g_MissionIdPre =41
x214000_g_MissionId = 107
x214000_g_MissionKind = 3
x214000_g_MissionLevel = 15
x214000_g_ScriptIdNext = {ScriptId = 214001 ,LV = 1 }
x214000_g_Name	="铁木真" 
x214000_g_DemandItem ={}
x214000_g_DemandKill ={{id=357,num=20}}

x214000_g_MissionName="战火燎原"
x214000_g_MissionInfo="    札木合的弟弟偷走了我们的马群，并出言侮辱我们，我的家臣在追回马群的时候，杀死了札木合的弟弟。\n \n    拙赤并没有做错，如果札木合还念着安答之情，根本就不会偷我的马群，也不会暗中纠集其他部落的人，对我们乞颜部发起战争。\n \n    在草原上，有很多的英雄，但是却只能有一个霸主！"  --任务描述
x214000_g_MissionInfo2="，我已经决定跟札木合开战了。在B处是归顺了札木合的塔塔儿人，杀死塔塔儿人，回来跟我复命。"
x214000_g_MissionTarget="    #G铁木真#W命你杀死在B处的20名#R塔塔儿士兵#W。"		                                                                                               
x214000_g_MissionComplete="    这次攻击作用很大。"					--完成任务npc说话的话
x214000_g_ContinueInfo="    你杀了那些塔塔儿士兵了吗？"
--任务奖励
x214000_g_MoneyBonus = 600
--固定物品奖励，最多8种
x214000_g_ItemBonus={}

--可选物品奖励，最多8种
x214000_g_RadioItemBonus={}

--MisDescEnd
x214000_g_ExpBonus = 6500
--**********************************

--任务入口函数

--**********************************

function x214000_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x214000_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x214000_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x214000_g_MissionId)
		if x214000_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x214000_g_MissionName)
			AddText(sceneId,x214000_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x214000_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死塔塔儿士兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x214000_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x214000_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x214000_g_MissionName)
		     AddText(sceneId,x214000_g_MissionComplete)
		     AddMoneyBonus(sceneId, x214000_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x214000_g_ScriptId, x214000_g_MissionId)
                end

        elseif x214000_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x214000_g_MissionName)
                AddText(sceneId,x214000_g_MissionInfo..GetName(sceneId, selfId)..x214000_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x214000_g_MissionTarget) 
		AddMoneyBonus(sceneId, x214000_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x214000_g_ScriptId, x214000_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x214000_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x214000_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x214000_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x214000_g_ScriptId, x214000_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x214000_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x214000_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x214000_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==14) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x214000_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x214000_g_MissionId, x214000_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x214000_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x214000_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x214000_g_MissionId)
	for i, item in x214000_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x214000_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x214000_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x214000_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x214000_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x214000_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x214000_g_MissionId)
		AddExp(sceneId, selfId, x214000_g_ExpBonus)
		AddMoney(sceneId, selfId, x214000_g_MoneyBonus)
		for i, item in x214000_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x214000_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x214000_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x214000_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x214000_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x214000_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x214000_g_DemandKill[1].id then 
       		    if num < x214000_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死塔塔儿士兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x214000_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x214000_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x214000_OnItemChanged(sceneId, selfId, itemdataId)

end

