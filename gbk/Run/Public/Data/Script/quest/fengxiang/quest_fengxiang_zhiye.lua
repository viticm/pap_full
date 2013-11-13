--杀怪任务
--金国士兵
--MisDescBegin
--脚本号
x910015_g_ScriptId = 910015

--上一个任务的ID
--g_MissionIdPre =

--任务号,9开头的是为测试任务分配的ID
x910015_g_MissionId = 905

--任务目标npc
x910015_g_Name	="速不台" 

--任务归类
x910015_g_MissionKind = 1

--任务等级
x910015_g_MissionLevel = 1

--是否是精英任务
x910015_g_IfMissionElite = 0

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************
--任务是否已经完成
x910015_g_IsMissionOkFail = 0		--变量的第0位

--任务需要杀死的怪
x910015_g_DemandKill ={{id=80,num=10}}		--变量第1位

--选择门派对应的三个按钮
x910015_g_eventList={910012,910013,910014}	

--以上是动态**************************************************************

--任务文本描述
x910015_g_MissionName="选择职业"
x910015_g_ZhiyeName={"战士","道士","牧师"}


x910015_g_MissionInfo="杀死10个金国士兵"  --任务描述
x910015_g_MissionTarget="杀死10个金国士兵"		--任务目标
x910015_g_ContinueInfo="你已经杀了10个金国士兵吗？"		--未完成任务的npc对话
x910015_g_MissionComplete="干得不错"					--完成任务npc说话的话

--任务奖励
x910015_g_MoneyBonus=100
x910015_g_ItemBonus={{id=30001001,num=5}}
x910015_g_RadioItemBonus={{id=30001002,num=5},{id=30001003,num=5}}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x910015_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	x910015_UpdateEventList( sceneId, selfId, targetId )
end


function x910015_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	AddText(sceneId,"请选择你要的职业")
	for i, eventId in pairs(x910015_g_eventList) do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

function x910015_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in pairs(x910015_g_eventList) do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--列举事件
--**********************************
function x910015_OnEnumerate( sceneId, selfId, targetId )
	AddNumText(sceneId,x910015_g_ScriptId,x910015_g_MissionName);
end

--**********************************
--列举门派
--**********************************
function x910015_OnEnumerateZhiye( sceneId, selfId, targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	AddText(sceneId,"现在有三个职业供你选择。你也可以随时来找我更换职业。")
	for i, eventId in pairs(x910015_g_eventList) do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--检测接受条件
--**********************************
function x910015_CheckAccept( sceneId, selfId )
	--需要1级才能接
	if GetLevel( sceneId, selfId ) >= 1 then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x910015_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x910015_g_MissionId, x910015_g_ScriptId, 1, 0, 0 )		--添加任务
	misIndex = GetMissionIndexByID(sceneId,selfId,x910015_g_MissionId)			--得到任务的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)						--根据序列号把任务变量的第0位置0
	SetMissionByIndex(sceneId,selfId,misIndex,1,0)						--根据序列号把任务变量的第1位置0
end

--**********************************
--放弃
--**********************************
function x910015_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x910015_g_MissionId )
end

--**********************************
--继续
--**********************************
function x910015_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x910015_g_MissionName)
		AddText(sceneId,x910015_g_MissionComplete)
		AddMoneyBonus( sceneId, x910015_g_MoneyBonus )
		for i, item in pairs(x910015_g_ItemBonus) do
			AddItemBonus( sceneId, item.id, item.num )
		end
		for i, item in pairs(x910015_g_RadioItemBonus) do
			AddRadioItemBonus( sceneId, item.id, item.num )
		end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x910015_g_ScriptId,x910015_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x910015_CheckSubmit( sceneId, selfId )
	misIndex = GetMissionIndexByID(sceneId,selfId,x910015_g_MissionId)
    num = GetMissionParam(sceneId,selfId,misIndex,1)
    if num == x910015_g_DemandKill[1].num then
       return 1
    end
	return 0
end

--**********************************
--提交
--**********************************
function x910015_OnSubmit( sceneId, selfId, targetId,selectRadioId )
	if x910015_CheckSubmit( sceneId, selfId, selectRadioId ) then
    	BeginAddItem(sceneId)
			for i, item in pairs(x910015_g_ItemBonus) do
				AddItem( sceneId,item.id, item.num )
			end
			for i, item in pairs(x910015_g_RadioItemBonus) do
				if item.id == selectRadioId then
					AddItem( sceneId,item.id, item.num )
				end
			end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then
			AddMoney(sceneId,selfId,x910015_g_MoneyBonus );
			--扣除任务物品
			--for i, item in pairs(g_DemandItem) do
			--	DelItem( sceneId, selfId, item.id, item.num )
			--end
			ret = DelMission( sceneId, selfId, x910015_g_MissionId )
			if ret > 0 then
				MissionCom( sceneId,selfId, x910015_g_MissionId )
				AddItemListToHuman(sceneId,selfId)
			end
		else
		--任务奖励没有加成功
			BeginEvent(sceneId)
				strText = "背包已满,无法完成任务"
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		end      
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x910015_OnKillObject( sceneId, selfId, objdataId )

end

--**********************************
--进入区域事件
--**********************************
function x910015_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x910015_OnItemChanged( sceneId, selfId, itemdataId )
end
