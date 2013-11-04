--剿灭

--MisDescBegin
x223011_g_ScriptId = 223011
x223011_g_MissionIdPre =302
x223011_g_MissionId = 303
x223011_g_MissionKind = 20
x223011_g_MissionLevel = 100
--x223011_g_ScriptIdNext = {ScriptId = 223007 ,LV = 1 }
x223011_g_Name	="速不台" 
x223011_g_DemandItem ={}
x223011_g_DemandKill ={{id=447,num=20}}

x223011_g_MissionName="剿灭"
x223011_g_MissionInfo="    所有的勇士都竖起你们的耳朵，听从我的号令：从现在起，我们的马蹄所到之处，便是我们大蒙古国的国界。那些负隅顽抗的钦察战士将会受到我们严重的处罚，没有人愿意看到，有外人在他的土地上捣乱。\n \n    所有的勇士听令，征服他们，让所有的#R钦察勇士#W滚出我们的土地，一个不剩的送他们去地狱，让那些百姓成为我们的子民。"  --任务描述
x223011_g_MissionTarget="    听从#G速不台#W号令去敌营杀死20个#R钦察勇士#W"		                                                                                               
x223011_g_MissionComplete="    在战场上，没有人能比我们更狠更勇猛的，长生天会保佑任何为大蒙古国出力的人。"					--完成任务npc说话的话
x223011_g_ContinueInfo="    我们是天下最勇猛的铁血雄狮，凡是马蹄所到之处，就是我大蒙古国的天下，绝对不允许任何人反叛，你要记住这一点，去吧，消灭那些钦察勇士。"
--任务奖励
x223011_g_MoneyBonus = 500

--固定物品奖励，最多8种
x223011_g_ItemBonus={}

--可选物品奖励，最多8种
x223011_g_RadioItemBonus={}

--MisDescEnd
x223011_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x223011_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x223011_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x223011_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x223011_g_MissionId)
		if x223011_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x223011_g_MissionName)
			AddText(sceneId,x223011_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x223011_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死钦察勇士   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x223011_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x223011_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x223011_g_MissionName)
		     AddText(sceneId,x223011_g_MissionComplete)
		     AddMoneyBonus(sceneId, x223011_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x223011_g_ScriptId, x223011_g_MissionId)
                end

        elseif x223011_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x223011_g_MissionName)
                AddText(sceneId,x223011_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x223011_g_MissionTarget) 
		AddMoneyBonus(sceneId, x223011_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x223011_g_ScriptId, x223011_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x223011_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x223011_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x223011_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x223011_g_ScriptId, x223011_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x223011_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x223011_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x223011_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==17) then
		if IsMissionHaveDone(sceneId, selfId, x223011_g_MissionIdPre) > 0 then
        	    	return 1
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x223011_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x223011_g_MissionId, x223011_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x223011_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x223011_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x223011_g_MissionId)
	for i, item in x223011_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x223011_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x223011_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x223011_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x223011_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x223011_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x223011_g_MissionId)
		AddExp(sceneId, selfId, x223011_g_ExpBonus)
		AddMoney(sceneId, selfId, x223011_g_MoneyBonus)
		for i, item in x223011_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x223011_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x223011_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x223011_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x223011_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x223011_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x223011_g_DemandKill[1].id then 
       		    if num < x223011_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死钦察勇士   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x223011_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x223011_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x223011_OnItemChanged(sceneId, selfId, itemdataId)

end

