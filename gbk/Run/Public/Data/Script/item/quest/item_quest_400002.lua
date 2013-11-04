
x400002_g_scriptId = 400002 
x400002_g_Impact1 = 3001 
x400002_g_Impact2 = -1 --不用
x208003_g_MissionId = 57
x400002_g_DemandItem ={{id=13010009,num=1}}

--**********************************
--事件交互入口
--**********************************
function x400002_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不需要这个接口，但要保留空函数
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x400002_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x400002_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x400002_OnConditionCheck( sceneId, selfId )
	misIndex = GetMissionIndexByID(sceneId,selfId,x208003_g_MissionId)
        if (GetMissionParam(sceneId,selfId,misIndex,2)==1) then
        		return 1
	end
	if (GetMissionParam(sceneId,selfId,misIndex,2)==0) then
		BeginEvent(sceneId)
		AddText(sceneId,"请先到城门前再使用")
		DispatchMissionTips(sceneId,selfId) 
		EndEvent(sceneId)
	end
	return 0
end

--**********************************
--消耗检测及处理入口：
--系统会在技能消耗的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--注意：这不光负责消耗的检测也负责消耗的执行。
--**********************************
function x400002_OnDeplete( sceneId, selfId )
     misIndex = GetMissionIndexByID(sceneId,selfId,x208003_g_MissionId)
        		LuaFnDepletingUsedItem(sceneId, selfId)
        		SetMissionByIndex(sceneId,selfId,misIndex,1,1)
			BeginEvent(sceneId)
			AddText(sceneId,format("把告示贴在城门   %d/1", GetMissionParam(sceneId,selfId,misIndex,1)))
			DispatchMissionTips(sceneId,selfId) 
			return 1
end

--**********************************
--只会执行一次入口：
--聚气和瞬发技能会在消耗完成后调用这个接口（聚气结束并且各种条件都满足的时候），而引导
--技能也会在消耗完成后调用这个接口（技能的一开始，消耗成功执行之后）。
--返回1：处理成功；返回0：处理失败。
--注：这里是技能生效一次的入口
--**********************************
function x400002_OnActivateOnce( sceneId, selfId )
	
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x400002_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end
