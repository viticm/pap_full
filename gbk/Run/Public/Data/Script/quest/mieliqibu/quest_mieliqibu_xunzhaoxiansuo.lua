--寻找线索

--MisDescBegin
x201007_g_ScriptId = 201007
x201007_g_MissionIdPre =82
x201007_g_MissionId = 89
x201007_g_MissionKind = 2
x201007_g_MissionLevel = 10
--x201007_g_ScriptIdNext = {ScriptId = 201001 ,LV = 1 }
x201007_g_Name	="女佣豁黑" 
x201007_g_DemandItem ={}
x201007_g_DemandKill ={{id=345,num=1}}

x201007_g_MissionName="寻找线索"
x201007_g_MissionInfo="    呜呜…… 我对不起孛儿帖，这都是我的过错！\n \n    蔑里乞人偷袭我们的那天，大家都忙着撤退，我把孛儿帖藏在了牛车上的羊毛里面，本来是骗过了蔑里乞人，没想到，马车坏了，孛儿帖被追上来的敌人给带走了。\n \n    这些天，我一直在找附近找线索，最可疑的，就是负责马匹监管的蔑里乞将领#R答赤巫#W，杀了他，看看能不能从他上找到一些线索。"  --任务描述
x201007_g_MissionTarget="    杀死#G马场#W附近的#R答赤巫#W，寻找线索，然后告诉#G女佣豁黑#W。"		                                                                                               
x201007_g_MissionComplete="    一点消息都没有吗？难道是我看错了？夫人到底被抓到哪里去了？……我会再找找！"					--完成任务npc说话的话
x201007_g_ContinueInfo="    答赤巫或许有孛儿帖的消息，我是这么认为的。"
--任务奖励
x201007_g_MoneyBonus = 2
--固定物品奖励，最多8种
x201007_g_ItemBonus={}

--可选物品奖励，最多8种
x201007_g_RadioItemBonus={{id=10226001,num=1},{id=10276002,num=1},{id=10266001,num=1}}

--MisDescEnd
x201007_g_ExpBonus = 100
--**********************************

--任务入口函数

--**********************************

function x201007_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x201007_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x201007_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x201007_g_MissionId)
		if x201007_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x201007_g_MissionName)
			AddText(sceneId,x201007_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x201007_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死答赤乌   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x201007_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x201007_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x201007_g_MissionName)
		     AddText(sceneId,x201007_g_MissionComplete)
		     AddMoneyBonus(sceneId, x201007_g_MoneyBonus)
		     for i, item in x201007_g_ItemBonus do
	             	AddItemBonus(sceneId, item.id, item.num)
	             end
		     for i, item in x201007_g_RadioItemBonus do
	            	 AddRadioItemBonus(sceneId, item.id, item.num)
	             end
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x201007_g_ScriptId, x201007_g_MissionId)
                end

        elseif x201007_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x201007_g_MissionName)
                AddText(sceneId,x201007_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x201007_g_MissionTarget) 
		AddMoneyBonus(sceneId, x201007_g_MoneyBonus)	
		for i, item in x201007_g_ItemBonus do
	             	AddItemBonus(sceneId, item.id, item.num)
	        end
		for i, item in x201007_g_RadioItemBonus do
	            	 AddRadioItemBonus(sceneId, item.id, item.num)
	        end	
		EndEvent()
		DispatchMissionInfo(sceneId, selfId, targetId, x201007_g_ScriptId, x201007_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x201007_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x201007_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x201007_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x201007_g_ScriptId, x201007_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x201007_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x201007_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x201007_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==1) then
			if IsMissionHaveDone(sceneId, selfId, x201007_g_MissionIdPre) > 0 then
        	    	return 1
        end
  end
        return 0
	
end

--**********************************

--接受

--**********************************

function x201007_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x201007_g_MissionId, x201007_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x201007_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x201007_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x201007_g_MissionId)
	for i, item in x201007_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x201007_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x201007_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x201007_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x201007_OnSubmit(sceneId, selfId, targetId, selectRadioId)

		BeginAddItem(sceneId)                                                    
			for i, item in x201007_g_ItemBonus do                    
				AddItem( sceneId,item.id, item.num )             
			end                                                      
			for i, item in x201007_g_RadioItemBonus do               
				if item.id == selectRadioId then                 
					AddItem( sceneId,item.id, item.num )     
				end                                              
			end                                                      
		ret = EndAddItem(sceneId,selfId)                                 
		if ret > 0 then                                                  
		  ret = DelMission( sceneId, selfId, x201007_g_MissionId ) 
			if ret > 0 then                                   
				MissionCom( sceneId,selfId, x201007_g_MissionId )
				AddExp(sceneId, selfId, x201007_g_ExpBonus)   
	                        AddMoney(sceneId, selfId, x201007_g_MoneyBonus)
	                        AddItemListToHuman(sceneId,selfId)
			end                                               
		else                                                             
			BeginEvent(sceneId)                                      
				AddText(sceneId,"物品栏已满，请整理下再来！");                        
			EndEvent(sceneId)                                        
			DispatchMissionTips(sceneId,selfId)                      
		end 
		--CallScriptFunction( x201007_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x201007_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x201007_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x201007_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x201007_g_DemandKill[1].id then 
       		    if num < x201007_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死答赤乌   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x201007_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x201007_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x201007_OnItemChanged(sceneId, selfId, itemdataId)

end

