--烟火满天飞

--MisDescBegin
x202008_g_ScriptId = 202008
--x202008_g_MissionIdPre =40
x202008_g_MissionId = 127
x202008_g_MissionKind = 4
x202008_g_MissionLevel = 20
--x202008_g_ScriptIdNext = {ScriptId = 208005 ,LV = 1 }
x202008_g_Name	="豁儿赤" 
x202008_g_noDemandItem ={{id=13010041,num=1}}
--x202008_g_noDemandKill ={{id=301,num=1}}	

x202008_g_MissionName="烟火满天飞"
x202008_g_MissionInfo="，就你了！我选了好久，觉得你最帅，最忠诚了！\n \n    恩，是的，虽然忠诚是不能用帅来表示，但是以你的智慧，我很难跟你解释！\n \n    来，这是一枚发讯号的用的烟花，来自南方的金国。王汗的人马要比我们多处几倍，要打赢这一丈，代价很大。大汗已经和金国谈好了，他们会出兵五万，偷袭克烈部！只要你把这枚烟花，拿到高坡的马厩里点燃，金国的那些笨蛋就会偷袭克烈部。"  --任务描述
x202008_g_MissionTarget="    拿着#c0080C0豁儿赤的烟火#W到高坡的马厩里使用。"		
x202008_g_MissionComplete="    你放烟花的姿势，颇有我年轻时的风范。"					--完成任务npc说话的话
x202008_g_ContinueInfo="    你还没点烟花吗？贻误战机可是砍头的罪名。"
--任务奖励
x202008_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x202008_g_ItemBonus={}

--可选物品奖励，最多8种
x202008_g_RadioItemBonus={}

--MisDescEnd
x202008_g_ExpBonus = 6500
--**********************************

--任务入口函数

--**********************************

function x202008_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	misIndex = GetMissionIndexByID(sceneId,selfId,x202008_g_MissionId)
	if x202008_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x202008_g_MissionId) > 0 then
		if x202008_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     	BeginEvent(sceneId)
                     	AddText(sceneId,"#Y"..x202008_g_MissionName)
		     	AddText(sceneId,x202008_g_MissionComplete)
		     	AddMoneyBonus(sceneId, x202008_g_MoneyBonus)
		     	EndEvent()
                     	DispatchMissionContinueInfo(sceneId, selfId, targetId, x202008_g_ScriptId, x202008_g_MissionId)
                elseif x202008_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                	BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x202008_g_MissionName)
			AddText(sceneId,x202008_g_ContinueInfo)
			AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x202008_g_MissionTarget) 
			AddText(sceneId,format("\n    点燃豁儿赤烟花   %d/1", GetMissionParam(sceneId,selfId,misIndex,0) ))
		     	EndEvent()
			DispatchEventList(sceneId, selfId, targetId)	
                end

        elseif x202008_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x202008_g_MissionName)
                AddText(sceneId,"    "..GetName(sceneId, selfId)..x202008_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x202008_g_MissionTarget) 
		AddMoneyBonus(sceneId, x202008_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x202008_g_ScriptId, x202008_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x202008_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x202008_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x202008_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x202008_g_ScriptId, x202008_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x202008_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x202008_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x202008_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==2) then
        	            	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x202008_OnAccept(sceneId, selfId)

	                                                  
	BeginAddItem(sceneId)                                                    
	AddItem( sceneId,x202008_g_noDemandItem[1].id, x202008_g_noDemandItem[1].num )             
		ret = EndAddItem(sceneId,selfId)                                 
	        if ret > 0 then                                                  
	        	BeginEvent(sceneId)
			AddMission( sceneId, selfId, x202008_g_MissionId, x202008_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x202008_g_MissionName) 
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

function x202008_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x202008_g_MissionId)
	for i, item in x202008_g_noDemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x202008_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x202008_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == 1 then
			    		return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x202008_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x202008_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x202008_g_MissionId)
		AddExp(sceneId, selfId, x202008_g_ExpBonus)
		AddMoney(sceneId, selfId, x202008_g_MoneyBonus)
		for i, item in x202008_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end
		--CallScriptFunction( x202008_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x202008_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x202008_OnEnterArea(sceneId, selfId, zoneId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x202008_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,1,1)
	
end

function x202008_OnLeaveArea(sceneId, selfId )
	misIndex = GetMissionIndexByID(sceneId,selfId,x202008_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,1,0)
end

function x202008_OnTimer(sceneId, selfId )

end



--**********************************

--道具改变

--**********************************

function x202008_OnItemChanged(sceneId, selfId, itemdataId)

end

