--一怒屠城

--MisDescBegin
x217011_g_ScriptId = 217011
--x217011_g_MissionIdPre =41
x217011_g_MissionId = 183
x217011_g_MissionKind = 6
x217011_g_MissionLevel = 30
--x217011_g_ScriptIdNext = {ScriptId = 217001 ,LV = 1 }
x217011_g_Name	="拖雷" 
x217011_g_DemandItem ={}
x217011_g_DemandKill ={{id=457,num=20}}

x217011_g_MissionName="一怒屠城"
x217011_g_MissionInfo="    乌月营即将被攻破，他们不仅不投降，还放毒烟试图击退我们，他们把我们不少的将士吊死在书上对我们示威！\n \n    我们蒙古铁骑是天下第一的铁血雄狮，从来不缺少热血和勇气，为了我们的国家，即使牺牲也在所不惜。\n \n    这是我们铁骑战无不胜的关键，为了征服金国，为了给先祖报仇，为了所有汗国的兄弟姐妹，我们一定要战斗。\n \n    所有的人听到我的号召，都必须服从我们的命令，放开你们的胆量屠城，我要让这里变成死城！"  --任务描述
x217011_g_MissionTarget="    #G拖雷#W一怒之下，号召所有的战士进行屠城，向#G物资处#W进攻，你要出一份自己的力量，杀死20名#R乌月营步兵#W。"		                                                                                               
x217011_g_MissionComplete="    烧光他们的粮草，杀光所有的人，让他们看看我们的手段！"					--完成任务npc说话的话
x217011_g_ContinueInfo="    所有的战士都去战斗，凡是胆怯退缩者，杀无赦。"
--任务奖励
x217011_g_MoneyBonus = 500

--固定物品奖励，最多8种
x217011_g_ItemBonus={}

--可选物品奖励，最多8种
x217011_g_RadioItemBonus={}

--MisDescEnd
x217011_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x217011_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x217011_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x217011_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x217011_g_MissionId)
		if x217011_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x217011_g_MissionName)
			AddText(sceneId,x217011_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x217011_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死乌月营步兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x217011_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x217011_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x217011_g_MissionName)
		     AddText(sceneId,x217011_g_MissionComplete)
		     AddMoneyBonus(sceneId, x217011_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x217011_g_ScriptId, x217011_g_MissionId)
                end

        elseif x217011_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x217011_g_MissionName)
                AddText(sceneId,x217011_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x217011_g_MissionTarget) 
		AddMoneyBonus(sceneId, x217011_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x217011_g_ScriptId, x217011_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x217011_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x217011_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x217011_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x217011_g_ScriptId, x217011_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x217011_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x217011_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x217011_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==20) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x217011_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x217011_g_MissionId, x217011_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x217011_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x217011_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x217011_g_MissionId)
	for i, item in x217011_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x217011_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x217011_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x217011_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x217011_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x217011_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x217011_g_MissionId)
		AddExp(sceneId, selfId, x217011_g_ExpBonus)
		AddMoney(sceneId, selfId, x217011_g_MoneyBonus)
		for i, item in x217011_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x217011_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x217011_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x217011_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x217011_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x217011_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x217011_g_DemandKill[1].id then 
       		    if num < x217011_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死乌月营步兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x217011_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x217011_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x217011_OnItemChanged(sceneId, selfId, itemdataId)

end

