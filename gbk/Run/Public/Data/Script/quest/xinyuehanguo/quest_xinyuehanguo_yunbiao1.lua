--功能：一级运镖
--NPC：新月汗国 哈马斯

x211009_g_ScriptId = 211009
x211009_g_MissionName="一级运镖"

--**********************************

--任务入口函数

--**********************************

function x211009_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	BeginEvent(sceneId)
		AddText(sceneId, "#Y一级运镖")
		AddText(sceneId, "看到我名字了吗？别看我人小，在道上我可是出了名的，旁边这两个都是我收的小弟。\n只要你愿意拜在我的门下，保你以后在道上混得开。不然，嘿嘿……我的名字可不是叫着玩的！！！")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end



--**********************************

--列举事件

--**********************************

function x211009_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x211009_g_ScriptId, x211009_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x211009_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x211009_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x211009_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211009_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211009_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211009_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211009_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211009_OnItemChanged(sceneId, selfId, itemdataId)

end