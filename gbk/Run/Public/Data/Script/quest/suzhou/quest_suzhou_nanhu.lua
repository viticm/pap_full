--功能：传送
--MisDescBegin
x199998_g_ScriptId = 199998
x199998_g_MissionName="我要去南湖"
--MisDescEnd
--**********************************

--任务入口函数

--**********************************

function x199998_OnDefaultEvent(sceneId, selfId, targetId,PosX,PosZ)	--点击该任务后执行此脚本
	  if GetLevel(sceneId, selfId ) >= 15 then
		NewWorld(sceneId, selfId,10,100,90)
			BeginEvent(sceneId)
			strText = "你来到了南湖野外"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	else
	BeginEvent(sceneId)
			AddText(sceneId, "#Y我要去南湖")
			AddText(sceneId, "你还太嫩了点，等你到15级以后再来找我吧")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end

--**********************************

--列举事件

--**********************************

function x199998_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x199998_g_ScriptId, x199998_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x199998_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x199998_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x199998_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x199998_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x199998_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x199998_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x199998_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x199998_OnItemChanged(sceneId, selfId, itemdataId)

end