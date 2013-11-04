--哲别

--MisDescBegin
x214010_g_ScriptId = 214010
x214010_g_MissionIdPre =116
x214010_g_MissionId = 117
x214010_g_MissionKind = 3
x214010_g_MissionLevel = 15
--x214010_g_ScriptIdNext = {ScriptId = 204001 ,LV = 1 }
x214010_g_Name	="者勒蔑" 
x214010_g_DemandItem ={}
x214010_g_DemandKill ={{id=365,num=1}}

x214010_g_MissionName="哲别"
x214010_g_MissionInfo="    我为大汗得到一个得利助手和高兴！他就是豁阿歹……，哦不，现在应该叫他哲别！铁木真赐了个新的名字给豁阿歹，叫哲别，就是“神箭”的意思。\n \n    "  --任务描述
x214010_g_MissionInfo2="，你还不知道吧，哲别跟我打赌，只要我们乞颜部能有人打败他，他救回誓死效忠铁木真，你立了大功！\n \n    恩，至于我……嘿嘿，不说也罢，反正也都过去了。现在有件事情，一定要你才能做，那就是，到札木合营地去——杀死#R札木合#W！"
x214010_g_MissionTarget="    #G者勒蔑#W命你到札木合营地去——杀死#R札木合#W！"		                                                                                               
x214010_g_MissionComplete="    札木合纠集的这11个部落，因为他的死亡而溃败。"					--完成任务npc说话的话
x214010_g_ContinueInfo="    札木合曾经和铁木真三次结为安答，刀功非常厉害，你要小心。"
--任务奖励
x214010_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x214010_g_ItemBonus={}

--可选物品奖励，最多8种
x214010_g_RadioItemBonus={{id=10286001,num=1},{id=10286002,num=1},{id=10286003,num=1}}

--MisDescEnd

--**********************************

--任务入口函数

--**********************************

function x214010_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x214010_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x214010_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x214010_g_MissionId)
		if x214010_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x214010_g_MissionName)
			AddText(sceneId,x214010_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x214010_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死札木合   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x214010_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x214010_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x214010_g_MissionName)
		     AddText(sceneId,x214010_g_MissionComplete)
		     AddMoneyBonus(sceneId, x214010_g_MoneyBonus)
		     for i, item in x214010_g_ItemBonus do
	             	AddItemBonus(sceneId, item.id, item.num)
	             end
		     for i, item in x214010_g_RadioItemBonus do
	            	 AddRadioItemBonus(sceneId, item.id, item.num)
	             end
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x214010_g_ScriptId, x214010_g_MissionId)
                end

        elseif x214010_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x214010_g_MissionName)
                AddText(sceneId,x214010_g_MissionInfo..GetName(sceneId, selfId)..x214010_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x214010_g_MissionTarget) 
		AddMoneyBonus(sceneId, x214010_g_MoneyBonus)	
		for i, item in x214010_g_ItemBonus do
	             	AddItemBonus(sceneId, item.id, item.num)
	        end
		for i, item in x214010_g_RadioItemBonus do
	            	 AddRadioItemBonus(sceneId, item.id, item.num)
	        end	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x214010_g_ScriptId, x214010_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x214010_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x214010_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x214010_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x214010_g_ScriptId, x214010_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x214010_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x214010_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x214010_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==14) then
		if IsMissionHaveDone(sceneId, selfId, x214010_g_MissionIdPre) > 0 then
        	    	return 1
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x214010_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x214010_g_MissionId, x214010_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x214010_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x214010_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x214010_g_MissionId)
	for i, item in x214010_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x214010_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x214010_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x214010_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x214010_OnSubmit(sceneId, selfId, targetId, selectRadioId)

		BeginAddItem(sceneId)                                                    
			for i, item in x214010_g_ItemBonus do                    
				AddItem( sceneId,item.id, item.num )             
			end                                                      
			for i, item in x214010_g_RadioItemBonus do               
				if item.id == selectRadioId then                 
					AddItem( sceneId,item.id, item.num )     
				end                                              
			end                                                      
		ret = EndAddItem(sceneId,selfId)                                 
		if ret > 0 then                                                  
		  ret = DelMission( sceneId, selfId, x214010_g_MissionId ) 
			if ret > 0 then                                   
				MissionCom( sceneId,selfId, x214010_g_MissionId )
				AddExp(sceneId, selfId, x214010_g_ExpBonus)   
	                        AddMoney(sceneId, selfId, x214010_g_MoneyBonus)
	                        AddItemListToHuman(sceneId,selfId)
			end                                               
		else                                                             
			BeginEvent(sceneId)                                      
				AddText(sceneId,"物品栏已满，请整理下再来！");                        
			EndEvent(sceneId)                                        
			DispatchMissionTips(sceneId,selfId)                      
		end 
		--CallScriptFunction( x214010_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x214010_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x214010_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x214010_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x214010_g_DemandKill[1].id then 
       		    if num < x214010_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死札木合   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x214010_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x214010_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x214010_OnItemChanged(sceneId, selfId, itemdataId)

end

