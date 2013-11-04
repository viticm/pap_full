--大汗的洗礼四

--MisDescBegin
x212012_g_ScriptId = 212012
x212012_g_MissionIdPre =258
x212012_g_MissionId = 259
x212012_g_MissionKind = 17
x212012_g_MissionLevel = 70
--x212012_g_ScriptIdNext = {ScriptId = 212011 ,LV = 1 }
x212012_g_Name	="丘处机"
x212012_g_Name2	="窝阔台" 
x212012_g_Name3	="拖雷"
x212012_g_Name4	="耶律楚材"
x212012_g_DemandItem ={}
x212012_g_noDemandItem ={{id=13010056,num=1},{id=13010057,num=1},{id=13010058,num=1}}
--x212012_g_noDemandKill ={{id=301,num=1}}	

x212012_g_MissionName="大汗的洗礼四"
x212012_g_MissionInfo="    这是大汗给窝阔台、拖雷和耶律楚材的信，麻烦你把信分别交给他们三人。"  --任务描述
x212012_g_MissionTarget="    把三封信分别送到#G窝阔台#W，#G拖雷#W和#G耶律楚材#W那里。"		
x212012_g_MissionComplete="    很感谢你的热心。"
x212012_g_ContinueInfo="    信都送过去了吗？"
x212012_g_ContinueInfo2="    丘真人这么说，我就放心了。"
--任务奖励
x212012_g_MoneyBonus = 200
--固定物品奖励，最多8种
x212012_g_ItemBonus={}

--可选物品奖励，最多8种
x212012_g_RadioItemBonus={}

