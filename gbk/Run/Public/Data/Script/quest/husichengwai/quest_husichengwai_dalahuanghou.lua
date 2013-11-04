--达拉皇后

--MisDescBegin
x204005_g_ScriptId = 204005
x204005_g_MissionIdPre =99
x204005_g_MissionId = 100
x204005_g_MissionKind = 9
x204005_g_MissionLevel = 45
x204005_g_ScriptIdNext = {ScriptId = 204006 ,LV = 1 }
x204005_g_Name	="达拉皇后" 
x204005_g_Name2	="哲别" 
x204005_g_DemandItem ={{id=13010033,num=1}}
--x204005_g_noDemandKill ={{id=301,num=1}}	

x204005_g_MissionName="达拉皇后"
x204005_g_MissionInfo="    我亲爱的勇士，终于等到你来了！哈勒将军还是没有忘记我，很好，很忠心！\n \n   <说到哈勒将军的时候，皇后两颊微红>\n \n    请你回去告诉哈勒将军，西辽国不能毁在屈出律的手上，让他请成吉思汗帮忙，把屈出律这个以怨报德的人给赶出西辽国，然后到这里来接我。\n \n    这是我的信物，请交给哲别将军，哈勒将军看到，他一定会相信你们的话。"  --任务描述
x204005_g_MissionTarget="    #G达拉皇后#W让你拿着信物回去给#G哲别#W。"		
x204005_g_MissionComplete="    原来是西辽前国王耶律直的皇后。"					--完成任务npc说话的话
--x204005_g_ContinueInfo="    不管付出多大代价，也要把那件东西给拿回来。"
--任务奖励
x204005_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x204005_g_ItemBonus={}

--可选物品奖励，最多8种
x204005_g_RadioItemBonus={}

--MisDescEnd
x204005_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x204005_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x204005_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x204005_g_MissionId) > 0 then
		
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x204005_g_MissionName)
		     AddText(sceneId,x204005_g_MissionComplete)
		     AddMoneyBonus(sceneId, x204005_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x204005_g_ScriptId, x204005_g_MissionId)
                

        elseif x204005_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x204005_g_MissionName)
                AddText(sceneId,x204005_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x204005_g_MissionTarget) 
		AddMoneyBonus(sceneId, x204005_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x204005_g_ScriptId, x204005_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x204005_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x204005_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x204005_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x204005_g_ScriptId, x204005_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x204005_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x204005_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x204005_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==4) then
        	if IsMissionHaveDone(sceneId, selfId, x204005_g_MissionIdPre) > 0 then
	        	if (GetName(sceneId,targetId)==x204005_g_Name) then
	        	        if IsHaveMission(sceneId,selfId, x204005_g_MissionId)<= 0 then
	        	            	return 1
	        	        end
	        	end
			if (GetName(sceneId,targetId)==x204005_g_Name2) then
				    if IsHaveMission(sceneId,selfId, x204005_g_MissionId) > 0 then
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

function x204005_OnAccept(sceneId, selfId)

	                                                  
	BeginAddItem(sceneId)                                                    
	AddItem( sceneId,x204005_g_DemandItem[1].id, x204005_g_DemandItem[1].num )             
		ret = EndAddItem(sceneId,selfId)                                 
	        if ret > 0 then                                                  
	        	BeginEvent(sceneId)
			AddMission( sceneId, selfId, x204005_g_MissionId, x204005_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x204005_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)
			AddItemListToHuman(sceneId,selfId) 
	        else                                                             
		     BeginEvent(sceneId)                                      
		     AddText(sceneId,"物品栏已满，请整理下再来！")                    
		     EndEvent(sceneId)                                        
		     DispatchMissionTips(sceneId,selfId)                      
	        end    
	     	                                    
	     
end



--**********************************

--放弃

--**********************************

function x204005_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x204005_g_MissionId)
	for i, item in x204005_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x204005_CheckSubmit( sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x204005_g_Name2) then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x204005_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x204005_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x204005_g_MissionId)
		AddExp(sceneId, selfId, x204005_g_ExpBonus)
		AddMoney(sceneId, selfId, x204005_g_MoneyBonus)
		for i, item in x204005_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x204005_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x204005_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x204005_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x204005_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x204005_OnItemChanged(sceneId, selfId, itemdataId)

end

