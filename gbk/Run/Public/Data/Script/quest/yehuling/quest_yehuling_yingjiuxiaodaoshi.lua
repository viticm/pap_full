--营救小道士

--MisDescBegin
x207017_g_ScriptId = 207017
x207017_g_MissionIdPre =15
x207017_g_MissionId = 18
x207017_g_MissionKind = 1
x207017_g_ScriptIdNext = {ScriptId = 207018 ,LV = 1 }
x207017_g_Name	="矮胖子" 
x207017_g_Name2	="小道士" 

x207017_g_MissionName="营救小道士"
x207017_g_MissionInfo="    是#G流浪汉#W那烂人叫你来的？这穷酸，又卖弄起学问来了！\n \n    术虎疑心太大，而且狡猾的很，我们的眼线几次都差点跟丢了。认你怎么想你都想不出来，他现在化妆成什么样子，哈哈哈哈，说出来一定会笑死人，不敢相信……\n \n    堂堂的一名将军，为了逃命，他把自己的胡子剃了，居然化装成一个胖妇人，哈哈哈！为了这个消息，我们的兄弟被#R流窜的金兵#W给抓住了。\n \n    如果你能把他救出来，说不定他知道点什么！他是一名#G小道士#W，被关押在（xxx，xxx）处 "  --任务描述
x207017_g_MissionTarget="    找到被关押的#G小道士#W"		
x207017_g_MissionComplete="    这些金兵到处流窜，山里的猎户都被他们抢光了……！恩，关于术虎的行踪，我最后一次见他是在黑风口一带,他和一#G算命先生#W在一起，附近有一群带着面具的人暗中保护着，你可要小心啊！"					--完成任务npc说话的话
--任务奖励
x207017_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x207017_g_ItemBonus={}

--可选物品奖励，最多8种
x207017_g_RadioItemBonus={}

--MisDescEnd


--**********************************

--任务入口函数

--**********************************

function x207017_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207017_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207017_g_MissionId) > 0 then
		if (GetName(sceneId,targetId)==x207017_g_Name2) then
                     	BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x207017_g_MissionName)
			AddText(sceneId,x207017_g_MissionComplete)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x207017_g_MissionTarget) 
			AddMoneyBonus(sceneId, x207017_g_MoneyBonus)	
			EndEvent()
			DispatchMissionContinueInfo(sceneId, selfId, targetId, x207017_g_ScriptId, x207017_g_MissionId)
		end
        elseif x207017_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x207017_g_MissionName)
                AddText(sceneId,x207017_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x207017_g_MissionTarget) 
		AddMoneyBonus(sceneId, x207017_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207017_g_ScriptId, x207017_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207017_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207017_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207017_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207017_g_ScriptId, x207017_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207017_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207017_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207017_CheckPushList(sceneId, selfId, targetId)
	if IsMissionHaveDone(sceneId, selfId, x207017_g_MissionIdPre) > 0 then
        	if (GetName(sceneId,targetId)==x207017_g_Name) then
                	if IsHaveMission(sceneId,selfId, x207017_g_MissionId)<= 0 then
                   	 return 1
                	end
        	end
		if (GetName(sceneId,targetId)==x207017_g_Name2) then
		    	if IsHaveMission(sceneId,selfId, x207017_g_MissionId) > 0 then
		    	return 1
                    	end
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x207017_OnAccept(sceneId, selfId)

	--加入任务到玩家列表
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x207017_g_MissionId, x207017_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x207017_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
end



--**********************************

--放弃

--**********************************

function x207017_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207017_g_MissionId)

end



--**********************************

--检测是否可以提交

--**********************************

function x207017_CheckSubmit( sceneId, selfId, targetId)

	if IsHaveMission(sceneId, selfId, x207017_g_MissionId) >= 0 then
		return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207017_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207017_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207017_g_MissionId)
		AddExp(sceneId, selfId, x207017_g_ExpBonus)
		AddMoney(sceneId, selfId, x207017_g_MoneyBonus)
		
	end
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207017_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x207017_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207017_OnItemChanged(sceneId, selfId, itemdataId)

end

