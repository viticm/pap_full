--听话的老鼠

--MisDescBegin
x203003_g_ScriptId = 203003
x203003_g_MissionIdPre =70
x203003_g_MissionId = 71
x203003_g_MissionKind = 13
x203003_g_MissionLevel = 50
x203003_g_ScriptIdNext = {ScriptId = 203004 ,LV = 1 }
x203003_g_Name	="郭靖" 
x203003_g_Name2	="明安" 
x203003_g_DemandItem ={{id=13010018,num=1}}
x203003_g_noDemandKill ={{id=323,num=1}}	

x203003_g_MissionName="听话的老鼠"
x203003_g_MissionInfo="    闻名不如见面，真像跟你把酒言欢，把明安那小子给叫上，大家喝个痛快……\n \n    恩，你见过听话的老鼠吗？就是那种到处乱窜的小家伙，一个个拳头大小，鬼头鬼脑，黑溜溜的……很听话！这些老鼠是明安训练出来的！\n \n    明安出了个好主意，他把这些药涂在老鼠的嘴巴上和他们的爪上，只要这些老鼠去他糟蹋他们的粮草，这药自然就在那些粮草上。\n \n    哈哈哈，不要太惊讶，我给他送去的药，是生巴豆碾磨而成的泻药。那些士兵要是吃了……\n \n    不过，这些老鼠很奇怪，它们对一种药酒的味道很忌惮。明安告诉我，在敌人粮仓那一伙人，有一个军官是最喜欢喝这种药酒的，你要解决了他，然后把他的#c0080C0药酒葫芦#W带给#G明安#W。 "  --任务描述
x203003_g_MissionTarget="    杀死#R喝药酒的军官#W给#G明安#W带回#c0080C0药酒葫芦#W。"		
x203003_g_MissionComplete="    帖木儿灭里是他们的护国将军，这一仗打得漂亮。"					--完成任务npc说话的话
x203003_g_ContinueInfo="    那些花剌子模人不值得可怜，只有杀了他们才能平息我们仇恨的怒火。"
--任务奖励
x203003_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x203003_g_ItemBonus={}

--可选物品奖励，最多8种
x203003_g_RadioItemBonus={}

--MisDescEnd
x203003_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x203003_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x203003_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x203003_g_MissionId) > 0 then
		if x203003_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x203003_g_MissionName)
			AddText(sceneId,x203003_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x203003_g_MissionTarget) 
			AddText(sceneId,format("\n    药酒葫芦   %d/%d", LuaFnGetItemCount(sceneId,selfId,x203003_g_DemandItem[1].id),x203003_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x203003_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x203003_g_MissionName)
		     AddText(sceneId,x203003_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in x203003_g_DemandItem do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x203003_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x203003_g_ScriptId, x203003_g_MissionId)
                end

        elseif x203003_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x203003_g_MissionName)
                AddText(sceneId,x203003_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x203003_g_MissionTarget) 
		AddMoneyBonus(sceneId, x203003_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x203003_g_ScriptId, x203003_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x203003_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x203003_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x203003_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x203003_g_ScriptId, x203003_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x203003_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x203003_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x203003_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==3) then
        	if IsMissionHaveDone(sceneId, selfId, x203003_g_MissionIdPre) > 0 then
        		if (GetName(sceneId,targetId)==x203003_g_Name) then
        			if IsHaveMission(sceneId,selfId, x203003_g_MissionId) <= 0 then
        	            		return 1
        	            	end
        	        end
        	        if (GetName(sceneId,targetId)==x203003_g_Name2) then
        			if IsHaveMission(sceneId,selfId, x203003_g_MissionId) > 0 then
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

function x203003_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x203003_g_MissionId, x203003_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x203003_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x203003_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x203003_g_MissionId)
	for i, item in x203003_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x203003_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x203003_g_DemandItem[1].id) == x203003_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x203003_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x203003_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x203003_g_MissionId)
		AddExp(sceneId, selfId, x203003_g_ExpBonus)
		AddMoney(sceneId, selfId, x203003_g_MoneyBonus)
		for i, item in x203003_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x203003_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x203003_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x203003_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x203003_g_MissionId) >= 0 then                                       
       		 if objdataId == x203003_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x203003_g_DemandItem[1].id) < x203003_g_DemandItem[1].num then
       		         if random(1,100)>0 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x203003_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("药酒葫芦   %d/%d", LuaFnGetItemCount(sceneId,selfId,x203003_g_DemandItem[1].id)+1,x203003_g_DemandItem[1].num )) 
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

function x203003_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x203003_OnItemChanged(sceneId, selfId, itemdataId)

end

