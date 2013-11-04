--突围出去

--MisDescBegin
x205007_g_ScriptId = 205007
--x205007_g_MissionIdPre =40
x205007_g_MissionId = 47
x205007_g_MissionKind = 11
x205007_g_MissionLevel = 55
--x205007_g_ScriptIdNext = {ScriptId = 205007 ,LV = 1 }
x205007_g_Name	="也遂" 
x205007_g_Name2	="阿卜拉老人" 
x205007_g_noDemandItem ={{id=13010007,num=1}}
x205007_g_DemandKill ={{id=305,num=20}}	

x205007_g_MissionName="突围出去"
x205007_g_MissionInfo="    不管扎兰丁王子是否看到大汗的信，我们不能再等下去！我们的食物和淡水非常有限，护卫队的伤员越来越多！\n \n    为了所有的勇士和商队的安全，我已经决定了要做好突围的准备，如果大汗怪罪下来，我一个人承担！\n \n    我研究过，也许可以从沙漠的（211，112）处突围！这是我们联络用的烟花，你把那附近的#R沙漠守卫#W给清理之后，点燃这个#c0080C0烟花#W，#R阿卜拉老人#W会接应你。"  --任务描述
x205007_g_MissionTarget="    也遂王妃让你拿着烟花从沙漠的（211，112）处突围，杀死20个附近的#R沙漠守卫#W后点燃#c0080C0烟花#W，然后跟#G阿卜拉老人#W接头。"		
x205007_g_MissionComplete="    仁慈的真主啊，请保佑那些受困受难的人吧。"					--完成任务npc说话的话
x205007_g_ContinueInfo="    那是敌人最薄弱的环节，只要你能成功突围出去，我们的大批人马就紧跟着过来。你千万要小心。"
--任务奖励
x205007_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x205007_g_ItemBonus={}

--可选物品奖励，最多8种
x205007_g_RadioItemBonus={}

--MisDescEnd
x205007_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x205007_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x205007_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x205007_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x205007_g_MissionId)
		if x205007_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x205007_g_MissionName)
			AddText(sceneId,x205007_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x205007_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死沙漠守卫   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x205007_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x205007_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x205007_g_MissionName)
		     AddText(sceneId,x205007_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in x205007_g_noDemandItem do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x205007_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x205007_g_ScriptId, x205007_g_MissionId)
                end

        elseif x205007_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x205007_g_MissionName)
                AddText(sceneId,x205007_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x205007_g_MissionTarget) 
		AddMoneyBonus(sceneId, x205007_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x205007_g_ScriptId, x205007_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x205007_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x205007_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x205007_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x205007_g_ScriptId, x205007_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x205007_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x205007_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x205007_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==5) then
        	if (GetName(sceneId,targetId)==x205007_g_Name) then
                 --if IsMissionHaveDone(sceneId, selfId, x205007_g_MissionIdPre) > 0 then
                    if IsHaveMission(sceneId,selfId, x205007_g_MissionId)<= 0 then
                    	return 1
                    end
                --end
        	end
        
		if (GetName(sceneId,targetId)==x205007_g_Name2) then
		    if IsHaveMission(sceneId,selfId, x205007_g_MissionId) > 0 then
		    	return 1
                    end
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x205007_OnAccept(sceneId, selfId)

	BeginAddItem(sceneId)                                                    
	AddItem( sceneId,x205007_g_noDemandItem[1].id, x205007_g_noDemandItem[1].num )             
		ret = EndAddItem(sceneId,selfId)                                 
	        if ret > 0 then                                                  
	        	BeginEvent(sceneId)
			AddMission( sceneId, selfId, x205007_g_MissionId, x205007_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x205007_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)AddItemListToHuman(sceneId,selfId) 
	        else                                                             
		     BeginEvent(sceneId)                                      
		     AddText(sceneId,"物品栏已满，请整理下再来！")                    
		     EndEvent(sceneId)                                        
		     DispatchMissionTips(sceneId,selfId)                      
	        end           	         
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x205007_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x205007_g_MissionId)
	for i, item in x205007_g_noDemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x205007_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x205007_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x205007_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x205007_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x205007_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x205007_g_MissionId)
		AddExp(sceneId, selfId, x205007_g_ExpBonus)
		AddMoney(sceneId, selfId, x205007_g_MoneyBonus)
		for i, item in x205007_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x205007_g_noDemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x205007_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x205007_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x205007_g_MissionId) >= 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x205007_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x205007_g_DemandKill[1].id then 
       		    if num < x205007_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死沙漠守卫   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x205007_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x205007_OnEnterArea(sceneId, selfId, zoneId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x205007_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,1,1)

end

function x205007_OnLeaveArea(sceneId, selfId )
	misIndex = GetMissionIndexByID(sceneId,selfId,x205007_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,1,0)
end

function x205007_OnTimer(sceneId, selfId )

end



--**********************************

--道具改变

--**********************************

function x205007_OnItemChanged(sceneId, selfId, itemdataId)

end
