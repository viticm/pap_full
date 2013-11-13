--MisDescBegin
--当前脚本的索引号
x920001_g_ScriptId = 920001

--当前任务的MissionID，具体由专人负责分配，9开头的默认为是为测试任务分配的ID
x920001_g_MissionId = 921

--任务归类
x920001_g_MissionKind = 13
x920001_g_MissionLevel = 10

--任务起始npc
x920001_g_NameHead	= "黄药师"

--任务提交npc
x920001_g_NameEnd	= "黄药师"

--任务是否已经完成
x920001_g_IsMissionOkFail = 0		--变量的第0位

x920001_g_DemandKill ={{id=9123,num=1}}

x920001_g_MissionName="每日活动测试"

--任务描述(接任务时，和所有目标完成交任务时)支持多条语句
x920001_g_MissionInfo={"自打神秘的黑衣人在岛上出现过后，岛上发现了很多偷渡上岛的盗贼，我想这一定和黑衣人的出现有关，劳烦大侠帮我去除掉他们，打探黑衣人的下落。"} 

x920001_g_MissionTarget="杀掉1个#aB{72,182,4,桃花岛,盗贼}[盗贼]#aE，完成后回去找#aB{33,180,4,桃花岛,黄药师}[黄药师]#aE"	

x920001_g_ContinueInfo={"还没进展吗？"}

x920001_g_MissionComplete="什么？他们说不认识黑衣人吗？看来我得找人继续打听了，辛苦你了，年轻人。"

x920001_g_MoneyBonus=10000
x920001_g_ItemBonus={{id=12010003,num=1},{id=12020004,num=1}}
x920001_g_RadioItemBonus={{id=12010005,num=1},{id=12020006,num=1}}



--任务限时( 单位:秒 )
--x920001_g_MissionLimitTime  = 0

--任务环数
--x920001_g_MissionRound = 0
--MisDescEnd

--****************************************任务可接条件判断*************************************************************************

--活动限制次数
x920001_g_CanDoCount = 2

--任务可接等级范围
x920001_g_MissionMinLevel = 1
x920001_g_MissionMaxLevel = 100

--前置任务的MissionID,可以填写多个前置任务
x920001_g_MisIdPre = {}

--需要后续任务在该任务结束后直接弹出，则填写下面的参数，否则不填写，只能填写一个后续任务
--ScriptId为后续任务的ScriptId。LV为后续任务的等级要求，要和ScriptId对应脚本里面的等级要求一致
x920001_g_ScriptIdNext = {}

--****************************************任务内容开始*********************************************************************
--总的大体任务目标描述，一句话描述
x920001_g_MissionAim="找到偷渡上岛的盗贼，除掉他们并且打探到黑衣人消息。"		

--任务目标类型(可以多任务目标)
--MONSTER_KILL					--杀怪                        --id为杀怪类型，name为怪物名称,num为对应杀怪数量
x920001_g_MONSTER_KILL = {{id=9123,name="盗贼",num=1,type="MONSTER_KILL",order=0}}

--MONSTER_ITEM					--打怪掉落                    --id为杀怪类型，item为怪物掉落物品类型,name为道具名称，per为掉落概率，max为一次掉落物品的个数上限,num为需求道具个数
x920001_g_MONSTER_ITEM = {}

--********************************任务目标的组合********************************
--*********************一个任务的目标个数最多只能为8个,现在已经超出了,请修正*******************************
--********************任务目标为最小元素,比如杀3种怪,算作3个任务目标计算***********************************

x920001_g_QuestType = {x920001_g_MONSTER_KILL}
x920001_g_Quest = {}
x920001_g_QuestNum = 0
x920001_MP_ISCOMPLETE = 7

--根据类型将任务需求放入x920001_g_Quest队列
function  x920001_g_QuestOrder(QuestType)
	local count = 0
	for i, QuestLabel in pairs(QuestType) do
		for j, QuestInfo in pairs(QuestLabel) do
			count = count + 1
			QuestInfo.order = count
			x920001_g_Quest[count] = QuestInfo
		end
	end
	x920001_g_QuestNum = count
end
	
