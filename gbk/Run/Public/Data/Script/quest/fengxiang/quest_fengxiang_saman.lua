--杀怪任务
--金国士兵
--MisDescBegin
--脚本号
x910013_g_ScriptId = 910013

--以上是动态**************************************************************

--任务文本描述
x910013_g_MissionName="80级荣誉装"


x910013_g_ZhiYeItemBonus1={{id=10014001,num=1},{id=10074001,num=1},{id=10204001,num=1},{id=10214001,num=1},{id=10224001,num=1},{id=10234001,num=1}}
x910013_g_ZhiYeItemBonus2={{id=10244001,num=1},{id=10254001,num=1},{id=10264001,num=1},{id=10274001,num=1},{id=10284001,num=1},{id=10294001,num=1}}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x910013_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	BeginEvent(sceneId)
			local zhiye = LuaFnGetMenPai(sceneId, selfId)
			
			--LuaFnJoinMenpai(sceneId, selfId, targetId, 3)
			local ret
			BeginAddItem(sceneId)
				for i, item in x910013_g_ZhiYeItemBonus1 do
					if i < 3 then
						AddItem( sceneId,item.id+10000*zhiye-1000+1, item.num )
					else
						AddItem( sceneId,item.id+10*zhiye-1000+1, item.num )
					end
				end			
			ret = EndAddItem(sceneId,selfId)
			if ret > 0 then
				AddItemListToHuman(sceneId,selfId)
				BeginAddItem(sceneId)
					for i, item in x910013_g_ZhiYeItemBonus2 do
						AddItem( sceneId,item.id+10*zhiye-1000+1, item.num )
					end
				ret = EndAddItem(sceneId,selfId)
				--添加职业物品
				if ret > 0 then
					AddItemListToHuman(sceneId,selfId)
					BeginEvent(sceneId)
						strText = "你获得了一套80级荣誉装"
						AddText(sceneId,strText);
					EndEvent(sceneId)
					DispatchMissionTips(sceneId,selfId)	
					AddText(sceneId,"这是80级荣誉装，你收好了！")
				else
				--职业物品没有加成功
					BeginEvent(sceneId)
						strText = "背包空间不足，无法获得全部物品。"
						AddText(sceneId,strText);
					EndEvent(sceneId)
					DispatchMissionTips(sceneId,selfId)
					AddText(sceneId,"这是一部分80级荣誉装！")
				end	
			else
				BeginEvent(sceneId)
					strText = "背包空间不足，无法获得物品。"
					AddText(sceneId,strText);
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				AddText(sceneId,"你整理下背包再来找我领取套装吧！")
			end							
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--列举事件
--**********************************
function x910013_OnEnumerate( sceneId, selfId, targetId )
	AddNumText(sceneId,x910013_g_ScriptId,x910013_g_MissionName);
end



--**********************************
--接受
--**********************************
function x910013_OnAccept( sceneId, selfId )
end

--**********************************
--放弃
--**********************************
function x910013_OnAbandon( sceneId, selfId )

end

--**********************************
--继续
--**********************************
function x910013_OnContinue( sceneId, selfId, targetId )

end

--**********************************
--检测是否可以提交
--**********************************
function x910013_CheckSubmit( sceneId, selfId )

end

--**********************************
--提交
--**********************************
function x910013_OnSubmit( sceneId, selfId, targetId,selectRadioId )

end

--**********************************
--杀死怪物或玩家
--**********************************
function x910013_OnKillObject( sceneId, selfId, objdataId )

end

--**********************************
--进入区域事件
--**********************************
function x910013_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x910013_OnItemChanged( sceneId, selfId, itemdataId )
end
