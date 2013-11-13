--功能：中心传送
--NPC：中心传送使者

--**********************************

--任务入口函数

--**********************************

function x800021_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

end

--用户通过UI请求切换场景
--在CGMapInfoHandler中被呼叫
function x800021_OnChangeSceneEvent(sceneId, selfId, index)	
				
	--得到进入该场景需要的最小等级、场景ID，位置信息
	local MinUserLevel, targetSceneId, PosX,PosZ = LuaFnGetNewSceneInfoByIndex(sceneId,index)
	
	local level = GetLevel(sceneId, selfId)
	
	if level >= MinUserLevel then
		if LuaFnIsInStall(sceneId, selfId) == 0 then
			if (sceneId~=targetSceneId) then
				NewWorld(sceneId,selfId,targetSceneId,PosX,PosZ)	
			else
				BeginEvent(sceneId)
					strText = "#Y你已经身处此地了"
					AddText(sceneId,strText);
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
			end
		end
	else
		BeginEvent(sceneId)
			strText = "#Y你等级还低，无法前往目的地"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	end
	
end

--**********************************

--列举事件

--**********************************

function x800021_OnEnumerate(sceneId, selfId, targetId)

end



--**********************************

--检测接受条件

--**********************************

function x800021_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x800021_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x800021_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x800021_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x800021_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x800021_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x800021_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x800021_OnItemChanged(sceneId, selfId, itemdataId)

end