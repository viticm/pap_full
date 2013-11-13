--寻找线索

--MisDescBegin
x207004_g_ScriptId = 207004
x207004_g_MissionIdPre =4
x207004_g_MissionId = 5
x207004_g_MissionKind = 1
x207004_g_ScriptIdNext = {ScriptId = 207005 ,LV = 1 }
x207004_g_Name	="阔阔出" 
x207004_g_Name2	="赤老温" 
x207004_g_DemandItem ={id=13010010,num=1}
x207004_g_noDemandKill ={{id=420,num=1},{id=421,num=1},{id=422,num=1}}	

x207004_g_MissionName="寻找线索"
x207004_g_MissionInfo="    在攻打#G乌月营#W的时候，这女人被乱箭给射死了，#G拖雷#W埋葬这女人的时候，把这玉佩也跟着一起埋了。多好的玉啊，值钱啊，这#G拖雷#W……咳~！！~！我们的话离题了！\n \n只是，戴着面具的人是怎样得到这玉佩的，我是不能说的，这是天机！噢，我想起来了，前几天#G赤老温#W找我喝酒的时候，似乎也遇到了……，你可以到处走走，或许戴面具的人还有其他同伙，西北方的神秘人鬼鬼祟祟的，幸运的话，你能从他们身上找到一些什么东西，#G赤老温#W可能会给你答案。"  --任务描述
x207004_g_MissionTarget="    找到#R神秘人#W并在他们身上找到些线索，然后给#G赤老温#W带回来。"		
x207004_g_MissionComplete="    这封信是你在那些带着面具的#R神秘人#W身上找到的？"					--完成任务npc说话的话
x207004_g_ContinueInfo="    那些#R神秘人#W我也不太了解，你最好能在他们身上找到些线索给我带回来。"
--任务奖励
x207004_g_MoneyBonus = 10000

--固定物品奖励，最多8种
x207004_g_ItemBonus={}

--可选物品奖励，最多8种
x207004_g_RadioItemBonus={}

--MisDescEnd
--**********************************

--任务入口函数

--**********************************

function x207004_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207004_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207004_g_MissionId) > 0 then
		if x207004_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x207004_g_MissionName)
			AddText(sceneId,x207004_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x207004_g_MissionTarget) 
			AddText(sceneId,format("\n    潦草的信   %d/1", LuaFnGetItemCount(sceneId,selfId,13010010) ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x207004_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x207004_g_MissionName)
		     AddText(sceneId,x207004_g_MissionComplete)
		     AddText(sceneId,"#Y任务目标#W") 
		     AddText(sceneId,x207004_g_MissionTarget) 
		     AddText(sceneId,format("\n    潦草的信   %d/1", LuaFnGetItemCount(sceneId,selfId,13010010) ))
                     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x207004_g_ScriptId, x207004_g_MissionId)
                end

        elseif x207004_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x207004_g_MissionName)
                AddText(sceneId,x207004_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x207004_g_MissionTarget) 
		AddMoneyBonus(sceneId, x207004_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207004_g_ScriptId, x207004_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207004_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207004_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207004_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207004_g_ScriptId, x207004_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207004_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207004_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207004_CheckPushList(sceneId, selfId, targetId)
        if (GetName(sceneId,targetId)==x207004_g_Name) then
                if IsMissionHaveDone(sceneId, selfId, x207004_g_MissionIdPre) > 0 then
                    if IsHaveMission(sceneId,selfId, x207004_g_MissionId)<= 0 then
                    return 1
                    end
                end
        end
	if (GetName(sceneId,targetId)==x207004_g_Name2) then
		    if IsHaveMission(sceneId,selfId, x207004_g_MissionId) > 0 then
		    return 1
                    end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x207004_OnAccept(sceneId, selfId)

	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x207004_g_MissionId, x207004_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x207004_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
		                                                           
	                                                                     
	     
end



--**********************************

--放弃

--**********************************







function x207004_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207004_g_MissionId)
	for i, item in pairs(x207004_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x207004_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,13010010) == 1 then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207004_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207004_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207004_g_MissionId)
		AddExp(sceneId, selfId, x207004_g_ExpBonus)
		AddMoney(sceneId, selfId, x207004_g_MoneyBonus)
		for i, item in pairs(x207004_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x207004_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x207004_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207004_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x207004_g_MissionId) >= 0 then   
       		 if objdataId == x207004_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,13010010) < 1 then
       		         if random(1,100)>10 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x207004_g_DemandItem.id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("潦草的信   %d/1", LuaFnGetItemCount(sceneId,selfId,13010010)+1 )) 
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
      		 if objdataId == x207004_g_noDemandKill[2].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,13010010) < 1 then
       		         if random(1,100)>10 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x207004_g_DemandItem.id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("潦草的信   %d/1", LuaFnGetItemCount(sceneId,selfId,13010010)+1 )) 
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
       		 if objdataId == x207004_g_noDemandKill[3].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,13010010) < 1 then
       		         if random(1,100)>10 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x207004_g_DemandItem.id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("潦草的信   %d/1", LuaFnGetItemCount(sceneId,selfId,13010010)+1 )) 
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

function x207004_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207004_OnItemChanged(sceneId, selfId, itemdataId)

end

