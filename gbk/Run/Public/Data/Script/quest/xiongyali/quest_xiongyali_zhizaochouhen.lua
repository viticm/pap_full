--制造仇恨

--MisDescBegin
x213000_g_ScriptId = 213000
--x213000_g_MissionIdPre =41
x213000_g_MissionId = 145
x213000_g_MissionKind = 24
x213000_g_MissionLevel = 125
--x213000_g_ScriptIdNext = {ScriptId = 213001 ,LV = 1 }
x213000_g_Name	="速不台" 
x213000_g_DemandItem ={}
x213000_g_DemandKill ={{id=398,num=1}}

x213000_g_MissionName="制造仇恨"
x213000_g_MissionInfo="    还记得在钦察被我们吓跑的那个酋长库丹吗？他跑到这里来寻求贝拉的庇护了，贝拉居然也敢收留他。收留我们的敌人的人，就是我们的敌人。\n \n    现在钦察人和匈牙利人联合在一起，不过他们生活习惯相差太多，虽然库丹和贝拉是诚心的联合，但是他们的人民不这么认为。只要把#R库丹#W暗杀了，他们的联盟就会瓦解。\n \n    勇士，我想不出比你更好的人选来执行这个任务了，你愿意去吗？"  --任务描述
x213000_g_MissionTarget="    执行#G速不台#W的计划，暗杀#R库丹#W。"		                                                                                               
x213000_g_MissionComplete="    做得比我想象中的要漂亮，愚蠢的钦察人以为是贝拉暗杀了库丹，立刻反叛。现在钦察人向南去了，一路上烧杀抢掠，还与匈牙利的援军大打出手。匈牙利人有苦头吃了。"					--完成任务npc说话的话
x213000_g_ContinueInfo="    只要库丹一死，钦察人就不会安心呆在匈牙利！"
--任务奖励
x213000_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x213000_g_ItemBonus={}

--可选物品奖励，最多8种
x213000_g_RadioItemBonus={}

--MisDescEnd
x213000_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x213000_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x213000_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x213000_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x213000_g_MissionId)
		if x213000_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x213000_g_MissionName)
			AddText(sceneId,x213000_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x213000_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死库丹   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0) ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x213000_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x213000_g_MissionName)
		     AddText(sceneId,x213000_g_MissionComplete)
		     AddMoneyBonus(sceneId, x213000_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x213000_g_ScriptId, x213000_g_MissionId)
                end

        elseif x213000_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x213000_g_MissionName)
                AddText(sceneId,x213000_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x213000_g_MissionTarget) 
		AddMoneyBonus(sceneId, x213000_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x213000_g_ScriptId, x213000_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x213000_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x213000_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x213000_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x213000_g_ScriptId, x213000_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x213000_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x213000_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x213000_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==13) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x213000_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x213000_g_MissionId, x213000_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x213000_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x213000_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x213000_g_MissionId)
	for i, item in pairs(x213000_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x213000_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x213000_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x213000_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x213000_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x213000_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x213000_g_MissionId)
		AddExp(sceneId, selfId, x213000_g_ExpBonus)
		AddMoney(sceneId, selfId, x213000_g_MoneyBonus)
		for i, item in pairs(x213000_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x213000_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x213000_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x213000_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x213000_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x213000_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x213000_g_DemandKill[1].id then 
       		    if num < x213000_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死库丹   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x213000_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x213000_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x213000_OnItemChanged(sceneId, selfId, itemdataId)

end

