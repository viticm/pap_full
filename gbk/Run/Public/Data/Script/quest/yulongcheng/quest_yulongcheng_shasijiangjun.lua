--杀死将军

--MisDescBegin
x208006_g_ScriptId = 208006
x208006_g_MissionIdPre =58
x208006_g_MissionId = 60
x208006_g_MissionKind = 12
x208006_g_MissionLevel = 60
--x208006_g_ScriptIdNext = {ScriptId = 205005 ,LV = 1 }
x208006_g_Name	="哲别" 
x208006_g_DemandItem ={{id=13010014,num=1}}
x208006_g_noDemandKill ={{id=312,num=1}}	

x208006_g_MissionName="杀死将军"
x208006_g_MissionInfo="    你听说过#R帖木儿灭里#W这人吗？他是花剌子模国的大将军，他的军队被我们的大军围在（151，134）处，据说这大将军是魔诃魔的爱将，我命你去把他人头拿下！"  --任务描述
x208006_g_MissionTarget="    杀死#R帖木儿灭里#W给#G哲别#W带回#c0080C0帖木儿灭里的头#W。"		
x208006_g_MissionComplete="    帖木儿灭里是他们的护国将军，这一仗打得漂亮。"					--完成任务npc说话的话
x208006_g_ContinueInfo="    那些花剌子模人不值得可怜，只有杀了他们才能平息我们仇恨的怒火。"
--任务奖励
x208006_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x208006_g_ItemBonus={}

--可选物品奖励，最多8种
x208006_g_RadioItemBonus={}

--MisDescEnd
x208006_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x208006_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x208006_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x208006_g_MissionId) > 0 then
		if x208006_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x208006_g_MissionName)
			AddText(sceneId,x208006_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x208006_g_MissionTarget) 
			AddText(sceneId,format("\n    帖木儿灭里的头   %d/1", LuaFnGetItemCount(sceneId,selfId,x208006_g_DemandItem[1].id) ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x208006_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x208006_g_MissionName)
		     AddText(sceneId,x208006_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in x208006_g_DemandItem do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x208006_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x208006_g_ScriptId, x208006_g_MissionId)
                end

        elseif x208006_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x208006_g_MissionName)
                AddText(sceneId,x208006_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x208006_g_MissionTarget) 
		AddMoneyBonus(sceneId, x208006_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x208006_g_ScriptId, x208006_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x208006_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x208006_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x208006_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x208006_g_ScriptId, x208006_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x208006_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x208006_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x208006_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==8) then
        	if IsMissionHaveDone(sceneId, selfId, x208006_g_MissionIdPre) > 0 then
        	            return 1
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x208006_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x208006_g_MissionId, x208006_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x208006_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x208006_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x208006_g_MissionId)
	for i, item in x208006_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x208006_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x208006_g_DemandItem[1].id) == 1 then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x208006_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x208006_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x208006_g_MissionId)
		AddExp(sceneId, selfId, x208006_g_ExpBonus)
		AddMoney(sceneId, selfId, x208006_g_MoneyBonus)
		for i, item in x208006_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x208006_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x208006_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x208006_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x208006_g_MissionId) >= 0 then                                       
       		 if objdataId == x208006_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x208006_g_DemandItem[1].id) < 1 then
       		         if random(1,100)>0 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x208006_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("帖木儿灭里的头   %d/1", LuaFnGetItemCount(sceneId,selfId,x208006_g_DemandItem[1].id)+1 )) 
				 	EndEvent()
				 	DispatchMissionTips(sceneId, selfId)
				 	AddItemListToHuman(sceneId,selfId) 
		        	 else                                                             
		        	 	BeginEvent(sceneId)                                      
				     	AddText(sceneId,"物品栏已满！")                    
				        EndEvent(sceneId)                                        
				        DispatchMissionTips(sceneId,selfId) 
				 end                     
		         end             
       		    end
       		 end
       		 
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x208006_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x208006_OnItemChanged(sceneId, selfId, itemdataId)

end

