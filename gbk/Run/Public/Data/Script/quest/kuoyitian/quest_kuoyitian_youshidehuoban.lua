--幼时的伙伴

--MisDescBegin
x214001_g_ScriptId = 214001
x214001_g_MissionIdPre =107
x214001_g_MissionId = 108
x214001_g_MissionKind = 3
x214001_g_MissionLevel = 15
x214001_g_ScriptIdNext = {ScriptId = 214002 ,LV = 1 }
x214001_g_Name	="铁木真"
x214001_g_Name2	="合答安"  
x214001_g_DemandItem ={}
x214001_g_DemandKill ={{id=358,num=25}}

x214001_g_MissionName="幼时的伙伴"
x214001_g_MissionInfo="    我9岁的时候被泰赤乌人追杀，合答安救了我一名，她把我藏在羊毛堆里，从那时候起，我就发誓，等我长大了一定娶她为妻。\n \n    一直以来，我都没有忘记过她……<铁木真说到这里的时候，露出了一丝羞涩>\n \n    她就被困在D处，"  --任务描述
x214001_g_MissionInfo2="，你要尽快赶去，把那25名围困他的泰赤乌人给杀了，把她带回来。"
x214001_g_MissionTarget="    到D处去，杀死25名#R泰赤乌士兵#W，然后跟#G合答安#W谈谈。"		                                                                                               
x214001_g_MissionComplete="    谢谢你的相救！"					--完成任务npc说话的话
x214001_g_ContinueInfo="    你杀了附近的那些泰赤乌人了吗？"
--任务奖励
x214001_g_MoneyBonus = 600
--固定物品奖励，最多8种
x214001_g_ItemBonus={}

--可选物品奖励，最多8种
x214001_g_RadioItemBonus={}

--MisDescEnd
x214001_g_ExpBonus = 6500
--**********************************

--任务入口函数

--**********************************

function x214001_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x214001_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x214001_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x214001_g_MissionId)
		if x214001_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x214001_g_MissionName)
			AddText(sceneId,x214001_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x214001_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死泰赤乌士兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x214001_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x214001_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x214001_g_MissionName)
		     AddText(sceneId,x214001_g_MissionComplete)
		     AddMoneyBonus(sceneId, x214001_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x214001_g_ScriptId, x214001_g_MissionId)
                end

        elseif x214001_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x214001_g_MissionName)
                AddText(sceneId,x214001_g_MissionInfo..GetName(sceneId, selfId)..x214001_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x214001_g_MissionTarget) 
		AddMoneyBonus(sceneId, x214001_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x214001_g_ScriptId, x214001_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x214001_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x214001_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x214001_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x214001_g_ScriptId, x214001_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x214001_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x214001_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x214001_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==14) then
		if IsMissionHaveDone(sceneId, selfId, x214001_g_MissionIdPre) > 0 then
			if (GetName(sceneId,targetId)==x214001_g_Name) then 
				if IsHaveMission(sceneId,selfId, x214001_g_MissionId) <= 0 then
        	    			return 1
        	    		end
        	    	end
        	    	if (GetName(sceneId,targetId)==x214001_g_Name2) then 
				if IsHaveMission(sceneId,selfId, x214001_g_MissionId) > 0 then
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

function x214001_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x214001_g_MissionId, x214001_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x214001_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x214001_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x214001_g_MissionId)
	for i, item in x214001_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x214001_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x214001_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x214001_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x214001_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x214001_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x214001_g_MissionId)
		AddExp(sceneId, selfId, x214001_g_ExpBonus)
		AddMoney(sceneId, selfId, x214001_g_MoneyBonus)
		for i, item in x214001_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x214001_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x214001_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x214001_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x214001_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x214001_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x214001_g_DemandKill[1].id then 
       		    if num < x214001_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死泰赤乌士兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x214001_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x214001_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x214001_OnItemChanged(sceneId, selfId, itemdataId)

end

