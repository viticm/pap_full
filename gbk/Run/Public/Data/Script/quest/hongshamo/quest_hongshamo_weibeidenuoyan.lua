--违背的诺言

--MisDescBegin
x205012_g_ScriptId = 205012
x205012_g_MissionIdPre =51
x205012_g_MissionId = 52
x205012_g_MissionKind = 11
x205012_g_MissionLevel = 55
--x205012_g_ScriptIdNext = {ScriptId = 205002 ,LV = 1 }
x205012_g_Name	="扎兰丁" 
x205012_g_Name2	="速不台" 
--x205012_g_DemandItem ={{id=13010003,num=1}}
--x205012_g_noDemandKill ={{id=301,num=1}}	

x205012_g_MissionName="违背的诺言"
x205012_g_MissionInfo="    （扎兰丁脸色阴晴不定，他眼里的那抹凶光却让人感到寒栗）\n \n    哈哈哈，这个宝箱到底是哪里来的？我花剌子模帝国还需要你这样的人帮忙吗？在我们帝国的土地上，是没有任何盗贼的，你居然敢对我说谎！\n \n    你刚刚杀了我的侍卫，这是大家都看到的。嘿嘿，你不要狡辩了，我的侍卫只不过是化装成盗贼在此练兵，你居然为了一个宝箱杀了他们！\n \n    我不会放过你的，你们这些异国的叛逆者，背叛真主的人，我看你们就是奸细，我要让你们这群奸细有来无回，一个不剩的杀了。"  --任务描述
x205012_g_MissionTarget="    扎兰丁违背了他的诺言，还污蔑我们是奸细，一定要逃离这里，把消息尽快带给#G速不台#W将军，让他好有防范。"		
x205012_g_MissionComplete="    那些花剌子模人是最不可靠的，大汗早就料到了。"					--完成任务npc说话的话
--x205012_g_ContinueInfo="    不管付出多大代价，也要把那件东西给拿回来。"
--任务奖励
x205012_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x205012_g_ItemBonus={}

--可选物品奖励，最多8种
x205012_g_RadioItemBonus={}

--MisDescEnd
x205012_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x205012_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x205012_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x205012_g_MissionId) > 0 then
		
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x205012_g_MissionName)
		     AddText(sceneId,x205012_g_MissionComplete)
		     AddMoneyBonus(sceneId, x205012_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x205012_g_ScriptId, x205012_g_MissionId)
                

        elseif x205012_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x205012_g_MissionName)
                AddText(sceneId,x205012_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x205012_g_MissionTarget) 
		AddMoneyBonus(sceneId, x205012_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x205012_g_ScriptId, x205012_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x205012_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x205012_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x205012_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x205012_g_ScriptId, x205012_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x205012_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x205012_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x205012_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==5) then
	        if IsMissionHaveDone(sceneId, selfId, x205012_g_MissionIdPre) > 0 then
	        	if (GetName(sceneId,targetId)==x205012_g_Name) then
	        	        if IsHaveMission(sceneId,selfId, x205012_g_MissionId)<= 0 then
	        	            	return 1
	        	        end
	        	end
			if (GetName(sceneId,targetId)==x205012_g_Name2) then
				    if IsHaveMission(sceneId,selfId, x205012_g_MissionId) > 0 then
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

function x205012_OnAccept(sceneId, selfId)

	                                                  
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x205012_g_MissionId, x205012_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x205012_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
	LuaFnCreateMonster(sceneId, 306,135,174,0,1,-1)
	LuaFnCreateMonster(sceneId, 306,136,176,0,1,-1)
	LuaFnCreateMonster(sceneId, 306,140,174,0,1,-1)
	LuaFnCreateMonster(sceneId, 306,139,176,0,1,-1)
	         	                                    
	     
end



--**********************************

--放弃

--**********************************

function x205012_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x205012_g_MissionId)
	for i, item in pairs(x205012_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x205012_CheckSubmit( sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x205012_g_Name2) then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x205012_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x205012_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x205012_g_MissionId)
		AddExp(sceneId, selfId, x205012_g_ExpBonus)
		AddMoney(sceneId, selfId, x205012_g_MoneyBonus)
		for i, item in pairs(x205012_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x205012_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x205012_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x205012_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x205012_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x205012_OnItemChanged(sceneId, selfId, itemdataId)

end

