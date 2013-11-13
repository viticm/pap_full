--收集任务
--金国士兵的腰牌符
--MisDescBegin
--脚本号
x910006_g_ScriptId = 910006

--上一个任务的ID
--g_MissionIdPre =

--任务号
x910006_g_MissionId = 906

--任务目标npc
x910006_g_Name	="札木合" 

--任务归类
x910006_g_MissionKind = 1

--任务等级
x910006_g_MissionLevel = 2

--是否是精英任务
x910006_g_IfMissionElite = 0

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************
--任务是否已经完成
x910006_g_IsMissionOkFail = 0		--变量的第0位

--任务需要收集的物品
x910006_g_DemandItem ={{id=30007005,num=1}}		--变量第1位

--以上是动态**************************************************************

--任务文本描述
x910006_g_MissionName="收集蒙古铠甲碎片"
x910006_g_MissionInfo="Boss1身上有蒙古铠甲碎片，拿来我可以给你换件好的衣服！"  --任务描述
x910006_g_MissionTarget="拿来蒙古铠甲碎片"		--任务目标
x910006_g_ContinueInfo="你有蒙古铠甲碎片吗？"		--未完成任务的npc对话
x910006_g_MissionComplete="给你这件衣服！"					--完成任务npc说话的话

--任务奖励
x910006_g_MoneyBonus=0
x910006_g_ItemBonus={}
x910006_g_RadioItemBonus={{id=10413006,num=1},{id=10413016,num=1},{id=10413026,num=1}}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x910006_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	--如果玩家完成过这个任务（实际上如果完成了任务这里就不会显示，但是再检测一次比较安全）
    --if IsMissionHaveDone(sceneId,selfId,x910006_g_MissionId) > 0 then
	--	return
	--end
	--如果已接此任务
	if IsHaveMission(sceneId,selfId,x910006_g_MissionId) > 0 then
		--发送任务需求的信息
		BeginEvent(sceneId)
			AddText(sceneId,x910006_g_MissionName)
			AddText(sceneId,x910006_g_ContinueInfo)
			for i, item in pairs(x910006_g_DemandItem) do
				AddItemDemand( sceneId, item.id, item.num )
			end
		EndEvent( )
		bDone = x910006_CheckSubmit( sceneId, selfId )
		DispatchMissionDemandInfo(sceneId,selfId,targetId,x910006_g_ScriptId,x910006_g_MissionId,bDone)
	--满足任务接收条件
	elseif x910006_CheckAccept(sceneId,selfId) > 0 then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x910006_g_MissionName)
			AddText(sceneId,x910006_g_MissionInfo)
			AddText(sceneId,"#{M_MUBIAO}")
			AddText(sceneId,x910006_g_MissionTarget)
			--AddMoneyBonus( sceneId, x910006_g_MoneyBonus )
			for i, item in pairs(x910006_g_ItemBonus) do
				AddItemBonus( sceneId, item.id, item.num )
			end
			for i, item in pairs(x910006_g_RadioItemBonus) do
				AddRadioItemBonus( sceneId, item.id, item.num )
			end
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x910006_g_ScriptId,x910006_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x910006_OnEnumerate( sceneId, selfId, targetId )

    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x910006_g_MissionId) > 0 then
    	return 
	end
    --如果已接此任务
    --else
    if IsHaveMission(sceneId,selfId,x910006_g_MissionId) > 0 then
		AddNumText(sceneId,x910006_g_ScriptId,x910006_g_MissionName);
    --满足任务接收条件
    elseif x910006_CheckAccept(sceneId,selfId) > 0 then
		AddNumText(sceneId,x910006_g_ScriptId,x910006_g_MissionName);
    end
end

--**********************************
--检测接受条件
--**********************************
function x910006_CheckAccept( sceneId, selfId )
	--需要2级才能接
	if GetLevel( sceneId, selfId ) >= 5 then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x910006_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x910006_g_MissionId, x910006_g_ScriptId, 1, 0, 0 )		--添加任务
	misIndex = GetMissionIndexByID(sceneId,selfId,x910006_g_MissionId)			--得到任务的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)						--根据序列号把任务变量的第0位置0
	SetMissionByIndex(sceneId,selfId,misIndex,1,0)						--根据序列号把任务变量的第1位置0
end

--**********************************
--放弃
--**********************************
function x910006_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x910006_g_MissionId )
end

--**********************************
--继续
--**********************************
function x910006_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x910006_g_MissionName)
		AddText(sceneId,x910006_g_MissionComplete)
		--AddMoneyBonus( sceneId, x910006_g_MoneyBonus )
		for i, item in pairs(x910006_g_ItemBonus) do
			AddItemBonus( sceneId, item.id, item.num )
		end
		for i, item in pairs(x910006_g_RadioItemBonus) do
			AddRadioItemBonus( sceneId, item.id, item.num )
		end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x910006_g_ScriptId,x910006_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x910006_CheckSubmit( sceneId, selfId )
	for i, item in pairs(x910006_g_DemandItem) do
		itemCount = GetItemCount(sceneId,selfId,item.id)
		if itemCount < item.num then
			return 0
		end
	end
	return 1	

	--misIndex = GetMissionIndexByID(sceneId,selfId,x910006_g_MissionId)
    --num = GetMissionParam(sceneId,selfId,misIndex,1)
    --if num == x910006_g_DemandKill[1].num then
    --   return 1
    --end
	--return 0
end

--**********************************
--提交
--**********************************
function x910006_OnSubmit( sceneId, selfId, targetId,selectRadioId )
	if x910006_CheckSubmit( sceneId, selfId, selectRadioId ) then
    	BeginAddItem(sceneId)
			for i, item in pairs(x910006_g_ItemBonus) do
				AddItem( sceneId,item.id, item.num )
			end
			for i, item in pairs(x910006_g_RadioItemBonus) do
				if item.id == selectRadioId then
					AddItem( sceneId,item.id, item.num )
				end
			end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then
		--	AddMoney(sceneId,selfId,x910006_g_MoneyBonus );
			--扣除任务物品
			for i, item in pairs(x910006_g_DemandItem) do
				DelItem( sceneId, selfId, item.id, item.num )
			end
			ret = DelMission( sceneId, selfId, x910006_g_MissionId )
			if ret > 0 then
				MissionCom( sceneId,selfId, x910006_g_MissionId )
				AddItemListToHuman(sceneId,selfId)
				LuaFnAddExp( sceneId, selfId,200)
			end
		else
		--任务奖励没有加成功
			BeginEvent(sceneId)
				strText = "物品栏已满，请整理下再来！"
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		end      
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x910006_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x910006_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x910006_OnItemChanged( sceneId, selfId, itemdataId )
end
