--背叛真主的下场

--MisDescBegin
x205010_g_ScriptId = 205010
--x205010_g_MissionIdPre =40
x205010_g_MissionId = 50
x205010_g_MissionKind = 11
x205010_g_MissionLevel = 55
x205010_g_ScriptIdNext = {ScriptId = 205011 ,LV = 1 }
x205010_g_Name	="扎兰丁" 
x205010_g_DemandItem ={{id=13010008,num=1}}
x205010_g_noDemandKill ={{id=307,num=1}}	

x205010_g_MissionName="背叛真主的下场"
x205010_g_MissionInfo="   异国来的勇士，欢迎你来到花剌子模帝国！过了这红沙漠，就是我们的不花剌城，那里有美丽的姑娘，甘甜的葡萄酒，还有数之不尽的美食和财宝！\n \n    但是，你要想到达那里，先要帮我做一件事情。在沙漠中居住了一群盗贼，他们曾经是我们的正规军，但是却违背了真主的誓言，背叛了我们！这群人在沙漠中，见人就杀，见人就抢。如果你要到不花剌城，请先帮我把他们首领的头颅拿回来。"  --任务描述
x205010_g_MissionTarget="    #G扎兰丁#W让你杀掉#R盗贼头目#W，带回#c0080C0盗贼头目的头颅#W拿给他。"		
x205010_g_MissionComplete="    这就是背叛真主的下场！"					--完成任务npc说话的话
x205010_g_ContinueInfo="    我们绝对不能容忍背叛真主的人存在。"
--任务奖励
x205010_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x205010_g_ItemBonus={}

--可选物品奖励，最多8种
x205010_g_RadioItemBonus={}

--MisDescEnd
x205010_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x205010_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x205010_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x205010_g_MissionId) > 0 then
		if x205010_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x205010_g_MissionName)
			AddText(sceneId,x205010_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x205010_g_MissionTarget) 
			AddText(sceneId,format("\n    盗贼头目的头颅   %d/%d", LuaFnGetItemCount(sceneId,selfId,x205010_g_DemandItem[1].id),x205010_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x205010_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x205010_g_MissionName)
		     AddText(sceneId,x205010_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in x205010_g_DemandItem do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x205010_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x205010_g_ScriptId, x205010_g_MissionId)
                end

        elseif x205010_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x205010_g_MissionName)
                AddText(sceneId,x205010_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x205010_g_MissionTarget) 
		AddMoneyBonus(sceneId, x205010_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x205010_g_ScriptId, x205010_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x205010_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x205010_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x205010_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x205010_g_ScriptId, x205010_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x205010_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x205010_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x205010_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==5) then
        		return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x205010_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x205010_g_MissionId, x205010_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x205010_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x205010_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x205010_g_MissionId)
	for i, item in x205010_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x205010_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x205010_g_DemandItem[1].id) == x205010_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x205010_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x205010_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x205010_g_MissionId)
		AddExp(sceneId, selfId, x205010_g_ExpBonus)
		AddMoney(sceneId, selfId, x205010_g_MoneyBonus)
		for i, item in x205010_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x205010_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x205010_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x205010_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x205010_g_MissionId) >= 0 then                                       
       		 if objdataId == x205010_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x205010_g_DemandItem[1].id) < 1 then
       		         	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x205010_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("盗贼头目的头颅   %d/%d", LuaFnGetItemCount(sceneId,selfId,x205010_g_DemandItem[1].id)+1,x205010_g_DemandItem[1].num )) 
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



--**********************************

--进入区域事件

--**********************************

function x205010_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x205010_OnItemChanged(sceneId, selfId, itemdataId)

end

