--摧毁投石机

--MisDescBegin
x217007_g_ScriptId = 217007
--x217007_g_MissionIdPre =41
x217007_g_MissionId = 179
x217007_g_MissionKind = 6
x217007_g_MissionLevel = 30
x217007_g_ScriptIdNext = {ScriptId = 217008 ,LV = 1 }
x217007_g_Name	="拖雷" 
x217007_g_DemandItem ={}
x217007_g_DemandKill ={{id=455,num=10}}

x217007_g_MissionName="摧毁投石机"
x217007_g_MissionInfo="    这是金国囤粮秣的地方，我们的铁骑正在争夺这片营地，对我们来说，这是我们是否能取胜的关键战役。\n \n    金国如果丢失了这个营地，他们边关的40万大军便会缺少粮草，即使再险峻，再坚固的城池，没有了粮草，他们必败。\n \n    但是，我年轻的（职业），要争夺这片地方并不容易，东面的那些金兵，他们的投石机阻止了我们的脚本，我需要挑选最精锐的士兵去扫清障碍，保证我们大军的进攻脚步。\n \n    就是东面的器械处，摧毁那里的投石机，把我们的实力展现给那些懦弱的金国人。"  --任务描述
x217007_g_MissionTarget="    摧毁10个个东面的#G器械处#W的#R乌月营投石机#W，为大军#G拖雷#W扫清进攻的障碍。"		                                                                                               
x217007_g_MissionComplete="    做得好，我的战士！"					--完成任务npc说话的话
x217007_g_ContinueInfo="    我们的希望都寄托在你们这些精锐的身上，请不要让我失望，拿出你们的勇气为我战斗！"
--任务奖励
x217007_g_MoneyBonus = 500

--固定物品奖励，最多8种
x217007_g_ItemBonus={}

--可选物品奖励，最多8种
x217007_g_RadioItemBonus={}

--MisDescEnd
x217007_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x217007_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x217007_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x217007_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x217007_g_MissionId)
		if x217007_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x217007_g_MissionName)
			AddText(sceneId,x217007_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x217007_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死乌月营投石机   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x217007_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x217007_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x217007_g_MissionName)
		     AddText(sceneId,x217007_g_MissionComplete)
		     AddMoneyBonus(sceneId, x217007_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x217007_g_ScriptId, x217007_g_MissionId)
                end

        elseif x217007_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x217007_g_MissionName)
                AddText(sceneId,x217007_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x217007_g_MissionTarget) 
		AddMoneyBonus(sceneId, x217007_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x217007_g_ScriptId, x217007_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x217007_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x217007_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x217007_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x217007_g_ScriptId, x217007_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x217007_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x217007_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x217007_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==20) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x217007_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x217007_g_MissionId, x217007_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x217007_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x217007_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x217007_g_MissionId)
	for i, item in pairs(x217007_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x217007_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x217007_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x217007_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x217007_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x217007_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x217007_g_MissionId)
		AddExp(sceneId, selfId, x217007_g_ExpBonus)
		AddMoney(sceneId, selfId, x217007_g_MoneyBonus)
		for i, item in pairs(x217007_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x217007_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x217007_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x217007_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x217007_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x217007_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x217007_g_DemandKill[1].id then 
       		    if num < x217007_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死乌月营投石机   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x217007_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x217007_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x217007_OnItemChanged(sceneId, selfId, itemdataId)

end

