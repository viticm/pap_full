--圣洁的玉石

--MisDescBegin
x207003_g_ScriptId = 207003
x207003_g_MissionIdPre =3
x207003_g_MissionId = 4
x207003_g_MissionKind = 1
x207003_g_ScriptIdNext = {ScriptId = 207004 ,LV = 1 }
x207003_g_Name	="豁儿赤" 
x207003_g_Name2	="阔阔出" 

x207003_g_MissionName="圣洁的玉石"
x207003_g_MissionInfo="    要不是见识多广的#G木华黎#W将军告诉我关于#G乌月营#W的事，我还想不起来是怎么一回事！可是，这该怎么说呢……，从何说起呢？\n \n圣洁的玉石啊，到处透着一股让人伤心的往事，它应该属于大地，#G拖雷#W用它来陪葬一个勇敢伟大的女孩。\n \n就连大汗在内，都亲眼看到这玉佩陪着这女孩埋葬的，怎么会出现在这戴面具的人的身上呢？这样神奇的事情，你还是去问问#G阔阔出#W吧"  --任务描述
x207003_g_MissionTarget="    问问#G阔阔出#W玉佩与女孩的事情"		
x207003_g_MissionComplete="    高高在上的长生天，会让这样的事情，一定有他的理由！我已经感应到他要向我诉说什么了，可是天机不可泄露。\n \n不过，你既然来了，也是长生天的旨意，我就告诉你一些即又不是天机又没几个人知道的事情告诉你吧……。"					--完成任务npc说话的话

x207003_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x207003_g_ItemBonus={}

--可选物品奖励，最多8种
x207003_g_RadioItemBonus={}

--MisDescEnd


--**********************************

--任务入口函数

--**********************************

function x207003_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207003_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207003_g_MissionId) > 0 then
		if (GetName(sceneId,targetId)==x207003_g_Name2) then
                     	BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x207003_g_MissionName)
			AddText(sceneId,x207003_g_MissionComplete)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x207003_g_MissionTarget) 
			AddMoneyBonus(sceneId, x207003_g_MoneyBonus)	
			EndEvent()
			DispatchMissionContinueInfo(sceneId, selfId, targetId, x207003_g_ScriptId, x207003_g_MissionId)
		end
        elseif x207003_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x207003_g_MissionName)
                AddText(sceneId,x207003_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x207003_g_MissionTarget) 
		AddMoneyBonus(sceneId, x207003_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207003_g_ScriptId, x207003_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207003_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207003_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207003_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207003_g_ScriptId, x207003_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207003_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207003_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207003_CheckPushList(sceneId, selfId, targetId)
        if IsMissionHaveDone(sceneId, selfId, x207003_g_MissionIdPre) > 0 then
        	if (GetName(sceneId,targetId)==x207003_g_Name) then
        	        if IsHaveMission(sceneId,selfId, x207003_g_MissionId)<= 0 then
        	            return 1
        	        end
        	elseif (GetName(sceneId,targetId)==x207003_g_Name2) then
			    if IsHaveMission(sceneId,selfId, x207003_g_MissionId) > 0 then
			    return 1
        	            end
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x207003_OnAccept(sceneId, selfId)

	--加入任务到玩家列表
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x207003_g_MissionId, x207003_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x207003_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
end



--**********************************

--放弃

--**********************************

function x207003_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207003_g_MissionId)

end



--**********************************

--检测是否可以提交

--**********************************

function x207003_CheckSubmit( sceneId, selfId, targetId)

	if IsHaveMission(sceneId, selfId, x207003_g_MissionId) >= 0 then
		return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207003_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207003_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207003_g_MissionId)
		AddExp(sceneId, selfId, x207003_g_ExpBonus)
		AddMoney(sceneId, selfId, x207003_g_MoneyBonus)
		for i, item in x207003_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end
	        CallScriptFunction( x207003_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )

	end
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207003_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x207003_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207003_OnItemChanged(sceneId, selfId, itemdataId)

end

