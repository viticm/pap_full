
--脚本邮件的脚本文件

--脚本号
x888889_g_scriptId = 888889


function x888889_ExecuteMail( sceneId, selfId, param0, param1, param2, param3 )
	
	if param0 == MAIL_REPUDIATE then
		x888889_Mail_Repudiate( sceneId, selfId, param0, param1, param2, param3 )
	elseif param0 == MAIL_BETRAYMASTER then
		x888889_Mail_BetrayMaster( sceneId, selfId, param0, param1, param2, param3 )
	elseif param0 == MAIL_EXPELPRENTICE then
		x888889_Mail_ExpelPrentice( sceneId, selfId, param0, param1, param2, param3 )
	elseif param0 == MAIL_UPDATE_ATTR then
		LuaFnUpdateAttr(sceneId, selfId, param0, param1, param2, param3)
	elseif param0 == MAIL_UNSWEAR then
		x888889_Mail_Unswear(sceneId, selfId, param0, param1, param2, param3)
	elseif param0 == MAIL_PRENTICE_EXP then
		x888889_Mail_PrenticeProfExp(sceneId, selfId, param0, param1, param2, param3)
	elseif param0 == MAIL_COMMISIONSHOP then
		x888889_Mail_CommisionShop( sceneId, selfId, param0, param1, param2, param3 )
	elseif param0 == MAIL_HUASHANJIANGLI then
		x888889_Mail_HuaShanJiangLi( sceneId, selfId, param0, param1, param2, param3 )
	elseif param0 == MAIL_DELFRIEND then
		x888889_Mail_DelFriend( sceneId, selfId, param0, param1, param2, param3 )
	end

end

--徒弟给师傅经验
function x888889_Mail_PrenticeProfExp( sceneId, selfId, command, PrenticeGuid, Exps, zero )
	--PrenticeGuid给了selfId，Exps这么多经验
	if Exps > 0 then
		LuaAddPrenticeProExp( sceneId, selfId, PrenticeGuid, Exps )
	end
end

function x888889_Mail_Unswear( sceneId, selfId, command, betrayerGuid, alldismiss, zero )

	--(1) 降低好友度
	local FriendPoint = LuaFnGetFriendPointByGUID( sceneId, selfId, betrayerGuid )
	if FriendPoint > 500 then
		LuaFnSetFriendPointByGUID( sceneId, selfId, betrayerGuid, 500 )
	end

	--(2) 取消结拜
	LuaFnUnswear( sceneId, selfId, betrayerGuid )

	--(3) 如果全部解散，则删除称号
	if tonumber(alldismiss) == 1 then
		AwardJieBaiTitle( sceneId, selfId, "" )
		DispatchAllTitle( sceneId, selfId )
	end
end

function x888889_Mail_Repudiate( sceneId, selfId, param0, param1, param2, param3 )
	if not param1 or param1 == -1 then
		return
	end

	if param1 < 0 then
		param1 = 4294967296 + param1
	end

	SpouseGUID = LuaFnGetSpouseGUID( sceneId, selfId )

	-- 如果不是相同的 GUID 则不进行强制离婚处理
	if param1 ~= 0 and param1 ~= SpouseGUID then
		return
	end

	--删除称号；
	LuaFnAwardSpouseTitle( sceneId, selfId, "" )
	DispatchAllTitle( sceneId, selfId )

	--删除婚姻技能
	Skills = {260, 261, 262, 263, 264, 265, 266, 267, 268 }
	for i, skillId in Skills do
		DelSkill( sceneId, selfId, skillId )
	end

	--增加金钱N=100000做为补偿；
--LuaFnAddMoney( sceneId, selfId, 100000 )

	--增加一个物品相思糖做为补偿；（如果空间够，不够算了）
--LuaFnBeginAddItem( sceneId )
--LuaFnAddItem( sceneId, 30002002, 1 )
--ret = LuaFnEndAddItem( sceneId, selfId )
--if ret == 1 then
--	LuaFnAddItemListToHuman( sceneId, selfId )
--end

	--和对方的好友度设置成N=X（10）
	LuaFnSetFriendPointByGUID( sceneId, selfId, SpouseGUID, 10 )

	CallScriptFunction(250036, "OnAbandon", sceneId, selfId);
	CallScriptFunction(250037, "OnAbandon", sceneId, selfId);

	--删除结婚状态；
	LuaFnDivorce( sceneId, selfId )

end

function x888889_Mail_BetrayMaster( sceneId, selfId, param0, param1, param2, param3 )
	--开除徒弟
	LuaFnExpelPrentice( sceneId, selfId, param1 )
end

function x888889_Mail_ExpelPrentice( sceneId, selfId, param0, param1, param2, param3 )
	--删除徒弟称号
	AwardShiTuTitle( sceneId, selfId, "" )
	DispatchAllTitle( sceneId, selfId )

	--离开师门
	LuaFnBetrayMaster( sceneId, selfId )
