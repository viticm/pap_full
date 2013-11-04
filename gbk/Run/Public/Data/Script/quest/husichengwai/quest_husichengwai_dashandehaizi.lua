--大山的孩子

--MisDescBegin
x204009_g_ScriptId = 204009
--x204009_g_MissionIdPre =41
x204009_g_MissionId = 104
x204009_g_MissionKind = 9
x204009_g_MissionLevel = 45
x204009_g_ScriptIdNext = {ScriptId = 204010 ,LV = 1 }
x204009_g_Name	="忽必来" 
x204009_g_DemandItem ={}
x204009_g_DemandKill ={{id=352,num=10}}

x204009_g_MissionName="大山的孩子"
x204009_g_MissionInfo="    大山的孩子被屈出律关在一个营寨里，那里的守卫虽然不多，但是大山毫无办法。\n \n    "  --任务描述
x204009_g_MissionInfo2="，大山是上一任国王耶律直的贴身护卫，屈出律关着他的孩子，一定是想威胁他，这是我们的机会。营寨就在南岭的左下角，有10名#R契丹刀手#W看守，杀了他们，救出孩子。"
x204009_g_MissionTarget="    在南岭的营寨有10名#R契丹刀手#W，#G忽必来#W让你杀了他们，才能救出孩子。"		                                                                                               
x204009_g_MissionComplete="    大山让我替他说谢谢。"					--完成任务npc说话的话
x204009_g_ContinueInfo="    孩子救出来了吗？"
--任务奖励
x204009_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x204009_g_ItemBonus={}

--可选物品奖励，最多8种
x204009_g_RadioItemBonus={}

--MisDescEnd
x204009_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x204009_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x204009_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x204009_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x204009_g_MissionId)
		if x204009_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x204009_g_MissionName)
			AddText(sceneId,x204009_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x204009_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死契丹刀手   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x204009_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x204009_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x204009_g_MissionName)
		     AddText(sceneId,x204009_g_MissionComplete)
		     AddMoneyBonus(sceneId, x204009_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x204009_g_ScriptId, x204009_g_MissionId)
                end

        elseif x204009_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x204009_g_MissionName)
                AddText(sceneId,x204009_g_MissionInfo..GetName(sceneId, selfId)..x204009_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x204009_g_MissionTarget) 
		AddMoneyBonus(sceneId, x204009_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x204009_g_ScriptId, x204009_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x204009_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x204009_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x204009_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x204009_g_ScriptId, x204009_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x204009_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x204009_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x204009_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==4) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x204009_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x204009_g_MissionId, x204009_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x204009_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x204009_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x204009_g_MissionId)
	for i, item in x204009_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x204009_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x204009_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x204009_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x204009_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x204009_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x204009_g_MissionId)
		AddExp(sceneId, selfId, x204009_g_ExpBonus)
		AddMoney(sceneId, selfId, x204009_g_MoneyBonus)
		for i, item in x204009_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x204009_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x204009_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x204009_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x204009_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x204009_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x204009_g_DemandKill[1].id then 
       		    if num < x204009_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死契丹刀手   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x204009_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x204009_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x204009_OnItemChanged(sceneId, selfId, itemdataId)

end

