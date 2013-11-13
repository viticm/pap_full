--代练之经验效率

--MisDescBegin
--脚本号
x800025_g_ScriptId = 800025
--MisDescEnd


function x800025_SubTrainExpRate( sceneId, level, attack, mode, constant )	--点击该任务后执行此脚本
	local mode = mode/10
	local Exp
	if level < 10 then
		Exp = ceil(level*attack*mode*2)
	else
		Exp = ceil(level*level*attack*mode/5)
	end
	
	if Exp > 0 then
		return Exp
	else
		return 0
	end
end





--**********************************
--任务入口函数
--**********************************
function x800025_OnDefaultEvent( sceneId, selfId, targetId )	

end

--**********************************
--列举事件
--**********************************
function x800025_OnEnumerate( sceneId, selfId, targetId )

end


--********************
--检测接受条件
--**********************************
function x800025_CheckAccept( sceneId, selfId )

end

--**********************************
--接受
--**********************************
function x800025_OnAccept( sceneId, selfId )

end

--**********************************
--放弃
--**********************************
function x800025_OnAbandon( sceneId, selfId )

end

--**********************************
--继续
--**********************************
function x800025_OnContinue( sceneId, selfId, targetId )

end

--**********************************
--检测是否可以提交
--**********************************
function x800025_CheckSubmit( sceneId, selfId )

end

--**********************************
--提交
--**********************************
function x800025_OnSubmit( sceneId, selfId, targetId,selectRadioId )

end

--**********************************
--杀死怪物或玩家
--**********************************
function x800025_OnKillObject( sceneId, selfId, objdataId )

end

--**********************************
--进入区域事件
--**********************************
function x800025_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x800025_OnItemChanged( sceneId, selfId, itemdataId )
end