--任务奖励(exp为经验调节参数，money为金钱调节参数)
--经验奖励
x920001_g_ExpBonustxt = ""
x920001_g_exp = 1

function x920001_g_ExpBonus( sceneId, selfId, exp )
	local LV = GetLevel( sceneId, selfId )
	local ExpBonus = 41
	return ExpBonus*x920001_g_exp
end

--金钱奖励
x920001_g_MoneyBonustxt = 10000
x920001_g_money = 1

function x920001_g_MoneyBonus( sceneId, selfId, money )
	local MoneyBonus=10000
	return MoneyBonus*x920001_g_money
end

--固定物品奖励，最多8种
x920001_g_ItemBonus={{id=12010003,num=1},{id=12020004,num=1}}

--可选物品奖励，最多8种
x920001_g_RadioItemBonus={{id=12010005,num=1},{id=12020006,num=1}}
--**********************************任务入口函数**********************************

function x920001_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本

   --加载任务需求队列
 	 x920001_g_QuestOrder( x920001_g_QuestType )
 	 
 	 --是否做过此任务
   if IsHaveMission( sceneId, selfId, x920001_g_MissionId ) > 0 then
   		
   		local MisIndex = GetMissionIndexByID( sceneId, selfId, x920001_g_MissionId )
   		
		   	 --是交任务NPC，则判断是否完成任务，显示对应提示信息
				 if ( GetName( sceneId, targetId ) == x920001_g_NameEnd ) then	
				
					 local Done = 0
					 
					 --注意------------------------------------------------------------------------------------
					 --如果是限时任务，这里还需判断是否在规定时间内完成，如果不是则此次任务失败，返回未完成提示	
					 ------------------------------------------------------------------------------------------		 
					 
					 Done = x920001_CheckSubmit( sceneId, selfId )
					 
					 --PrintStr( "是否完成" )
					 --PrintNum( Done )				 

					if Done == 1 then			
						BeginEvent(sceneId)		
						x920001_ShowQuestInfo( sceneId, selfId, targetId , 1)		
						DispatchMissionContinueInfo( sceneId, selfId, targetId,x920001_g_ScriptId, x920001_g_MissionId )	
						EndEvent( )
					else
					  BeginEvent(sceneId)
						x920001_ShowQuestInfo( sceneId, selfId, targetId , 2)
				 		DispatchMissionDemandInfo( sceneId, selfId, targetId, x920001_g_ScriptId, x920001_g_MissionId, 0 )
				 		EndEvent( )
					end					 
					 										
		    end	
		    --if ( GetName( sceneId, targetId ) == x920001_g_NameEnd ) then	
    
  --没有接过此任务，直接显示任务信息
  else 

    --检测今日接任务时，是否有之前做已做满的次数，需要重置为0
    x920001_CheckNeedReset( sceneId, selfId )
    
		BeginEvent(sceneId)
			x920001_ShowQuestInfo( sceneId, selfId, targetId ,0 )
		EndEvent()
		DispatchMissionInfo( sceneId, selfId, targetId, x920001_g_ScriptId, x920001_g_MissionId )
		
  end
  --if IsHaveMission( sceneId, selfId, x920001_g_MissionId ) > 0 then
	
end

--检测今日接任务时，是否有之前做已做的次数，需要重置为0
function	x920001_CheckNeedReset( sceneId, selfId )

		local lastDone = GetMissionData( sceneId, selfId, MD_HUODONGCESHI_DATE );			
		local today		 = GetTodayDate();		
		
		if( lastDone ~= today ) then
				    
		  local bTodayCanDo = IsTodayMission( x920001_g_MissionId )
		  
			if( bTodayCanDo == 1 ) then
			
					--重置活动完成次数为0
			  	SetMissionData(  sceneId, selfId, MD_HUODONGCESHU_ROUND, 0 )
			end
			
   end
  
