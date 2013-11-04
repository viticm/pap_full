--证明实力

--MisDescBegin
x207011_g_ScriptId = 207011
x207011_g_MissionIdPre =11
x207011_g_MissionId = 12
x207011_g_MissionKind = 1
x207011_g_ScriptIdNext = {ScriptId = 207012 ,LV = 1 }
x207011_g_Name	="赤老温" 
x207011_g_DemandItem ={}
x207011_g_DemandKill ={id=279,num=15}

x207011_g_MissionName="证明实力"
x207011_g_MissionInfo="    嘿嘿，杀敌的时候，要把敌人看成是你手里的羊羔，你就会战无不胜，不能有任何犹豫和仁慈……那些#R鬼仆#W并不神秘，只是鬼鬼祟祟的，嗯，是的，他们确实有点本领，不过遇上了我们……，你明白我在说什么吗？我也不明白自己说什么……\n \n用事实来证明一切吧，外面有一队流窜的金兵，交给你了，记住了，敌人是你手里的羔羊！"  --任务描述
x207011_g_MissionTarget="    杀掉15个#R流窜的金兵#W"		                                                                                               
x207011_g_MissionComplete="    恭喜你，体会到了真正的含义，只要眼里没有敌人，自己的真正潜能挥发出来！看来，该是告诉你关于#R神秘人#W的事情了。"					--完成任务npc说话的话
x207011_g_ContinueInfo="    你还是没明白真正的含义……"
--任务奖励
x207011_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x207011_g_ItemBonus={}

--可选物品奖励，最多8种
x207011_g_RadioItemBonus={}

--MisDescEnd
--**********************************

--任务入口函数

--**********************************

function x207011_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207011_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207011_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x207011_g_MissionId)
		if x207011_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x207011_g_MissionName)
			AddText(sceneId,x207011_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x207011_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死流窜的金兵   %d/15", GetMissionParam(sceneId,selfId,misIndex,0) ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x207011_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x207011_g_MissionName)
		     AddText(sceneId,x207011_g_MissionComplete)
		     AddText(sceneId,"#Y任务目标#W") 
		     AddText(sceneId,x207011_g_MissionTarget) 
		     AddText(sceneId,format("\n    杀死流窜的金兵   %d/15", GetMissionParam(sceneId,selfId,misIndex,0) ))
                     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x207011_g_ScriptId, x207011_g_MissionId)
                end

        elseif x207011_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x207011_g_MissionName)
                AddText(sceneId,x207011_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x207011_g_MissionTarget) 
		AddMoneyBonus(sceneId, x207011_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207011_g_ScriptId, x207011_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207011_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207011_g_MissionId) > 0 then
		return 0
	end
	--如果已接此任务
	if  x207011_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207011_g_ScriptId, x207011_g_MissionName)
	end
	return 0
	
end



--**********************************

--检测接受条件

--**********************************

function x207011_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207011_g_Name) then
		return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207011_CheckPushList(sceneId, selfId, targetId)
        if IsMissionHaveDone(sceneId, selfId, x207011_g_MissionIdPre) > 0 then
                return 1
        end
		
end

--**********************************

--接受

--**********************************

function x207011_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x207011_g_MissionId, x207011_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x207011_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x207011_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207011_g_MissionId)
	for i, item in x207011_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x207011_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x207011_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == 15 then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207011_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207011_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207011_g_MissionId)
		AddExp(sceneId, selfId, x207011_g_ExpBonus)
		AddMoney(sceneId, selfId, x207011_g_MoneyBonus)
		for i, item in x207011_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x207011_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x207011_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207011_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x207011_g_MissionId) >= 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x207011_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
       		 if objdataId == x207011_g_DemandKill.id then 
       		    if num < 15 then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死流窜的金兵   %d/15", GetMissionParam(sceneId,selfId,misIndex,0) )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x207011_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207011_OnItemChanged(sceneId, selfId, itemdataId)

end

