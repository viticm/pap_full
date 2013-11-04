--孛儿帖的困惑

--MisDescBegin
x201003_g_ScriptId = 201003
x201003_g_MissionIdPre =84
x201003_g_MissionId = 85
x201003_g_MissionKind = 2
x201003_g_MissionLevel = 10
--x201003_g_ScriptIdNext = {ScriptId = 201002 ,LV = 1 }
x201003_g_Name	="孛儿帖"
x201003_g_DemandItem ={}
x201003_g_DemandKill ={{id=340,num=20}}

x201003_g_MissionName="孛儿帖的困惑"
x201003_g_MissionInfo="    铁木真还好吗？我知道他一定会来救我的……\n \n    我们不能就这样冲出去，那些#R蔑里乞巫师#W是一群魔鬼，一群吃人不吐骨头的恶魔。\n \n    "  --任务描述
x201003_g_MissionInfo2="，消灭附近的那些巫师，我实在不放心！"
x201003_g_MissionTarget="    消灭附近的20名#R蔑里乞巫师#W，回去告诉#G孛儿帖#W。"		                                                                                               
x201003_g_MissionComplete="    谢谢你，我们安全了！"					--完成任务npc说话的话
x201003_g_ContinueInfo="    有那些巫师在，我们逃不出去的，一定要消灭了他们。"
--任务奖励
x201003_g_MoneyBonus = 2
--固定物品奖励，最多8种
x201003_g_ItemBonus={}

--可选物品奖励，最多8种
x201003_g_RadioItemBonus={{id=10206001,num=1},{id=10236001,num=1},{id=10266002,num=1}}
--MisDescEnd
x201003_g_ExpBonus = 80
--**********************************

--任务入口函数

--**********************************

function x201003_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x201003_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x201003_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x201003_g_MissionId)
		if x201003_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x201003_g_MissionName)
			AddText(sceneId,x201003_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x201003_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死蔑里乞巫师   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x201003_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x201003_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x201003_g_MissionName)
		     AddText(sceneId,x201003_g_MissionComplete)
		     AddMoneyBonus(sceneId, x201003_g_MoneyBonus)
		     for i, item in x201003_g_ItemBonus do
	             	AddItemBonus(sceneId, item.id, item.num)
	             end
		     for i, item in x201003_g_RadioItemBonus do
	            	 AddRadioItemBonus(sceneId, item.id, item.num)
	             end
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x201003_g_ScriptId, x201003_g_MissionId)
                end

        elseif x201003_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x201003_g_MissionName)
                AddText(sceneId,x201003_g_MissionInfo..GetName(sceneId, selfId)..x201003_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x201003_g_MissionTarget) 
		AddMoneyBonus(sceneId, x201003_g_MoneyBonus)
		for i, item in x201003_g_ItemBonus do
	             	AddItemBonus(sceneId, item.id, item.num)
	        end
		for i, item in x201003_g_RadioItemBonus do
	            	 AddRadioItemBonus(sceneId, item.id, item.num)
	        end		
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x201003_g_ScriptId, x201003_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x201003_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x201003_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x201003_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x201003_g_ScriptId, x201003_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x201003_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x201003_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x201003_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==1) then
		if IsMissionHaveDone(sceneId, selfId, x201003_g_MissionIdPre) > 0 then
			return 1
   	end
  end
        return 0
	
end

--**********************************

--接受

--**********************************

function x201003_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x201003_g_MissionId, x201003_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x201003_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x201003_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x201003_g_MissionId)
	for i, item in x201003_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x201003_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x201003_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x201003_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x201003_OnSubmit(sceneId, selfId, targetId, selectRadioId)

		BeginAddItem(sceneId)                                                    
			for i, item in x201003_g_ItemBonus do                    
				AddItem( sceneId,item.id, item.num )             
			end                                                      
			for i, item in x201003_g_RadioItemBonus do               
				if item.id == selectRadioId then                 
					AddItem( sceneId,item.id, item.num )     
				end                                              
			end                                                      
		ret = EndAddItem(sceneId,selfId)                                 
		if ret > 0 then                                                  
		  ret = DelMission( sceneId, selfId, x201003_g_MissionId ) 
			if ret > 0 then                                   
				MissionCom( sceneId,selfId, x201003_g_MissionId )
				AddExp(sceneId, selfId, x201003_g_ExpBonus)   
	                        AddMoney(sceneId, selfId, x201003_g_MoneyBonus)
	                        AddItemListToHuman(sceneId,selfId)
			end                                               
		else                                                             
		--任务奖励没有加成功                                             
			BeginEvent(sceneId)                                      
				AddText(sceneId,"物品栏已满，请整理下再来！");                        
			EndEvent(sceneId)                                        
			DispatchMissionTips(sceneId,selfId)                      
		end   
		--CallScriptFunction( x201003_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )

	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x201003_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x201003_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x201003_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x201003_g_DemandKill[1].id then 
       		    if num < x201003_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死蔑里乞巫师   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x201003_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x201003_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x201003_OnItemChanged(sceneId, selfId, itemdataId)

end

