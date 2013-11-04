--商队的团长

--MisDescBegin
x205000_g_ScriptId = 205000
--x205000_g_MissionIdPre =5
x205000_g_MissionId = 40
x205000_g_MissionKind = 11
x205000_g_MissionLevel = 55
x205000_g_ScriptIdNext = {ScriptId = 205001 ,LV = 1 }
x205000_g_Name	="速不台" 
x205000_g_Name2	="艾山" 
x205000_g_DemandItem ={}
x205000_g_DemandKill ={{id=300,num=15}}

x205000_g_MissionName="商队的团长"
x205000_g_MissionInfo="，我听哲别提起过你，你有着“铜的额颅、凿子似的嘴、铁的心、锥子似的舌”，这是我们蒙古勇士必须必备的，具备了这些之后，我们还需要有“忠诚”和“勇敢”……跟你说这么多，就是想让你帮我做一些事情。\n \n    我奉了成吉思汗的命令，护送商队到达花剌子模国，在这个沙漠里，我们中了那些山贼的埋伏，商队的团长艾山至今下落不明。\n \n    我们的探子查到了一些消息，#G艾山#W被#R沙漠盗贼#W困在（66，112）处了，他需要我们的帮助。"  --任务描述
x205000_g_MissionTarget="    杀死十五名#R沙漠盗贼#W，并在解救被困的商队团长#G艾山#W"		                                                                                               
x205000_g_MissionComplete="    谢谢你帮我解决了这些盗贼。"					--完成任务npc说话的话
x205000_g_ContinueInfo="    贪婪的盗贼似乎是盯着我们的珍宝和商品来的！"
--任务奖励
x205000_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x205000_g_ItemBonus={}

--可选物品奖励，最多8种
x205000_g_RadioItemBonus={}

--MisDescEnd
x205000_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x205000_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x205000_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x205000_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x205000_g_MissionId)
		if x205000_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x205000_g_MissionName)
			AddText(sceneId,x205000_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x205000_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死沙漠盗贼   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x205000_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x205000_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x205000_g_MissionName)
		     AddText(sceneId,x205000_g_MissionComplete)
		     AddMoneyBonus(sceneId, x205000_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x205000_g_ScriptId, x205000_g_MissionId)
                end

        elseif x205000_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x205000_g_MissionName)
                AddText(sceneId,"    "..GetName(sceneId, selfId)..x205000_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x205000_g_MissionTarget) 
		AddMoneyBonus(sceneId, x205000_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x205000_g_ScriptId, x205000_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x205000_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x205000_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x205000_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x205000_g_ScriptId, x205000_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x205000_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x205000_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x205000_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==5) then
        	if (GetName(sceneId,targetId)==x205000_g_Name) then
                 --if IsMissionHaveDone(sceneId, selfId, x205000_g_MissionIdPre) > 0 then
                    if IsHaveMission(sceneId,selfId, x205000_g_MissionId)<= 0 then
                    	return 1
                    end
                --end
        	end
        
		if (GetName(sceneId,targetId)==x205000_g_Name2) then
		    if IsHaveMission(sceneId,selfId, x205000_g_MissionId) > 0 then
		    	return 1
                    end
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x205000_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x205000_g_MissionId, x205000_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x205000_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x205000_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x205000_g_MissionId)
	for i, item in x205000_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x205000_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x205000_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x205000_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x205000_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x205000_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x205000_g_MissionId)
		AddExp(sceneId, selfId, x205000_g_ExpBonus)
		AddMoney(sceneId, selfId, x205000_g_MoneyBonus)
		for i, item in x205000_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x205000_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x205000_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x205000_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x205000_g_MissionId) >= 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x205000_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x205000_g_DemandKill[1].id then 
       		    if num < x205000_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死沙漠盗贼   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x205000_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x205000_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x205000_OnItemChanged(sceneId, selfId, itemdataId)

end

