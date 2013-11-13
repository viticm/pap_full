x950000_g_ScriptId = 950000

--以上是动态**************************************************************

--任务文本描述
x950000_g_MissionName="清空包裹"


--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x950000_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本

	for i = 0, 180 do
		local itemnum = LuaFnGetItemCountInBagPos(sceneId, selfId, i);
		if itemnum > 0 then
			LuaFnEraseItem(sceneId, selfId, i);
		end
	end
	
end

--**********************************
--列举事件
--**********************************
function x950000_OnEnumerate( sceneId, selfId, targetId )
	AddNumText(sceneId,x950000_g_ScriptId,x950000_g_MissionName);
end