--药物

--MisDescBegin
x203002_g_ScriptId = 203002
x203002_g_MissionIdPre =69
x203002_g_MissionId = 70
x203002_g_MissionKind = 13
x203002_g_MissionLevel = 50
x203002_g_ScriptIdNext = {ScriptId = 203003 ,LV = 1 }
x203002_g_Name	="郭靖" 
x203002_g_Name2	="明安" 
x203002_g_noDemandItem ={{id=13010017,num=1}}
--x203002_g_noDemandKill ={{id=301,num=1}}	

x203002_g_MissionName="药物"
x203002_g_MissionInfo="，侠士，把这包药交给明安。我相信明安会好好利用这包药的。\n \n    <郭靖递给你一包东西的时候，还多嘱咐了你一句>\n \n    记得提醒他，自己要小心。明安知道我想要什么。他一定会设法替我办妥此事，很快我们就会再见面的。"  --任务描述
x203002_g_MissionTarget="    替#G郭靖#W把药送给#G明安#W后，向郭靖复命。"		
x203002_g_MissionComplete="    做得很好，我喜欢你这样果断神勇的年轻人。"					--完成任务npc说话的话
x203002_g_ContinueInfo="    很多年前就跟明安认识了，当时他的毒伤……，你还是赶紧去找他吧！"
x203002_g_ContinueInfo2="    虽然多年不见，但是郭大侠的风采时时刻刻在我脑海里，他是我见过最让人倾心的英雄！\n \n    不管做什么，都难以报答他当年的救命之恩，能为他做事，这是我的荣幸，请告诉郭大侠，我已经弄清楚了这药的用法。"
--任务奖励
x203002_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x203002_g_ItemBonus={}

--可选物品奖励，最多8种
x203002_g_RadioItemBonus={}

--MisDescEnd
x203002_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x203002_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	misIndex = GetMissionIndexByID(sceneId,selfId,x203002_g_MissionId)
	if x203002_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x203002_g_MissionId) > 0 then
		if x203002_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     	BeginEvent(sceneId)
                     	AddText(sceneId,"#Y"..x203002_g_MissionName)
		     	AddText(sceneId,x203002_g_MissionComplete)
		     	AddMoneyBonus(sceneId, x203002_g_MoneyBonus)
		     	EndEvent()
                     	DispatchMissionContinueInfo(sceneId, selfId, targetId, x203002_g_ScriptId, x203002_g_MissionId)
                end
                if x203002_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                	if (GetName(sceneId,targetId)==x203002_g_Name) then
                		BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x203002_g_MissionName)
				AddText(sceneId,x203002_g_ContinueInfo)
				AddText(sceneId,"#Y任务目标#W") 
				AddText(sceneId,x203002_g_MissionTarget) 
				AddText(sceneId,format("\n    把药送给明安   %d/1", GetMissionParam(sceneId,selfId,misIndex,0) ))
		     		EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
			end
			if (GetName(sceneId,targetId)==x203002_g_Name2) then
                		BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x203002_g_MissionName)
				AddText(sceneId,x203002_g_ContinueInfo2)
				EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
				SetMissionByIndex(sceneId,selfId,misIndex,0,1)
				BeginEvent(sceneId)
				AddText(sceneId,format("把药送给明安   %d/1", GetMissionParam(sceneId,selfId,misIndex,0) ))
		     		EndEvent()
		     		DispatchMissionTips(sceneId, selfId)
		     		for i, item in x203002_g_noDemandItem do
					DelItem(sceneId, selfId, item.id, item.num)
				end
			end
                		
                end

        elseif x203002_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x203002_g_MissionName)
                AddText(sceneId,"    "..GetName(sceneId, selfId)..x203002_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x203002_g_MissionTarget) 
		AddMoneyBonus(sceneId, x203002_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x203002_g_ScriptId, x203002_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x203002_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x203002_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x203002_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x203002_g_ScriptId, x203002_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x203002_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x203002_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x203002_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==3) then
        	if IsMissionHaveDone(sceneId, selfId, x203002_g_MissionIdPre) > 0 then
        	misIndex = GetMissionIndexByID(sceneId,selfId,x203002_g_MissionId)
        		if (GetName(sceneId,targetId)==x203002_g_Name) then
        	            		return 1
        		end
			if (GetName(sceneId,targetId)==x203002_g_Name2) then
			   	 if IsHaveMission(sceneId,selfId, x203002_g_MissionId) > 0 then
			    		if LuaFnGetItemCount(sceneId,selfId,x203002_g_noDemandItem[1].id) == 1 then
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

function x203002_OnAccept(sceneId, selfId)

	                                                  
	BeginAddItem(sceneId)                                                    
	AddItem( sceneId,x203002_g_noDemandItem[1].id, x203002_g_noDemandItem[1].num )             
	ret = EndAddItem(sceneId,selfId)                                 
	if ret > 0 then                                                  
	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x203002_g_MissionId, x203002_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x203002_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		AddItemListToHuman(sceneId,selfId)
	else                                                             
		BeginEvent(sceneId)                                      
		AddText(sceneId,"物品栏已满，请整理下再来！")                    
		EndEvent(sceneId)                                        
		DispatchMissionTips(sceneId,selfId)                      
	end     
	     	                                    
	     
end



--**********************************

--放弃

--**********************************

function x203002_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x203002_g_MissionId)
	for i, item in x203002_g_noDemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x203002_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x203002_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == 1 then
			    		return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x203002_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x203002_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x203002_g_MissionId)
		AddExp(sceneId, selfId, x203002_g_ExpBonus)
		AddMoney(sceneId, selfId, x203002_g_MoneyBonus)
		for i, item in x203002_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end
		CallScriptFunction( x203002_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x203002_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x203002_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x203002_OnItemChanged(sceneId, selfId, itemdataId)

end

