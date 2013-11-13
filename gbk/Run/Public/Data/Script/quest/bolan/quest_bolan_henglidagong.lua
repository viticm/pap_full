--亨利大公

--MisDescBegin
x226005_g_ScriptId = 226005
x226005_g_MissionIdPre =340
x226005_g_MissionId = 341
x226005_g_MissionKind = 23
x226005_g_MissionLevel = 115
x226005_g_ScriptIdNext = {ScriptId = 226006 ,LV = 1 }
x226005_g_Name	="海都" 
x226005_g_DemandItem ={}
x226005_g_DemandKill ={{id=481,num=1}}

x226005_g_MissionName="亨利大公"
x226005_g_MissionInfo="    敌人联军的总指挥就是#R亨利大公#W，短短时间之内他就召集了几万的军队。这个人不简单，不能让他逃了。\n \n    他周围的骑士已经被我们杀的差不多了，你去杀了他吧。\n \n    注意，虽然他指挥战斗是一个白痴，但是听说他的剑术不错，你要小心。"  --任务描述
x226005_g_MissionTarget="    杀死#R亨利大公#W后向#G海都#W复命。"		                                                                                               
x226005_g_MissionComplete="    我已经听说了你的英勇事迹，领取你的奖励吧。这些就是为勇士准备的。"					--完成任务npc说话的话
x226005_g_ContinueInfo="    杀了他波德联军就会瓦解。"
--任务奖励
x226005_g_MoneyBonus = 500

--固定物品奖励，最多8种
x226005_g_ItemBonus={}

--可选物品奖励，最多8种
x226005_g_RadioItemBonus={}

--MisDescEnd
x226005_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x226005_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x226005_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x226005_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x226005_g_MissionId)
		if x226005_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x226005_g_MissionName)
			AddText(sceneId,x226005_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x226005_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死亨利大公   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x226005_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x226005_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x226005_g_MissionName)
		     AddText(sceneId,x226005_g_MissionComplete)
		     AddMoneyBonus(sceneId, x226005_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x226005_g_ScriptId, x226005_g_MissionId)
                end

        elseif x226005_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x226005_g_MissionName)
                AddText(sceneId,x226005_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x226005_g_MissionTarget) 
		AddMoneyBonus(sceneId, x226005_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x226005_g_ScriptId, x226005_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x226005_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x226005_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x226005_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x226005_g_ScriptId, x226005_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x226005_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x226005_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x226005_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==22) then
		if IsMissionHaveDone(sceneId, selfId, x226005_g_MissionIdPre) > 0 then
        	    	return 1
        end
  end
        return 0
	
end

--**********************************

--接受

--**********************************

function x226005_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x226005_g_MissionId, x226005_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x226005_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x226005_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x226005_g_MissionId)
	for i, item in pairs(x226005_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x226005_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x226005_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x226005_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x226005_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x226005_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x226005_g_MissionId)
		AddExp(sceneId, selfId, x226005_g_ExpBonus)
		AddMoney(sceneId, selfId, x226005_g_MoneyBonus)
		--CallScriptFunction( x226005_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x226005_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x226005_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x226005_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x226005_g_DemandKill[1].id then 
       		    if num < x226005_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死亨利大公   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x226005_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x226005_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x226005_OnItemChanged(sceneId, selfId, itemdataId)

end

