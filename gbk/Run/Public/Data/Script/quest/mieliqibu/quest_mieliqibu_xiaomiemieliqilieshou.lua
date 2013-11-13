--消灭蔑里乞猎手

--MisDescBegin
x201001_g_ScriptId = 201001
x201001_g_MissionIdPre =82
x201001_g_MissionId = 83
x201001_g_MissionKind = 2
x201001_g_MissionLevel = 10
x201001_g_ScriptIdNext = {ScriptId = 201002 ,LV = 1 }
x201001_g_Name	="铁木真" 
x201001_g_DemandItem ={}
x201001_g_DemandKill ={{id=338,num=20}}
x201001_g_noDemandKill ={{id=339,num=1}}
x201001_g_DemandItem ={{id=13010024,num=1}}

x201001_g_MissionName="消灭蔑里乞猎手"
x201001_g_MissionInfo="    <铁木真两眼怒火直冒，脸上透出冷冷的杀意>这些卑鄙无耻的蔑儿乞人偷袭了我们部落，他们杀我族人，抢我马匹，还把我最疼爱的妻子孛儿帖给抢走了！\n \n    所有的战士们，用你们的怒火点燃你们的勇气，凡是高过车轮的蔑里乞男人，一个都不留！\n \n    踏平蔑里乞部！向西营的北面前进，荡平那里的#R蔑里乞猎手#W，把他们的头目人头给我提回来！"  --任务描述
x201001_g_MissionTarget="    向#G西营以北#W前进，消灭20名#R蔑里乞猎手#B#aB{蔑里乞猎手_1}[49,56]#aE#W，把#R蔑里乞猎手头目#B#aB{蔑里乞猎手头目_2}[115,30]#aE#W的人头给#G铁木真#B#aB{铁木真_3}[79,128]#aE#W提回来。"		                                                                                               
x201001_g_MissionComplete="    再强的对手，我也会让他们屈服在我铁木真的脚下。"					--完成任务npc说话的话
x201001_g_ContinueInfo="    给他们颜色看看，那些猎手只不过是不堪一击。"


--自动寻路的定义
x201001_g_AutoFindPath =  {{sid=1,x=49,z=56,speak=0},{sid=1,x=115,z=30,speak=0},{sid=1,x=79,z=128,speak=1}}

--任务奖励
x201001_g_MoneyBonus = 2
--固定物品奖励，最多8种
x201001_g_ItemBonus={}

--可选物品奖励，最多8种
x201001_g_RadioItemBonus={}
--MisDescEnd
x201001_g_ExpBonus = 80

--**********************************

--任务入口函数

--**********************************

function x201001_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x201001_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x201001_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x201001_g_MissionId)
		if x201001_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x201001_g_MissionName)
			AddText(sceneId,x201001_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x201001_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死蔑里乞猎手   %d/%d\n    蔑里乞头目头颅   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x201001_g_DemandKill[1].num,LuaFnGetItemCount(sceneId,selfId,x201001_g_DemandItem[1].id),x201001_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x201001_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x201001_g_MissionName)
		     AddText(sceneId,x201001_g_MissionComplete)
		     AddMoneyBonus(sceneId, x201001_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x201001_g_ScriptId, x201001_g_MissionId)
                end

        elseif x201001_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x201001_g_MissionName)
                AddText(sceneId,x201001_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x201001_g_MissionTarget) 
		AddMoneyBonus(sceneId, x201001_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x201001_g_ScriptId, x201001_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x201001_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x201001_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x201001_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x201001_g_ScriptId, x201001_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x201001_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x201001_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x201001_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==1) then
		if IsMissionHaveDone(sceneId, selfId, x201001_g_MissionIdPre) > 0 then
        	    	return 1
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x201001_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x201001_g_MissionId, x201001_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x201001_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x201001_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x201001_g_MissionId)
	for i, item in pairs(x201001_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x201001_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x201001_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x201001_g_DemandKill[1].num then
			if LuaFnGetItemCount(sceneId,selfId,x201001_g_DemandItem[1].id) == x201001_g_DemandItem[1].num then
	        return 1
	    end
	end
	return 0

end



--**********************************

--提交

--**********************************

function x201001_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x201001_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x201001_g_MissionId)
		AddExp(sceneId, selfId, x201001_g_ExpBonus)
		AddMoney(sceneId, selfId, x201001_g_MoneyBonus)
		for i, item in pairs(x201001_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x201001_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x201001_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x201001_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x201001_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x201001_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 	if objdataId == x201001_g_DemandKill[1].id then 
       		if num < x201001_g_DemandKill[1].num then
       		    	SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		      BeginEvent(sceneId)
			 					AddText(sceneId,format("杀死蔑里乞猎手   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x201001_g_DemandKill[1].num )) 
			 					EndEvent()
			 					DispatchMissionTips(sceneId, selfId)
		     end
      end
      if objdataId == x201001_g_noDemandKill[1].id then 
       		 if LuaFnGetItemCount(sceneId,selfId,x201001_g_DemandItem[1].id) < x201001_g_DemandItem[1].num then
       		         if random(1,100)>0 then
       		        	  BeginAddItem(sceneId)                                                    
				 							AddItem( sceneId,x201001_g_DemandItem[1].id, 1 )             
				 							ret = EndAddItem(sceneId,selfId)                                 
		        	 				if ret > 0 then                                                  
		        	 						BeginEvent(sceneId)
				 									AddText(sceneId,format("蔑里乞猎头头颅   %d/%d", LuaFnGetItemCount(sceneId,selfId,x201001_g_DemandItem[1].id)+1,x201001_g_DemandItem[1].num )) 
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

function x201001_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x201001_OnItemChanged(sceneId, selfId, itemdataId)

end

