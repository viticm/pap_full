--恐怖的面具

--MisDescBegin
x207002_g_ScriptId = 207002
x207002_g_MissionIdPre =2
x207002_g_MissionId = 3
x207002_g_MissionKind = 1
x207002_g_ScriptIdNext = {ScriptId = 207003 ,LV = 1 }
x207002_g_Name	="速不台" 
x207002_g_Name2	="豁儿赤" 
x207002_g_DemandItem ={{id=13010001,num=10},{id=13010005,num=1}}
x207002_g_noDemandKill ={{id=277,num=1},{id=277,num=1}}	

x207002_g_MissionName="恐怖的面具"
x207002_g_MissionInfo="    哈哈哈！至于那个人嘛……让我想想？这实在是费脑筋，我进城之后，杀的人没有八百也有一千，是哪一个呢……，让我记忆最深的，是一个戴着一张很恐怖面具的人，我差点就被他伤到！#G豁儿赤#W对死人的玉佩这么感兴趣？原来……，哈哈哈，这没出息的小子看来是醉翁之意不在酒，还惦记着那玩意！你到（xxx,xxx，）处去，把那些俘虏给杀了，把他们身上的东西带回去给#G豁儿赤#W！等等，这个面具对我也没用，你一起拿去给他吧。"  --任务描述
x207002_g_MissionTarget="    把#c0080C0恐怖的面具#W和十包#c0080C0白色粉末#W带给#G豁儿赤#W"		
x207002_g_MissionComplete="    这，这，#G速不台#W这家伙，纯粹是故意让我丢人！嘿嘿，当时让他给我弄点春药，只是随便说说，他居然当真……，先不说这个，你看看这玉佩，它在哭泣，它在倾诉……，如果不是亲眼看到，我绝对不会相信有这样的事情。之所以奇怪，是因为我在看到玉佩的时候，感觉到非常的熟悉，它在召唤我！"					--完成任务npc说话的话
x207002_g_ContinueInfo="    #G速不台#W让你给我带东西来了？"
--任务奖励
x207002_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x207002_g_ItemBonus={}

--可选物品奖励，最多8种
x207002_g_RadioItemBonus={}

--MisDescEnd
--**********************************

--任务入口函数

--**********************************

function x207002_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207002_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207002_g_MissionId) > 0 then
		if x207002_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x207002_g_MissionName)
			AddText(sceneId,x207002_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x207002_g_MissionTarget) 
			AddText(sceneId,format("\n    白色粉末   %d/10", LuaFnGetItemCount(sceneId,selfId,13010001) ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x207002_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x207002_g_MissionName)
		     AddText(sceneId,x207002_g_MissionComplete)
		     AddText(sceneId,"#Y任务目标#W") 
		     AddText(sceneId,x207002_g_MissionTarget) 
		     AddText(sceneId,format("\n    白色粉末   %d/10", LuaFnGetItemCount(sceneId,selfId,13010001) ))
                     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x207002_g_ScriptId, x207002_g_MissionId)
                end

        elseif x207002_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x207002_g_MissionName)
                AddText(sceneId,x207002_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x207002_g_MissionTarget) 
		AddMoneyBonus(sceneId, x207002_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207002_g_ScriptId, x207002_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207002_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207002_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207002_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207002_g_ScriptId, x207002_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207002_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207002_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207002_CheckPushList(sceneId, selfId, targetId)
        if (GetName(sceneId,targetId)==x207002_g_Name) then
                if IsMissionHaveDone(sceneId, selfId, x207002_g_MissionIdPre) > 0 then
                    if IsHaveMission(sceneId,selfId, x207002_g_MissionId)<= 0 then
                    return 1
                    end
                end
        end
	if (GetName(sceneId,targetId)==x207002_g_Name2) then
		    if IsHaveMission(sceneId,selfId, x207002_g_MissionId) > 0 then
		    return 1
                    end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x207002_OnAccept(sceneId, selfId)

	        BeginAddItem(sceneId)                                                    
			AddItem( sceneId,x207002_g_DemandItem[2].id, x207002_g_DemandItem[2].num )             
			                                             
		        ret = EndAddItem(sceneId,selfId)                                 
		        --添加任务奖励                                                   
		        if ret > 0 then                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x207002_g_MissionId, x207002_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x207002_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)AddItemListToHuman(sceneId,selfId) 
		        else                                                             
		--任务奖励没有加成功                                             
			     BeginEvent(sceneId)                                      
			     	AddText(sceneId,"物品栏已满，请整理下再来！")                    
			     EndEvent(sceneId)                                        
			     DispatchMissionTips(sceneId,selfId)                      
		        end                                                              
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x207002_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207002_g_MissionId)
	for i, item in pairs(x207002_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x207002_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,13010001) == 10 then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207002_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207002_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207002_g_MissionId)
		AddExp(sceneId, selfId, x207002_g_ExpBonus)
		AddMoney(sceneId, selfId, x207002_g_MoneyBonus)
		for i, item in pairs(x207002_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x207002_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x207002_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207002_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x207002_g_MissionId) >= 0 then                                       
       		 if objdataId == x207002_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,13010001) < 10 then
       		         if random(1,100)>20 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x207002_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("白色粉末   %d/10", LuaFnGetItemCount(sceneId,selfId,13010001)+1 )) 
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

end



--**********************************

--进入区域事件

--**********************************

function x207002_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207002_OnItemChanged(sceneId, selfId, itemdataId)

end