end

function x888889_Mail_CommisionShop( sceneId, selfId, param0, param1, param2, param3 )
	if param1 == 1 then									-- 退回寄售金钱
		-- param2 是序列号
		-- param3 是数量
		local ret = AddBankMoney( sceneId, selfId, param3 )
		local strAppend = ""
		if ret == 0 then
			return
		else
			if ret == 1 then
				strAppend = ""
			elseif ret == 2 then
				strAppend = "#{Mail_TooMuchMoney}"
			end
		end

		local mailStr = format( "您寄售的#{_MONEY%d}到期没有售出，返还的金钱已经存到了您的银行户头。%s", param3, strAppend )
		LuaFnSendSystemMail( sceneId, GetName( sceneId, selfId ), mailStr )
		local logStr = format( "Recvback type:1 sn:%d value:%d", param2, param3 )
		LogCommisionDeal( sceneId, selfId, logStr )
	elseif param1 == 0 then								-- 退回寄售元宝
		-- param2 是序列号
		-- param3 是数量
		CSAddYuanbao( sceneId, selfId, param3 )
		local mailStr = format( "您寄售的%d点元宝到期没有售出，商店已经将点数返还给您。", param3 )
		LuaFnSendSystemMail( sceneId, GetName( sceneId, selfId ), mailStr )
		local logStr = format( "Recvback type:0 sn:%d value:%d", param2, param3 )
		LogCommisionDeal( sceneId, selfId, logStr )
	elseif param1 == 2 then								-- 发送寄售金钱
		-- param2 是序列号
		-- param3 是数量
		local ret = AddBankMoney( sceneId, selfId, param3 )
		local strAppend = ""
		if ret == 0 then
			return
		else
			if ret == 1 then
				strAppend = ""
			elseif ret == 2 then
				strAppend = "#{Mail_TooMuchMoney}"
			end
		end

		local mailStr = format( "您寄售的元宝成功地售出，您获得的#{_MONEY%d}已经存入您的银行户头。%s", param3, strAppend )
		LuaFnSendSystemMail( sceneId, GetName( sceneId, selfId ), mailStr )
		local logStr = format( "Gain type:1 sn:%d value:%d", param2, param3 )
		LogCommisionDeal( sceneId, selfId, logStr )
	elseif param1 == 3 then								-- 发送寄售元宝
		-- param2 是序列号
		-- param3 是数量
		CSAddYuanbao( sceneId, selfId, param3 )
		local mailStr = format( "您寄售的金钱成功地售出，您获得的%d点元宝已经加到您身上。", param3 )
		LuaFnSendSystemMail( sceneId, GetName( sceneId, selfId ), mailStr )
		local logStr = format( "Gain type:0 sn:%d value:%d", param2, param3 )
		LogCommisionDeal( sceneId, selfId, logStr )
	end
end

function x888889_Mail_HuaShanJiangLi( sceneId, selfId, param0, param1, param2, param3 )
	-- PrintStr(GetName(sceneId, selfId))
	-- PrintNum(param1)
	-- PrintNum(param2)
	-- PrintNum(param3)
	if param2 == 1 then
		if param3 == 1 then			
			-- PrintStr(GetName(sceneId, selfId))
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli01, 0 )
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli02, 0 )
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli03, 1 )
			SetMissionData( sceneId, selfId, MD_HUASHANJIANGLI_TIME, param1 )
		elseif param3 == 2 then
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli01, 0 )
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli02, 1 )
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli03, 0 )
			SetMissionData( sceneId, selfId, MD_HUASHANJIANGLI_TIME, param1 )
		elseif param3 == 3 then
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli01, 0 )
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli02, 1 )
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli03, 1 )
			SetMissionData( sceneId, selfId, MD_HUASHANJIANGLI_TIME, param1 )
		end
	elseif param2 == 2 then
		if param3 == 1 then
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli01, 1 )
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli02, 0 )
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli03, 0 )
			SetMissionData( sceneId, selfId, MD_HUASHANJIANGLI_TIME, param1 )
		elseif param3 == 2 then
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli01, 1 )
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli02, 0 )
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli03, 1 )
			SetMissionData( sceneId, selfId, MD_HUASHANJIANGLI_TIME, param1 )
		elseif param3 == 3 then
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli01, 1 )
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli02, 1 )
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli03, 0 )
			SetMissionData( sceneId, selfId, MD_HUASHANJIANGLI_TIME, param1 )
		end	
	end
end


-- 删除好友
function x888889_Mail_DelFriend( sceneId, selfId, param0, param1, param2, param3 )

	LuaFnDelFriendByGUID( sceneId, selfId, param1, param2)
end