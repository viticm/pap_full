--传播恐惧

--MisDescBegin
x223004_g_ScriptId = 223004
x223004_g_MissionIdPre =295
x223004_g_MissionId = 296
x223004_g_MissionKind = 20
x223004_g_MissionLevel = 100
--x223004_g_ScriptIdNext = {ScriptId = 208005 ,LV = 1 }
x223004_g_Name	="蒙哥" 
x223004_g_Name2	="拔都" 
x223004_g_noDemandItem ={{id=13010066,num=1}}
--x223004_g_noDemandKill ={{id=301,num=1}}	

x223004_g_MissionName="传播恐惧"
x223004_g_MissionInfo="    一时半刻我们还不能马上剿灭八赤蛮的军队，我属下的探子来报，库丹带着一大队的人马来救援。\n \n    "  --任务描述
x223004_g_MissionInfo2="，他们的援军交给你了，从沿着这条路到达（）处，你只需要替我把炸药埋在小路的巨石处。不过，那里的敌人很多，你要小心！"
x223004_g_MissionTarget="    把#c0080C0八赤蛮的头#W挂到#G北面的城堡#W上，然后把这个消息带给#G拔都#W。"		
x223004_g_MissionComplete="    蒙哥已经把你的英勇表现告诉了我。“在战场上，勇气胜于数量。”这句话在你的身上得到了很好的证明！领取你应得的奖励吧！"					--完成任务npc说话的话
x223004_g_ContinueInfo="    战局很紧，有什么军情要禀报吗？"
--任务奖励
x223004_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x223004_g_ItemBonus={}

--可选物品奖励，最多8种
x223004_g_RadioItemBonus={}

--MisDescEnd
x223004_g_ExpBonus = 6500
--**********************************

--任务入口函数

--**********************************

function x223004_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	misIndex = GetMissionIndexByID(sceneId,selfId,x223004_g_MissionId)
	if x223004_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x223004_g_MissionId) > 0 then
		if x223004_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     	BeginEvent(sceneId)
                     	AddText(sceneId,"#Y"..x223004_g_MissionName)
		     	AddText(sceneId,x223004_g_MissionComplete)
		     	AddMoneyBonus(sceneId, x223004_g_MoneyBonus)
		     	EndEvent()
                     	DispatchMissionContinueInfo(sceneId, selfId, targetId, x223004_g_ScriptId, x223004_g_MissionId)
                elseif x223004_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                	BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x223004_g_MissionName)
			AddText(sceneId,x223004_g_ContinueInfo)
			AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x223004_g_MissionTarget) 
			AddText(sceneId,format("\n    把八赤蛮的头挂在城堡处   %d/1", GetMissionParam(sceneId,selfId,misIndex,0) ))
		     	EndEvent()
			DispatchEventList(sceneId, selfId, targetId)	
                end

        elseif x223004_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x223004_g_MissionName)
                AddText(sceneId,x223004_g_MissionInfo..GetName(sceneId, selfId)..x223004_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x223004_g_MissionTarget) 
		AddMoneyBonus(sceneId, x223004_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x223004_g_ScriptId, x223004_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x223004_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x223004_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x223004_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x223004_g_ScriptId, x223004_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x223004_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x223004_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x223004_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==17) then
        	if IsMissionHaveDone(sceneId, selfId, x223004_g_MissionIdPre) > 0 then
        		if (GetName(sceneId,targetId)==x223004_g_Name) then
	        	        if IsHaveMission(sceneId,selfId, x223004_g_MissionId)<= 0 then
	        	            	return 1
	        	        end
	        	end
			if (GetName(sceneId,targetId)==x223004_g_Name2) then
				    if IsHaveMission(sceneId,selfId, x223004_g_MissionId) > 0 then
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

function x223004_OnAccept(sceneId, selfId)

	                                                  
	BeginAddItem(sceneId)                                                    
	AddItem( sceneId,x223004_g_noDemandItem[1].id, x223004_g_noDemandItem[1].num )             
		ret = EndAddItem(sceneId,selfId)                                 
	        if ret > 0 then                                                  
	        	BeginEvent(sceneId)
			AddMission( sceneId, selfId, x223004_g_MissionId, x223004_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x223004_g_MissionName) 
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

function x223004_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x223004_g_MissionId)
	for i, item in x223004_g_noDemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x223004_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x223004_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == 1 then
			    		return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x223004_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x223004_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x223004_g_MissionId)
		AddExp(sceneId, selfId, x223004_g_ExpBonus)
		AddMoney(sceneId, selfId, x223004_g_MoneyBonus)
		for i, item in x223004_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end
		--CallScriptFunction( x223004_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x223004_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x223004_OnEnterArea(sceneId, selfId, zoneId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x223004_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,1,1)
	
end

function x223004_OnLeaveArea(sceneId, selfId )
	misIndex = GetMissionIndexByID(sceneId,selfId,x223004_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,1,0)
end

function x223004_OnTimer(sceneId, selfId )

end



--**********************************

--道具改变

--**********************************

function x223004_OnItemChanged(sceneId, selfId, itemdataId)

end

