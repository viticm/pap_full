--有福庆的伴当

--MisDescBegin
x214011_g_ScriptId = 214011
--x214011_g_MissionIdPre =87
x214011_g_MissionId = 118
x214011_g_MissionKind = 3
x214011_g_MissionLevel = 15
--x214011_g_ScriptIdNext = {ScriptId = 205005 ,LV = 1 }
x214011_g_Name	="王汗" 
x214011_g_DemandItem ={{id=13010038,num=1}}
x214011_g_noDemandKill ={{id=366,num=1}}	

x214011_g_MissionName="有福庆的伴当"
x214011_g_MissionInfo="    "  --任务描述
x214011_g_MissionInfo2="小兄弟，我听说过你的大名，闻名不如见面，果真是英雄出少年。见到铁木真孩儿有你们这些英雄辅助，我是老怀安慰啊！\n \n    恩，告诉你一个秘密，铁木真准备封者勒蔑为“有福庆的伴当”，这是因为铁木真受伤的时候，者勒蔑光着身子到敌阵抢水并彻夜看护。\n \n     跟你聊天真是太愉快了，不过，还是说说正事吧，我想你帮我去把塔塔儿首领#c0080C0蔑儿真的人头#W给拿来，他就在札木合大营附近，我要拿他人头来奠基我的先祖。"
x214011_g_MissionTarget="    到札木合附近找到塔塔儿首领#R蔑儿真#W，把他人头拿回来给#G王汗#W。"		
x214011_g_MissionComplete="    苍天有眼，我终于可以为我祖父报仇了！"					--完成任务npc说话的话
x214011_g_ContinueInfo="    塔塔儿的蔑儿真是我的仇人，我一定要拿到他的人头。"
--任务奖励
x214011_g_MoneyBonus = 600
--固定物品奖励，最多8种
x214011_g_ItemBonus={}

--可选物品奖励，最多8种
x214011_g_RadioItemBonus={{id=10226002,num=1},{id=10206002,num=1}}

--MisDescEnd
x214011_g_ExpBonus = 6500
--**********************************

--任务入口函数

--**********************************

function x214011_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x214011_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x214011_g_MissionId) > 0 then
		if x214011_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x214011_g_MissionName)
			AddText(sceneId,x214011_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x214011_g_MissionTarget) 
			AddText(sceneId,format("\n    蔑儿真的人头   %d/%d", LuaFnGetItemCount(sceneId,selfId,x214011_g_DemandItem[1].id),x214011_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x214011_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x214011_g_MissionName)
		     AddText(sceneId,x214011_g_MissionComplete)
		     AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in pairs(x214011_g_DemandItem) do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x214011_g_MoneyBonus)
		     for i, item in pairs(x214011_g_ItemBonus) do
	             	AddItemBonus(sceneId, item.id, item.num)
	             end
		     for i, item in pairs(x214011_g_RadioItemBonus) do
	            	 AddRadioItemBonus(sceneId, item.id, item.num)
	             end
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x214011_g_ScriptId, x214011_g_MissionId)
                end

        elseif x214011_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x214011_g_MissionName)
                AddText(sceneId,x214011_g_MissionInfo..GetName(sceneId, selfId)..x214011_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x214011_g_MissionTarget) 
		AddMoneyBonus(sceneId, x214011_g_MoneyBonus)	
		for i, item in pairs(x214011_g_ItemBonus) do
	             	AddItemBonus(sceneId, item.id, item.num)
	        end
		for i, item in pairs(x214011_g_RadioItemBonus) do
	            	 AddRadioItemBonus(sceneId, item.id, item.num)
	        end	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x214011_g_ScriptId, x214011_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x214011_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x214011_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x214011_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x214011_g_ScriptId, x214011_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x214011_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x214011_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x214011_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==14) then
        	         return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x214011_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x214011_g_MissionId, x214011_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x214011_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x214011_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x214011_g_MissionId)
	for i, item in pairs(x214011_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x214011_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x214011_g_DemandItem[1].id) == x214011_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x214011_OnSubmit(sceneId, selfId, targetId, selectRadioId)

		BeginAddItem(sceneId)                                                    
			for i, item in pairs(x214011_g_ItemBonus) do                    
				AddItem( sceneId,item.id, item.num )             
			end                                                      
			for i, item in pairs(x214011_g_RadioItemBonus) do               
				if item.id == selectRadioId then                 
					AddItem( sceneId,item.id, item.num )     
				end                                              
			end                                                      
		ret = EndAddItem(sceneId,selfId)                                 
		if ret > 0 then                                                  
		  ret = DelMission( sceneId, selfId, x214011_g_MissionId ) 
			if ret > 0 then                                   
				MissionCom( sceneId,selfId, x214011_g_MissionId )
				AddExp(sceneId, selfId, x214011_g_ExpBonus)   
	                        AddMoney(sceneId, selfId, x214011_g_MoneyBonus)
	                        AddItemListToHuman(sceneId,selfId)
			end                                               
		else                                                             
			BeginEvent(sceneId)                                      
				AddText(sceneId,"物品栏已满，请整理下再来！");                        
			EndEvent(sceneId)                                        
			DispatchMissionTips(sceneId,selfId)                      
		end   
		--CallScriptFunction( x214011_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x214011_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x214011_g_MissionId) >= 0 then                                       
       		 if objdataId == x214011_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x214011_g_DemandItem[1].id) < x214011_g_DemandItem[1].num then
       		         if random(1,100)>0 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x214011_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("蔑儿真的人头   %d/%d", LuaFnGetItemCount(sceneId,selfId,x214011_g_DemandItem[1].id)+1,x214011_g_DemandItem[1].num )) 
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

function x214011_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x214011_OnItemChanged(sceneId, selfId, itemdataId)

end

