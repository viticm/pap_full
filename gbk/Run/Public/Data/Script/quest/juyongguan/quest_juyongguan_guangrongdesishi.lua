--光荣的死士

--MisDescBegin
x206010_g_ScriptId = 206010
x206010_g_MissionIdPre =36
x206010_g_MissionId = 37
x206010_g_MissionKind = 8
x206010_g_MissionLevel = 40
x206010_g_ScriptIdNext = {ScriptId = 206011 ,LV = 1 }
x206010_g_Name	="窝阔台" 
x206010_g_Name2	="朱家亮" 
x206010_g_Name3	="金兵甲" 
x206010_g_Name4	="金兵乙" 
x206010_g_DemandItem ={}
x206010_g_DemandKill ={{id=400,num=20}}

x206010_g_MissionName="光荣的死士"
x206010_g_MissionInfo="    这些金兵真不知死活，忽兰王妃说，你一身的功夫出神入化，而且颇得我父汗的赞赏，我也很想见识一下你的功夫。\n \n    前面的一个营寨是金兵的营寨，由于地势的原因，我们一直无法攻下他，这次，就看看你的手段了！\n \n    不过，恩，我父汗非常欣赏这营寨的将领#G朱家亮#W，只希望能把他招降，你可不能杀他。"  --任务描述
x206010_g_MissionTarget="    窝阔台命你去杀掉20个#R金国守卫#W并劝说#G朱家亮#W和他的手下投降投降。"		                                                                                               
x206010_g_MissionComplete="     朱将军只是区区两百人，就难倒我们三千铁骑！这样的人才，如果能为我们所用，那我们将会实力大增。\n \n    不过，我们只有一天的时间……\n \n    忽兰公主带来父汗的口谕，是让我们想办法得到他！即使得不到，也不能让别人得到他！不然后患无穷！\n \n    我不希望损失一个英雄！"					--完成任务npc说话的话
x206010_g_ContinueInfo="    从乌月营打到居庸关，只有这个营寨的将军是一条真的汉子。"
x206010_g_MidInfo2="    本将军区区两百人，就把你们三千人马给弄得人仰马翻，就算是死，今生也无憾了！废话少说，有本事就长个翅膀上来抓我！难道你们的蒙古铁蹄就只会JJYY的劝降吗？"
x206010_g_MidInfo3="    即使你说再多，我们也不会相信，居庸关是天险之地，你们连我们都攻不下，更别指望攻下居庸关！"
x206010_g_MidInfo4="    我们这两百人，跟随朱将军将近十年，纪律森严，个个都是死士，你们人马再多，我们也不会皱一下眉头。没有守城将军撤退的号令，我们就算战死，也不会离开这里！"

--任务奖励
x206010_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x206010_g_ItemBonus={}

--可选物品奖励，最多8种
x206010_g_RadioItemBonus={}

--MisDescEnd
x206010_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x206010_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x206010_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x206010_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x206010_g_MissionId)
		if (GetName(sceneId,targetId)==x206010_g_Name) then
                	if x206010_CheckSubmit(sceneId, selfId, targetId) <= 0 then
	                        BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x206010_g_MissionName)
				AddText(sceneId,x206010_g_ContinueInfo)
			        AddText(sceneId,"#Y任务目标#W") 
				AddText(sceneId,x206010_g_MissionTarget) 
				AddText(sceneId,format("\n    杀死金国守卫   %d/%d\n    劝说朱家亮   %d/1\n    劝说士兵甲   %d/1\n    劝说士兵乙   %d/1", GetMissionParam(sceneId,selfId,misIndex,0),x206010_g_DemandKill[1].num,GetMissionParam(sceneId,selfId,misIndex,1),GetMissionParam(sceneId,selfId,misIndex,2),GetMissionParam(sceneId,selfId,misIndex,3) ))
				EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
			else 
				BeginEvent(sceneId)
	                     	AddText(sceneId,"#Y"..x206010_g_MissionName)
			    	AddText(sceneId,x206010_g_MissionComplete)
			    	AddMoneyBonus(sceneId, x206010_g_MoneyBonus)
	                     	EndEvent()
			    	DispatchMissionContinueInfo(sceneId, selfId, targetId, x206010_g_ScriptId, x206010_g_MissionId)
	                end
	       elseif  (GetName(sceneId,targetId)==x206010_g_Name2) then
	       		SetMissionByIndex(sceneId,selfId,misIndex,1,1)
	        	BeginEvent(sceneId)
			AddText(sceneId,x206010_g_MidInfo2)
        		EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
			BeginEvent(sceneId)
			AddText(sceneId,format("劝说朱家亮   %d/1", GetMissionParam(sceneId,selfId,misIndex,1) ))
			EndEvent()
			DispatchMissionTips(sceneId, selfId)
	       elseif  (GetName(sceneId,targetId)==x206010_g_Name3) then
	       		SetMissionByIndex(sceneId,selfId,misIndex,2,1)
	        	BeginEvent(sceneId)
			AddText(sceneId,x206010_g_MidInfo3)
        		EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
			BeginEvent(sceneId)
			AddText(sceneId,format("劝说士兵甲   %d/1", GetMissionParam(sceneId,selfId,misIndex,2) ))
			EndEvent()
			DispatchMissionTips(sceneId, selfId)
			
	       elseif  (GetName(sceneId,targetId)==x206010_g_Name4) then
	       		SetMissionByIndex(sceneId,selfId,misIndex,3,1)
	        	BeginEvent(sceneId)
			AddText(sceneId,x206010_g_MidInfo4)
        		EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
			BeginEvent(sceneId)
			AddText(sceneId,format("劝说士兵乙   %d/1", GetMissionParam(sceneId,selfId,misIndex,3) ))
			EndEvent()
			DispatchMissionTips(sceneId, selfId)
		end
	                

        elseif x206010_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x206010_g_MissionName)
                AddText(sceneId,x206010_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x206010_g_MissionTarget) 
		AddMoneyBonus(sceneId, x206010_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x206010_g_ScriptId, x206010_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x206010_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x206010_g_MissionId) > 0 then
		return 0
	end
	--如果已接此任务
	if  x206010_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x206010_g_ScriptId, x206010_g_MissionName)
	end
	return 0
	
