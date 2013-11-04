--麻痹敌人

--MisDescBegin
x203005_g_ScriptId = 203005
x203005_g_MissionIdPre =72
x203005_g_MissionId = 73
x203005_g_MissionKind = 13
x203005_g_MissionLevel = 50
--x203005_g_ScriptIdNext = {ScriptId = 208009 ,LV = 1 }
x203005_g_Name	="郭靖" 
x203005_g_DemandItem ={}
x203005_g_DemandKill ={{id=325,num=2},{id=326,num=2}}

x203005_g_MissionName="麻痹敌人"
x203005_g_MissionInfo="     我的计策成功了，哲别和速不台暗杀了他们的医生，现在，他们开始乱了……\n \n    这几天，上吐下泻的人越来越多，就连摩诃末国王也中了巴豆的毒，因为泻药的缘故，已经虚脱的不省人事。\n \n    冲动的扎兰丁王子和那些执政的大臣们为了争夺权利，矛盾越来越深。\n \n    我们需要给他们两边放一把火，让他们自相残杀。你已经把黄金装甲给拿了回来，只要装扮成黄金侍卫，把扎兰丁的#R白金侍卫首领#W给杀掉，然后再用同样的方法杀掉#R白金侍卫首领#W。 "  --任务描述
x203005_g_MissionTarget="    解决掉2名#R黄金侍卫首领#W和2名#R白金侍卫首领#W后再回来找#G郭靖#W"		                                                                                               
x203005_g_MissionComplete="    成吉思汗进攻的战斗号角会在他们两败俱伤的时候吹响！"					--完成任务npc说话的话
x203005_g_ContinueInfo="    一定要暗中行动，别露了马脚。"
--任务奖励
x203005_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x203005_g_ItemBonus={}

--可选物品奖励，最多8种
x203005_g_RadioItemBonus={}

--MisDescEnd
x203005_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x203005_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x203005_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x203005_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x203005_g_MissionId)
		if x203005_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x203005_g_MissionName)
			AddText(sceneId,x203005_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x203005_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死黄金侍卫首领   %d/%d\n    杀死白金侍卫首领   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x203005_g_DemandKill[1].num, GetMissionParam(sceneId,selfId,misIndex,1),x203005_g_DemandKill[2].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x203005_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x203005_g_MissionName)
		     AddText(sceneId,x203005_g_MissionComplete)
		     AddMoneyBonus(sceneId, x203005_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x203005_g_ScriptId, x203005_g_MissionId)
                end

        elseif x203005_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x203005_g_MissionName)
                AddText(sceneId,x203005_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x203005_g_MissionTarget) 
		AddMoneyBonus(sceneId, x203005_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x203005_g_ScriptId, x203005_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x203005_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x203005_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x203005_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x203005_g_ScriptId, x203005_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x203005_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x203005_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x203005_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==3) then
		if IsMissionHaveDone(sceneId, selfId, x203005_g_MissionIdPre) > 0 then
		    	return 1
		end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x203005_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x203005_g_MissionId, x203005_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x203005_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x203005_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x203005_g_MissionId)
	for i, item in x203005_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x203005_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x203005_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x203005_g_DemandKill[1].num then
		if GetMissionParam(sceneId,selfId,misIndex,1) == x203005_g_DemandKill[2].num then
	        	return 1
	        end
	end
	return 0

end



--**********************************

--提交

--**********************************

function x203005_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x203005_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x203005_g_MissionId)
		AddExp(sceneId, selfId, x203005_g_ExpBonus)
		AddMoney(sceneId, selfId, x203005_g_MoneyBonus)
		for i, item in x203005_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x203005_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x203005_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x203005_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x203005_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x203005_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x203005_g_DemandKill[1].id then 
       		    if num < x203005_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死黄金侍卫首领   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x203005_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
        num2 = GetMissionParam(sceneId,selfId,misIndex,1) 
	 	 if objdataId == x203005_g_DemandKill[2].id then 
       		    if num2 < x203005_g_DemandKill[2].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,1,num2+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死白金侍卫首领   %d/%d", GetMissionParam(sceneId,selfId,misIndex,1),x203005_g_DemandKill[2].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
      end  

end



--**********************************

--进入区域事件

--**********************************

function x203005_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x203005_OnItemChanged(sceneId, selfId, itemdataId)

end

