--一半的财富

--MisDescBegin
x205011_g_ScriptId = 205011
x205011_g_MissionIdPre =50
x205011_g_MissionId = 51
x205011_g_MissionKind = 11
x205011_g_MissionLevel = 55
x205011_g_ScriptIdNext = {ScriptId = 205012 ,LV = 1 }
x205011_g_Name	="扎兰丁" 
x205011_g_DemandItem ={{id=13010010,num=1}}
x205011_g_noDemandKill ={{id=308,num=1}}	

x205011_g_MissionName="一半的财富"
x205011_g_MissionInfo="   感谢你帮我解决了一个头疼的问题！我自我介绍一下，我是花剌子模帝国的王子，我叫扎兰丁！我想，我们应该能称为很好的朋友。\n \n    你能再帮我解决第二个难题吗？当然，对你来说，那是轻而易举的事情。是这样的，盗贼首领已经解决了，但是他们抢来的财宝还没有夺回来，如果你能帮我把财宝夺回，我会把那里的财宝给你一半！"  --任务描述
x205011_g_MissionTarget="    帮助#G扎兰丁#W杀死#R盗贼喽啰#W夺回#c0080C0扎兰丁的宝箱#W"		
x205011_g_MissionComplete="    恩，这是我丢失已久的宝箱！"					--完成任务npc说话的话
x205011_g_ContinueInfo="    盗贼害人无数，一定要铲之而后快。"
--任务奖励
x205011_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x205011_g_ItemBonus={}

--可选物品奖励，最多8种
x205011_g_RadioItemBonus={}

--MisDescEnd
x205011_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x205011_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x205011_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x205011_g_MissionId) > 0 then
		if x205011_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x205011_g_MissionName)
			AddText(sceneId,x205011_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x205011_g_MissionTarget) 
			AddText(sceneId,format("\n    扎兰丁的宝箱   %d/%d", LuaFnGetItemCount(sceneId,selfId,x205011_g_DemandItem[1].id),x205011_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x205011_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x205011_g_MissionName)
		     AddText(sceneId,x205011_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in pairs(x205011_g_DemandItem) do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x205011_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x205011_g_ScriptId, x205011_g_MissionId)
                end

        elseif x205011_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x205011_g_MissionName)
                AddText(sceneId,x205011_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x205011_g_MissionTarget) 
		AddMoneyBonus(sceneId, x205011_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x205011_g_ScriptId, x205011_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x205011_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x205011_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x205011_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x205011_g_ScriptId, x205011_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x205011_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x205011_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x205011_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==5) then
        	if IsMissionHaveDone(sceneId, selfId, x205011_g_MissionIdPre) > 0 then
        		return 1
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x205011_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x205011_g_MissionId, x205011_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x205011_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x205011_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x205011_g_MissionId)
	for i, item in pairs(x205011_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x205011_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x205011_g_DemandItem[1].id) == x205011_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x205011_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x205011_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x205011_g_MissionId)
		AddExp(sceneId, selfId, x205011_g_ExpBonus)
		AddMoney(sceneId, selfId, x205011_g_MoneyBonus)
		for i, item in pairs(x205011_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x205011_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x205011_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x205011_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x205011_g_MissionId) >= 0 then                                       
       		 if objdataId == x205011_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x205011_g_DemandItem[1].id) < x205011_g_DemandItem[1].num then
       		    	if random(1,100)>95 then
       		         	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x205011_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("扎兰丁的宝箱   %d/%d", LuaFnGetItemCount(sceneId,selfId,x205011_g_DemandItem[1].id)+1,x205011_g_DemandItem[1].num )) 
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

function x205011_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x205011_OnItemChanged(sceneId, selfId, itemdataId)

end

