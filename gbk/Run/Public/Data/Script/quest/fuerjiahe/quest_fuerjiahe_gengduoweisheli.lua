--更多威慑力

--MisDescBegin
x223010_g_ScriptId = 223010
x223010_g_MissionIdPre =301
x223010_g_MissionId = 302
x223010_g_MissionKind = 20
x223010_g_MissionLevel = 100
x223010_g_ScriptIdNext = {ScriptId = 223011 ,LV = 1 }
x223010_g_Name	="速不台" 
x223010_g_DemandItem ={}
x223010_g_DemandKill ={{id=449,num=10},{id=448,num=10}}

x223010_g_MissionName="更多威慑力"
x223010_g_MissionInfo="     用不了多久，我们将会攻破钦察人的防御，杀死他们的领袖八赤蛮。"  --任务描述
x223010_g_MissionInfo2="，我需要更多的威慑力，让来救援的酋长库丹知难而退！\n \n    在右侧（）处我们的勇士已经和库丹的军队开战，你要前去支援，消灭10个#R钦察投石机指挥官#W和10个#R钦察骑士#W。"
x223010_g_MissionTarget="    解决掉10名#R钦察投石机指挥官#W和10名#R钦察骑士#W后再回来找#G速不台#W"		                                                                                               
x223010_g_MissionComplete="    我就知道，库丹这个胆小鬼不会为了八赤蛮卖命，他们不会像我们蒙古人这名团结！你又立了一功，勇士！"					--完成任务npc说话的话
x223010_g_ContinueInfo="    一定要让库丹领教我大蒙古国的实力！"
--任务奖励
x223010_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x223010_g_ItemBonus={}

--可选物品奖励，最多8种
x223010_g_RadioItemBonus={}

--MisDescEnd
x223010_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x223010_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x223010_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x223010_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x223010_g_MissionId)
		if x223010_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x223010_g_MissionName)
			AddText(sceneId,x223010_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x223010_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死钦察投石机指挥官   %d/%d\n    杀死钦察骑士   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x223010_g_DemandKill[1].num, GetMissionParam(sceneId,selfId,misIndex,1),x223010_g_DemandKill[2].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x223010_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x223010_g_MissionName)
		     AddText(sceneId,x223010_g_MissionComplete)
		     AddMoneyBonus(sceneId, x223010_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x223010_g_ScriptId, x223010_g_MissionId)
                end

        elseif x223010_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x223010_g_MissionName)
                AddText(sceneId,x223010_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x223010_g_MissionTarget) 
		AddMoneyBonus(sceneId, x223010_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x223010_g_ScriptId, x223010_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x223010_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x223010_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x223010_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x223010_g_ScriptId, x223010_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x223010_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x223010_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x223010_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==17) then
		if IsMissionHaveDone(sceneId, selfId, x223010_g_MissionIdPre) > 0 then
		    	return 1
		end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x223010_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x223010_g_MissionId, x223010_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x223010_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x223010_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x223010_g_MissionId)
	for i, item in x223010_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x223010_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x223010_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x223010_g_DemandKill[1].num then
		if GetMissionParam(sceneId,selfId,misIndex,1) == x223010_g_DemandKill[2].num then
	        	return 1
	        end
	end
	return 0

end



--**********************************

--提交

--**********************************

function x223010_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x223010_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x223010_g_MissionId)
		AddExp(sceneId, selfId, x223010_g_ExpBonus)
		AddMoney(sceneId, selfId, x223010_g_MoneyBonus)
		for i, item in x223010_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x223010_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x223010_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x223010_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x223010_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x223010_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x223010_g_DemandKill[1].id then 
       		    if num < x223010_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死钦察投石机指挥官   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x223010_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
        num2 = GetMissionParam(sceneId,selfId,misIndex,1) 
	 	 if objdataId == x223010_g_DemandKill[2].id then 
       		    if num2 < x223010_g_DemandKill[2].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,1,num2+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死钦察骑士   %d/%d", GetMissionParam(sceneId,selfId,misIndex,1),x223010_g_DemandKill[2].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
      end  

end



--**********************************

--进入区域事件

--**********************************

function x223010_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x223010_OnItemChanged(sceneId, selfId, itemdataId)

end

