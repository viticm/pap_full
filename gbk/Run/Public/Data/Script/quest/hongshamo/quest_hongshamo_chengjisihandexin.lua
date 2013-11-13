--成吉思汗的信

--MisDescBegin
x205006_g_ScriptId = 205006
--x205006_g_MissionIdPre =40
x205006_g_MissionId = 46
x205006_g_MissionKind = 11
x205006_g_MissionLevel = 55
--x205006_g_ScriptIdNext = {ScriptId = 205002 ,LV = 1 }
x205006_g_Name	="也遂" 
x205006_g_Name2	="扎兰丁" 
x205006_g_DemandItem ={{id=13010003,num=1}}
--x205006_g_noDemandKill ={{id=301,num=1}}	

x205006_g_MissionName="成吉思汗的信"
x205006_g_MissionInfo="    我手里的这封信非常的重要，这是大汗写给花剌子模国王摩诃魔的信，信是这样写的：\n \n亲爱的摩诃末国王：\n \n    贵国的商团以至我处，我们热情的接待了他们，他们带来的商品也已售完。我们再次派商团去贵国进行贸易。从今以后，我们应该加强往来，那仇怨的脓疮可以挤出，骚乱反间的毒汁可以洗净！\n \n                                   成吉思汗\n \n    这是一封很重要的信，我需要像你这样的勇士来完成这样的任务。请你把这封信，送到#R扎兰丁#W王子的手上，请他转交给摩诃魔国王，以消除我们的之间的误会。"  --任务描述
x205006_g_MissionTarget="    把#c0080C0成吉思汗的信#W送到#G扎兰丁#W的手上"		
x205006_g_MissionComplete="    哈哈哈！我花剌子模帝国地大物博，资源丰富，根本就不需要你们跟你们通商。不过，我很敬佩你的勇气！"					--完成任务npc说话的话
--x205006_g_ContinueInfo="    不管付出多大代价，也要把那件东西给拿回来。"
--任务奖励
x205006_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x205006_g_ItemBonus={}

--可选物品奖励，最多8种
x205006_g_RadioItemBonus={}

--MisDescEnd
x205006_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x205006_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x205006_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x205006_g_MissionId) > 0 then
		
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x205006_g_MissionName)
		     AddText(sceneId,x205006_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in pairs(x205006_g_DemandItem) do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x205006_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x205006_g_ScriptId, x205006_g_MissionId)
                

        elseif x205006_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x205006_g_MissionName)
                AddText(sceneId,x205006_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x205006_g_MissionTarget) 
		AddMoneyBonus(sceneId, x205006_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x205006_g_ScriptId, x205006_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x205006_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x205006_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x205006_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x205006_g_ScriptId, x205006_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x205006_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x205006_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x205006_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==5) then
        	if (GetName(sceneId,targetId)==x205006_g_Name) then
        	        if IsHaveMission(sceneId,selfId, x205006_g_MissionId)<= 0 then
        	            	return 1
        	        end
        	end
		if (GetName(sceneId,targetId)==x205006_g_Name2) then
			    if IsHaveMission(sceneId,selfId, x205006_g_MissionId) > 0 then
			    	return 1
        	            end
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x205006_OnAccept(sceneId, selfId)

	                                                  
	BeginAddItem(sceneId)                                                    
	AddItem( sceneId,x205006_g_DemandItem[1].id, x205006_g_DemandItem[1].num )             
		ret = EndAddItem(sceneId,selfId)                                 
	        if ret > 0 then                                                  
	        	BeginEvent(sceneId)
			AddMission( sceneId, selfId, x205006_g_MissionId, x205006_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x205006_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)AddItemListToHuman(sceneId,selfId) 
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

function x205006_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x205006_g_MissionId)
	for i, item in pairs(x205006_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x205006_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x205006_g_DemandItem[1].id) == 1 then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x205006_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x205006_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x205006_g_MissionId)
		AddExp(sceneId, selfId, x205006_g_ExpBonus)
		AddMoney(sceneId, selfId, x205006_g_MoneyBonus)
		for i, item in pairs(x205006_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x205006_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x205006_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x205006_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x205006_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x205006_OnItemChanged(sceneId, selfId, itemdataId)

end

