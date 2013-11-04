--主教的手

--MisDescBegin
x213009_g_ScriptId = 213009
--x213009_g_MissionIdPre =148
x213009_g_MissionId = 154
x213009_g_MissionKind = 24
x213009_g_MissionLevel = 125
--x213009_g_ScriptIdNext = {ScriptId = 205005 ,LV = 1 }
x213009_g_Name	="速不台" 
x213009_g_DemandItem ={{id=13010045,num=1}}
x213009_g_noDemandKill ={{id=395,num=1}}	

x213009_g_MissionName="主教的手"
x213009_g_MissionInfo="    一个叫#R瓦如丁#W的主教带着一队骑士过来支援贝拉，目前他们已经到了我们营地西边的河畔。\n \n    不用我说你也该知道怎么做了吧。干掉那个瓦如丁，把他带着主教戒指的双手砍下来给我带回来，我要把这双手送给贝拉。"  --任务描述
x213009_g_MissionTarget="    杀了#R瓦如丁#W把他的双手砍下来带给#G速不台#W。"		
x213009_g_MissionComplete="    看，多么细腻的一双手啊，这样的人也敢带兵上战场，他的士兵真的很悲哀！"					--完成任务npc说话的话
x213009_g_ContinueInfo="    砍手的时候小心些，要让它们看起来象长在瓦如丁身上一样。"
--任务奖励
x213009_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x213009_g_ItemBonus={}

--可选物品奖励，最多8种
x213009_g_RadioItemBonus={}

--MisDescEnd
x213009_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x213009_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x213009_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x213009_g_MissionId) > 0 then
		if x213009_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x213009_g_MissionName)
			AddText(sceneId,x213009_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x213009_g_MissionTarget) 
			AddText(sceneId,format("\n    瓦如丁的双手   %d/%d", LuaFnGetItemCount(sceneId,selfId,x213009_g_DemandItem[1].id),x213009_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x213009_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x213009_g_MissionName)
		     AddText(sceneId,x213009_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in x213009_g_DemandItem do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x213009_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x213009_g_ScriptId, x213009_g_MissionId)
                end

        elseif x213009_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x213009_g_MissionName)
                AddText(sceneId,x213009_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x213009_g_MissionTarget) 
		AddMoneyBonus(sceneId, x213009_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x213009_g_ScriptId, x213009_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x213009_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x213009_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x213009_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x213009_g_ScriptId, x213009_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x213009_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x213009_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x213009_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==13) then
        	         return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x213009_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x213009_g_MissionId, x213009_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x213009_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x213009_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x213009_g_MissionId)
	for i, item in x213009_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x213009_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x213009_g_DemandItem[1].id) == x213009_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x213009_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x213009_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x213009_g_MissionId)
		AddExp(sceneId, selfId, x213009_g_ExpBonus)
		AddMoney(sceneId, selfId, x213009_g_MoneyBonus)
		for i, item in x213009_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x213009_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x213009_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x213009_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x213009_g_MissionId) >= 0 then                                       
       		 if objdataId == x213009_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x213009_g_DemandItem[1].id) < x213009_g_DemandItem[1].num then
       		         if random(1,100)>0 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x213009_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("瓦如丁的双手   %d/%d", LuaFnGetItemCount(sceneId,selfId,x213009_g_DemandItem[1].id)+1,x213009_g_DemandItem[1].num )) 
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

function x213009_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x213009_OnItemChanged(sceneId, selfId, itemdataId)

end

