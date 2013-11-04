--杀怪任务
--金国士兵
--MisDescBegin
--脚本号
x910020_g_ScriptId = 910020

--上一个任务的ID
--g_MissionIdPre =

--任务号,9开头的是为测试任务分配的ID
x910020_g_MissionId = 905

--任务目标npc
x910020_g_Name	="速不台" 

--任务归类
x910020_g_MissionKind = 1

--任务等级
x910020_g_MissionLevel = 1

--是否是精英任务
x910020_g_IfMissionElite = 0

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************
--任务是否已经完成
x910020_g_IsMissionOkFail = 0		--变量的第0位

--任务需要杀死的怪
x910020_g_DemandKill ={{id=80,num=10}}		--变量第1位

--选择门派对应的三个按钮
x910020_g_eventList={}	

--以上是动态**************************************************************

--任务文本描述

x910020_g_MissionName="变换玩家阵营"
x910020_g_ZhiyeName={"战士","道士","牧师"}


x910020_g_MissionInfo="杀死10个金国士兵"  --任务描述
x910020_g_MissionTarget="杀死10个金国士兵"		--任务目标
x910020_g_ContinueInfo="你已经杀了10个金国士兵吗？"		--未完成任务的npc对话
x910020_g_MissionComplete="干得不错"					--完成任务npc说话的话

--任务奖励
x910020_g_MoneyBonus=100
x910020_g_ItemBonus={{id=30001001,num=5}}
x910020_g_RadioItemBonus={{id=30001002,num=5},{id=30001003,num=5}}
x910020_g_ZhiYeItemBonus1={{id=12010001,num=20},{id=12040001,num=10},{id=12040002,num=10},{id=12040003,num=10},{id=12040004,num=10},{id=12040005,num=10},{id=12040006,num=10},{id=12040007,num=10}}
x910020_g_ZhiYeItemBonus2={{id=12040008,num=10},{id=12040009,num=10},{id=10010001,num=1},{id=10070001,num=1},{id=10200001,num=1},{id=10210001,num=1},{id=10220001,num=1},{id=10230001,num=1}}
x910020_g_ZhiYeItemBonus3={{id=10240001,num=1},{id=10250001,num=1},{id=10260001,num=1},{id=10270001,num=1},{id=10280001,num=1},{id=10290001,num=1},{id=12050001,num=1},{id=10010002,num=1}}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x910020_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
		
	SetCurCamp(sceneId, selfId, 0)
			
end

--**********************************
--列举事件
--**********************************
function x910020_OnEnumerate( sceneId, selfId, targetId )
	AddNumText(sceneId,x910020_g_ScriptId,x910020_g_MissionName);
end

--**********************************
--列举门派
--**********************************
function x910020_OnEnumerateZhiye( sceneId, selfId, targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	AddText(sceneId,"现在有三个职业供你选择。你也可以随时来找我更换职业。")
	for i, eventId in x910020_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--检测接受条件
--**********************************
function x910020_CheckAccept( sceneId, selfId )
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
function x910020_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x910020_g_MissionId, x910020_g_ScriptId, 1, 0, 0 )		--添加任务
	misIndex = GetMissionIndexByID(sceneId,selfId,x910020_g_MissionId)			--得到任务的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)						--根据序列号把任务变量的第0位置0
	SetMissionByIndex(sceneId,selfId,misIndex,1,0)						--根据序列号把任务变量的第1位置0
end

--**********************************
--放弃
--**********************************
function x910020_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x910020_g_MissionId )
end

--**********************************
--继续
--**********************************
function x910020_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x910020_g_MissionName)
		AddText(sceneId,x910020_g_MissionComplete)
		AddMoneyBonus( sceneId, x910020_g_MoneyBonus )
		for i, item in x910020_g_ItemBonus do
			AddItemBonus( sceneId, item.id, item.num )
		end
		for i, item in x910020_g_RadioItemBonus do
			AddRadioItemBonus( sceneId, item.id, item.num )
		end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x910020_g_ScriptId,x910020_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x910020_CheckSubmit( sceneId, selfId )
	misIndex = GetMissionIndexByID(sceneId,selfId,x910020_g_MissionId)
    num = GetMissionParam(sceneId,selfId,misIndex,1)
    if num == x910020_g_DemandKill[1].num then
       return 1
    end
	return 0
end

--**********************************
--提交
--**********************************
function x910020_OnSubmit( sceneId, selfId, targetId,selectRadioId )
	if x910020_CheckSubmit( sceneId, selfId, selectRadioId ) then
    	BeginAddItem(sceneId)
			for i, item in x910020_g_ItemBonus do
				AddItem( sceneId,item.id, item.num )
			end
			for i, item in x910020_g_RadioItemBonus do
				if item.id == selectRadioId then
					AddItem( sceneId,item.id, item.num )
				end
			end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then
			AddMoney(sceneId,selfId,x910020_g_MoneyBonus );
			--扣除任务物品
			--for i, item in g_DemandItem do
			--	DelItem( sceneId, selfId, item.id, item.num )
			--end
			ret = DelMission( sceneId, selfId, x910020_g_MissionId )
			if ret > 0 then
				MissionCom( sceneId,selfId, x910020_g_MissionId )
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
function x910020_OnKillObject( sceneId, selfId, objdataId )

end

--**********************************
--进入区域事件
--**********************************
function x910020_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x910020_OnItemChanged( sceneId, selfId, itemdataId )
end
