--无马骑士

--MisDescBegin
x226004_g_ScriptId = 226004
x226004_g_MissionIdPre =326
x226004_g_MissionId = 340
x226004_g_MissionKind = 23
x226004_g_MissionLevel = 115
x226004_g_ScriptIdNext = {ScriptId = 226005 ,LV = 1 }
x226004_g_Name	="海都" 
x226004_g_DemandItem ={{id=13010072,num=5}}
x226004_g_noDemandKill ={{id=480,num=1}}	

x226004_g_MissionName="无马骑士"
x226004_g_MissionInfo="    欧洲人的盔甲真厚，我们的弓箭都没有办法穿透它们。不过骑士的战马都没穿盔甲，我们的骑射手把敌人的战马都射死了。\n \n    这些盔甲厚重的骑士都摔在地上，我看他们想爬起来都困难。去屠杀他们吧，把他们的头盔带回来。"  --任务描述
x226004_g_MissionTarget="    屠杀那些#R下马骑士#W，把5个骑士头盔给#G海都#W带回来。"		
x226004_g_MissionComplete="    这么重的头盔，人在里面能喘气吗？"					--完成任务npc说话的话
x226004_g_ContinueInfo="    记得把头盔中敌人的头拿出来，我可不想要看他们的死脸。"
--任务奖励
x226004_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x226004_g_ItemBonus={}

--可选物品奖励，最多8种
x226004_g_RadioItemBonus={}

--MisDescEnd
x226004_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x226004_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x226004_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x226004_g_MissionId) > 0 then
		if x226004_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x226004_g_MissionName)
			AddText(sceneId,x226004_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x226004_g_MissionTarget) 
			AddText(sceneId,format("\n    骑士头盔   %d/%d", LuaFnGetItemCount(sceneId,selfId,x226004_g_DemandItem[1].id),x226004_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x226004_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x226004_g_MissionName)
		     AddText(sceneId,x226004_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in x226004_g_DemandItem do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x226004_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x226004_g_ScriptId, x226004_g_MissionId)
                end

        elseif x226004_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x226004_g_MissionName)
                AddText(sceneId,x226004_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x226004_g_MissionTarget) 
		AddMoneyBonus(sceneId, x226004_g_MoneyBonus)
		EndEvent()
		DispatchMissionInfo(sceneId, selfId, targetId, x226004_g_ScriptId, x226004_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x226004_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x226004_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x226004_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x226004_g_ScriptId, x226004_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x226004_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x226004_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x226004_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==22) then
        	--if IsMissionHaveDone(sceneId, selfId, x226004_g_MissionIdPre) > 0 then
        	         return 1
        	--end
		
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x226004_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x226004_g_MissionId, x226004_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x226004_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x226004_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x226004_g_MissionId)
	for i, item in x226004_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x226004_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x226004_g_DemandItem[1].id) == x226004_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x226004_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x226004_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x226004_g_MissionId)
		AddExp(sceneId, selfId, x226004_g_ExpBonus)
		AddMoney(sceneId, selfId, x226004_g_MoneyBonus)
		for i, item in x226004_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x226004_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x226004_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end

	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x226004_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x226004_g_MissionId) >= 0 then                                       
       		 if objdataId == x226004_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x226004_g_DemandItem[1].id) < x226004_g_DemandItem[1].num then
       		         if random(1,100)>20 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x226004_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("骑士头盔   %d/%d", LuaFnGetItemCount(sceneId,selfId,x226004_g_DemandItem[1].id)+1,x226004_g_DemandItem[1].num ))
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

function x226004_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x226004_OnItemChanged(sceneId, selfId, itemdataId)

end

