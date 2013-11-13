--杀怪任务
--日本士兵
--MisDescBegin
--脚本号
x910000_g_ScriptId = 910000

--上一个任务的ID
--g_MissionIdPre =

--任务号,9开头的是为测试任务分配的ID
x910000_g_MissionId = 900

--任务目标npc
x910000_g_Name	="速不台" 

--任务归类
x910000_g_MissionKind = 1

--任务等级
x910000_g_MissionLevel = 1

--是否是精英任务
x910000_g_IfMissionElite = 0

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************
--任务是否已经完成
x910000_g_IsMissionOkFail = 0		--变量的第0位

--任务需要杀死的怪
x910000_g_DemandKill ={{id=1000,num=10}}		--变量第1位

--以上是动态**************************************************************

--任务文本描述
x910000_g_MissionName="消灭日本兵"
x910000_g_MissionInfo="这次凤翔之战，不知道从哪冒出来一些日本兵，真是奇怪。想我大蒙古国的勇士，怎会怕这些倭人！接军令，前去消灭10个日本兵，扬我国威。"  --任务描述
x910000_g_MissionTarget="杀死10个日本兵"		--任务目标
x910000_g_ContinueInfo="你已经杀了10个日本兵了吗？可不能让这些倭人小瞧了我蒙古勇士。"		--未完成任务的npc对话
x910000_g_MissionComplete="区区弹丸之地的小日本，我蒙古国不把它放在眼里！你是好样的，这些东西你收着。"					--完成任务npc说话的话

--任务奖励
--x910000_g_MoneyBonus=100
--x910000_g_ItemBonus={{id=30001001,num=5}}
x910000_g_RadioItemBonus={{id=30001001,num=5},{id=30002001,num=5}}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x910000_OnDefaultEvent( sceneId, actId, param1, param2, param3, param4, param5)	--点击该任务后执行此脚本
	
	
	
	
	local Day = GetDayTime()
	local Time = LuaFnGetCurrentTime()
	StartupSystemTimer( sceneId, actId )
	if actId==1 then
	else
		SetSystemTimerTick( sceneId,910000,"OnTimer",actId, 3000 )	
	end	
end

function x910000_OnTimer( sceneId, actId, uTime )
	local Day = GetDayTime()
	local Time = LuaFnGetCurrentTime()
end





--**********************************
--列举事件
--**********************************
function x910000_OnEnumerate( sceneId, selfId, targetId )

    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x910000_g_MissionId) > 0 then
    	return 
	end
    --如果已接此任务
    --else
    if IsHaveMission(sceneId,selfId,x910000_g_MissionId) > 0 then
		AddNumText(sceneId,x910000_g_ScriptId,x910000_g_MissionName);
    --满足任务接收条件
    elseif x910000_CheckAccept(sceneId,selfId) > 0 then
		AddNumText(sceneId,x910000_g_ScriptId,x910000_g_MissionName);
    end
end

--**********************************
--检测接受条件
--**********************************
function x910000_CheckAccept( sceneId, selfId )
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
function x910000_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x910000_g_MissionId, x910000_g_ScriptId, 1, 0, 0 )		--添加任务
	misIndex = GetMissionIndexByID(sceneId,selfId,x910000_g_MissionId)			--得到任务的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)						--根据序列号把任务变量的第0位置0
	SetMissionByIndex(sceneId,selfId,misIndex,1,0)						--根据序列号把任务变量的第1位置0
end

--**********************************
--放弃
--**********************************
function x910000_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x910000_g_MissionId )
end

--**********************************
--继续
--**********************************
function x910000_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x910000_g_MissionName)
		AddText(sceneId,x910000_g_MissionComplete)
		--AddMoneyBonus( sceneId, x910000_g_MoneyBonus )
		--for i, item in pairs(x910000_g_ItemBonus) do
		--	AddItemBonus( sceneId, item.id, item.num )
		--end
		for i, item in pairs(x910000_g_RadioItemBonus) do
			AddRadioItemBonus( sceneId, item.id, item.num )
		end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x910000_g_ScriptId,x910000_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x910000_CheckSubmit( sceneId, selfId )
	misIndex = GetMissionIndexByID(sceneId,selfId,x910000_g_MissionId)
    num = GetMissionParam(sceneId,selfId,misIndex,1)
    if num == x910000_g_DemandKill[1].num then
       return 1
    end
	return 0
end

--**********************************
--提交
--**********************************
function x910000_OnSubmit( sceneId, selfId, targetId,selectRadioId )
	if x910000_CheckSubmit( sceneId, selfId, selectRadioId ) then
    	BeginAddItem(sceneId)
			--for i, item in pairs(x910000_g_ItemBonus) do
			--	AddItem( sceneId,item.id, item.num )
			--end
			for i, item in pairs(x910000_g_RadioItemBonus) do
				if item.id == selectRadioId then
					AddItem( sceneId,item.id, item.num )
				end
			end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then
			--AddMoney(sceneId,selfId,x910000_g_MoneyBonus );
			--扣除任务物品
			--for i, item in pairs(g_DemandItem) do
			--	DelItem( sceneId, selfId, item.id, item.num )
			--end
			ret = DelMission( sceneId, selfId, x910000_g_MissionId )
			if ret > 0 then
				MissionCom( sceneId,selfId, x910000_g_MissionId )
				AddItemListToHuman(sceneId,selfId)
				LuaFnAddExp( sceneId, selfId,25)
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
function x910000_OnKillObject( sceneId, selfId, objdataId )

 if objdataId == x910000_g_DemandKill[1].id then
	  misIndex = GetMissionIndexByID(sceneId,selfId,x910000_g_MissionId)
	  num = GetMissionParam(sceneId,selfId,misIndex,1)
	  if num < x910000_g_DemandKill[1].num then
		--把任务完成标志设置为1
		if num == x910000_g_DemandKill[1].num - 1 then
			SetMissionByIndex(sceneId,selfId,misIndex,0,1)
		end
		--设置打怪数量+1
	    SetMissionByIndex(sceneId,selfId,misIndex,1,num+1)
	  	BeginEvent(sceneId)
	  	strText = format("已杀死日本兵%d/10", GetMissionParam(sceneId,selfId,misIndex,1) )
	  	AddText(sceneId,strText);
	  	EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	  end
 end
 
end

--**********************************
--进入区域事件
--**********************************
function x910000_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x910000_OnItemChanged( sceneId, selfId, itemdataId )
end
