--灭口

--MisDescBegin
x215003_g_ScriptId = 215003
x215003_g_MissionIdPre =133
x215003_g_MissionId = 134
x215003_g_MissionKind = 14
x215003_g_MissionLevel = 55
--x215003_g_ScriptIdNext = {ScriptId = 204001 ,LV = 1 }
x215003_g_Name	="铸剑使" 
x215003_g_DemandItem ={}
x215003_g_DemandKill ={{id=387,num=3}}

x215003_g_MissionName="灭口"
x215003_g_MissionInfo="    绝世兵器？你确定是要绝世兵器吗？哈哈哈哈……！你看到我背后的那把剑了吗，那就是绝世兵器！\n \n    是扎兰丁国王命令你来拿宝剑的吗？好，那我就成全你！\n \n    <铸剑使对你狞笑，一声召唤，周围不知不觉多了一群侍卫>希望真主能原谅你的罪过！如果你没死的话，我会告诉你宝剑的真相！"  --任务描述
x215003_g_MissionInfo2="你能帮我解决了他吗？"
x215003_g_MissionTarget="    你莫名其妙的被一群带刀侍卫所围，只要杀了他们，才能得到宝剑的真相。"		                                                                                               
x215003_g_MissionComplete="    别……别杀我，是扎兰丁让我这么干的。！\n \n    凡是得扎兰丁的命令来拿宝剑的人，都是为他做过秘密任务的人，来这里就是为了灭口！我身不由己！"					--完成任务npc说话的话
x215003_g_ContinueInfo="    愚不可及的人，都是贪念在作怪。"
--任务奖励
x215003_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x215003_g_ItemBonus={}

--可选物品奖励，最多8种
x215003_g_RadioItemBonus={}

--MisDescEnd
x215003_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x215003_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x215003_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x215003_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x215003_g_MissionId)
		if x215003_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x215003_g_MissionName)
			AddText(sceneId,x215003_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x215003_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死宝剑守卫   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x215003_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x215003_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x215003_g_MissionName)
		     AddText(sceneId,x215003_g_MissionComplete)
		     AddMoneyBonus(sceneId, x215003_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x215003_g_ScriptId, x215003_g_MissionId)
                end

        elseif x215003_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x215003_g_MissionName)
                AddText(sceneId,x215003_g_MissionInfo..GetName(sceneId, selfId)..x215003_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x215003_g_MissionTarget) 
		AddMoneyBonus(sceneId, x215003_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x215003_g_ScriptId, x215003_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x215003_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x215003_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x215003_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x215003_g_ScriptId, x215003_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x215003_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x215003_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x215003_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==15) then
		if IsMissionHaveDone(sceneId, selfId, x215003_g_MissionIdPre) > 0 then
        	    	return 1
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x215003_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x215003_g_MissionId, x215003_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x215003_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		LuaFnCreateMonster(sceneId,387,201,152,0,1,-1)
		LuaFnCreateMonster(sceneId,387,206,152,0,1,-1)
		LuaFnCreateMonster(sceneId,387,202,159,0,1,-1)
		LuaFnCreateMonster(sceneId,387,204,159,0,1,-1)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x215003_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x215003_g_MissionId)
	for i, item in pairs(x215003_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x215003_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x215003_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x215003_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x215003_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x215003_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x215003_g_MissionId)
		AddExp(sceneId, selfId, x215003_g_ExpBonus)
		AddMoney(sceneId, selfId, x215003_g_MoneyBonus)
		for i, item in pairs(x215003_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x215003_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x215003_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x215003_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x215003_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x215003_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x215003_g_DemandKill[1].id then 
       		    if num < x215003_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死宝剑守卫   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x215003_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x215003_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x215003_OnItemChanged(sceneId, selfId, itemdataId)

end

