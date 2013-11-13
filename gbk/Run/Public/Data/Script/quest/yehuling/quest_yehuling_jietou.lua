--接头

--MisDescBegin
x207015_g_ScriptId = 207015
x207016_g_ScriptId = 207016
x207014_g_ScriptId = 207014
x207014_g_MissionIdPre =14
x207014_g_MissionId = 15
x207014_g_MissionKind = 1
x207014_g_ScriptIdNext = {ScriptId = 207017 ,LV = 1 }
x207014_g_Name	="术虎" 
x207014_g_Name2	="流浪汉" 

x207014_g_MissionName="接头"
x207014_g_MissionInfo="    我能逃出来，是我命不该绝，我一定会报仇这个仇。嘿嘿，他们没想到，我在做替身的时候，已经做好了一切准备。\n \n    真的术虎，在野狐岭沦陷之前，已经化妆逃跑了。万幸的是，我早就收买了他身边的人，他现在的藏身之处，只有我一个人知道……\n \n    #G野狐岭#W（33,84）处的#G流浪汉#W，是我的眼线，他会给你最新的消息。接头暗号是：天龙盖地虎，宝塔镇河妖。 "  --任务描述
x207014_g_MissionTarget="    跟#G流浪汉#W接头"		
x207014_g_MissionComplete="    噢，真主保佑！我正想去面见#G赤老温#W将军，没想到他先派你来了！嗯，你来的目的我已经知道了，可是我这里出了大问题……，我，我，我很担心！\n \n    如果不能尽快解决这事情，我想，我真的要去见真主了~！我可不想这么快就死，我老婆就快生了！无论如何，你一定要帮我想办法啊，我不想还没见到我的孩子就……"					--完成任务npc说话的话
x207014_g_answer1="芝麻开门"
x207014_g_answer2="地虎盖天龙"
x207014_g_answer3="宝塔镇河妖"
--任务奖励
x207014_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x207014_g_ItemBonus={}

--可选物品奖励，最多8种
x207014_g_RadioItemBonus={}

--MisDescEnd


--**********************************

--任务入口函数

--**********************************

function x207014_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207014_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207014_g_MissionId) > 0 then
		if (GetName(sceneId,targetId)==x207014_g_Name2) then
                     	BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x207014_g_MissionName)
			AddText(sceneId,x207014_g_MissionComplete)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x207014_g_MissionTarget) 
			AddMoneyBonus(sceneId, x207014_g_MoneyBonus)	
			EndEvent()
			DispatchMissionContinueInfo(sceneId, selfId, targetId, x207014_g_ScriptId, x207014_g_MissionId)
		end
        elseif x207014_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x207014_g_MissionName)
                AddText(sceneId,x207014_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x207014_g_MissionTarget) 
		AddMoneyBonus(sceneId, x207014_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207014_g_ScriptId, x207014_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207014_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207014_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207014_CheckPushList(sceneId, selfId, targetId) > 0 then
		if (GetName(sceneId,targetId)==x207014_g_Name) then
			AddNumText(sceneId, x207014_g_ScriptId, x207014_g_MissionName)
		end
		if (GetName(sceneId,targetId)==x207014_g_Name2) then
			AddNumText(sceneId, x207015_g_ScriptId, x207014_g_answer1)
			AddNumText(sceneId, x207015_g_ScriptId, x207014_g_answer2)
			AddNumText(sceneId, x207016_g_ScriptId, x207014_g_answer3)
		end
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207014_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207014_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207014_CheckPushList(sceneId, selfId, targetId)
	if IsMissionHaveDone(sceneId, selfId, x207014_g_MissionIdPre) > 0 then
        	if (GetName(sceneId,targetId)==x207014_g_Name) then
                	if IsHaveMission(sceneId,selfId, x207014_g_MissionId)<= 0 then
                   	 return 1
                	end
        	end
		if (GetName(sceneId,targetId)==x207014_g_Name2) then
		    	if IsHaveMission(sceneId,selfId, x207014_g_MissionId) > 0 then
		    	return 1
                    	end
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x207014_OnAccept(sceneId, selfId)

	--加入任务到玩家列表
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x207014_g_MissionId, x207014_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x207014_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
end



--**********************************

--放弃

--**********************************

function x207014_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207014_g_MissionId)

end



--**********************************

--检测是否可以提交

--**********************************

function x207014_CheckSubmit( sceneId, selfId, targetId)

	if IsHaveMission(sceneId, selfId, x207014_g_MissionId) >= 0 then
		return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207014_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207014_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207014_g_MissionId)
		AddExp(sceneId, selfId, x207014_g_ExpBonus)
		AddMoney(sceneId, selfId, x207014_g_MoneyBonus)
		
	end
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207014_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x207014_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207014_OnItemChanged(sceneId, selfId, itemdataId)

end

