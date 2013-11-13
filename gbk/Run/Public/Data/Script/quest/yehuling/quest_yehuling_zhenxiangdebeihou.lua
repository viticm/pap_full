--真相的背后

--MisDescBegin
x207009_g_ScriptId = 207009
x207009_g_MissionIdPre =9
x207009_g_MissionId = 10
x207009_g_MissionKind = 1
x207009_g_ScriptIdNext = {ScriptId = 207009 ,LV = 1 }
x207009_g_Name	="年轻的射手" 
x207009_g_Name2	="成吉思汗" 
x207009_g_Name3	="灵狐草" 
x207009_g_DemandItem ={{id=13010003,num=10},{id=13010002,num=10}}
x207009_g_noDemandKill ={{id=278,num=1},{id=279,num=1}}	

x207009_g_MissionName="真相的背后"
x207009_g_MissionInfo="    野狐狸……狐狸精，唉!这件事之后，我一直很痛苦，我不相信#G水月#W是狐狸精，她是一个好女孩，因为我射向#G拖雷#W的第一箭是故意射偏一点点，#G水月#W居然……唉，事情已经过去了！离开#G乌月营#W之后，我很想念大汗，听说他生病了，你回去的时候，帮我采集十株#c0080C0灵狐草#W和十个#R流窜的金兵#W的耳朵回去给大汗！我，我只是想静一静，过一阵再回去。"  --任务描述
x207009_g_MissionTarget="    采集十株#c0080C0灵狐草#W,剿灭那些#R流窜的金兵#W，割下他们的耳朵。把#c0080C0灵狐草#W和#c0080C0金兵的耳朵#W带给#G成吉思汗#W。"		                                                                                               
x207009_g_MissionComplete=",你见过我的爱将#G哲别#W了？就让他自己冷静一下吧！\n \n萨满巫师#G阔阔出#W跟长生天交流的时候，长生天告诉我们，#G水月#W是狐狸精变的，她是一只在野狐岭里修行多年的九尾狐。\n \n九尾狐……，多么妖邪的东西啊！就算是翰难河的水干了，草原上的草枯了，我也不能让她靠近#G拖雷#W！\n \n圣明的腾格里啊，请结束这一切吧。狐狸精是不会死的，它是会骗人的，玉佩的出现就是最好的证明！\n \n#G哲别#W做的事情，是对的。万一有一天我死了，我的事业，需要我的儿子们来承担，只要有草原，有马匹牛羊的地方，就有我们大蒙古帝国！"					--完成任务npc说话的话
x207009_g_ContinueInfo="    野狐岭攻破之后，很多金兵流窜在各处，留下了很大的隐患！"
--任务奖励
x207009_g_MoneyBonus = 10000

--固定物品奖励，最多8种
x207009_g_ItemBonus={}

--可选物品奖励，最多8种
x207009_g_RadioItemBonus={}

--MisDescEnd
--**********************************

--任务入口函数

--**********************************

