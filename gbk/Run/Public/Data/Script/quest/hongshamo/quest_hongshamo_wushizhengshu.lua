--武士证书

--MisDescBegin
x205003_g_ScriptId = 205003
--x205003_g_MissionIdPre =42
x205003_g_MissionId = 43
x205003_g_MissionKind = 11
x205003_g_MissionLevel = 55
--x205003_g_ScriptIdNext = {ScriptId = 205004 ,LV = 1 }
x205003_g_Name	="速不台" 
x205003_g_DemandItem ={{id=13010001,num=10}}
x205003_g_noDemandKill ={{id=303,num=1}}	

x205003_g_MissionName="武士证书"
x205003_g_MissionInfo="    各位勇士们听着！听着了！我们蒙古帝国几百年来一直被邻国踏贱，我们的祖先，我们的兄弟姐妹，父老乡亲受尽了苦难！我蒙古草原上的勇士们，儿郎们！伟大的成吉思汗统一了蒙古，他是长生天最勇敢的儿子！他让我们带上草原的珍宝，怀着一颗友善和慈祥的心，来到花剌子模国与他们邦交。可是，这些花剌子模的狗崽子们，他们怀疑我们大汗的用心，他们拿起了弓箭，居然狼心狗肺的来对付我们！这些人违背了长生天的旨意！\n \n    现在，我要征集最杰出的勇士作为敢死队，让这些有眼无珠的人的鲜血，洒在这片红沙漠上，让红沙漠成为他们的墓穴！用你们的武器，杀死那些花剌子模士兵，把他们身上的武士证书拿回来，以证明你们的价值！"  --任务描述
x205003_g_MissionTarget="    杀死那些，#R花剌子模士兵头目#W（30，45），从他们身上取得10枚#c0080C0武士证书的宪章#W，交给#G速不台#W将军。"		
x205003_g_MissionComplete="    对，就是这样！红沙漠不是我们的墓地，而是他们的！"					--完成任务npc说话的话
x205003_g_ContinueInfo="    武士证书，只有在那些头目身上才能找到。"
--任务奖励
x205003_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x205003_g_ItemBonus={}

--可选物品奖励，最多8种
x205003_g_RadioItemBonus={}

--MisDescEnd
x205003_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x205003_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x205003_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x205003_g_MissionId) > 0 then
		if x205003_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x205003_g_MissionName)
			AddText(sceneId,x205003_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x205003_g_MissionTarget) 
			AddText(sceneId,format("\n    武士证书的宪章   %d/%d", LuaFnGetItemCount(sceneId,selfId,x205003_g_DemandItem[1].id),x205003_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x205003_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x205003_g_MissionName)
		     AddText(sceneId,x205003_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in pairs(x205003_g_DemandItem) do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x205003_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x205003_g_ScriptId, x205003_g_MissionId)
                end

        elseif x205003_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x205003_g_MissionName)
                AddText(sceneId,x205003_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x205003_g_MissionTarget) 
		AddMoneyBonus(sceneId, x205003_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x205003_g_ScriptId, x205003_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x205003_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x205003_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x205003_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x205003_g_ScriptId, x205003_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x205003_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x205003_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x205003_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==5) then
        	            	return 1
       	end
        return 0
	
end

--**********************************

--接受

--**********************************

function x205003_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x205003_g_MissionId, x205003_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x205003_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x205003_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x205003_g_MissionId)
	for i, item in pairs(x205003_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x205003_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x205003_g_DemandItem[1].id) == x205003_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x205003_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x205003_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x205003_g_MissionId)
		AddExp(sceneId, selfId, x205003_g_ExpBonus)
		AddMoney(sceneId, selfId, x205003_g_MoneyBonus)
		for i, item in pairs(x205003_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x205003_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x205003_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x205003_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x205003_g_MissionId) >= 0 then                                       
       		 if objdataId == x205003_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x205003_g_DemandItem[1].id) < x205003_g_DemandItem[1].num then
       		         if random(1,100)>30 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x205003_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("武士证书的宪章   %d/%d", LuaFnGetItemCount(sceneId,selfId,x205003_g_DemandItem[1].id)+1,x205003_g_DemandItem[1].num )) 
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

function x205003_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x205003_OnItemChanged(sceneId, selfId, itemdataId)

end

