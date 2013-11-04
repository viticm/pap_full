--代练之金钱消耗

--MisDescBegin
--脚本号
x800026_g_ScriptId = 800026
--MisDescEnd




function x800026_SubTrainMoneyRate( sceneId, level, attack, mode, constant )	--点击该任务后执行此脚本
	local mode = mode/10
	local Money
	if level < 10 then
		Money = ceil(level*attack*mode)
	else
		Money = ceil(level*level*attack*mode/10)
	end
	
	if Money > 0 then
		return Money
	else
		return 0
	end
end




--**********************************
--任务入口函数
--**********************************
function x800026_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
--		(这里写弹出打孔界面的脚本接口)
end

--**********************************
--列举事件
--**********************************
function x800026_OnEnumerate( sceneId, selfId, targetId )
	AddNumText(sceneId,x800026_g_ScriptId,x800026_g_MissionName);
end


--********************
--检测接受条件
--**********************************
function x800026_CheckAccept( sceneId, selfId )
		return 1
end

--**********************************
--接受
--**********************************
function x800026_OnAccept( sceneId, selfId )

end

--**********************************
--放弃
--**********************************
function x800026_OnAbandon( sceneId, selfId )

end

--**********************************
--继续
--**********************************
function x800026_OnContinue( sceneId, selfId, targetId )

end

--**********************************
--检测是否可以提交
--**********************************
function x800026_CheckSubmit( sceneId, selfId )

end

--**********************************
--提交
--**********************************
function x800026_OnSubmit( sceneId, selfId, targetId,selectRadioId )

end

--**********************************
--杀死怪物或玩家
--**********************************
function x800026_OnKillObject( sceneId, selfId, objdataId )

end

--**********************************
--进入区域事件
--**********************************
function x800026_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x800026_OnItemChanged( sceneId, selfId, itemdataId )
end
