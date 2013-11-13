--敌人的委托

--MisDescBegin
x206012_g_ScriptId = 206012
x206012_g_MissionIdPre =38
x206012_g_MissionId = 39
x206012_g_MissionKind = 8
x206012_g_MissionLevel = 40
--x206012_g_ScriptIdNext = {ScriptId = 206005 ,LV = 1 }
x206012_g_Name	="朱家亮" 
x206012_g_Name2	="白发老人" 

x206012_g_MissionName="敌人的委托"
x206012_g_MissionInfo="    虽然我们的皇帝很无能，但是作为臣子，即使死在这里，我也无怨无悔！\n \n    只是，有一件事情我一直放心不下！一位大叔在十多年前身患重病，为了让他的孩子不跟他受苦，在西辽的边境，把两个孩子送给了两个朴实的好人养。\n \n    后来，他在临死之前，遇到了一名叫丘处机的道士，把他给救活了。等他再回去找他孩子的时候，已经没有了下落。\n \n    这十多年来，他浪迹天涯，就是为了寻找他的孩子。只可惜我无法帮助这样一个善良的大叔。我希望你能够帮助他……"  --任务描述
x206012_g_MissionTarget="    帮助白发老人。"		
x206012_g_MissionComplete="    我们又见面了！看来，我们是真的有缘！如果能帮我找回我的儿子，我一定会报答你的！\n \n    这十多年来，我从西辽边境一直在寻找当年领养我孩子的人，只是连年战乱，音信全无，好不容易才找到了一些消息。"					--完成任务npc说话的话
x206012_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x206012_g_ItemBonus={}

--可选物品奖励，最多8种
x206012_g_RadioItemBonus={}

--MisDescEnd
x206012_g_ExpBonus = 1000

--**********************************

--任务入口函数

--**********************************

function x206012_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x206012_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x206012_g_MissionId) > 0 then
		if (GetName(sceneId,targetId)==x206012_g_Name2) then
                     	BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x206012_g_MissionName)
			AddText(sceneId,x206012_g_MissionComplete)
		        AddMoneyBonus(sceneId, x206012_g_MoneyBonus)
			EndEvent()
		        DispatchMissionContinueInfo(sceneId, selfId, targetId, x206012_g_ScriptId, x206012_g_MissionId)
		end
        elseif x206012_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x206012_g_MissionName)
                AddText(sceneId,x206012_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x206012_g_MissionTarget) 
		AddMoneyBonus(sceneId, x206012_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x206012_g_ScriptId, x206012_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x206012_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x206012_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x206012_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x206012_g_ScriptId, x206012_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x206012_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x206012_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x206012_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==6) then
        	if IsMissionHaveDone(sceneId, selfId, x206012_g_MissionIdPre) > 0 then
        		if (GetName(sceneId,targetId)==x206012_g_Name) then
        		        if IsHaveMission(sceneId,selfId, x206012_g_MissionId)<= 0 then
        		            return 1
        		        end
        		elseif (GetName(sceneId,targetId)==x206012_g_Name2) then
				    if IsHaveMission(sceneId,selfId, x206012_g_MissionId) > 0 then
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

function x206012_OnAccept(sceneId, selfId)

	--加入任务到玩家列表
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x206012_g_MissionId, x206012_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x206012_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
end



--**********************************

--放弃

--**********************************

function x206012_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x206012_g_MissionId)

end



--**********************************

--检测是否可以提交

--**********************************

function x206012_CheckSubmit( sceneId, selfId, targetId)

	if IsHaveMission(sceneId, selfId, x206012_g_MissionId) >= 0 then
		return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x206012_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x206012_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x206012_g_MissionId)
		AddExp(sceneId, selfId, x206012_g_ExpBonus)
		AddMoney(sceneId, selfId, x206012_g_MoneyBonus)
		for i, item in pairs(x206012_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end
	        --CallScriptFunction( x206012_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )

	end
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x206012_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x206012_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x206012_OnItemChanged(sceneId, selfId, itemdataId)

end