end
--**********************************任务内容显示**********************************
function	x920001_ShowQuestInfo( sceneId, selfId, targetId ,Done )

	--显示任务名称
	AddText( sceneId, "#Y"..x920001_g_MissionName )	
	
	--任务未完成
	if Done == 2 then 
		for i, Info in pairs(x920001_g_ContinueInfo) do
			AddText(sceneId,Info)
		end
	--任务完成
	elseif( Done == 1 ) then
		AddText( sceneId, x920001_g_MissionComplete )
	--接任务时
	elseif( Done == 0 ) then
		for i, Info in pairs(x920001_g_MissionInfo) do
			AddText(sceneId,Info)
		end
	end
	
	--AddText(sceneId,x920001_g_ExpBonustxt)
	if( Done ~= 1 ) then
		AddText(sceneId,"#Y任务目标:")
		AddText(sceneId,x920001_g_MissionAim) --显示任务目标描述文字
		
		--多任务目标的显示
		x920001_ShowQuestAim( sceneId, selfId, targetId,Done )	 --显示任务目标完成情况
	end
	
	AddMoneyBonus( sceneId, x920001_g_MoneyBonustxt )			   --添加金钱奖励
	
	--添加奖励物品
	if x920001_g_ItemBonus ~= nil then
		for i, item in pairs(x920001_g_ItemBonus) do
			AddItemBonus( sceneId, item.id, item.num )
		end
	end		
	
	--添加可选奖励道具
	if x920001_g_RadioItemBonus ~= nil then
		for i, item in pairs(x920001_g_RadioItemBonus) do
			AddRadioItemBonus( sceneId, item.id, item.num )
		end
	end
	
end

function  x920001_CheckAccept( sceneId, selfId, targetId )
 
 if ( GetName( sceneId, targetId ) == x920001_g_NameHead ) then
		--if ( GetLevel( sceneId, selfId ) >= x920001_g_MissionMinLevel ) and (GetLevel( sceneId, selfId ) <= x920001_g_MissionMaxLevel ) then
		if ( MissionCommonCheck( x920001_g_MissionId, sceneId, selfId ) == 1 ) then
			if	x920001_g_MisIdPre == nil then
				return	1
			else
				for i, questpre in pairs(x920001_g_MisIdPre) do
					if IsMissionHaveDone(sceneId,selfId,questpre) == 0 then
						 BeginEvent(sceneId)			
       			--AddText( sceneId, "#Y"..x920001_g_MissionName )
       			AddText( sceneId, "你不满足活动条件。" )       
      			EndEvent()
      			DispatchMissionTips(sceneId,selfId)
						return 0
					end
				end
				return 1
			end		
		else
		  BeginEvent(sceneId)			
       --AddText( sceneId, "#Y"..x920001_g_MissionName )
       AddText( sceneId, "你不满足活动条件。" )       
      EndEvent()
      DispatchMissionTips(sceneId,selfId)
			return 0
		end
	else
		return 0
	end
	
end

--**********************************任务目标显示**********************************

function	x920001_ShowQuestAim( sceneId, selfId, targetId, Done )
 
 x920001_g_QuestOrder(x920001_g_QuestType)
	if x920001_g_Quest ==nil then
		print("该任务没有绑目标!!!")
	else
		local Many = 0
		misIndex = GetMissionIndexByID(sceneId,selfId,x920001_g_MissionId)
		
		--显示每个目标的完成情况
		for i, QuestInfo in pairs(x920001_g_Quest) do

			if QuestInfo.type == "MONSTER_KILL" or QuestInfo.type == "COLLECT_SPECIAL"  or QuestInfo.type == "MONSTER_ITEM" then
				if Done == 1 then
					Many = GetMissionParam(sceneId,selfId,misIndex,QuestInfo.order-1)
					if Many == nil then
						Many = 0
					end
				end
				StrTxt = QuestInfo.name.."    "..Many.."/"..QuestInfo.num
				AddText(sceneId,StrTxt)				
			elseif  (QuestInfo.type == "COLLECT") then
				if Done == 1 then
					Many = LuaFnGetItemCount(sceneId,selfId,QuestInfo.item)
					if Many == nil then
						Many = 0
					elseif Many >  QuestInfo.num then
						Many = QuestInfo.num
					end
				end
				StrTxt = QuestInfo.name.."    "..Many.."/"..QuestInfo.num
				AddText(sceneId,StrTxt)
			elseif  QuestInfo.type == "DELIVERY" or QuestInfo.type == "ENTERAREA" or QuestInfo.type == "PROTECT" then
				if Done == 1 then
					Many = GetMissionParam(sceneId,selfId,misIndex,QuestInfo.order-1)
					if Many == nil then
						Many = 0
					end
				end
				StrTxt = QuestInfo.info.."    "..Many.."/1"
				AddText(sceneId,StrTxt)
			end
			
		end
		--for i, QuestInfo in pairs(x920001_g_Quest) do
	end
	--if x920001_g_Quest ==nil then

