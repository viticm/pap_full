--水囊

--MisDescBegin
x205004_g_ScriptId = 205004
--x205004_g_MissionIdPre =40
x205004_g_MissionId = 44
x205004_g_MissionKind = 11
x205004_g_MissionLevel = 55
x205004_g_ScriptIdNext = {ScriptId = 205005 ,LV = 1 }
x205004_g_Name	="巴吉" 
x205004_g_Name2	="哈撒儿" 
x205004_g_DemandItem ={{id=13010002,num=15}}
x205004_g_noDemandKill ={{id=304,num=1}}	

x205004_g_MissionName="水囊"
x205004_g_MissionInfo="    真主保佑，你终于来了！我们被围了十天，整整十天了！恩，再这样下去，我们会遭到灭团之灾的……，恩，请相信我不是在危言耸听，动摇军心！\n \n    速不台将军骁勇善战，没有任何人怀疑，他被成吉思汗称为陆地之虎！可是，我听说花剌子模这次围剿我们的，有三万精兵，而我们的护卫队不到三千人……你，明白我的意思吗？别这样看着我，我也没有什么好办法，现在唯一能做的，就是在没死之前，尽量为大家多办点事情！\n \n我要收集水囊，把水囊送到哈撒儿那里！这些#c0080C0水囊#W，可以从东面处的#R契丹士兵#W身上拿到。"  --任务描述
x205004_g_MissionTarget="    #R契丹士兵#W身上有巴吉要的#c0080C0水囊#W，请收集15个水囊，把它交给#G哈撒儿#W。"		
x205004_g_MissionComplete="    15个水囊，一个不少，谢谢你的帮助。"					--完成任务npc说话的话
x205004_g_ContinueInfo="    在沙漠里，水比黄金更宝贵，这些水囊，是用来装水的。"
--任务奖励
x205004_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x205004_g_ItemBonus={}

--可选物品奖励，最多8种
x205004_g_RadioItemBonus={}

--MisDescEnd
x205004_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x205004_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x205004_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x205004_g_MissionId) > 0 then
		if x205004_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x205004_g_MissionName)
			AddText(sceneId,x205004_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x205004_g_MissionTarget) 
			AddText(sceneId,format("\n    水囊   %d/%d", LuaFnGetItemCount(sceneId,selfId,x205004_g_DemandItem[1].id),x205004_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x205004_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x205004_g_MissionName)
		     AddText(sceneId,x205004_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in x205004_g_DemandItem do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x205004_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x205004_g_ScriptId, x205004_g_MissionId)
                end

        elseif x205004_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x205004_g_MissionName)
                AddText(sceneId,x205004_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x205004_g_MissionTarget) 
		AddMoneyBonus(sceneId, x205004_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x205004_g_ScriptId, x205004_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x205004_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x205004_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x205004_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x205004_g_ScriptId, x205004_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x205004_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x205004_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x205004_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==5) then
        	if (GetName(sceneId,targetId)==x205004_g_Name) then
        	            if IsHaveMission(sceneId,selfId, x205004_g_MissionId)<= 0 then
        	            	return 1
        	        end
        	end
		if (GetName(sceneId,targetId)==x205004_g_Name2) then
			    if IsHaveMission(sceneId,selfId, x205004_g_MissionId) > 0 then
			    	return 1
        	            end
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x205004_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x205004_g_MissionId, x205004_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x205004_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x205004_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x205004_g_MissionId)
	for i, item in x205004_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x205004_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x205004_g_DemandItem[1].id) == x205004_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x205004_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x205004_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x205004_g_MissionId)
		AddExp(sceneId, selfId, x205004_g_ExpBonus)
		AddMoney(sceneId, selfId, x205004_g_MoneyBonus)
		for i, item in x205004_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x205004_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x205004_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x205004_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x205004_g_MissionId) >= 0 then                                       
       		 if objdataId == x205004_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x205004_g_DemandItem[1].id) < x205004_g_DemandItem[1].num then
       		         if random(1,100)>20 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x205004_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("水囊   %d/%d", LuaFnGetItemCount(sceneId,selfId,x205004_g_DemandItem[1].id)+1,x205004_g_DemandItem[1].num )) 
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

function x205004_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x205004_OnItemChanged(sceneId, selfId, itemdataId)

end

