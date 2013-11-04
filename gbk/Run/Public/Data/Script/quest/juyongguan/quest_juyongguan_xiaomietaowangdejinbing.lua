--消灭逃亡的金兵

--MisDescBegin
x206001_g_ScriptId = 206001
x206001_g_MissionIdPre =27
x206001_g_MissionId = 28
x206001_g_MissionKind = 8
x206001_g_MissionLevel = 40
x206001_g_ScriptIdNext = {ScriptId = 206002 ,LV = 1 }
x206001_g_Name	="速不台" 
x206001_g_Name2	="木华黎" 
x206001_g_DemandItem ={{id=13010012,num=15}}
x206001_g_noDemandKill ={id=404,num=1}	

x206001_g_MissionName="消灭逃亡的金兵"
x206001_g_MissionInfo="    要成为英雄，单单靠勇猛是不足的，还需要靠这里……，脑子。\n \n    我们的军队越来越大，人越来越多。成吉思汗要我从你们这些人里面挑选出一百位智勇双全的人来当百夫长，你的机会非常大！\n \n    要当上百夫长，最注重的就是战功，有了战功，才能服人！根据探子回报，东面有一队逃亡的金兵，你去把敌人都杀了，把他们的鼻子割下来做证明，然后交给#G木华黎#W将军。记住啊，年轻人要厚道，千万不要弄虚作假，我指的是依靠脑子，不是让你耍小聪明！"  --任务描述
x206001_g_MissionTarget="    把把15个#c0080C0金兵的鼻子#W带给#G木华黎#W。"		
x206001_g_MissionComplete="    （木华黎看到了一袋子都是染血的鼻子，眉头微皱，但是脸上渐渐露出了笑容）哈哈哈，好，真好，你是速不台这只野豹的手下吗？哦，实在抱歉，也许你不知道吧，速不台是我们蒙军最英勇的战士，每次打仗他都像野豹一样，冲在最前面，大汗称他为“成吉思豹”！你给我们送来了这么重的礼物，大汗一定很高兴！"					--完成任务npc说话的话
x206001_g_ContinueInfo="    我们几百年的恩怨和怒火，是需要战争才能宣泄的！"
--任务奖励
x206001_g_MoneyBonus = 10000

--固定物品奖励，最多8种
x206001_g_ItemBonus={}

--可选物品奖励，最多8种
x206001_g_RadioItemBonus={}

--MisDescEnd
x206001_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x206001_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x206001_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x206001_g_MissionId) > 0 then
		if x206001_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x206001_g_MissionName)
			AddText(sceneId,x206001_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x206001_g_MissionTarget) 
			AddText(sceneId,format("\n    金兵的鼻子   %d/%d", LuaFnGetItemCount(sceneId,selfId,x206001_g_DemandItem[1].id),x206001_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x206001_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x206001_g_MissionName)
		     AddText(sceneId,x206001_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in x206001_g_DemandItem do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x206001_g_MoneyBonus)
                     EndEvent()
		     DispatchMissionContinueInfo(sceneId, selfId, targetId, x206001_g_ScriptId, x206001_g_MissionId)
                end

        elseif x206001_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x206001_g_MissionName)
                AddText(sceneId,x206001_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x206001_g_MissionTarget) 
		AddMoneyBonus(sceneId, x206001_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x206001_g_ScriptId, x206001_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x206001_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x206001_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x206001_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x206001_g_ScriptId, x206001_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x206001_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x206001_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x206001_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==6) then
        	if (GetName(sceneId,targetId)==x206001_g_Name) then
        	        if IsMissionHaveDone(sceneId, selfId, x206001_g_MissionIdPre) > 0 then
        	            if IsHaveMission(sceneId,selfId, x206001_g_MissionId)<= 0 then
        	            	return 1
        	            end
        	        end
        	end
		if (GetName(sceneId,targetId)==x206001_g_Name2) then
			    if IsHaveMission(sceneId,selfId, x206001_g_MissionId) > 0 then
			    	return 1
        	            end
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x206001_OnAccept(sceneId, selfId)

	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x206001_g_MissionId, x206001_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x206001_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
		                                                           
	                                                                     
	     
end



--**********************************

--放弃

--**********************************







function x206001_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x206001_g_MissionId)
	for i, item in x206001_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x206001_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x206001_g_DemandItem[1].id) == x206001_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x206001_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x206001_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x206001_g_MissionId)
		AddExp(sceneId, selfId, x206001_g_ExpBonus)
		AddMoney(sceneId, selfId, x206001_g_MoneyBonus)
		for i, item in x206001_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x206001_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x206001_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x206001_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x206001_g_MissionId) >= 0 then     
       		 if objdataId == x206001_g_noDemandKill.id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x206001_g_DemandItem[1].id) < x206001_g_DemandItem[1].num then
       		         if random(1,100)>20 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x206001_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("金兵的鼻子   %d/%d", LuaFnGetItemCount(sceneId,selfId,x206001_g_DemandItem[1].id)+1,x206001_g_DemandItem[1].num )) 
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

function x206001_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x206001_OnItemChanged(sceneId, selfId, itemdataId)

end

