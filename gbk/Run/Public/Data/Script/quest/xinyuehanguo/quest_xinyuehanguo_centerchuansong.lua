--功能：中心传送
--NPC：中心传送使者

x211022_g_ScriptId = 211022
x211022_g_MissionName="蔑里乞部"
--**********************************

--任务入口函数

--**********************************

function x211022_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	CallScriptFunction((800019), "TransferFunc",sceneId, selfId, 1,86,130)
end

--用户通过UI请求切换场景
--在CGMapInfoHandler中被呼叫
function x211022_OnChangeSceneEvent(sceneId, selfId, index)	
				
	--得到进入该场景需要的最小等级、场景ID，位置信息
	local MinUserLevel, targetSceneId, PosX,PosZ = LuaFnGetNewSceneInfoByIndex(sceneId,index)
	
	local level = GetLevel(sceneId, selfId)
	
	if level >= MinUserLevel then
		if LuaFnIsInStall(sceneId, selfId) == 0 then
			NewWorld(sceneId,selfId,targetSceneId,PosX,PosZ)	
		end
	end

end

--**********************************

--列举事件

--**********************************

function x211022_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x211022_g_ScriptId, x211022_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x211022_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x211022_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x211022_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211022_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211022_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211022_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211022_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211022_OnItemChanged(sceneId, selfId, itemdataId)

end