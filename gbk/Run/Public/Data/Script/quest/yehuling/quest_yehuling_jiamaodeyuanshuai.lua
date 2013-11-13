--假冒的元帅

--MisDescBegin
x207013_g_ScriptId = 207013
x207013_g_MissionIdPre =13
x207013_g_MissionId = 14
x207013_g_MissionKind = 1
x207013_g_ScriptIdNext = {ScriptId = 207014 ,LV = 1 }
x207013_g_Name	="阿拉乌" 
x207013_g_Name2	="术虎" 

x207013_g_MissionName="假冒的元帅"
x207013_g_MissionInfo="    事情是这样的，曾经是野狐岭副将的#G石抹明#W，成了#G成吉思汗#W的那可儿，他告诉我，#G术虎#W的脖子上有一颗很显眼的黑痣，可是，地牢里的那个#G术虎#W，没有黑痣……\n \n    这是一个阴谋，有人把#G术虎#W给掉包了，想让我背黑锅，是的，一定是这样，这个人一定是牢头，怪不得这几天他神情古怪的，请你一定把#G术虎#W给杀了，不然……"  --任务描述
x207013_g_MissionTarget="    打败假术虎"		
x207013_g_MissionComplete="    你一定是#G阿拉乌#W派来追杀我的，这个狗贼真卑鄙！年轻人，你可不要被他的花言巧语给骗了，他是骗死人不偿命的类型……\n \n    你看看，你看看我的脸……，这杀千刀的#G阿拉乌#W，在一年前把我和我妻子给骗到#G野狐岭#W来，说要给我过上好日子，后来，不知道他从哪找来了几名大夫，说是给我易容……\n \n    我，我……，我就成了#G术虎#W的替身，不能随意的外出，我有差不多一年没见到我妻子了。\n \n    要不是圣明的#G成吉思汗#W攻克#G野狐岭#W，我还不知道，我的妻子已经被他给强占了，他抓住我是想杀我灭口……年轻人，你就算杀我也没用，我是假的术虎，只要你肯放了我，我会告诉你真的术虎藏在哪里。"					--完成任务npc说话的话
--任务奖励
x207013_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x207013_g_ItemBonus={}

--可选物品奖励，最多8种
x207013_g_RadioItemBonus={}

--MisDescEnd


--**********************************

--任务入口函数

--**********************************

function x207013_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207013_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207013_g_MissionId) > 0 then
		if (GetName(sceneId,targetId)==x207013_g_Name2) then
                     	BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x207013_g_MissionName)
			AddText(sceneId,x207013_g_MissionComplete)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x207013_g_MissionTarget) 
			AddMoneyBonus(sceneId, x207013_g_MoneyBonus)	
			EndEvent()
			DispatchMissionContinueInfo(sceneId, selfId, targetId, x207013_g_ScriptId, x207013_g_MissionId)
		end
        elseif x207013_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x207013_g_MissionName)
                AddText(sceneId,x207013_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x207013_g_MissionTarget) 
		AddMoneyBonus(sceneId, x207013_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207013_g_ScriptId, x207013_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207013_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207013_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207013_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207013_g_ScriptId, x207013_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207013_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207013_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207013_CheckPushList(sceneId, selfId, targetId) 
	if IsMissionHaveDone(sceneId, selfId, x207013_g_MissionIdPre) > 0 then
	        if (GetName(sceneId,targetId)==x207013_g_Name) then
	                if IsHaveMission(sceneId,selfId, x207013_g_MissionId)<= 0 then
	                    return 1
	                end
	        end
		if (GetName(sceneId,targetId)==x207013_g_Name2) then
			    if IsHaveMission(sceneId,selfId, x207013_g_MissionId) > 0 then
			    return 1
	                    end
	        end
	end
        return 0
	
end

--**********************************

--接受

--**********************************

function x207013_OnAccept(sceneId, selfId)

	--加入任务到玩家列表
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x207013_g_MissionId, x207013_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x207013_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
end



--**********************************

--放弃

--**********************************

function x207013_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207013_g_MissionId)

end



--**********************************

--检测是否可以提交

--**********************************

function x207013_CheckSubmit( sceneId, selfId, targetId)

	if IsHaveMission(sceneId, selfId, x207013_g_MissionId) >= 0 then
		return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207013_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207013_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207013_g_MissionId)
		AddExp(sceneId, selfId, x207013_g_ExpBonus)
		AddMoney(sceneId, selfId, x207013_g_MoneyBonus)
		CallScriptFunction( x207013_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )

	end
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207013_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x207013_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207013_OnItemChanged(sceneId, selfId, itemdataId)

end

