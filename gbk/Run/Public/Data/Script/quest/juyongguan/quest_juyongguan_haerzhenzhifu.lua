--哈儿真之父

--MisDescBegin
x206007_g_ScriptId = 206007
x206007_g_MissionIdPre =33
x206007_g_MissionId = 34
x206007_g_MissionKind = 8
x206007_g_MissionLevel = 40
x206007_g_ScriptIdNext = {}
x206007_g_Name	="帖古察" 
x206007_g_Name2	="白发老人" 
x206007_g_DemandItem ={}
x206007_g_DemandKill ={{id=399,num=1}}

x206007_g_MissionName="哈儿真之父"
x206007_g_MissionInfo="    #R阿拉乌#W那个小人，一个小小的俘虏营头目，整天到晚的只知道把责任推给别人，上次野狐狸让术虎给跑了，他被赤老温将军臭骂了一顿之后，把责任推到哈儿真身上。我的哈儿真啊，跟着他算跟错人了，如果哈儿真要叛军，一定是阿拉乌又做了什么见不得人事了！\n \n    恩，希望大人你一定要帮我想想办法！哈儿真和他的亲生父亲见了面，是个白发的老头，阿拉乌正带人去抓他父亲呢，这是人命关天的大事啊。"  --任务描述
x206007_g_MissionTarget="    帮助哈儿真的生父#G白发老人#W解围。"		                                                                                               
x206007_g_MissionComplete="    看你这样出手相救，一定是我儿肝胆相照的朋友，既然都不是外人，我就不瞒你了！\n \n    #R哈儿真#W是我的亲生儿子，他叫完颜不破！虽然我是金人，但是我早已带发修行了，唉……我没有几天可活了，这次来就是想看看我的两个孩子一眼，没想到，被一个叫#R阿拉乌#W的人给抓了!\n \n    我的孩子为了救我，偷偷放了我出来，还让我先跑，他引开追兵去了……，我已经见到大儿子了，我还有个小儿子，他的命没有不破好，天生就瞎了一只眼，造孽啊！我想在我死之前，见他一面。"					--完成任务npc说话的话
x206007_g_ContinueInfo="    救救我，这些蒙古人要杀我！"
--任务奖励
x206007_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x206007_g_ItemBonus={}

--可选物品奖励，最多8种
x206007_g_RadioItemBonus={}

--MisDescEnd
x206007_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x206007_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x206007_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x206007_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x206007_g_MissionId)
		if x206007_CheckSubmit(sceneId, selfId, targetId) <= 0 then
	                        BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x206007_g_MissionName)
				AddText(sceneId,x206007_g_ContinueInfo)
			        AddText(sceneId,"#Y任务目标#W") 
				AddText(sceneId,x206007_g_MissionTarget) 
				AddText(sceneId,format("\n    杀死阿拉乌   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x206007_g_DemandKill[1].num))
				EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
			local nMonsterNum = GetMonsterCount(sceneId)
			local bHave = 0
			local ii = 0
			local bOk =0
			for ii=0, nMonsterNum-1 do
				local nMonsterId = GetMonsterObjID(sceneId,ii)
				if GetName(sceneId, nMonsterId)  == "阿拉乌(45)"  then
					bOk =1
				end
			end
			if bOk==0 then
        			LuaFnCreateMonster(sceneId, 399,211,93,0,1,-1)
        		end
		end
		if x206007_CheckSubmit(sceneId, selfId, targetId) > 0 then
	                     BeginEvent(sceneId)
	                     AddText(sceneId,"#Y"..x206007_g_MissionName)
			     AddText(sceneId,x206007_g_MissionComplete)
			     AddMoneyBonus(sceneId, x206007_g_MoneyBonus)
	                     EndEvent()
			     DispatchMissionContinueInfo(sceneId, selfId, targetId, x206007_g_ScriptId, x206007_g_MissionId)
	        end
	       	       
        elseif x206007_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x206007_g_MissionName)
                AddText(sceneId,x206007_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x206007_g_MissionTarget) 
		AddMoneyBonus(sceneId, x206007_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x206007_g_ScriptId, x206007_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x206007_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x206007_g_MissionId) > 0 then
		return 0
	end
	--如果已接此任务
	if  x206007_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x206007_g_ScriptId, x206007_g_MissionName)
	end
	return 0
	
end



--**********************************

--检测接受条件

--**********************************

function x206007_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x206007_g_Name) then
		return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x206007_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==6) then
		if IsMissionHaveDone(sceneId, selfId, x206007_g_MissionIdPre) > 0 then
	        	if (GetName(sceneId,targetId)==x206007_g_Name2) then
		        	if IsHaveMission(sceneId,selfId, x206007_g_MissionId)> 0 then
		        		return 1
		        	end
		        end
		        if (GetName(sceneId,targetId)==x206007_g_Name) then
				if IsHaveMission(sceneId,selfId, x206007_g_MissionId)<= 0 then
		        		return 1
		        	end
			end
		end
	end
        return 0
		
end

--**********************************

--接受

--**********************************

function x206007_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x206007_g_MissionId, x206007_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x206007_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x206007_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x206007_g_MissionId)
	for i, item in x206007_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x206007_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x206007_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == 1 then
			return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x206007_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x206007_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x206007_g_MissionId)
		AddExp(sceneId, selfId, x206007_g_ExpBonus)
		AddMoney(sceneId, selfId, x206007_g_MoneyBonus)
		for i, item in x206007_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x206007_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x206007_OnKillObject(sceneId, selfId, objdataId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x206007_g_MissionId)  
	if IsHaveMission(sceneId,selfId, x206007_g_MissionId)> 0 then
		if GetMissionParam(sceneId,selfId,misIndex,0) <= 0 then
			if objdataId == x206007_g_DemandKill[1].id then 
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,1)
       		    	 BeginEvent(sceneId)
		    	 AddText(sceneId,format("杀死阿拉乌   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x206007_g_DemandKill[1].num )) 
		    	 EndEvent()
		    	 DispatchMissionTips(sceneId, selfId)
		    	end
       		 end	 
       	end

end



--**********************************

--进入区域事件

--**********************************

function x206007_OnEnterArea(sceneId, selfId, zoneId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x206007_g_MissionId)
	
        if GetMissionParam(sceneId,selfId,misIndex,0) <= 0 then
        	if IsHaveMission(sceneId,selfId, x206007_g_MissionId) > 0 then
        		local nMonsterNum = GetMonsterCount(sceneId)
			local bHave = 0
			local ii = 0
			local bOk =0
			for ii=0, nMonsterNum-1 do
				local nMonsterId = GetMonsterObjID(sceneId,ii)
				if GetName(sceneId, nMonsterId)  == "阿拉乌(45)"  then
					bOk =1
				end
			end
			if bOk==0 then
        			LuaFnCreateMonster(sceneId, 399,211,93,0,1,-1)
        		end
        	end
        	
        end

end

function x206007_OnTimer(sceneId, selfId )
	
end

function x206007_OnLeaveArea(sceneId, selfId )

end



--**********************************

--道具改变

--**********************************

function x206007_OnItemChanged(sceneId, selfId, itemdataId)

end

