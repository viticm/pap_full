--勇士的见证

--MisDescBegin
x205002_g_ScriptId = 205002
--x205002_g_MissionIdPre =41
x205002_g_MissionId = 42
x205002_g_MissionKind = 11
x205002_g_MissionLevel = 55
--x205002_g_ScriptIdNext = {ScriptId = 205003 ,LV = 1 }
x205002_g_Name	="速不台" 
x205002_g_DemandItem ={}
x205002_g_DemandKill ={{id=302,num=30}}

x205002_g_MissionName="勇士的见证"
x205002_g_MissionInfo="    <速不台在焦急的来回走，见到你来，欲言又止，最后还是跟你说话了>\n \n    我们善良的蒙古商队，是奉成吉思汗的旨意，到花剌子模来通商，这是一件对两国人民都有益的事情。数不尽的草原宝物和这个野蛮国家所没有的商品，能让他们富足，弥补稀缺。可是，他们却趁着我们被盗贼打劫的时候，派大军团团的围住我们……！他们已经伤了我们十多人！我作为商队的护卫队首领，本不应该跟他们冲突，但是，作为长生天的奴仆，成吉思汗的子民，我们不能这么让他们这么欺负。\n \n"  --任务描述
x205002_g_MissionInfo2="    ,你替我去教训他们把（124，114）处的那些花剌子模士兵给杀了，让他们尝尝我们的手段。"
x205002_g_MissionTarget="    #G速不台#W命你杀了30个#R花剌子模士兵#W，让他们尝尝我们长生天勇士的厉害。"		                                                                                               
x205002_g_MissionComplete="    当你的武器划破敌人喉咙的时候，那皮肤的撕裂声音，在整个沙漠里奏起！我听得见，我看得见，因为鲜血的召唤，把死神给带来了。"					--完成任务npc说话的话
x205002_g_ContinueInfo="    我们不想惹事，但是我们是天生的勇士，从来都不怕事！去吧，让这些人尝尝我们的厉害"
--任务奖励
x205002_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x205002_g_ItemBonus={}

--可选物品奖励，最多8种
x205002_g_RadioItemBonus={}

--MisDescEnd
x205002_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x205002_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x205002_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x205002_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x205002_g_MissionId)
		if x205002_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x205002_g_MissionName)
			AddText(sceneId,x205002_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x205002_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死花剌子模士兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x205002_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x205002_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x205002_g_MissionName)
		     AddText(sceneId,x205002_g_MissionComplete)
		     AddMoneyBonus(sceneId, x205002_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x205002_g_ScriptId, x205002_g_MissionId)
                end

        elseif x205002_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x205002_g_MissionName)
                AddText(sceneId,x205002_g_MissionInfo..GetName(sceneId, selfId)..x205002_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x205002_g_MissionTarget) 
		AddMoneyBonus(sceneId, x205002_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x205002_g_ScriptId, x205002_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x205002_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x205002_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x205002_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x205002_g_ScriptId, x205002_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x205002_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x205002_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x205002_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==5) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x205002_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x205002_g_MissionId, x205002_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x205002_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x205002_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x205002_g_MissionId)
	for i, item in x205002_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x205002_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x205002_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x205002_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x205002_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x205002_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x205002_g_MissionId)
		AddExp(sceneId, selfId, x205002_g_ExpBonus)
		AddMoney(sceneId, selfId, x205002_g_MoneyBonus)
		for i, item in x205002_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x205002_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x205002_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x205002_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x205002_g_MissionId) >= 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x205002_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x205002_g_DemandKill[1].id then 
       		    if num < x205002_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死花剌子模士兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x205002_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x205002_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x205002_OnItemChanged(sceneId, selfId, itemdataId)

end

