--戈德堡矿工

--MisDescBegin
x226001_g_ScriptId = 226001
x226001_g_MissionIdPre =337
x226001_g_MissionId = 338
x226001_g_MissionKind = 23
x226001_g_MissionLevel = 115
x226001_g_ScriptIdNext = {ScriptId = 226002 ,LV = 1 }
x226001_g_Name	="贝达尔" 
x226001_g_DemandItem ={}
x226001_g_DemandKill ={{id=477,num=20}}

x226001_g_MissionName="戈德堡矿工"
x226001_g_MissionInfo="    现在敌人的步兵已经被我们牵制住，想跑也跑不掉了。真正的战斗，不象欧洲那些笨骑士一样正面冲击掉最顽强的敌人，而是最先消灭弱小的敌人，造成敌人精锐的溃退，再进行追击。\n \n    我听说敌人步兵里面有一群从戈德堡来的矿工，他们根本不是战士，而是临时招募来的，我们先从他们下手吧。"  --任务描述
x226001_g_MissionTarget="    #G贝达尔#W命你消灭20个#R戈德堡矿工#W。"		                                                                                               
x226001_g_MissionComplete="    他们果然一触即溃，这一定对敌人其它部队士气产生不利影响，我们要抓住这次机会。"					--完成任务npc说话的话
x226001_g_ContinueInfo="    一群拿着武器的矿工而已，你的头如果不是矿石做的就没有问题。"
--任务奖励
x226001_g_MoneyBonus = 500

--固定物品奖励，最多8种
x226001_g_ItemBonus={}

--可选物品奖励，最多8种
x226001_g_RadioItemBonus={}

--MisDescEnd
x226001_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x226001_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x226001_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x226001_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x226001_g_MissionId)
		if x226001_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x226001_g_MissionName)
			AddText(sceneId,x226001_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x226001_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死戈德堡矿工   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x226001_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x226001_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x226001_g_MissionName)
		     AddText(sceneId,x226001_g_MissionComplete)
		     AddMoneyBonus(sceneId, x226001_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x226001_g_ScriptId, x226001_g_MissionId)
                end

        elseif x226001_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x226001_g_MissionName)
                AddText(sceneId,x226001_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x226001_g_MissionTarget) 
		AddMoneyBonus(sceneId, x226001_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x226001_g_ScriptId, x226001_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x226001_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x226001_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x226001_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x226001_g_ScriptId, x226001_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x226001_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x226001_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x226001_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==22) then
		if IsMissionHaveDone(sceneId, selfId, x226001_g_MissionIdPre) > 0 then
        	    	return 1
        end
  end
        return 0
	
end

--**********************************

--接受

--**********************************

function x226001_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x226001_g_MissionId, x226001_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x226001_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x226001_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x226001_g_MissionId)
	for i, item in x226001_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x226001_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x226001_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x226001_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x226001_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x226001_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x226001_g_MissionId)
		AddExp(sceneId, selfId, x226001_g_ExpBonus)
		AddMoney(sceneId, selfId, x226001_g_MoneyBonus)
		CallScriptFunction( x226001_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x226001_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x226001_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x226001_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x226001_g_DemandKill[1].id then 
       		    if num < x226001_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死戈德堡矿工   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x226001_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x226001_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x226001_OnItemChanged(sceneId, selfId, itemdataId)

end

