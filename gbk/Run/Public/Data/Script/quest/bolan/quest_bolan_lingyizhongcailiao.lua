--另一种材料

--MisDescBegin
x226008_g_ScriptId = 226008
x226008_g_MissionIdPre =343
x226008_g_MissionId = 344
x226008_g_MissionKind = 23
x226008_g_MissionLevel = 115
x226008_g_ScriptIdNext = {ScriptId = 226009 ,LV = 1 }
x226008_g_Name	="随军巫师" 
x226008_g_DemandItem ={{id=13010074,num=10}}
x226008_g_noDemandKill ={{id=483,num=1}}	

x226008_g_MissionName="另一种材料"
x226008_g_MissionInfo="    还需要另一种材料才能破除奥施特恩的防御，这种材料就是骑士的戒指。\n \n    条顿骑士团里每个骑士都会带有一枚戒指，那是忠诚的象征。\n \n    再次冲入敌阵吧，勇士，拿回10枚骑士的戒指。"  --任务描述
x226008_g_MissionTarget="    杀入#R条顿骑士#W的聚集地，抢到10枚#c0080C0骑士的戒指#W，给#G随军巫师#W带回来。"		
x226008_g_MissionComplete="    <巫师贪婪的看着戒指>\n \n    好的我要开始配药了，马上就会配好。"					--完成任务npc说话的话
x226008_g_ContinueInfo="    骑士的心和戒指融合在一起就能破除奥施特恩的防御。"
--任务奖励
x226008_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x226008_g_ItemBonus={}

--可选物品奖励，最多8种
x226008_g_RadioItemBonus={}

--MisDescEnd
x226008_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x226008_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x226008_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x226008_g_MissionId) > 0 then
		if x226008_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x226008_g_MissionName)
			AddText(sceneId,x226008_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x226008_g_MissionTarget) 
			AddText(sceneId,format("\n    骑士的戒指   %d/%d", LuaFnGetItemCount(sceneId,selfId,x226008_g_DemandItem[1].id),x226008_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x226008_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x226008_g_MissionName)
		     AddText(sceneId,x226008_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in pairs(x226008_g_DemandItem) do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x226008_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x226008_g_ScriptId, x226008_g_MissionId)
                end

        elseif x226008_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x226008_g_MissionName)
                AddText(sceneId,x226008_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x226008_g_MissionTarget) 
		AddMoneyBonus(sceneId, x226008_g_MoneyBonus)
		EndEvent()
		DispatchMissionInfo(sceneId, selfId, targetId, x226008_g_ScriptId, x226008_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x226008_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x226008_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x226008_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x226008_g_ScriptId, x226008_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x226008_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x226008_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x226008_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==22) then
        	if IsMissionHaveDone(sceneId, selfId, x226008_g_MissionIdPre) > 0 then
        	         return 1
        	end
		
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x226008_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x226008_g_MissionId, x226008_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x226008_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x226008_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x226008_g_MissionId)
	for i, item in pairs(x226008_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x226008_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x226008_g_DemandItem[1].id) == x226008_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x226008_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x226008_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x226008_g_MissionId)
		AddExp(sceneId, selfId, x226008_g_ExpBonus)
		AddMoney(sceneId, selfId, x226008_g_MoneyBonus)
		for i, item in pairs(x226008_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x226008_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x226008_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end

	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x226008_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x226008_g_MissionId) >= 0 then                                       
       		 if objdataId == x226008_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x226008_g_DemandItem[1].id) < x226008_g_DemandItem[1].num then
       		         if random(1,100)>20 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x226008_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("骑士的戒指   %d/%d", LuaFnGetItemCount(sceneId,selfId,x226008_g_DemandItem[1].id)+1,x226008_g_DemandItem[1].num ))
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

function x226008_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x226008_OnItemChanged(sceneId, selfId, itemdataId)

end

