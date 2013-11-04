--千年龟王的眼泪

--MisDescBegin
x206008_g_ScriptId = 206008
--x206008_g_MissionIdPre =34
x206008_g_MissionId = 35
x206008_g_MissionKind = 8
x206008_g_MissionLevel = 40
--x206008_g_ScriptIdNext = {ScriptId = 206009 ,LV = 1 }
x206008_g_Name	="阔阔出" 
x206008_g_DemandItem ={{id=13010048,num=10}}
x206008_g_noDemandKill ={id=401,num=1}


x206008_g_MissionName="千年龟王的眼泪"
x206008_g_MissionInfo="，你应该为能见到我而荣幸，我是成吉思汗帐下的通天巫，除了和天神通灵之外，我只跟成吉思汗和我的父母说话。\n \n    天上的神灵托梦告诉我，成吉思汗是长生天的儿子，他肩负着统一天下的重任，而我，是他最能干，最得力的巫师，只有依靠我，才能打赢丈！\n \n    恩，太多的秘密，你还没有资格听……，我需要十滴#c0080C0千年龟王的眼泪#W来做药引，配长生不老之药！\n \n    选中你，是你的荣幸！你快去为我做这个事情吧！"  --任务描述
x206008_g_MissionTarget="    采集十滴#c0080C0千年龟王的眼泪#W带给#G阔阔出#W。"		                                                                                               
x206008_g_MissionComplete="    你找到#c0080C0千年龟王的眼泪#W了？怎么可能……！就凭你？？\n \n    给我……，光滑如玉，凝聚如脂，芳香四溢……，你，你怎么可能找到？千年龟王一向呆在北极的最深处，怎么会……\n \n    咳~！很抱歉，我失态了！看不出来你是个身怀绝技的高手啊，成吉思汗一向是求才若渴，我要是推荐的话，你将会称为大汗最信任的那可儿。\n \n    恩，是的，我和你十分有缘，就这样决定，这是我的推荐信，如果你有机会遇到#G成吉思汗#W，一定会得到重用。我能与神共语，你所做的一切都逃不过我的眼睛，如果大汗有什么重要的机密，记得偷偷告诉我！你别怀疑，我只是想多为大汗分担而已！"			--完成任务npc说话的话
x206008_g_ContinueInfo="    太多的秘密，你还没有资格听……泄露天机是要被天谴的！"
--任务奖励
x206008_g_MoneyBonus = 10000

--固定物品奖励，最多8种
x206008_g_ItemBonus={}

--可选物品奖励，最多8种
x206008_g_RadioItemBonus={}

--MisDescEnd
x206008_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x206008_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	

	--检测列出条件
	if x206008_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x206008_g_MissionId) > 0 then
			if x206008_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                	        BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x206008_g_MissionName)
				AddText(sceneId,x206008_g_ContinueInfo)
			        AddText(sceneId,"#Y任务目标#W") 
				AddText(sceneId,x206008_g_MissionTarget) 
				AddText(sceneId,format("\n    千年龟王的眼泪   %d/%d", LuaFnGetItemCount(sceneId,selfId,x206008_g_DemandItem[1].id),x206008_g_DemandItem[1].num ))
				EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
			end
                	
			     
                	if x206008_CheckSubmit(sceneId, selfId, targetId) > 0 then
                	     BeginEvent(sceneId)
                	     AddText(sceneId,"#Y"..x206008_g_MissionName)
			     AddText(sceneId,x206008_g_MissionComplete)
			     AddMoneyBonus(sceneId, x206008_g_MoneyBonus)
                	     EndEvent()
			     DispatchMissionContinueInfo(sceneId, selfId, targetId, x206008_g_ScriptId, x206008_g_MissionId)
                	end
      
        elseif x206008_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x206008_g_MissionName)
                AddText(sceneId,x206008_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x206008_g_MissionTarget) 
		AddMoneyBonus(sceneId, x206008_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x206008_g_ScriptId, x206008_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x206008_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x206008_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x206008_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x206008_g_ScriptId, x206008_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x206008_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x206008_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x206008_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==6) then
                    return 1
        end
	return 0
	
end

--**********************************

--接受

--**********************************

function x206008_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x206008_g_MissionId, x206008_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x206008_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x206008_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x206008_g_MissionId)
	for i, item in x206008_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x206008_CheckSubmit( sceneId, selfId, targetId)
	if LuaFnGetItemCount(sceneId,selfId,x206008_g_DemandItem[1].id) == x206008_g_DemandItem[1].num then
		return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x206008_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x206008_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x206008_g_MissionId)
		AddExp(sceneId, selfId, x206008_g_ExpBonus)
		AddMoney(sceneId, selfId, x206008_g_MoneyBonus)
		for i, item in x206008_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x206008_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x206008_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x206008_OnKillObject(sceneId, selfId, objdataId)
	if LuaFnGetItemCount(sceneId,selfId,x206008_g_DemandItem[1].id) < x206008_g_DemandItem[1].num then
        	if IsHaveMission(sceneId,selfId, x206008_g_MissionId) > 0 then
        		if objdataId == x206008_g_noDemandKill.id then
				BeginAddItem(sceneId)                                                    
				AddItem( sceneId,x206008_g_DemandItem[1].id, 1 )             
				ret = EndAddItem(sceneId,selfId)                                 
		        	if ret > 0 then                                                  
		       	 	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("千年龟王的眼泪   %d/%d", LuaFnGetItemCount(sceneId,selfId,x206008_g_DemandItem[1].id)+1,x206008_g_DemandItem[1].num )) 
				 	EndEvent()
				 	DispatchMissionTips(sceneId, selfId)
				 	AddItemListToHuman(sceneId,selfId) 
		        	else                                                             
		        	 	BeginEvent(sceneId)                                      
				 	AddText(sceneId,"物品栏已满！")                    
				 	EndEvent(sceneId)                                        
				 	DispatchMissionTips(sceneId,selfId) 
				end
			end
		end
	end
	 

end



--**********************************

--进入区域事件

--**********************************

function x206008_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x206008_OnItemChanged(sceneId, selfId, itemdataId)

end

