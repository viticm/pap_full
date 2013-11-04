--无边的等待

--MisDescBegin
x206011_g_ScriptId = 206011
x206011_g_MissionIdPre =37
x206011_g_MissionId = 38
x206011_g_MissionKind = 8
x206011_g_MissionLevel = 40
x206011_g_ScriptIdNext = {ScriptId = 206012 ,LV = 1 }
x206011_g_Name	="窝阔台" 
x206011_g_Name2	="朱家亮"
x206011_g_DemandItem ={{id=13010049,num=1}}


x206011_g_MissionName="无边的等待"
x206011_g_MissionInfo="    要让他降，看来只有一个办法，就是让他相信居庸关已经被我们打下了，他们这样死守已经不值了！\n \n    我们需要一些信物来证明居庸关被攻破，这个信物，最好是朱将军见过的，认识的，是他身边的人的……范琪仁！他们的守城将！\n \n    对，是守城将范琪仁身上的东西! 我们把死后的金兵尸体都扔在乱葬岗，你去把范琪仁的尸体找出来，看看他身上有没有什么能做信物的东西？ 找到之后，拿去给那些执着的死士们看，让他们归降！"  --任务描述
x206011_g_MissionTarget="    把#c0080C0范琪人的剑#W带给#G朱家亮#W。"		                                                                                               
x206011_g_MissionComplete="    这，这是……，范将军的宝剑！\n \n    哼！不管发生了什么事，出了什么意外，退兵的鼓声没有响起之前，只要我们还有人站着，就一定会死守这里。\n \n    这位勇士，你能冲破我的箭阵，足见英雄了得，如果是在他日，定当把酒言欢，只可惜我们各为其主！ "					--完成任务npc说话的话
x206011_g_ContinueInfo="    我都说了，我们宁死不降！"
--任务奖励
x206011_g_MoneyBonus = 10000

--固定物品奖励，最多8种
x206011_g_ItemBonus={}

--可选物品奖励，最多8种
x206011_g_RadioItemBonus={}

--MisDescEnd
x206011_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x206011_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x206011_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x206011_g_MissionId) > 0 then
		if (GetName(sceneId,targetId)==x206011_g_Name2) then
			if x206011_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                	        BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x206011_g_MissionName)
				AddText(sceneId,x206011_g_ContinueInfo)
			        AddText(sceneId,"#Y任务目标#W") 
				AddText(sceneId,x206011_g_MissionTarget) 
				AddText(sceneId,format("\n    范琪人的剑   %d/%d", LuaFnGetItemCount(sceneId,selfId,x206011_g_DemandItem[1].id),x206011_g_DemandItem[1].num ))
				EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
			end
                	
			     
                	if x206011_CheckSubmit(sceneId, selfId, targetId) > 0 then
                	     BeginEvent(sceneId)
                	     AddText(sceneId,"#Y"..x206011_g_MissionName)
			     AddText(sceneId,x206011_g_MissionComplete)
			     AddMoneyBonus(sceneId, x206011_g_MoneyBonus)
                	     EndEvent()
			     DispatchMissionContinueInfo(sceneId, selfId, targetId, x206011_g_ScriptId, x206011_g_MissionId)
                	end
                end
                
        elseif x206011_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x206011_g_MissionName)
                AddText(sceneId,x206011_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x206011_g_MissionTarget) 
		AddMoneyBonus(sceneId, x206011_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x206011_g_ScriptId, x206011_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x206011_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x206011_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x206011_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x206011_g_ScriptId, x206011_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x206011_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x206011_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x206011_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==6) then
		if IsMissionHaveDone(sceneId, selfId, x206011_g_MissionIdPre) > 0 then
        		if (GetName(sceneId,targetId)==x206011_g_Name) then
        	        	if IsHaveMission(sceneId,selfId, x206011_g_MissionId) <= 0 then
        	            		return 1
        	            	end
        	        end
        		if (GetName(sceneId,targetId)==x206011_g_Name2) then
        	        	if IsHaveMission(sceneId,selfId, x206011_g_MissionId) > 0 then
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

function x206011_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x206011_g_MissionId, x206011_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x206011_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x206011_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x206011_g_MissionId)
	for i, item in x206011_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x206011_CheckSubmit( sceneId, selfId, targetId)
	if LuaFnGetItemCount(sceneId,selfId,x206011_g_DemandItem[1].id) == x206011_g_DemandItem[1].num then
		return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x206011_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x206011_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x206011_g_MissionId)
		AddExp(sceneId, selfId, x206011_g_ExpBonus)
		AddMoney(sceneId, selfId, x206011_g_MoneyBonus)
		for i, item in x206011_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x206011_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x206011_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x206011_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x206011_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x206011_OnItemChanged(sceneId, selfId, itemdataId)

end

