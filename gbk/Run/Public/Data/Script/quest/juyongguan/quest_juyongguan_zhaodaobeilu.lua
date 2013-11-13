--找到孛鲁

--MisDescBegin
x206004_g_ScriptId = 206004
x206004_g_MissionIdPre =30
x206004_g_MissionId = 31
x206004_g_MissionKind = 8
x206004_g_MissionLevel = 40
x206004_g_ScriptIdNext = {ScriptId = 206005 ,LV = 1 }
x206004_g_Name	="木华黎" 
x206004_g_Name2	="孛鲁" 

x206004_g_MissionName="找到孛鲁"
x206004_g_MissionInfo="    #G孛鲁#W是我的一切，他从小就失去了妈妈，虽然没有母爱，但是却很懂事，怎么会生你的气呢？\n \n    恩，豁儿赤回来了，我们即将进军中兴府，大汗让我们研究下一个作战方案，孛鲁就拜托你了。\n \n    这孩子不会耍脾气的，一定是有什么原因，你去帮我照顾照顾他！"  --任务描述
x206004_g_MissionTarget="    #G孛鲁#W不愿意回来，你去问问他为什么生气了。"		
x206004_g_MissionComplete="    想让我回去？你认为我会这么笨，跟着一个手上沾满鲜血的人走吗！哼！我父亲虽然杀了很多人，但是杀的都是金人，那是为先祖俺巴孩汗报仇，是成吉思汗的命令！成吉思汗说过，对待敌人，一定不能手软，对待自己的兄弟，一定要宽容！\n \n    你们居然杀了哈儿真叔叔！"					--完成任务npc说话的话
x206004_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x206004_g_ItemBonus={}

--可选物品奖励，最多8种
x206004_g_RadioItemBonus={}

--MisDescEnd
x206004_g_ExpBonus = 1000

--**********************************

--任务入口函数

--**********************************

function x206004_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x206004_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x206004_g_MissionId) > 0 then
		if (GetName(sceneId,targetId)==x206004_g_Name2) then
                     	BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x206004_g_MissionName)
			AddText(sceneId,x206004_g_MissionComplete)
		        AddMoneyBonus(sceneId, x206004_g_MoneyBonus)	
			EndEvent()
			DispatchMissionContinueInfo(sceneId, selfId, targetId, x206004_g_ScriptId, x206004_g_MissionId)
		end
        elseif x206004_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x206004_g_MissionName)
                AddText(sceneId,x206004_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x206004_g_MissionTarget) 
		AddMoneyBonus(sceneId, x206004_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x206004_g_ScriptId, x206004_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x206004_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x206004_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x206004_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x206004_g_ScriptId, x206004_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x206004_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x206004_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x206004_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==6) then
        	if IsMissionHaveDone(sceneId, selfId, x206004_g_MissionIdPre) > 0 then
        		if (GetName(sceneId,targetId)==x206004_g_Name) then
        		        if IsHaveMission(sceneId,selfId, x206004_g_MissionId)<= 0 then
        		            return 1
        		        end
        		elseif (GetName(sceneId,targetId)==x206004_g_Name2) then
				    if IsHaveMission(sceneId,selfId, x206004_g_MissionId) > 0 then
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

function x206004_OnAccept(sceneId, selfId)

	--加入任务到玩家列表
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x206004_g_MissionId, x206004_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x206004_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
end



--**********************************

--放弃

--**********************************

function x206004_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x206004_g_MissionId)

end



--**********************************

--检测是否可以提交

--**********************************

function x206004_CheckSubmit( sceneId, selfId, targetId)

	if IsHaveMission(sceneId, selfId, x206004_g_MissionId) >= 0 then
		return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x206004_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x206004_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x206004_g_MissionId)
		AddExp(sceneId, selfId, x206004_g_ExpBonus)
		AddMoney(sceneId, selfId, x206004_g_MoneyBonus)
		for i, item in pairs(x206004_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end
	        CallScriptFunction( x206004_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )

	end
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x206004_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x206004_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x206004_OnItemChanged(sceneId, selfId, itemdataId)

end

