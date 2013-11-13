--送信任务

--铁木真2哲别

--MisDescBegin

--脚本号

x910010_g_ScriptId = 910010



--上一个任务的ID

--g_MissionIdPre =



--任务号

x910010_g_MissionId = 910



--任务目标npc

x910010_g_Name	="铁木真" 



--任务归类

x910010_g_MissionKind = 1



--任务等级

x910010_g_MissionLevel = 1



--是否是精英任务

x910010_g_IfMissionElite = 0



--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************

--任务是否已经完成

x910010_g_IsMissionOkFail = 0		--变量的第0位



--任务需要杀死的怪

--x910010_g_DemandKill ={{id=500,num=5}}		--变量第1位



--以上是动态**************************************************************



--任务文本描述

x910010_g_MissionName="长生天的旨意"

x910010_g_MissionInfo="去告诉前线的哲别，这场战役，我要让凤翔守军知道我蒙古勇士的热血。叫哲别先在原地等我下一命令，这之前不许进击。"  --任务描述

x910010_g_MissionTarget="把铁木真的命令告诉凤翔野外的哲别"		--任务目标

x910010_g_ContinueInfo="快把命令告诉哲别去，别在这里磨蹭了，否则长生天会降罪与你！"		--未完成任务和铁木真的npc对话

x910010_g_TargetContinueInfo="我真想上前线去杀敌啊，我的弓在隐隐发出鸣叫，催我战斗啊！"		--和哲别的对话

x910010_g_MissionComplete="既然原来铁木真是这么想的，那我就在原地待命就是了！谢谢你带来大汗的口信，这张符就送给你吧！"					--完成任务时这边说话的话



--任务奖励

--x910010_g_MoneyBonus=100

x910010_g_ItemBonus={{id=30501003,num=1}}

--x910010_g_RadioItemBonus={}



--MisDescEnd

--**********************************

--任务入口函数

--**********************************

function x910010_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本

	--如果玩家完成过这个任务（实际上如果完成了任务这里就不会显示，但是再检测一次比较安全）

    --if IsMissionHaveDone(sceneId,selfId,x910010_g_MissionId) > 0 then

	--	return

	--end

	--如果已接此任务

	if IsHaveMission(sceneId,selfId,x910010_g_MissionId) > 0 then

		--发送任务需求的信息

		BeginEvent(sceneId)

			AddText(sceneId,x910010_g_MissionName)
			if (GetName(sceneId,targetId)==x910010_g_Name) then
				AddText(sceneId,x910010_g_ContinueInfo)
			else
				AddText(sceneId,x910010_g_TargetContinueInfo)
			end
			--for i, item in pairs(g_DemandItem) do

			--	AddItemDemand( sceneId, item.id, item.num )

			--end

		EndEvent( )

		bDone = CallScriptFunction( 900003, "SongxinCheck",sceneId, selfId, targetId )

		DispatchMissionDemandInfo(sceneId,selfId,targetId,x910010_g_ScriptId,x910010_g_MissionId,bDone)

	--满足任务接收条件

	elseif x910010_CheckAccept(sceneId,selfId) > 0 then

		--发送任务接受时显示的信息

		BeginEvent(sceneId)

			AddText(sceneId,x910010_g_MissionName)

			AddText(sceneId,x910010_g_MissionInfo)

			AddText(sceneId,"#{M_MUBIAO}")

			AddText(sceneId,x910010_g_MissionTarget)

			--AddMoneyBonus( sceneId, x910010_g_MoneyBonus )

			for i, item in pairs(x910010_g_ItemBonus) do

				AddItemBonus( sceneId, item.id, item.num )

			end

			--for i, item in pairs(x910010_g_RadioItemBonus) do

				--AddRadioItemBonus( sceneId, item.id, item.num )

			--end

		EndEvent( )

		DispatchMissionInfo(sceneId,selfId,targetId,x910010_g_ScriptId,x910010_g_MissionId)

	end

end



--**********************************

--列举事件

--**********************************

