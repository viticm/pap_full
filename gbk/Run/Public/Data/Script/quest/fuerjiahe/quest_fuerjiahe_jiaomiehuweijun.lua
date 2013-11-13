--剿灭护卫军

--MisDescBegin
x223002_g_ScriptId = 223002
--x223002_g_MissionIdPre =41
x223002_g_MissionId = 294
x223002_g_MissionKind = 20
x223002_g_MissionLevel = 100
x223002_g_ScriptIdNext = {ScriptId = 223003 ,LV = 1 }
x223002_g_Name	="蒙哥" 
x223002_g_DemandItem ={}
x223002_g_DemandKill ={{id=440,num=20}}

x223002_g_MissionName="剿灭护卫军"
x223002_g_MissionInfo="    年轻人，很高兴见到你来为我效力，你成为我杀敌先锋的队员之一后，一定要按照我的纪律去做。\n \n    请你记住，我们是要征服他们，而不是毁灭他们，你要毫不犹豫的杀死你的敌人，但是却不能对百姓下手。\n \n    我们的目的，就是要吸取西方文明的精华，同时把我们的东方文明带到这里，让东西方融合，构成我大蒙古国。\n \n    任何人在进入钦察国的时候，都不允许毁掉他们的书籍，这是我们了解西方，得到他们智慧的最好途径。\n \n    很快，我们就能如愿了，"  --任务描述
x223002_g_MissionInfo2="，（）处的是钦察的领袖八赤蛮统帅的护卫军，去消灭他们，为我们的理想而奋斗！"
x223002_g_MissionTarget="    到山谷中杀死20个#R钦察残兵#W。"		                                                                                               
x223002_g_MissionComplete="    我喜欢听到敌人那低沉的哀叫，喜欢闻到敌人的鲜血味，能让人有很强的征服感。"					--完成任务npc说话的话
x223002_g_ContinueInfo="    总有一天你会明白我说的话，去完成你的使命吧，征服那些护卫军！"
--任务奖励
x223002_g_MoneyBonus = 500

--固定物品奖励，最多8种
x223002_g_ItemBonus={}

--可选物品奖励，最多8种
x223002_g_RadioItemBonus={}

--MisDescEnd
x223002_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x223002_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x223002_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x223002_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x223002_g_MissionId)
		if x223002_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x223002_g_MissionName)
			AddText(sceneId,x223002_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x223002_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死钦察残兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x223002_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x223002_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x223002_g_MissionName)
		     AddText(sceneId,x223002_g_MissionComplete)
		     AddMoneyBonus(sceneId, x223002_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x223002_g_ScriptId, x223002_g_MissionId)
                end

        elseif x223002_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x223002_g_MissionName)
                AddText(sceneId,x223002_g_MissionInfo..GetName(sceneId, selfId)..x223002_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x223002_g_MissionTarget) 
		AddMoneyBonus(sceneId, x223002_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x223002_g_ScriptId, x223002_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x223002_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x223002_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x223002_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x223002_g_ScriptId, x223002_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x223002_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x223002_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x223002_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==17) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x223002_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x223002_g_MissionId, x223002_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x223002_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x223002_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x223002_g_MissionId)
	for i, item in pairs(x223002_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x223002_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x223002_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x223002_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x223002_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x223002_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x223002_g_MissionId)
		AddExp(sceneId, selfId, x223002_g_ExpBonus)
		AddMoney(sceneId, selfId, x223002_g_MoneyBonus)
		for i, item in pairs(x223002_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x223002_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x223002_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x223002_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x223002_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x223002_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x223002_g_DemandKill[1].id then 
       		    if num < x223002_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死钦察残兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x223002_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x223002_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x223002_OnItemChanged(sceneId, selfId, itemdataId)

end

