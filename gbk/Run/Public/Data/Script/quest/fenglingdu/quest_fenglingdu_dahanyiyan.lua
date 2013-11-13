--大汗遗言

--MisDescBegin
x212003_g_ScriptId = 212003
x212003_g_MissionIdPre =249
x212003_g_MissionId = 250
x212003_g_MissionKind = 17
x212003_g_MissionLevel = 70
--x212003_g_ScriptIdNext = {ScriptId = 201003 ,LV = 1 }
x212003_g_Name	="成吉思汗" 
x212003_g_Name2	="拖雷" 
x212003_g_DemandItem ={}
x212003_g_DemandKill ={{id=423,num=1}}

x212003_g_MissionName="大汗遗言"
x212003_g_MissionInfo="    我听到长生天呼唤了我，可能不久，我就要死去！\n \n    如果我死了，不要发丧，举哀，好叫敌人不知道我已经死去，这样，对攻打金国有利。\n \n    就算是病死，我也要先看到西夏灭亡。"  --任务描述
x212003_g_MissionInfo2="，杀了西夏的皇帝#R李睍#W，然后找到我的幼子#G拖雷#W，我很想再见见他。"
x212003_g_MissionTarget="    替成吉思汗杀死#G西夏行营#W处的西夏国王#R李睍#W后告知#G拖雷#W成吉思汗的近况。"		                                                                                               
x212003_g_MissionComplete="    父汗不会有事的，谢谢你的帮忙。"					--完成任务npc说话的话
x212003_g_ContinueInfo="    父汗交代你的事情你都做完了吗？"
--任务奖励
x212003_g_MoneyBonus = 500
--固定物品奖励，最多8种
x212003_g_ItemBonus={}

--可选物品奖励，最多8种
x212003_g_RadioItemBonus={}
--MisDescEnd
x212003_g_ExpBonus = 4000

--**********************************

--任务入口函数

--**********************************

function x212003_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x212003_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x212003_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x212003_g_MissionId)
		if x212003_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x212003_g_MissionName)
			AddText(sceneId,x212003_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x212003_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死李睍   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x212003_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x212003_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x212003_g_MissionName)
		     AddText(sceneId,x212003_g_MissionComplete)
		     AddMoneyBonus(sceneId, x212003_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x212003_g_ScriptId, x212003_g_MissionId)
                end

        elseif x212003_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x212003_g_MissionName)
                AddText(sceneId,x212003_g_MissionInfo..GetName(sceneId, selfId)..x212003_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x212003_g_MissionTarget) 
		AddMoneyBonus(sceneId, x212003_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x212003_g_ScriptId, x212003_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x212003_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x212003_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x212003_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x212003_g_ScriptId, x212003_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x212003_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x212003_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x212003_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==12) then
		if IsMissionHaveDone(sceneId, selfId, x212003_g_MissionIdPre) > 0 then
	         	if (GetName(sceneId,targetId)==x212003_g_Name) then 
	         		if IsHaveMission(sceneId,selfId, x212003_g_MissionId) <= 0 then
        			    	return 1
        			end
        		end
        		if (GetName(sceneId,targetId)==x212003_g_Name2) then 
	         		if IsHaveMission(sceneId,selfId, x212003_g_MissionId) > 0 then
        			    	return 1
        			end
        		end
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x212003_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x212003_g_MissionId, x212003_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x212003_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x212003_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x212003_g_MissionId)
	for i, item in pairs(x212003_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x212003_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x212003_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x212003_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x212003_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x212003_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x212003_g_MissionId)
		AddExp(sceneId, selfId, x212003_g_ExpBonus)
		AddMoney(sceneId, selfId, x212003_g_MoneyBonus)
		for i, item in pairs(x212003_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x212003_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x212003_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x212003_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x212003_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x212003_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x212003_g_DemandKill[1].id then 
       		    if num < x212003_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死李睍   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x212003_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x212003_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x212003_OnItemChanged(sceneId, selfId, itemdataId)

end

