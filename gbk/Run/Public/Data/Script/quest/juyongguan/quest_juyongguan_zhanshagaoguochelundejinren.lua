--斩杀高过车轮的金人

--MisDescBegin
x206000_g_ScriptId = 206000
--x206000_g_MissionIdPre =
x206000_g_MissionId = 27
x206000_g_MissionKind = 8
x206000_g_MissionLevel = 40
x206000_g_ScriptIdNext = {ScriptId = 206001 ,LV = 1 }
x206000_g_Name	="速不台" 
x206000_g_DemandItem ={}
x206000_g_DemandKill ={{id=405,num=10},{id=406,num=10}}

x206000_g_MissionName="斩杀高过车轮的金人"
x206000_g_MissionInfo="    大家都听着！大家都听着！是英雄的都竖起你们的大耳朵，聆听腾格里的呼唤声音！我们的铁蹄已经跨过了野狐岭，狂风将带着我们蒙古人几百年来的怒火和力量，攻下了金国号称是天下第一屏障的居庸关。\n \n    被钉死在木驴上的先祖俺巴孩汗啊，你是否听到了我们蒙古人的呼声，为了洗清我们几百年来被金人凌辱之仇，为了让你能瞑目，请继续保佑着这些勇士们，让他们的弯刀和弓箭，变成死神吧！\n \n    凡是超过车轮高的男人，不管是百姓还是士兵，全都不留活口！去，按照大汗的旨意，到战俘营地去给我证明你们的能力吧！"  --任务描述
x206000_g_MissionTarget="    替#G速不台#W杀掉10个#R投降的金兵#W和10个#R金国百姓#W"		                                                                                               
x206000_g_MissionComplete="    我理想的士兵，是一名活着的死士，只有在战场上死过一次的人才知道，对敌人手软，就是对自己的同伴凶残。 恭喜你，成为了我南征的第一名新部下！从你的身上，我看到了你的辉煌，你将会是我见过的最勇猛的英雄。"					--完成任务npc说话的话
x206000_g_ContinueInfo="    我们几百年的恩怨和怒火，是需要战争才能宣泄的！"
--任务奖励
x206000_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x206000_g_ItemBonus={}

--可选物品奖励，最多8种
x206000_g_RadioItemBonus={}

--MisDescEnd
x206000_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x206000_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x206000_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x206000_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x206000_g_MissionId)
		if x206000_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x206000_g_MissionName)
			AddText(sceneId,x206000_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x206000_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死投降的金兵   %d/%d\n    杀死金国百姓   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x206000_g_DemandKill[1].num,GetMissionParam(sceneId,selfId,misIndex,1),x206000_g_DemandKill[2].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x206000_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x206000_g_MissionName)
		     AddText(sceneId,x206000_g_MissionComplete)
		     AddMoneyBonus(sceneId, x206000_g_MoneyBonus)
                     EndEvent()
		     DispatchMissionContinueInfo(sceneId, selfId, targetId, x206000_g_ScriptId, x206000_g_MissionId)
                end

        elseif x206000_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x206000_g_MissionName)
                AddText(sceneId,x206000_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x206000_g_MissionTarget) 
		AddMoneyBonus(sceneId, x206000_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x206000_g_ScriptId, x206000_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x206000_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x206000_g_MissionId) > 0 then
		return 0
	end
	--如果已接此任务
	if  x206000_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x206000_g_ScriptId, x206000_g_MissionName)
	end
	return 0
	
end



--**********************************

--检测接受条件

--**********************************

function x206000_CheckAccept(sceneId, selfId, targetId)
	if (GetName(sceneId,targetId)==x206000_g_Name) then
		return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x206000_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==6) then
                return 1
        end
	return 0	
end

--**********************************

--接受

--**********************************

function x206000_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x206000_g_MissionId, x206000_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x206000_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x206000_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x206000_g_MissionId)
	for i, item in x206000_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x206000_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x206000_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x206000_g_DemandKill[1].num then
		if GetMissionParam(sceneId,selfId,misIndex,1) == x206000_g_DemandKill[2].num then
	        	return 1
	        end
	end
	return 0

end



--**********************************

--提交

--**********************************

function x206000_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x206000_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x206000_g_MissionId)
		AddExp(sceneId, selfId, x206000_g_ExpBonus)
		AddMoney(sceneId, selfId, x206000_g_MoneyBonus)
		for i, item in x206000_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x206000_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x206000_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x206000_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x206000_g_MissionId) >= 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x206000_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0)
	 num2 = GetMissionParam(sceneId,selfId,misIndex,1)  
		 if objdataId == x206000_g_DemandKill[1].id then 
       		    if num < x206000_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死投降的金兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x206000_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 if objdataId == x206000_g_DemandKill[2].id then 
       		    if num2 < x206000_g_DemandKill[2].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,1,num2+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死金国百姓   %d/%d", GetMissionParam(sceneId,selfId,misIndex,1),x206000_g_DemandKill[2].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x206000_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x206000_OnItemChanged(sceneId, selfId, itemdataId)

end

