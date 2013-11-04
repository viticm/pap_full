--追杀桑昆

--MisDescBegin
x202003_g_ScriptId = 202003
x202003_g_MissionIdPre =121
x202003_g_MissionId = 122
x202003_g_MissionKind = 4
x202003_g_MissionLevel = 20
--x202003_g_ScriptIdNext = {ScriptId = 202004 ,LV = 1 }
x202003_g_Name	="铁木真"
x202003_g_DemandItem ={}
x202003_g_DemandKill ={{id=369,num=1}}

x202003_g_MissionName="追杀桑昆"
x202003_g_MissionInfo="    恶魔占据了#R桑昆#W的心，蒙蔽了王汗的慧眼，他们挑起了这场战争，杀了我的子民，抢走了财物。\n \n    我以长生天的名义发誓，一定要讨回公道，要让他们付出代价！\n \n    桑昆往合阑湖的方向跑了，他们试图再次聚集起来攻击我们，我绝不能让他得逞，"  --任务描述
x202003_g_MissionInfo2="，你领我的命令，到合阑湖西侧去消灭他。"
x202003_g_MissionTarget="    #G铁木真#W命你到合阑湖西侧杀死#R桑昆#W。"		                                                                                               
x202003_g_MissionComplete="    这就是他们的代价。"					--完成任务npc说话的话
x202003_g_ContinueInfo="    桑昆是个祸害，你要杀了他。"
--任务奖励
x202003_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x202003_g_ItemBonus={}

--可选物品奖励，最多8种
x202003_g_RadioItemBonus={}

--MisDescEnd
x202003_g_ExpBonus = 6500
--**********************************

--任务入口函数

--**********************************

function x202003_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x202003_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x202003_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x202003_g_MissionId)
		if x202003_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x202003_g_MissionName)
			AddText(sceneId,x202003_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x202003_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死桑昆   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x202003_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x202003_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x202003_g_MissionName)
		     AddText(sceneId,x202003_g_MissionComplete)
		     AddMoneyBonus(sceneId, x202003_g_MoneyBonus)
                     EndEvent()
		     DispatchMissionContinueInfo(sceneId, selfId, targetId, x202003_g_ScriptId, x202003_g_MissionId)
                end

        elseif x202003_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x202003_g_MissionName)
                AddText(sceneId,x202003_g_MissionInfo..GetName(sceneId, selfId)..x202003_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x202003_g_MissionTarget) 
		AddMoneyBonus(sceneId, x202003_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x202003_g_ScriptId, x202003_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x202003_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x202003_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x202003_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x202003_g_ScriptId, x202003_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x202003_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x202003_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x202003_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==2) then
		if IsMissionHaveDone(sceneId, selfId, x202003_g_MissionIdPre) > 0 then
					return 1
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x202003_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x202003_g_MissionId, x202003_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x202003_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x202003_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x202003_g_MissionId)
	for i, item in x202003_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x202003_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x202003_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x202003_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x202003_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x202003_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x202003_g_MissionId)
		AddExp(sceneId, selfId, x202003_g_ExpBonus)
		AddMoney(sceneId, selfId, x202003_g_MoneyBonus)
		for i, item in x202003_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x202003_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x202003_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x202003_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x202003_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x202003_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x202003_g_DemandKill[1].id then 
       		    if num < x202003_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死桑昆   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x202003_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x202003_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x202003_OnItemChanged(sceneId, selfId, itemdataId)

end

