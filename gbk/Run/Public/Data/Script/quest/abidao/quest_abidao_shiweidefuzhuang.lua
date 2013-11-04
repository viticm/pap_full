--侍卫的服装

--MisDescBegin
x203004_g_ScriptId = 203004
x203004_g_MissionIdPre =71
x203004_g_MissionId = 72
x203004_g_MissionKind = 13
x203004_g_MissionLevel = 50
x203004_g_ScriptIdNext = {ScriptId = 203005 ,LV = 1 }
x203004_g_Name	="明安" 
x203004_g_Name2	="郭靖" 
x203004_g_DemandItem ={{id=13010019,num=1}}
x203004_g_noDemandKill ={{id=324,num=1}}	

x203004_g_MissionName="侍卫的服装"
x203004_g_MissionInfo="    这里原本是一个宁静的小岛，摩诃末他们来了之后，这里就成了地狱……\n \n    这里的居民对摩诃末父子俩简直恨之入骨。他们的士兵为了一个地瓜，残忍地杀害了这里的人，连毫无抵抗力的孩子都没有放过，我们要复仇。\n \n    不过，这里的士兵太多了，我们不能贸然行动，郭靖大侠已经想了一个好办法。弄一些侍卫的衣服，让我们的人鱼目混珠，靠近扎兰丁身边的时候刺杀他。\n \n    只有#R黄金侍卫#W才能有机会见到国王，去收集#c0080C0黄金侍卫的盔甲#W给郭靖大侠吧。"  --任务描述
x203004_g_MissionTarget="    杀死#R黄金侍卫#W给#G郭靖#W带回#c0080C0黄金侍卫的盔甲#W。"		
x203004_g_MissionComplete="    明安是个很特别的人，他很容易的跟动物称兄道弟，这点本事我以前见过。用老鼠来下毒，这方法很绝妙啊"					--完成任务npc说话的话
x203004_g_ContinueInfo="    黄金侍卫的弓很厉害，你可要小心啦。"
--任务奖励
x203004_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x203004_g_ItemBonus={}

--可选物品奖励，最多8种
x203004_g_RadioItemBonus={}

--MisDescEnd
x203004_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x203004_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x203004_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x203004_g_MissionId) > 0 then
		if x203004_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x203004_g_MissionName)
			AddText(sceneId,x203004_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x203004_g_MissionTarget) 
			AddText(sceneId,format("\n    黄金侍卫的盔甲   %d/%d", LuaFnGetItemCount(sceneId,selfId,x203004_g_DemandItem[1].id),x203004_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x203004_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x203004_g_MissionName)
		     AddText(sceneId,x203004_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in x203004_g_DemandItem do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x203004_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x203004_g_ScriptId, x203004_g_MissionId)
                end

        elseif x203004_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x203004_g_MissionName)
                AddText(sceneId,x203004_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x203004_g_MissionTarget) 
		AddMoneyBonus(sceneId, x203004_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x203004_g_ScriptId, x203004_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x203004_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x203004_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x203004_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x203004_g_ScriptId, x203004_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x203004_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x203004_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x203004_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==3) then
        	if IsMissionHaveDone(sceneId, selfId, x203004_g_MissionIdPre) > 0 then
        		if (GetName(sceneId,targetId)==x203004_g_Name) then
        			if IsHaveMission(sceneId,selfId, x203004_g_MissionId) <= 0 then
        	            		return 1
        	            	end
        	        end
        	        if (GetName(sceneId,targetId)==x203004_g_Name2) then
        			if IsHaveMission(sceneId,selfId, x203004_g_MissionId) > 0 then
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

function x203004_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x203004_g_MissionId, x203004_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x203004_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x203004_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x203004_g_MissionId)
	for i, item in x203004_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x203004_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x203004_g_DemandItem[1].id) == x203004_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x203004_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x203004_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x203004_g_MissionId)
		AddExp(sceneId, selfId, x203004_g_ExpBonus)
		AddMoney(sceneId, selfId, x203004_g_MoneyBonus)
		for i, item in x203004_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x203004_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x203004_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x203004_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x203004_g_MissionId) >= 0 then                                       
       		 if objdataId == x203004_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x203004_g_DemandItem[1].id) < x203004_g_DemandItem[1].num then
       		         if random(1,100)>95 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x203004_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("黄金侍卫的盔甲   %d/%d", LuaFnGetItemCount(sceneId,selfId,x203004_g_DemandItem[1].id)+1,x203004_g_DemandItem[1].num )) 
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

function x203004_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x203004_OnItemChanged(sceneId, selfId, itemdataId)

end