end



--**********************************

--检测接受条件

--**********************************

function x206010_CheckAccept(sceneId, selfId, targetId)
	if IsMissionHaveDone(sceneId, selfId, x206010_g_MissionIdPre) > 0 then
		return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x206010_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==6) then
		misIndex = GetMissionIndexByID(sceneId,selfId,x206010_g_MissionId)  
        	if IsMissionHaveDone(sceneId, selfId, x206010_g_MissionIdPre) > 0 then
        		if (GetName(sceneId,targetId)==x206010_g_Name) then
        	        	return 1
        	        end
        	        if (GetName(sceneId,targetId)==x206010_g_Name2) then
        	        	if IsHaveMission(sceneId, selfId, x206010_g_MissionId) >= 0 then 
        	        		if GetMissionParam(sceneId,selfId,misIndex,1) <=0 then
        	        			return 1
        	        		end
        	        	end
        	        end
		 	if (GetName(sceneId,targetId)==x206010_g_Name3) then
        	        	if IsHaveMission(sceneId, selfId, x206010_g_MissionId) >= 0 then 
        	        		if GetMissionParam(sceneId,selfId,misIndex,2) <=0 then
        	        			return 1
        	        		end
        	        	end
        	        end	
        	        if (GetName(sceneId,targetId)==x206010_g_Name4) then
        	        	if IsHaveMission(sceneId, selfId, x206010_g_MissionId) >= 0 then 
        	        		if GetMissionParam(sceneId,selfId,misIndex,3) <=0 then
        	        			return 1
        	        		end
        	        	end
        	        end	
        	        	
        	end
        end
        return 0
		
end

--**********************************

--接受

--**********************************

function x206010_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x206010_g_MissionId, x206010_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x206010_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x206010_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x206010_g_MissionId)
	for i, item in pairs(x206010_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x206010_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x206010_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x206010_g_DemandKill[1].num then
		if GetMissionParam(sceneId,selfId,misIndex,1) == 1 then
			if GetMissionParam(sceneId,selfId,misIndex,2) == 1 then
				if GetMissionParam(sceneId,selfId,misIndex,3) == 1 then
	        			return 1
	        		end
	        	end
	        end
	end
	return 0

end



--**********************************

--提交

--**********************************

function x206010_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x206010_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x206010_g_MissionId)
		AddExp(sceneId, selfId, x206010_g_ExpBonus)
		AddMoney(sceneId, selfId, x206010_g_MoneyBonus)
		for i, item in pairs(x206010_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x206010_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x206010_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x206010_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x206010_g_MissionId) >= 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x206010_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0)
	 	 if objdataId == x206010_g_DemandKill[1].id then 
       		    if num < x206010_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死金国守卫   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x206010_g_DemandKill[1].num ))
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x206010_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x206010_OnItemChanged(sceneId, selfId, itemdataId)

end

