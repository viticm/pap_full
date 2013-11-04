--绝世宝剑

--MisDescBegin
x215002_g_ScriptId = 215002
x215002_g_MissionIdPre =132
x215002_g_MissionId = 133
x215002_g_MissionKind = 14
x215002_g_MissionLevel = 55
x215002_g_ScriptIdNext = {ScriptId = 215003 ,LV = 1 }
x215002_g_Name	="扎兰丁"
x215002_g_Name2	="铸剑使" 
x215002_g_DemandItem ={}
x215002_g_noDemandKill ={}	

x215002_g_MissionName="绝世宝剑"
x215002_g_MissionInfo="    你为我带来了勇气和希望。我得给你点什么作为回报。你见过我的武器吗？这是用天山玄铁铸造而成的绝世兵器，它给与了我所有的光辉，是我花剌子模的国宝！\n \n    现在它对我来说都没什么用处了，还是送给你吧！宝剑就在铸剑使手里，我亲爱的勇士，如果你是真心的感激我，请为我祈祷吧！"  --任务描述
x215002_g_MissionTarget="    扎兰丁为了感谢你，把他的绝世宝剑赠送给你，你要到#G铸剑使#W处拿宝剑。"		
x215002_g_MissionComplete="    很荣幸见到你。"					--完成任务npc说话的话
--x215002_g_ContinueInfo="    不管付出多大代价，也要把那件东西给拿回来。"
--任务奖励
x215002_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x215002_g_ItemBonus={}

--可选物品奖励，最多8种
x215002_g_RadioItemBonus={}

--MisDescEnd
x215002_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x215002_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x215002_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x215002_g_MissionId) > 0 then
		
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x215002_g_MissionName)
		     AddText(sceneId,x215002_g_MissionComplete)
		     AddMoneyBonus(sceneId, x215002_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x215002_g_ScriptId, x215002_g_MissionId)
                

        elseif x215002_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x215002_g_MissionName)
                AddText(sceneId,x215002_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x215002_g_MissionTarget) 
		AddMoneyBonus(sceneId, x215002_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x215002_g_ScriptId, x215002_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x215002_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x215002_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x215002_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x215002_g_ScriptId, x215002_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x215002_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x215002_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x215002_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==15) then
        	if IsMissionHaveDone(sceneId, selfId, x215002_g_MissionIdPre) > 0 then
        		if (GetName(sceneId,targetId)==x215002_g_Name) then
	        	        if IsHaveMission(sceneId,selfId, x215002_g_MissionId)<= 0 then
	        	            	return 1
	        	        end
	        	end
			if (GetName(sceneId,targetId)==x215002_g_Name2) then
				    if IsHaveMission(sceneId,selfId, x215002_g_MissionId) > 0 then
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

function x215002_OnAccept(sceneId, selfId)

	                                                  
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x215002_g_MissionId, x215002_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x215002_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
	     	                                    
	     
end



--**********************************

--放弃

--**********************************

function x215002_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x215002_g_MissionId)
	for i, item in x215002_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x215002_CheckSubmit( sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x215002_g_Name2) then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x215002_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x215002_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x215002_g_MissionId)
		AddExp(sceneId, selfId, x215002_g_ExpBonus)
		AddMoney(sceneId, selfId, x215002_g_MoneyBonus)
		for i, item in x215002_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x215002_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x215002_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x215002_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x215002_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x215002_OnItemChanged(sceneId, selfId, itemdataId)

end