function x910010_OnEnumerate( sceneId, selfId, targetId )
	    --如果玩家完成过这个任务
	    if IsMissionHaveDone(sceneId,selfId,x910010_g_MissionId) > 0 then
	    	return 
		end
	    --如果已接此任务
	    --else
	    if IsHaveMission(sceneId,selfId,x910010_g_MissionId) > 0 then
			
				AddNumText(sceneId,x910010_g_ScriptId,x910010_g_MissionName);
	
	    --满足任务接收条件
	
	    elseif x910010_CheckAccept(sceneId,selfId,targetId) > 0 then
	
			AddNumText(sceneId,x910010_g_ScriptId,x910010_g_MissionName);
	
	    end
end



--**********************************

--检测接受条件

--**********************************

function x910010_CheckAccept( sceneId, selfId,targetId )

	--需要1级才能接

	if GetLevel( sceneId, selfId ) >= 1 then
		if (GetName(sceneId,targetId)==x910010_g_Name) then
			return 1
		else
			return 0
		end
	else

		return 0

	end

end



--**********************************

--接受

--**********************************

function x910010_OnAccept( sceneId, selfId )

	--加入任务到玩家列表

	AddMission( sceneId,selfId, x910010_g_MissionId, x910010_g_ScriptId, 1, 0, 0 )		--添加任务

	misIndex = GetMissionIndexByID(sceneId,selfId,x910010_g_MissionId)			--得到任务的序列号

	SetMissionByIndex(sceneId,selfId,misIndex,0,0)						--根据序列号把任务变量的第0位置0

	SetMissionByIndex(sceneId,selfId,misIndex,1,0)						--根据序列号把任务变量的第1位置0

end



--**********************************

--放弃

--**********************************

function x910010_OnAbandon( sceneId, selfId )

	--删除玩家任务列表中对应的任务

    DelMission( sceneId, selfId, x910010_g_MissionId )

end



--**********************************

--继续

--**********************************

function x910010_OnContinue( sceneId, selfId, targetId )

	--提交任务时的说明信息

    BeginEvent(sceneId)

		AddText(sceneId,x910010_g_MissionName)

		AddText(sceneId,x910010_g_MissionComplete)

		--AddMoneyBonus( sceneId, x910010_g_MoneyBonus )

		for i, item in pairs(x910010_g_ItemBonus) do

			AddItemBonus( sceneId, item.id, item.num )

		end

		--for i, item in pairs(x910010_g_RadioItemBonus) do

			--AddRadioItemBonus( sceneId, item.id, item.num )

		--end

    EndEvent( )

    DispatchMissionContinueInfo(sceneId,selfId,targetId,x910010_g_ScriptId,x910010_g_MissionId)

end



--**********************************

--检测是否可以提交

--**********************************

function x910010_CheckSubmit( sceneId, selfId, targetId)
	CallScriptFunction( 900003, "SongxinCheck",sceneId, selfId, targetId )
end



--**********************************

--提交

--**********************************

function x910010_OnSubmit( sceneId, selfId, targetId,selectRadioId )

	if CallScriptFunction( 900003, "SongxinCheck",sceneId, selfId, targetId )==1 then

    	BeginAddItem(sceneId)

			for i, item in pairs(x910010_g_ItemBonus) do

				AddItem( sceneId,item.id, item.num )

			end

			--for i, item in pairs(x910010_g_RadioItemBonus) do

				--if item.id == selectRadioId then

					--AddItem( sceneId,item.id, item.num )

				--end

			--end

		ret = EndAddItem(sceneId,selfId)

		--添加任务奖励

		if ret > 0 then

			--AddMoney(sceneId,selfId,x910010_g_MoneyBonus );

			--扣除任务物品

			--for i, item in pairs(g_DemandItem) do

			--	DelItem( sceneId, selfId, item.id, item.num )

			--end

			ret = DelMission( sceneId, selfId, x910010_g_MissionId )

			if ret > 0 then

				MissionCom( sceneId,selfId, x910010_g_MissionId )

				AddItemListToHuman(sceneId,selfId)
				LuaFnAddExp( sceneId, selfId,10)

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

function x910010_OnKillObject( sceneId, selfId, objdataId )

end



--**********************************

--进入区域事件

--**********************************

function x910010_OnEnterArea( sceneId, selfId, zoneId )

end



--**********************************

--道具改变

--**********************************

function x910010_OnItemChanged( sceneId, selfId, itemdataId )

end