function x207009_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207009_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207009_g_MissionId) > 0 then
		if (GetName(sceneId,targetId)==x207009_g_Name2) then
			if x207009_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                	        BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x207009_g_MissionName)
				AddText(sceneId,x207009_g_ContinueInfo)
			        AddText(sceneId,"#Y任务目标#W") 
				AddText(sceneId,x207009_g_MissionTarget) 
				AddText(sceneId,format("\n    灵狐草   %d/10", LuaFnGetItemCount(sceneId,selfId,13010002) ))
				AddText(sceneId,format("    金兵的耳朵   %d/10", LuaFnGetItemCount(sceneId,selfId,13010003) ))
				EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
			end
                	
			     
                	if x207009_CheckSubmit(sceneId, selfId, targetId) > 0 then
                	     BeginEvent(sceneId)
                	     AddText(sceneId,"#Y"..x207009_g_MissionName)
			     AddText(sceneId,x207009_g_MissionComplete)
			     AddText(sceneId,"#Y任务目标#W") 
			     AddText(sceneId,x207009_g_MissionTarget) 
			     AddText(sceneId,format("\n    灵狐草   %d/10", LuaFnGetItemCount(sceneId,selfId,13010002) ))
			     AddText(sceneId,format("    金兵的耳朵   %d/10", LuaFnGetItemCount(sceneId,selfId,13010003) ))
			     EndEvent()
                	     DispatchMissionContinueInfo(sceneId, selfId, targetId, x207009_g_ScriptId, x207009_g_MissionId)
                	end
                end
                if (GetName(sceneId,targetId)==x207009_g_Name3) then
                	BeginAddItem(sceneId)                                                    
			AddItem( sceneId,x207009_g_DemandItem[2].id, 1 )             
			ret = EndAddItem(sceneId,selfId)                                 
		        if ret > 0 then                                                  
		        	 BeginEvent(sceneId)
				 AddText(sceneId,format("灵狐草   %d/10", LuaFnGetItemCount(sceneId,selfId,13010002)+1 )) 
				 EndEvent()
				 DispatchMissionTips(sceneId, selfId)
				 AddItemListToHuman(sceneId,selfId) 
		        else                                                             
		        	 BeginEvent(sceneId)                                      
				 AddText(sceneId,"物品栏已满！")                    
				 EndEvent(sceneId)                                        
				 DispatchMissionTips(sceneId,selfId) 
			end
			BeginEvent(sceneId)
			AddText(sceneId,"已经采集")
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)    
		end 

        elseif x207009_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x207009_g_MissionName)
                AddText(sceneId,x207009_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x207009_g_MissionTarget) 
		AddMoneyBonus(sceneId, x207009_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207009_g_ScriptId, x207009_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207009_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207009_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207009_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207009_g_ScriptId, x207009_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207009_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207009_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207009_CheckPushList(sceneId, selfId, targetId)
        if (GetName(sceneId,targetId)==x207009_g_Name) then
                if IsMissionHaveDone(sceneId, selfId, x207009_g_MissionIdPre) > 0 then
                    if IsHaveMission(sceneId,selfId, x207009_g_MissionId)<= 0 then
                    return 1
                    end
                end
        end
	if (GetName(sceneId,targetId)==x207009_g_Name2) then
		    if IsHaveMission(sceneId,selfId, x207009_g_MissionId) > 0 then
		    return 1
                    end
        end
        if (GetName(sceneId,targetId)==x207009_g_Name3) then
		    if IsHaveMission(sceneId,selfId, x207009_g_MissionId) > 0 then
		    	if LuaFnGetItemCount(sceneId,selfId,13010002) < 10 then
		    		return 1
		    	end
                    end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x207009_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x207009_g_MissionId, x207009_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x207009_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x207009_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207009_g_MissionId)
	for i, item in pairs(x207009_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x207009_CheckSubmit( sceneId, selfId, targetId)
	if LuaFnGetItemCount(sceneId,selfId,13010003) == 10 then
		if LuaFnGetItemCount(sceneId,selfId,13010002) == 10 then
	        return 1
	        end
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207009_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207009_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207009_g_MissionId)
		AddExp(sceneId, selfId, x207009_g_ExpBonus)
		AddMoney(sceneId, selfId, x207009_g_MoneyBonus)
		for i, item in pairs(x207009_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x207009_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x207009_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207009_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x207009_g_MissionId) >= 0 then 
	 	 if objdataId == x207009_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,13010003) < 10 then
       		         if random(1,100)>20 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x207009_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("金兵的耳朵   %d/10", LuaFnGetItemCount(sceneId,selfId,13010003)+1 )) 
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
		 if objdataId == x207009_g_noDemandKill[2].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,13010003) < 10 then
       		         if random(1,100)>20 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x207009_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("金兵的耳朵   %d/10", LuaFnGetItemCount(sceneId,selfId,13010003)+1 )) 
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

function x207009_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207009_OnItemChanged(sceneId, selfId, itemdataId)

end

