--询问阿拉乌

--MisDescBegin
x207012_g_ScriptId = 207012
x207012_g_MissionIdPre =12
x207012_g_MissionId = 13
x207012_g_MissionKind = 1
x207012_g_ScriptIdNext = {ScriptId = 207013 ,LV = 1 }
x207012_g_Name	="赤老温" 
x207012_g_Name2	="阿拉乌" 

x207012_g_MissionName="询问阿拉乌"
x207012_g_MissionInfo="    金国皇帝疑心太重，而且胆小懦弱，他们暗中在培养一批戴着面具，从来不以真面目示人。这些戴着面具的人，被人称为“鬼仆”！#R鬼仆#W为皇帝保护派出去的大臣，也会监督这些大臣，怕他们起叛逆之心。大金国由此类昏庸无能的皇帝，注定了要被灭国！\n \n    这些#R鬼仆#W在#G野狐岭#W里没有逃走，一定有什么目的……\n \n    你可能要为我跑一趟！到俘虏营里找守营的将领#G阿拉乌#W，看能能不能从投降的野狐岭守将#G术虎#W嘴里掏出点什么！ "  --任务描述
x207012_g_MissionTarget="    到俘虏营寻找#G阿拉乌#W"		
x207012_g_MissionComplete="    噢，真主保佑！我正想去面见#G赤老温#W将军，没想到他先派你来了！嗯，你来的目的我已经知道了，可是我这里出了大问题……，我，我，我很担心！\n \n    如果不能尽快解决这事情，我想，我真的要去见真主了~！我可不想这么快就死，我老婆就快生了！无论如何，你一定要帮我想办法啊，我不想还没见到我的孩子就……"					--完成任务npc说话的话
--任务奖励
x207012_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x207012_g_ItemBonus={}

--可选物品奖励，最多8种
x207012_g_RadioItemBonus={}

--MisDescEnd


--**********************************

--任务入口函数

--**********************************

function x207012_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207012_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207012_g_MissionId) > 0 then
		if (GetName(sceneId,targetId)==x207012_g_Name2) then
                     	BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x207012_g_MissionName)
			AddText(sceneId,x207012_g_MissionComplete)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x207012_g_MissionTarget) 
			AddMoneyBonus(sceneId, x207012_g_MoneyBonus)	
			EndEvent()
			DispatchMissionContinueInfo(sceneId, selfId, targetId, x207012_g_ScriptId, x207012_g_MissionId)
		end
        elseif x207012_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x207012_g_MissionName)
                AddText(sceneId,x207012_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x207012_g_MissionTarget) 
		AddMoneyBonus(sceneId, x207012_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207012_g_ScriptId, x207012_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207012_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207012_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207012_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207012_g_ScriptId, x207012_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207012_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207012_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207012_CheckPushList(sceneId, selfId, targetId)
	if IsMissionHaveDone(sceneId, selfId, x207012_g_MissionIdPre) > 0 then
        	if (GetName(sceneId,targetId)==x207012_g_Name) then
                	if IsHaveMission(sceneId,selfId, x207012_g_MissionId)<= 0 then
                   	 return 1
                	end
        	end
		if (GetName(sceneId,targetId)==x207012_g_Name2) then
		    	if IsHaveMission(sceneId,selfId, x207012_g_MissionId) > 0 then
		    	return 1
                    	end
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x207012_OnAccept(sceneId, selfId)

	--加入任务到玩家列表
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x207012_g_MissionId, x207012_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x207012_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
end



--**********************************

--放弃

--**********************************

function x207012_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207012_g_MissionId)

end



--**********************************

--检测是否可以提交

--**********************************

function x207012_CheckSubmit( sceneId, selfId, targetId)

	if IsHaveMission(sceneId, selfId, x207012_g_MissionId) >= 0 then
		return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207012_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207012_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207012_g_MissionId)
		AddExp(sceneId, selfId, x207012_g_ExpBonus)
		AddMoney(sceneId, selfId, x207012_g_MoneyBonus)
		CallScriptFunction( x207012_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )

	end
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207012_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x207012_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207012_OnItemChanged(sceneId, selfId, itemdataId)

end

