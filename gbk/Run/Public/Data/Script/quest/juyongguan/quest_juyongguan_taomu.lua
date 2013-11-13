--桃木

--MisDescBegin
x206005_g_ScriptId = 206005
x206005_g_MissionIdPre =31
x206005_g_MissionId = 32
x206005_g_MissionKind = 8
x206005_g_MissionLevel = 40
x206005_g_ScriptIdNext = {ScriptId = 206006 ,LV = 1 }
x206005_g_Name	="孛鲁" 
x206005_g_DemandItem ={{id=13010047,num=3}}


x206005_g_MissionName="桃木"
x206005_g_MissionInfo="    不知道为何，#G孛鲁#W对#R哈儿真#W似乎有个特殊的感情，虽然我为#G木华黎#W解决的叛军，杀了#R哈儿真#W，但是#G孛鲁#W却把我当成仇人！\n \n    #G孛鲁#W并不像#G木华黎#W说的那样懂事，起码我是这么认为的。为了让他对我不起仇视，我把#R哈儿真#W背叛成吉思汗的事情说了出来，他没有感到一点意外，眼里反而露出了鄙夷和痛苦。这种表情，逃不过我锐利的眼睛。\n \n    他在掩饰着自己的感情，这到底是怎么回事呢？不知道是为了掩饰还是真的需要，他让我帮他去收集三株#c0080C0桃木#W！也许，满足了他的要求，他可能会给我透露一点什么。"  --任务描述
x206005_g_MissionTarget="    采集三株#c0080C0桃木#W带给#G#孛鲁#W。"		                                                                                               
x206005_g_MissionComplete="    噢，老天！\n \n    我不知道是该惊叹还是该害怕，#G孛鲁#W的这三株桃树让我感觉毛骨悚然，他居然相信一个那些迷信的东西。\n \n    他给#R哈儿真#W挖了一个坟墓，并把桃树从新种植在#R哈儿真#W的坟墓上，根据他的说法，坟墓上有桃树，可以让死去的人重新复活！这是怎么了，他到底要干什么吗？\n \n    不过，我的真诚还是打动了他，虽然得到的消息不多，但是让我有了新的线索。#R哈儿真#W并没有绑架他，反而是从一群#R逃亡的金兵#W手里救了他。只是#G豁儿赤#W太要面子，不想让太多的人知道他的无能！不过，#R哈儿真#W的叛逃却是事实，朦朦胧胧的话语中，我感觉到，这事情似乎跟#R哈儿真#W的亲生父亲有关。"					--完成任务npc说话的话
x206005_g_ContinueInfo="    以你这种智慧，我很难跟你解释！"
--任务奖励
x206005_g_MoneyBonus = 10000

--固定物品奖励，最多8种
x206005_g_ItemBonus={}

--可选物品奖励，最多8种
x206005_g_RadioItemBonus={}

--MisDescEnd
x206005_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x206005_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x206005_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x206005_g_MissionId) > 0 then
		if (GetName(sceneId,targetId)==x206005_g_Name) then
			if x206005_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                	        BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x206005_g_MissionName)
				AddText(sceneId,x206005_g_ContinueInfo)
			        AddText(sceneId,"#Y任务目标#W") 
				AddText(sceneId,x206005_g_MissionTarget) 
				AddText(sceneId,format("\n    桃木   %d/%d", LuaFnGetItemCount(sceneId,selfId,x206005_g_DemandItem[1].id),x206005_g_DemandItem[1].num ))
				EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
			end
                	
			     
                	if x206005_CheckSubmit(sceneId, selfId, targetId) > 0 then
                	     BeginEvent(sceneId)
                	     AddText(sceneId,"#Y"..x206005_g_MissionName)
			     AddText(sceneId,x206005_g_MissionComplete)
			     --AddText(sceneId,"#Y需要物品#W") 
		     	     --for i, item in pairs(x206005_g_DemandItem) do  
		     	     --AddItemBonus(sceneId, item.id, item.num)
		     	     --end
		     	     AddMoneyBonus(sceneId, x206005_g_MoneyBonus)
                	     EndEvent()
		     	     DispatchMissionContinueInfo(sceneId, selfId, targetId, x206005_g_ScriptId, x206005_g_MissionId)
                	end
                end
                

        elseif x206005_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x206005_g_MissionName)
                AddText(sceneId,x206005_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x206005_g_MissionTarget) 
		AddMoneyBonus(sceneId, x206005_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x206005_g_ScriptId, x206005_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x206005_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x206005_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x206005_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x206005_g_ScriptId, x206005_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x206005_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x206005_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x206005_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==6) then
        	if (GetName(sceneId,targetId)==x206005_g_Name) then
                	if IsMissionHaveDone(sceneId, selfId, x206005_g_MissionIdPre) > 0 then
                    		return 1
                	end
        	end
        end
	return 0
	
end

--**********************************

--接受

--**********************************

function x206005_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x206005_g_MissionId, x206005_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x206005_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x206005_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x206005_g_MissionId)
	for i, item in pairs(x206005_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x206005_CheckSubmit( sceneId, selfId, targetId)
	if LuaFnGetItemCount(sceneId,selfId,x206005_g_DemandItem[1].id) == x206005_g_DemandItem[1].num then
		return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x206005_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x206005_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x206005_g_MissionId)
		AddExp(sceneId, selfId, x206005_g_ExpBonus)
		AddMoney(sceneId, selfId, x206005_g_MoneyBonus)
		for i, item in pairs(x206005_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x206005_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x206005_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x206005_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x206005_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x206005_OnItemChanged(sceneId, selfId, itemdataId)

end

