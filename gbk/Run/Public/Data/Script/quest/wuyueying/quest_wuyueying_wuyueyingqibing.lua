--乌月营骑兵

--MisDescBegin
x217013_g_ScriptId = 217013
--x217013_g_MissionIdPre =41
x217013_g_MissionId = 185
x217013_g_MissionKind = 6
x217013_g_MissionLevel = 30
--x217013_g_ScriptIdNext = {ScriptId = 217001 ,LV = 1 }
x217013_g_Name	="赤老温" 
x217013_g_DemandItem ={}
x217013_g_DemandKill ={{id=459,num=15}}

x217013_g_MissionName="乌月营骑兵"
x217013_g_MissionInfo="    千家奴是金国最诡异的将军，他从来不出面指挥，没有人见过他的真相，就连金国著名的大将军胡沙虎都惧怕他三分，不过，这样一个人，居然甘愿当一个监军！\n \n    我对这个人非常感兴趣，现在终于有机会跟他交手。\n \n    你看到#G大粮仓#W西面的那些骑兵了吗？论马上的功夫，那些连马都坐不稳的金兵，无法跟我们比，但是，千家奴亲自训练的兵却厉害之极！\n \n    去会会那些骑兵，我要看看他们的实力。"  --任务描述
x217013_g_MissionTarget="    消灭#G大粮仓#W西面的15名#R乌月营骑兵#W，#G赤老温#W要看看千家奴的实力。"		                                                                                               
x217013_g_MissionComplete="    哈哈哈，看看，他们的脸色都变青了。"					--完成任务npc说话的话
x217013_g_ContinueInfo="    那些骑兵非常厉害，你要小心。"
--任务奖励
x217013_g_MoneyBonus = 500

--固定物品奖励，最多8种
x217013_g_ItemBonus={}

--可选物品奖励，最多8种
x217013_g_RadioItemBonus={}

--MisDescEnd
x217013_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x217013_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x217013_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x217013_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x217013_g_MissionId)
		if x217013_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x217013_g_MissionName)
			AddText(sceneId,x217013_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x217013_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死乌月营骑兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x217013_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x217013_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x217013_g_MissionName)
		     AddText(sceneId,x217013_g_MissionComplete)
		     AddMoneyBonus(sceneId, x217013_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x217013_g_ScriptId, x217013_g_MissionId)
                end

        elseif x217013_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x217013_g_MissionName)
                AddText(sceneId,x217013_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x217013_g_MissionTarget) 
		AddMoneyBonus(sceneId, x217013_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x217013_g_ScriptId, x217013_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x217013_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x217013_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x217013_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x217013_g_ScriptId, x217013_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x217013_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x217013_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x217013_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==20) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x217013_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x217013_g_MissionId, x217013_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x217013_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x217013_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x217013_g_MissionId)
	for i, item in pairs(x217013_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x217013_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x217013_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x217013_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x217013_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x217013_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x217013_g_MissionId)
		AddExp(sceneId, selfId, x217013_g_ExpBonus)
		AddMoney(sceneId, selfId, x217013_g_MoneyBonus)
		for i, item in pairs(x217013_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x217013_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x217013_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x217013_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x217013_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x217013_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x217013_g_DemandKill[1].id then 
       		    if num < x217013_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死乌月营骑兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x217013_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x217013_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x217013_OnItemChanged(sceneId, selfId, itemdataId)

end

