--虚伪的面具

--MisDescBegin
x205008_g_ScriptId = 205008
--x205008_g_MissionIdPre =41
x205008_g_MissionId = 48
x205008_g_MissionKind = 11
x205008_g_MissionLevel = 55
--x205008_g_ScriptIdNext = {ScriptId = 205003 ,LV = 1 }
x205008_g_Name	="千夫长" 
x205008_g_DemandItem ={}
x205008_g_DemandKill ={{id=306,num=15}}

x205008_g_MissionName="虚伪的面具"
x205008_g_MissionInfo="    两国相持，不斩来使！即使邦交不成，扎兰丁王子也不应该这样对我们的商队，这是遭世人唾弃的！我们带着成吉思汗那比天还高，比贝尔加湖的水还清澈的友谊来结交，他们居然当我们是奸细……\n \n    "  --任务描述
x205008_g_MissionInfo2="，你明白这里面的意思了吗？他们这样毫无忌惮，一定是想杀我们灭口！既然事情到了这个地步，我们只有一个办法，就是跟他们拼了！让他们常常成吉思汗子民的厉害，我们要反击。第一战，就是剿灭在（182，203）的营地的#R花剌子模步兵#W。"
x205008_g_MissionTarget="    帮助#G千夫长#W剿灭在南部营地的15名#R花剌子模步兵#W。"		                                                                                               
x205008_g_MissionComplete="    很好，我们草原英雄，就该有这样的手腕。"					--完成任务npc说话的话
x205008_g_ContinueInfo="    儿郎们，把你们的力量都使出来吧！在南部营地的那些花剌子模步兵将是你的羔羊！"
--任务奖励
x205008_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x205008_g_ItemBonus={}

--可选物品奖励，最多8种
x205008_g_RadioItemBonus={}

--MisDescEnd
x205008_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x205008_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x205008_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x205008_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x205008_g_MissionId)
		if x205008_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x205008_g_MissionName)
			AddText(sceneId,x205008_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x205008_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死花剌子模步兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x205008_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x205008_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x205008_g_MissionName)
		     AddText(sceneId,x205008_g_MissionComplete)
		     AddMoneyBonus(sceneId, x205008_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x205008_g_ScriptId, x205008_g_MissionId)
                end

        elseif x205008_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x205008_g_MissionName)
                AddText(sceneId,x205008_g_MissionInfo..GetName(sceneId, selfId)..x205008_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x205008_g_MissionTarget) 
		AddMoneyBonus(sceneId, x205008_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x205008_g_ScriptId, x205008_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x205008_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x205008_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x205008_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x205008_g_ScriptId, x205008_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x205008_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x205008_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x205008_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==5) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x205008_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x205008_g_MissionId, x205008_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x205008_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x205008_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x205008_g_MissionId)
	for i, item in x205008_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x205008_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x205008_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x205008_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x205008_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x205008_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x205008_g_MissionId)
		AddExp(sceneId, selfId, x205008_g_ExpBonus)
		AddMoney(sceneId, selfId, x205008_g_MoneyBonus)
		for i, item in x205008_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x205008_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x205008_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x205008_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x205008_g_MissionId) >= 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x205008_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x205008_g_DemandKill[1].id then 
       		    if num < x205008_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死花剌子模步兵   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x205008_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x205008_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x205008_OnItemChanged(sceneId, selfId, itemdataId)

end

