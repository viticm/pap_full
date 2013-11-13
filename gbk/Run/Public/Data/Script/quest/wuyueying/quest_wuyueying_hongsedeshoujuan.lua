--红色的手绢

--MisDescBegin
x217003_g_ScriptId = 217003
x217003_g_MissionIdPre =174
x217003_g_MissionId = 175
x217003_g_MissionKind = 6
x217003_g_MissionLevel = 30
--x217003_g_ScriptIdNext = {ScriptId = 203003 ,LV = 1 }
x217003_g_Name	="哲别" 
x217003_g_Name2	="孙先生" 
x217003_g_noDemandItem ={{id=13010070,num=1}}
--x217003_g_noDemandKill ={{id=301,num=1}}	

x217003_g_MissionName="红色的手绢"
x217003_g_MissionInfo="    时间不多了，你要第一时间帮我找孙先生，把这个东西送过去给他！\n \n    <哲别给你递过一条红手绢，很郑重的嘱咐你>让他遇到危险的时候，把这东西绑在手臂上！\n \n     这的确有点为难你，但是没办法，我也不知道他的下落，不过我知道，他还没离开乌月营！"  --任务描述
x217003_g_MissionTarget="    把红手绢送给#G孙先生#W，然后回来告诉#G哲别#W。"		
x217003_g_MissionComplete="    这一路辛苦你了。"					--完成任务npc说话的话
x217003_g_ContinueInfo="    东西送到了吗？"
x217003_g_ContinueInfo2="    我等你已经很久了，东西给我吧，你回去告诉哲别将军，让他放心就是了！"
--任务奖励
x217003_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x217003_g_ItemBonus={}

--可选物品奖励，最多8种
x217003_g_RadioItemBonus={}

--MisDescEnd
x217003_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x217003_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	misIndex = GetMissionIndexByID(sceneId,selfId,x217003_g_MissionId)
	if x217003_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x217003_g_MissionId) > 0 then
		if x217003_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     	BeginEvent(sceneId)
                     	AddText(sceneId,"#Y"..x217003_g_MissionName)
		     	AddText(sceneId,x217003_g_MissionComplete)
		     	AddMoneyBonus(sceneId, x217003_g_MoneyBonus)
		     	EndEvent()
                     	DispatchMissionContinueInfo(sceneId, selfId, targetId, x217003_g_ScriptId, x217003_g_MissionId)
                end
                if x217003_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                	if (GetName(sceneId,targetId)==x217003_g_Name) then
                		BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x217003_g_MissionName)
				AddText(sceneId,x217003_g_ContinueInfo)
				AddText(sceneId,"#Y任务目标#W") 
				AddText(sceneId,x217003_g_MissionTarget) 
				AddText(sceneId,format("\n    把手绢送给孙先生   %d/1", GetMissionParam(sceneId,selfId,misIndex,0) ))
		     		EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
			end
			if (GetName(sceneId,targetId)==x217003_g_Name2) then
                		BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x217003_g_MissionName)
				AddText(sceneId,x217003_g_ContinueInfo2)
				EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
				SetMissionByIndex(sceneId,selfId,misIndex,0,1)
				BeginEvent(sceneId)
				AddText(sceneId,format("把手绢送给孙先生   %d/1", GetMissionParam(sceneId,selfId,misIndex,0) ))
		     		EndEvent()
		     		DispatchMissionTips(sceneId, selfId)
		     		for i, item in pairs(x217003_g_noDemandItem) do
					DelItem(sceneId, selfId, item.id, item.num)
				end
			end
                		
                end

        elseif x217003_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x217003_g_MissionName)
                AddText(sceneId,x217003_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x217003_g_MissionTarget) 
		AddMoneyBonus(sceneId, x217003_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x217003_g_ScriptId, x217003_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x217003_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x217003_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x217003_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x217003_g_ScriptId, x217003_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x217003_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x217003_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x217003_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==20) then
        	if IsMissionHaveDone(sceneId, selfId, x217003_g_MissionIdPre) > 0 then
        	misIndex = GetMissionIndexByID(sceneId,selfId,x217003_g_MissionId)
        		if (GetName(sceneId,targetId)==x217003_g_Name) then
        	            		return 1
        		end
			if (GetName(sceneId,targetId)==x217003_g_Name2) then
			   	 if IsHaveMission(sceneId,selfId, x217003_g_MissionId) > 0 then
			    		if LuaFnGetItemCount(sceneId,selfId,x217003_g_noDemandItem[1].id) == 1 then
			    			return 1
			    		end
        	           	 end
        		end
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x217003_OnAccept(sceneId, selfId)

	                                                  
	BeginAddItem(sceneId)                                                    
	AddItem( sceneId,x217003_g_noDemandItem[1].id, x217003_g_noDemandItem[1].num )             
	ret = EndAddItem(sceneId,selfId)                                 
	if ret > 0 then                                                  
	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x217003_g_MissionId, x217003_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x217003_g_MissionName) 
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

function x217003_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x217003_g_MissionId)
	for i, item in pairs(x217003_g_noDemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x217003_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x217003_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == 1 then
			    		return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x217003_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x217003_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x217003_g_MissionId)
		AddExp(sceneId, selfId, x217003_g_ExpBonus)
		AddMoney(sceneId, selfId, x217003_g_MoneyBonus)
		for i, item in pairs(x217003_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end
		--CallScriptFunction( x217003_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x217003_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x217003_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x217003_OnItemChanged(sceneId, selfId, itemdataId)

end

