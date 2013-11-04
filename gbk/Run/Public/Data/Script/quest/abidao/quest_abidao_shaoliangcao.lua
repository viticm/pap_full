--烧粮草

--MisDescBegin
x203010_g_ScriptId = 203010
x203010_g_MissionIdPre =77
x203010_g_MissionId = 78
x203010_g_MissionKind = 13
x203010_g_MissionLevel = 50
--x203010_g_ScriptIdNext = {ScriptId = 203010 ,LV = 1 }
x203010_g_Name	="速不台"
x203010_g_Name2	="粮仓" 
--x203010_g_noDemandItem ={{id=13010007,num=1}}
x203010_g_DemandKill ={{id=330,num=15}}	

x203010_g_MissionName="烧粮草"
x203010_g_MissionInfo="    好，太好了！没了战马，他们的骑兵就无法发挥作用，我们的下一步，就是要烧了他们的粮仓，让他们没有力气作战。\n \n    粮仓的位置我已经查清楚了。不过，烧粮仓可不同杀马这么简单，魔诃魔在粮仓附近埋伏了两队人马。\n \n    我们人手太少，不能惊动了这两队人，你要先把附近的那15名#R阿碧岛哨兵#W给解决了，再烧粮仓。"  --任务描述
x203010_g_MissionTarget="    处杀死15名#R阿碧岛哨兵#W，点燃#G粮仓#W然后回到#G速不台#W处。"		
x203010_g_MissionComplete="    太高兴了，我看到他们粮仓的大火了。"					--完成任务npc说话的话
x203010_g_ContinueInfo="    粮仓易燃，小心别自焚，赶紧去吧。"
--任务奖励
x203010_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x203010_g_ItemBonus={}

--可选物品奖励，最多8种
x203010_g_RadioItemBonus={}

--MisDescEnd
x203010_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x203010_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x203010_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x203010_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x203010_g_MissionId)
		if x203010_CheckSubmit(sceneId, selfId, targetId) <= 0 then
			if (GetName(sceneId,targetId)==x203010_g_Name) then
	                        BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x203010_g_MissionName)
				AddText(sceneId,x203010_g_ContinueInfo)
			        AddText(sceneId,"#Y任务目标#W") 
				AddText(sceneId,x203010_g_MissionTarget) 
				AddText(sceneId,format("\n    杀死阿碧岛哨兵   %d/%d\n    烧毁粮仓   %d/1", GetMissionParam(sceneId,selfId,misIndex,0),x203010_g_DemandKill[1].num, GetMissionParam(sceneId,selfId,misIndex,1) ))
				EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
			end
		end

		     
                if x203010_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x203010_g_MissionName)
		     AddText(sceneId,x203010_g_MissionComplete)
		     AddMoneyBonus(sceneId, x203010_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x203010_g_ScriptId, x203010_g_MissionId)
                end

        elseif x203010_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x203010_g_MissionName)
                AddText(sceneId,x203010_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x203010_g_MissionTarget) 
		AddMoneyBonus(sceneId, x203010_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x203010_g_ScriptId, x203010_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x203010_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x203010_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x203010_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x203010_g_ScriptId, x203010_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x203010_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x203010_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x203010_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==3) then
        	 	if IsMissionHaveDone(sceneId, selfId, x203010_g_MissionIdPre) > 0 then
                    			return 1
                    	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x203010_OnAccept(sceneId, selfId)

	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x203010_g_MissionId, x203010_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x203010_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
	
end



--**********************************

--放弃

--**********************************

function x203010_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x203010_g_MissionId)
	for i, item in x203010_g_noDemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x203010_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x203010_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x203010_g_DemandKill[1].num then
		if GetMissionParam(sceneId,selfId,misIndex,1) == 1 then
	        	return 1
	        end
	end
	return 0

end



--**********************************

--提交

--**********************************

function x203010_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x203010_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x203010_g_MissionId)
		AddExp(sceneId, selfId, x203010_g_ExpBonus)
		AddMoney(sceneId, selfId, x203010_g_MoneyBonus)
		for i, item in x203010_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x203010_g_noDemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x203010_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x203010_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x203010_g_MissionId) >= 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x203010_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x203010_g_DemandKill[1].id then 
       		    if num < x203010_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死阿碧岛哨兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x203010_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x203010_OnEnterArea(sceneId, selfId, zoneId)
	

end

function x203010_OnLeaveArea(sceneId, selfId )
	
end

function x203010_OnTimer(sceneId, selfId )

end



--**********************************

--道具改变

--**********************************

function x203010_OnItemChanged(sceneId, selfId, itemdataId)

end
