--埋葬的勇士

--MisDescBegin
--当前脚本的索引号
x207001_g_ScriptId = 207001

--当前任务的MissionID，具体由专人负责分配，9开头的默认为是为测试任务分配的ID
x207001_g_MissionId = 2

--任务归类
x207001_g_MissionKind = 1

--任务起始npc
x207001_g_Name	= "速不台"
x207001_g_Name1	= "石头堆"
x207001_g_Name2	= "受伤的蒙古兵"

--****************************************任务可接条件判断*************************************************************************
--任务可接等级范围
x207001_g_MissionMinLevel = 1
x207001_g_MissionMaxLevel = 200

--前置任务的MissionID,可以填写多个前置任务
x207001_g_MisIdPre = 1

--需要后续任务在该任务结束后直接弹出，则填写下面的参数，否则不填写，只能填写一个后续任务
--ScriptId为后续任务的ScriptId。LV为后续任务的等级要求，要和ScriptId对应脚本里面的等级要求一致
x207001_g_ScriptIdNext = {ScriptId = 207002 ,LV = 0 }

--****************************************任务内容开始*********************************************************************
--任务名称
x207001_g_MissionName="埋葬的勇士"
--任务描述(接任务时，和所有目标完成交任务时)支持多条语句
x207001_g_MissionInfo="    真是受不了你，难道你没有看到吗，这城墙被我们的炮火给打塌了，压着我们很多的勇士，我要把他们救出来！我这人心里一急，就什么都想不起来了，你叫#G豁儿赤#W见鬼去吧……！\n \n    不过，看你有几分蛮力，又这么有闲情，如果你能帮我把我的勇士给救出来，我可能会想起一点什么！"
--任务未完成时去交任务的提示文字 ，支持多条语句
x207001_g_ContinueInfo="    勇士们还被埋在土堆下面，再跟我提玉佩的事，我让你直接去问阎王爷。"
--总的大体任务目标描述，一句话描述
x207001_g_MissionTarget="    拯救11名#G受伤的蒙古兵#W"	
x207001_g_MissionComplete="    你杀人的样子颇有我年轻时的神韵，不错！不错！做大事的人就应该这样！!"		

	
--任务奖励(exp为经验调节参数，money为金钱调节参数)
--经验奖励
x207001_g_MoneyBonus = 10000

--固定物品奖励，最多8种
x207001_g_ItemBonus={}

--可选物品奖励，最多8种
x207001_g_RadioItemBonus={}
--MisDescEnd
--**********************************任务入口函数**********************************

function x207001_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	misIndex = GetMissionIndexByID(sceneId,selfId,x207001_g_MissionId)
	local NPCX,NPCY = LuaFnGetWorldPos(sceneId,targetId)
	if IsHaveMission(sceneId,selfId, x207001_g_MissionId) > 0 then
		if (GetName(sceneId,targetId)==x207001_g_Name) then
			if (GetMissionParam(sceneId,selfId,misIndex,0)) < 11 then
				BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x207001_g_MissionName)
				AddText(sceneId,x207001_g_ContinueInfo)
		        	AddText(sceneId,"#Y任务目标#W") 
				AddText(sceneId,x207001_g_MissionTarget)
				AddText(sceneId,format("\n    救出受伤的蒙古兵   %d/11", GetMissionParam(sceneId,selfId,misIndex,0) ))
				EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
			else
				BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x207001_g_MissionName)
				AddText(sceneId,x207001_g_MissionComplete)
		        	AddText(sceneId,"#Y任务目标#W") 
				AddText(sceneId,x207001_g_MissionTarget) 
				AddText(sceneId,format("\n    救出受伤的蒙古兵   %d/11", GetMissionParam(sceneId,selfId,misIndex,0) ))
				AddMoneyBonus(sceneId, x207001_g_MoneyBonus)	
				EndEvent()
				DispatchMissionContinueInfo(sceneId, selfId, targetId, x207001_g_ScriptId, x207001_g_MissionId)
			end
			
		elseif (GetName(sceneId,targetId)==x207001_g_Name1) then

			BeginEvent(sceneId)
			AddText(sceneId,"扒开了土堆")
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
			if random(1,100)>50 then
				LuaFnCreateMonster(sceneId, 124,NPCX+random(-3,3),NPCY+random(-3,3),0,1,-1)
				
			else 
				local a = LuaFnCreateMonster(sceneId,268,NPCX+random(-3,3),NPCY+random(-3,3),3,1,-1)
				
			end
			--LuaFnGmKillObj(sceneId,selfId,targetId)
			
			
		elseif (GetName(sceneId,targetId)==x207001_g_Name2) then
			num = GetMissionParam(sceneId,selfId,misIndex,0)                                        
             		if num <=11  then    
             			SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)  
				BeginEvent(sceneId)
				AddText(sceneId,format("救出受伤的蒙古兵   %d/11", GetMissionParam(sceneId,selfId,misIndex,0) ))
				EndEvent()
			end
			DispatchMissionTips(sceneId, selfId)
			LuaFnDeleteMonster (sceneId,targetId )
		end
	elseif x207001_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x207001_g_MissionName)
                AddText(sceneId,x207001_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x207001_g_MissionTarget )
		AddMoneyBonus(sceneId, x207001_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207001_g_ScriptId, x207001_g_MissionId)
        end	