end


--**********************************判断任务是否显示**********************************
function x920001_OnEnumerate( sceneId, selfId, targetId )

		AddNumText( sceneId, x920001_g_ScriptId, x920001_g_MissionName );
		
end

--**********************************接受任务**********************************
function x920001_OnAccept( sceneId, selfId )		

  --判断是否是活动时间
  if( IsMissionInTime( x920001_g_MissionId ) == 1 ) then  

 		if( x920001_CheckAccept( sceneId, selfId, targetId ) == 1 ) then
    	 
  	 local nMisValue = GetMissionData( sceneId, selfId, MD_HUODONGCESHU_ROUND )
  	 
     if( nMisValue == x920001_g_CanDoCount ) then --如果次数已做满
        BeginEvent(sceneId)			
       	--AddText( sceneId, "#Y"..x920001_g_MissionName )
       	AddText( sceneId, "今日活动次数已做完。" )       
     		EndEvent()
     		DispatchMissionTips(sceneId,selfId)
     		return
     end      
     
    end
		
	else
		 BeginEvent(sceneId)			
       --AddText( sceneId, "#Y"..x920001_g_MissionName  )
       AddText( sceneId, "别着急哈，活动时间还没到。" )       
     EndEvent()
     DispatchMissionTips(sceneId,selfId)
     return
	end
	
			
	--加载任务需求队列
	x920001_g_QuestOrder( x920001_g_QuestType )
	
	--获取已接任务个数
	if GetMissionCount( sceneId, selfId ) >= 20 then
		Msg2Player(  sceneId, selfId, "#Y你的任务日志已经满了", MSG2PLAYER_PARA )
		BeginEvent(sceneId)
			strText = "#Y你的任务日志已经满了"
			AddText( sceneId, strText );
		EndEvent(sceneId)
		DispatchMissionTips( sceneId, selfId )
		return
	end
	
	local DoKill, DoArea, DoItem = 0, 0, 0
	for i, QuestInfo in pairs(x920001_g_Quest) do
		if QuestInfo.type == "MONSTER_KILL" then
			DoKill = 1
		elseif (QuestInfo.type == "DELIVERY") then
			DoItem = 1	
			local ret = 1
						
			BeginAddItem(sceneId)
			if QuestInfo.item > 0 and QuestInfo.num > 0 then
				AddItem( sceneId,QuestInfo.item, QuestInfo.num )
			end
			local ret = EndAddItem(sceneId,selfId)
			
			if ret > 0 then
					AddItemListToHuman(sceneId,selfId)
			else
				BeginEvent(sceneId)
					strText = "背包已满,无法获得任务物品"
					AddText(sceneId,strText);
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				return
			end
		elseif QuestInfo.type == "MONSTER_ITEM"	then			--打怪掉落
		 DoKill = 1
		 DoItem = 1
		end
	end		
	
	--第5个参数表示是否回调OnKillObject	第6个参数表示是否回调OnEnterArea	第7个参数表示是否回调OnItemChange		
	
	AddMission( sceneId,selfId, x920001_g_MissionId, x920001_g_ScriptId, DoKill, DoArea, DoItem )		
	
	--得到任务的序列号
	local misIndex = GetMissionIndexByID( sceneId, selfId, x920001_g_MissionId )			
	
	--根据序列号把任务变量置0
	for j=1, x920001_g_QuestNum do
		SetMissionByIndex( sceneId, selfId, misIndex, j-1, 0 )	
	end
		
	BeginEvent(sceneId)
	  	strText = "你接受了任务  "..x920001_g_MissionName
	  	AddText(sceneId,strText);
	EndEvent(sceneId)
	DispatchMissionTips( sceneId, selfId )
	
	