--MisDescEnd
x212012_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x212012_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x212012_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x212012_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x212012_g_MissionId)
		if (GetName(sceneId,targetId)==x212012_g_Name) then
			if x212012_CheckSubmit(sceneId, selfId, targetId) <= 0 then
				BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x212012_g_MissionName)
				AddText(sceneId,x212012_g_ContinueInfo)
				AddText(sceneId,"#Y任务目标#W") 
				AddText(sceneId,x212012_g_MissionTarget) 
				AddText(sceneId,format("\n    把大汗的信送给窝阔台   %d/1\n    把大汗的信送给拖雷   %d/1\n    把大汗的信送给耶律楚材   %d/1", GetMissionParam(sceneId,selfId,misIndex,0), GetMissionParam(sceneId,selfId,misIndex,1), GetMissionParam(sceneId,selfId,misIndex,2) ))
		     		EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
			end
			if x212012_CheckSubmit(sceneId, selfId, targetId) > 0 then
				BeginEvent(sceneId)
                     		AddText(sceneId,"#Y"..x212012_g_MissionName)
		     		AddText(sceneId,x212012_g_MissionComplete)
		     		AddMoneyBonus(sceneId, x212012_g_MoneyBonus)
		     		EndEvent()
                     		DispatchMissionContinueInfo(sceneId, selfId, targetId, x212012_g_ScriptId, x212012_g_MissionId)    			
			end
	        elseif (GetName(sceneId,targetId)==x212012_g_Name2) then
	        	BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x212012_g_MissionName)
			AddText(sceneId,x212012_g_ContinueInfo2)
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
			SetMissionByIndex(sceneId,selfId,misIndex,0,1)
			BeginEvent(sceneId)
			AddText(sceneId,format("把大汗的信送给窝阔台   %d/1", GetMissionParam(sceneId,selfId,misIndex,0) ))
		     	EndEvent()
		     	DispatchMissionTips(sceneId, selfId)
		     	DelItem(sceneId, selfId, x212012_g_noDemandItem[1].id, x212012_g_noDemandItem[1].num)
		elseif (GetName(sceneId,targetId)==x212012_g_Name3) then
	        	BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x212012_g_MissionName)
			AddText(sceneId,x212012_g_ContinueInfo2)
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
			SetMissionByIndex(sceneId,selfId,misIndex,1,1)
			BeginEvent(sceneId)
			AddText(sceneId,format("把大汗的信送给拖雷   %d/1", GetMissionParam(sceneId,selfId,misIndex,1) ))
		     	EndEvent()
		     	DispatchMissionTips(sceneId, selfId)
		     	DelItem(sceneId, selfId, x212012_g_noDemandItem[2].id, x212012_g_noDemandItem[2].num)
		elseif (GetName(sceneId,targetId)==x212012_g_Name4) then
	        	BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x212012_g_MissionName)
			AddText(sceneId,x212012_g_ContinueInfo2)
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
			SetMissionByIndex(sceneId,selfId,misIndex,2,1)
			BeginEvent(sceneId)
			AddText(sceneId,format("把大汗的信送给耶律楚材   %d/1", GetMissionParam(sceneId,selfId,misIndex,2) ))
		     	EndEvent()
		     	DispatchMissionTips(sceneId, selfId)
		     	DelItem(sceneId, selfId, x212012_g_noDemandItem[3].id, x212012_g_noDemandItem[3].num)
		end
		
                    
                

        elseif x212012_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x212012_g_MissionName)
                AddText(sceneId,x212012_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x212012_g_MissionTarget) 
		AddMoneyBonus(sceneId, x212012_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x212012_g_ScriptId, x212012_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x212012_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x212012_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x212012_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x212012_g_ScriptId, x212012_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x212012_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x212012_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x212012_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==12) then
        	if IsMissionHaveDone(sceneId, selfId, x212012_g_MissionIdPre) > 0 then
        	misIndex = GetMissionIndexByID(sceneId,selfId,x212012_g_MissionId)
        		if (GetName(sceneId,targetId)==x212012_g_Name) then
	        	            	return 1
	        	end
			if (GetName(sceneId,targetId)==x212012_g_Name2) then
				    if IsHaveMission(sceneId,selfId, x212012_g_MissionId) > 0 then
				    		if GetMissionParam(sceneId,selfId,misIndex,0) == 0 then
				    			return 1
				    		end
	        	            end
	        	end
	        	if (GetName(sceneId,targetId)==x212012_g_Name3) then
				    if IsHaveMission(sceneId,selfId, x212012_g_MissionId) > 0 then
				    		if GetMissionParam(sceneId,selfId,misIndex,1) == 0 then
				    			return 1
				    		end
	        	            end
	        	end
	        	if (GetName(sceneId,targetId)==x212012_g_Name4) then
				    if IsHaveMission(sceneId,selfId, x212012_g_MissionId) > 0 then
				    		if GetMissionParam(sceneId,selfId,misIndex,2) == 0 then
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

function x212012_OnAccept(sceneId, selfId)

	                                                  
	BeginAddItem(sceneId) 
	for i, item in x212012_g_noDemandItem do                                                   
	AddItem( sceneId,item.id, item.num ) 
	end            
	ret = EndAddItem(sceneId,selfId)                                 
	if ret > 0 then                                                  
	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x212012_g_MissionId, x212012_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x212012_g_MissionName) 
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

function x212012_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x212012_g_MissionId)
	for i, item in x212012_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x212012_CheckSubmit( sceneId, selfId, targetId)

	misIndex = GetMissionIndexByID(sceneId,selfId,x212012_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == 1 then
		if GetMissionParam(sceneId,selfId,misIndex,1) == 1 then
			if GetMissionParam(sceneId,selfId,misIndex,2) == 1 then
	        		return 1
			end
		end
	end
	return 0

end



--**********************************

--提交

--**********************************

function x212012_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x212012_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x212012_g_MissionId)
		AddExp(sceneId, selfId, x212012_g_ExpBonus)
		AddMoney(sceneId, selfId, x212012_g_MoneyBonus)
		for i, item in x212012_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x212012_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x212012_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x212012_OnKillObject(sceneId, selfId, objdataId)
	 

end



--**********************************

--进入区域事件

--**********************************

function x212012_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x212012_OnItemChanged(sceneId, selfId, itemdataId)

end