end


--**********************************

--列举事件

--**********************************

function x207001_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207001_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207001_CheckPushList(sceneId, selfId, targetId) > 0 then
		if (GetName(sceneId,targetId) ~=x207001_g_Name2) then
			AddNumText(sceneId, x207001_g_ScriptId, x207001_g_MissionName)
		else
			AddNumText(sceneId, x207001_g_ScriptId, "伤的重吗")
		end
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207001_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207001_g_Name) then
	    return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207001_CheckPushList(sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x207001_g_MissionId)
        if IsMissionHaveDone(sceneId, selfId, x207001_g_MisIdPre) > 0 then
        	if (GetName(sceneId,targetId)==x207001_g_Name) then
                    return 1
                end
                if (GetName(sceneId,targetId)==x207001_g_Name1) then
                	if IsHaveMission(sceneId,selfId, x207001_g_MissionId) > 0 then
                		if (GetMissionParam(sceneId,selfId,misIndex,0)) < 11 then
                    			return 1
                    		end
                    	end
                end
                if (GetName(sceneId,targetId)==x207001_g_Name2) then
                	if IsHaveMission(sceneId,selfId, x207001_g_MissionId) > 0 then
                		if (GetMissionParam(sceneId,selfId,misIndex,0)) < 11 then
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

function x207001_OnAccept(sceneId, selfId)

	--加入任务到玩家列表
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x207001_g_MissionId, x207001_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务:"..x207001_g_MissionName)
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
end



--**********************************

--放弃

--**********************************

function x207001_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207001_g_MissionId)

end




--**********************************

--检测是否可以提交

--**********************************

function x207001_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x207001_g_MissionId)
	if (GetMissionParam(sceneId,selfId,misIndex,0)) == 11 then
		return 1
	end

end



--**********************************

--提交

--**********************************

function x207001_OnSubmit(sceneId, selfId, targetId, selectRadioId)
 	MissionCom( sceneId,selfId, x207001_g_MissionId )
    	DelMission( sceneId, selfId, x207001_g_MissionId )
	AddExp(sceneId, selfId, x207001_g_ExpBonus)   
	AddMoney(sceneId, selfId, x207001_g_MoneyBonus)
	CallScriptFunction( x207001_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
   		
	     
end


--**********************************

--杀死怪物或玩家

--**********************************

function x207001_OnKillObject(sceneId, selfId, objdataId,objid) 
	if objdataId == 286 then
		LuaFnDeleteMonster (sceneId,objid )
	end
        	
end                                                                                                   
                  




--**********************************

--进入区域事件

--**********************************

function x207001_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207001_OnItemChanged(sceneId, selfId, itemdataId)

end


