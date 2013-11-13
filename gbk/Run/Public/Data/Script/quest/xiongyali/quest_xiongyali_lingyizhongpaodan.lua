--另一种炮弹

--MisDescBegin
x213002_g_ScriptId = 213002
x213002_g_MissionIdPre =146
x213002_g_MissionId = 147
x213002_g_MissionKind = 24
x213002_g_MissionLevel = 125
--x213002_g_ScriptIdNext = {ScriptId = 205005 ,LV = 1 }
x213002_g_Name	="昔班" 
x213002_g_DemandItem ={{id=13010043,num=30}}
x213002_g_noDemandKill ={{id=388,num=1}}	

x213002_g_MissionName="另一种炮弹"
x213002_g_MissionInfo="    每天发射这些大石头我都烦了，我们来找些有趣的事情做吧。\n \n    知道发射什么东西会比发射石头更令人恐惧吗？人头！没错，就是人头。当然不会是我们蒙古人的头，看见那些过来寻求赦免匈牙利平民了吗？我们就把他们的头送给佩斯城的守卫当礼物吧。\n \n    给我拿30颗#c0080C0匈牙利平民的头#W来吧。"  --任务描述
x213002_g_MissionTarget="    给#G昔班#W带回30颗#R匈牙利平民#W的头。"		
x213002_g_MissionComplete="    可怜的匈牙利人，不过至少他们站着的地方，今年不用施肥了。"					--完成任务npc说话的话
x213002_g_ContinueInfo="    想象一下，天上突然飞来无数的头颅，多么壮观啊！"
--任务奖励
x213002_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x213002_g_ItemBonus={}

--可选物品奖励，最多8种
x213002_g_RadioItemBonus={}

--MisDescEnd
x213002_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x213002_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x213002_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x213002_g_MissionId) > 0 then
		if x213002_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x213002_g_MissionName)
			AddText(sceneId,x213002_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x213002_g_MissionTarget) 
			AddText(sceneId,format("\n    匈牙利平民的头   %d/%d", LuaFnGetItemCount(sceneId,selfId,x213002_g_DemandItem[1].id),x213002_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x213002_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x213002_g_MissionName)
		     AddText(sceneId,x213002_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in pairs(x213002_g_DemandItem) do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x213002_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x213002_g_ScriptId, x213002_g_MissionId)
                end

        elseif x213002_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x213002_g_MissionName)
                AddText(sceneId,x213002_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x213002_g_MissionTarget) 
		AddMoneyBonus(sceneId, x213002_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x213002_g_ScriptId, x213002_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x213002_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x213002_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x213002_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x213002_g_ScriptId, x213002_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x213002_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x213002_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x213002_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==13) then
        	if IsMissionHaveDone(sceneId, selfId, x213002_g_MissionIdPre) > 0 then
        	         return 1
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x213002_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x213002_g_MissionId, x213002_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x213002_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x213002_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x213002_g_MissionId)
	for i, item in pairs(x213002_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x213002_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x213002_g_DemandItem[1].id) == x213002_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x213002_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x213002_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x213002_g_MissionId)
		AddExp(sceneId, selfId, x213002_g_ExpBonus)
		AddMoney(sceneId, selfId, x213002_g_MoneyBonus)
		for i, item in pairs(x213002_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x213002_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x213002_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x213002_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x213002_g_MissionId) >= 0 then                                       
       		 if objdataId == x213002_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x213002_g_DemandItem[1].id) < x213002_g_DemandItem[1].num then
       		         if random(1,100)>0 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x213002_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("匈牙利平民的头   %d/%d", LuaFnGetItemCount(sceneId,selfId,x213002_g_DemandItem[1].id)+1,x213002_g_DemandItem[1].num )) 
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

function x213002_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x213002_OnItemChanged(sceneId, selfId, itemdataId)

end