end

--**********************************
--放弃
--**********************************
function x920001_OnAbandon( sceneId, selfId )

	 --删除玩家任务列表中对应的任务
   DelMission( sceneId, selfId, x920001_g_MissionId )
	
end

--**********************************
--检测是否可以提交
--**********************************
function x920001_CheckSubmit( sceneId, selfId )	
		
	local bDone = 1
		
	x920001_g_QuestOrder( x920001_g_QuestType )
	
	local misIndex = GetMissionIndexByID( sceneId, selfId, x920001_g_MissionId )	

	--检查每一个任务需求是否都已完成
	for i, QuestInfo in pairs(x920001_g_Quest) do		
		--local Many = GetMissionParam( sceneId, selfId, misIndex, QuestInfo.order-1 )
		local Many = GetMissionParam( sceneId, selfId, misIndex, 1 )
		
		if QuestInfo.num == nil then
			QuestInfo.num = 1
		end

		if	Many < QuestInfo.num then
			bDone = 0
			break
		end		
			
	end
	
	if bDone == 1 then
		return 1
	end
	
	return 0
	
end

--**********************************
--提交
--**********************************
function x920001_OnSubmit( sceneId, selfId, targetId, selectRadioId )

	x920001_g_QuestOrder( x920001_g_QuestType )
	
	--如果任务需求都已完成
	if ( x920001_CheckSubmit( sceneId, selfId ) == 1 ) then
		local givebonus = 0
		local giveitem  = 0
		
		BeginAddItem(sceneId)
		
		--判读背包是否有空间放奖励物品
		if ( getn( x920001_g_ItemBonus ) == 0 ) and ( getn( x920001_g_RadioItemBonus ) == 0 ) then
			givebonus = 1
		else
			for i, item in pairs(x920001_g_ItemBonus) do
				if item.id > 0 and item.num > 0 then
					AddItem( sceneId,item.id, item.num )
					giveitem = 1
				end
			end
			
			for i, item in pairs(x920001_g_RadioItemBonus) do
				if item.id == selectRadioId and item.num > 0 and item.id > 0 then
					AddItem( sceneId,item.id, item.num )
					giveitem = 1
				end
			end
			
			if giveitem == 1 then
				giveitem = EndAddItem( sceneId, selfId )
			end
			
		end		
			
		--任务奖励没有加成功	
		if ( giveitem <= 0 ) and ( givebonus == 0 ) then
	
			BeginEvent(sceneId)
				strText = "物品栏已满，请整理下再来！"
				AddText( sceneId, strText );
			EndEvent(sceneId)
			DispatchMissionTips( sceneId, selfId )
			
		else
		 
		  local nMisIndex = GetMissionIndexByID( sceneId, selfId, x920001_g_MissionId )
		  
		  --记录本次完成日期(用于判断本日次数已满) 
		  SetTimeParam( MD_HUODONGCESHI_DATE, sceneId, selfId )		  
		  
		  --活动完成次数 + 1
		  local nMisValue = GetMissionData( sceneId, selfId, MD_HUODONGCESHU_ROUND )
		  SetMissionData( sceneId, selfId, MD_HUODONGCESHU_ROUND, nMisValue+1 )
		  
			DelMission( sceneId, selfId, x920001_g_MissionId )	
			
			--奖励经验值
			if ( x920001_g_ExpBonustxt ~= nil )  then
				LuaFnAddExp( sceneId, selfId,x920001_g_ExpBonus( sceneId, selfId, x920001_g_exp ))
			end			
			
			--奖励金钱		
			if ( x920001_g_MoneyBonustxt ~= nil ) then
				AddMoney( sceneId, selfId, x920001_g_MoneyBonus( sceneId, selfId, x920001_g_money ));
			end
			
			--背包有空间放奖励物品
			if giveitem == 1 then
				AddItemListToHuman( sceneId, selfId )
			end
			
			BeginEvent(sceneId)
			  	strText = "你完成了任务  "..x920001_g_MissionName
			  	AddText( sceneId, strText );
			EndEvent(sceneId)				
			DispatchMissionTips( sceneId, selfId )
				
		end
		--if ( giveitem == 0 ) and ( givebonus == 0 ) then		
		
	end
	--if ( x920001_CheckSubmit( sceneId, selfId ) == 1 ) then
		
