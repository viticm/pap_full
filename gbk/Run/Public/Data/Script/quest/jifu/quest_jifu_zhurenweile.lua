--助人为乐

--MisDescBegin
x225000_g_ScriptId = 225000
--x225000_g_MissionIdPre =41
x225000_g_MissionId = 322
x225000_g_MissionKind = 22
x225000_g_MissionLevel = 110
x225000_g_ScriptIdNext = {ScriptId = 225001 ,LV = 1 }
x225000_g_Name	="速不台" 
x225000_g_DemandItem ={}
x225000_g_DemandKill ={{id=435,num=30}}

x225000_g_MissionName="助人为乐"
x225000_g_MissionInfo="    看见南面的教堂了吗？那就是#G索菲亚大教堂#W，今天在那里发生了一见非常有趣的事。那些基辅人跑到教堂里面去寻求他们主的庇护，人越聚越多。后来教堂里面装不下人，外面惊恐万分的难民仍然希望在教堂圣地附近找到安全之地，很多人爬上教堂的围墙，到屋顶上去寻找避难所，由于他们的人数太多，以致于整个建筑物因不堪重负而倒塌，压死了许多拥挤在教堂里面的人。\n \n    既然基辅人那么相信他们的主，那我们就帮帮他们，让他们直接去见他们的主吧。去给我杀了30个#R寻求庇护者#W。"  --任务描述
x225000_g_MissionTarget="    #G速不台#W命你到#G索菲亚大教堂#W附近杀死30个#R寻求庇护者#W。"		                                                                                               
x225000_g_MissionComplete="    教堂被信徒给压塌了，哈哈。看来他们已经被他们的主抛弃了。"					--完成任务npc说话的话
x225000_g_ContinueInfo="    能帮助他们见到自己的主，我很高兴。我历来都喜欢助人为乐。"
--任务奖励
x225000_g_MoneyBonus = 500

--固定物品奖励，最多8种
x225000_g_ItemBonus={}

--可选物品奖励，最多8种
x225000_g_RadioItemBonus={}

--MisDescEnd
x225000_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x225000_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x225000_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x225000_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x225000_g_MissionId)
		if x225000_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x225000_g_MissionName)
			AddText(sceneId,x225000_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x225000_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死寻求庇护者   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x225000_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x225000_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x225000_g_MissionName)
		     AddText(sceneId,x225000_g_MissionComplete)
		     AddMoneyBonus(sceneId, x225000_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x225000_g_ScriptId, x225000_g_MissionId)
                end

        elseif x225000_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x225000_g_MissionName)
                AddText(sceneId,x225000_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x225000_g_MissionTarget) 
		AddMoneyBonus(sceneId, x225000_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x225000_g_ScriptId, x225000_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x225000_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x225000_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x225000_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x225000_g_ScriptId, x225000_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x225000_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x225000_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x225000_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==16) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x225000_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x225000_g_MissionId, x225000_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x225000_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x225000_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x225000_g_MissionId)
	for i, item in x225000_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x225000_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x225000_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x225000_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x225000_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x225000_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x225000_g_MissionId)
		AddExp(sceneId, selfId, x225000_g_ExpBonus)
		AddMoney(sceneId, selfId, x225000_g_MoneyBonus)
		for i, item in x225000_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x225000_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x225000_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x225000_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x225000_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x225000_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x225000_g_DemandKill[1].id then 
       		    if num < x225000_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死寻求庇护者   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x225000_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x225000_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x225000_OnItemChanged(sceneId, selfId, itemdataId)

end