end

--**********************************--杀死怪物或玩家--**********************************
function x920001_OnKillObject( sceneId, selfId, objdataId )

x920001_g_QuestOrder( x920001_g_QuestType )
	
	local QuestPlace = 0	--子任务对应在之前SetMissionByIndex(sceneId,selfId,misIndex,j-1,0)时存在的位置,==j-1
	
	for i, QuestInfo in pairs(x920001_g_Quest) do
	
		--屏幕中间提示杀死几个怪，并改变任务数据
		if QuestInfo.type ==  "MONSTER_KILL" then	
		
				if objdataId == QuestInfo.id then
	 		
				  local misIndex = GetMissionIndexByID( sceneId, selfId, x920001_g_MissionId )
				  --num = GetMissionParam( sceneId, selfId, misIndex, QuestInfo.order - 1 )
				  num = GetMissionParam( sceneId, selfId, misIndex, 1 )
				  
				  if num < QuestInfo.num then		
				  	--注意，原来杀死的怪物数放在序号1，在此修正为该类型的order				
				    --SetMissionByIndex( sceneId, selfId, misIndex, QuestInfo.order - 1, num + 1 )
				    SetMissionByIndex( sceneId, selfId, misIndex, 1, num + 1 )
			
				  	BeginEvent(sceneId)
							--strText = format("已杀死  "..QuestInfo.name.."  %d/"..QuestInfo.num, GetMissionParam( sceneId, selfId, misIndex, QuestInfo.order - 1 ) )
					  	strText = format("已杀死  "..QuestInfo.name.."  %d/"..QuestInfo.num, GetMissionParam( sceneId, selfId, misIndex, 1 ))
					  	AddText(sceneId,strText);
				  	EndEvent(sceneId)
					  DispatchMissionTips(sceneId,selfId)
					  
					  if ( num + 1 ) == QuestInfo.num then
						 SetMissionByIndex( sceneId, selfId, misIndex, x920001_MP_ISCOMPLETE, 1 )
					  end
				  end
				  
			 end
		   --if objdataId == QuestInfo.id then
		   
		end
		--if QuestInfo.type ==  "MONSTER_KILL" then	
		
	end
	--for i, QuestInfo in pairs(x920001_g_Quest) do
	
end
--**********************************--道具改变--**********************************
function x920001_OnItemChanged( sceneId, selfId, itemdataId )

	x920001_g_QuestOrder( x920001_g_QuestType )
	
	local misIndex = GetMissionIndexByID( sceneId, selfId, x920001_g_MissionId )
	
	for i, QuestInfo in pairs(x920001_g_Quest) do
	
		if QuestInfo.type == "COLLECT_SPECIAL" or QuestInfo.type == "COLLECT" or QuestInfo.type == "MONSTER_ITEM" then
		
			if ( QuestInfo.item == itemdataId ) then
				local questitemnum = LuaFnGetItemCount( sceneId, selfId, QuestInfo.item )
				
				if ( questitemnum >= 0 ) and ( questitemnum <= QuestInfo.num )then
					SetMissionByIndex( sceneId, selfId, misIndex, QuestInfo.order-1, questitemnum )
					BeginEvent(sceneId)
						strText = format( "已获得  "..QuestInfo.name.."  %d/"..QuestInfo.num, questitemnum )
					 	AddText( sceneId, strText );
				 	EndEvent(sceneId)
					DispatchMissionTips( sceneId, selfId )
				end
				
			end
			--if ( QuestInfo.item == itemdataId ) then
		end
		--if QuestInfo.type == "COLLECT_SPECIAL" or QuestInfo.type == "COLLECT" or ...
	end
	--for i, QuestInfo in pairs(x920001_g_Quest) do
	
end
