--怪兽总动员任务
--铁木真2哲别
--MisDescBegin
--脚本号
x700000_g_ScriptId = 700000
--上一个任务的ID
--g_MissionIdPre =
--任务号
x700000_g_MissionId = 25
--任务目标npc
x700000_g_Name	="铁木真" 
--任务归类
x700000_g_MissionKind = 1
--任务等级
x700000_g_MissionLevel = 1
--是否是精英任务
x700000_g_IfMissionElite = 0
--下面几项是动态显示的内容,用于在任务列表中动态显示任务情况**********************
--任务是否已经完成
x700000_g_IsMissionOkFail = 0		--变量的第0位
--任务需要杀死的怪
--x700000_g_DemandKill ={{id=500,num=5}}		--变量第1位
--以上是动态**************************************************************
--任务文本描述
x700000_g_MissionName="怪兽总动员"
x700000_g_MissionInfo="大萨满为大汗挑选精兵强将,共同达成一统天下的霸业,你要接受挑战吗？"  --任务描述
x700000_g_MissionTarget="通过大萨满的挑战,通过20关吧！"		--任务目标
x700000_g_ContinueInfo="快快通过挑战去吧！"		--未完成任务和铁木真的npc对话
x700000_g_TargetContinueInfo="今天你挑战了吗？"		--和哲别的对话
x700000_g_MissionComplete="领取你应得的奖励吧！"					--完成任务时这边说话的话

--MisDescEnd

--副本相关信息定义
x700000_g_CopySceneType=FUBEN_MONSTERPARTY	--副本类型，定义在ScriptGlobal.lua里面
x700000_g_LimitMembers=1			--可以进副本的最小队伍人数
x700000_g_TickTime=5				--回调脚本的时钟时间（单位：秒/次）
x700000_g_LimitTotalHoldTime=360	--副本可以存活的时间（单位：次数）,如果此时间到了，则任务将会失败
x700000_g_LimitTimeSuccess=500		--副本时间限制（单位：次数），如果此时间到了，任务完成

x700000_g_startTickCount = 2;				--开始出怪的时间（单位：次）

x700000_g_CloseTick=3600				--副本关闭前倒计时（单位：次数）
x700000_g_NoUserTime=5			--副本中没有人后可以继续保存的时间（单位：秒）
x700000_g_DeadTrans=1				--死亡转移模式，0：死亡后还可以继续在副本，1：死亡后被强制移出副本
x700000_g_Fuben_X=10				--进入副本的位置X
x700000_g_Fuben_Z=16				--进入副本的位置Z
x700000_g_Back_X=48				--源场景位置X
x700000_g_Back_Z=220					--源场景位置Z
x700000_g_TotalNeedKill=100			--需要杀死怪物数量


--任务奖励
--根据玩家接任务时不同等级段,所通过不同关卡数量,获得不同经验
--以下是不同等级阶段进行游戏时，完成不同关卡时所获得的经验奖励。
--lv=level(关卡),exp=过关经验奖励						
explist1 = {{lv = 1, exp = 12},
						{lv = 2, exp = 36},
						{lv = 3, exp = 96},
						{lv = 4, exp = 120},
						{lv = 5, exp = 216},						
						{lv = 6, exp = 288},
						{lv = 7, exp = 408},
						{lv = 8, exp = 504},
						{lv = 9, exp = 648},
						{lv = 10, exp = 888},
						{lv = 11, exp = 1164},
						{lv = 12, exp = 1488},
						{lv = 13, exp = 1848},
						{lv = 14, exp = 2244},
						{lv = 15, exp = 2340},
						{lv = 16, exp = 2448},
						{lv = 17, exp = 2568},
						{lv = 18, exp = 3048},
						{lv = 19, exp = 3708},
						{lv = 20, exp = 4116}}
						
explist2 = {{lv = 1, exp = 12},
						{lv = 2, exp = 36},
						{lv = 3, exp = 96},
						{lv = 4, exp = 120},
						{lv = 5, exp = 216},						
						{lv = 6, exp = 288},
						{lv = 7, exp = 408},
						{lv = 8, exp = 504},
						{lv = 9, exp = 648},
						{lv = 10, exp = 888},
						{lv = 11, exp = 1164},
						{lv = 12, exp = 1488},
						{lv = 13, exp = 1848},
						{lv = 14, exp = 2244},
						{lv = 15, exp = 2340},
						{lv = 16, exp = 2448},
						{lv = 17, exp = 2568},
						{lv = 18, exp = 3048},
						{lv = 19, exp = 3708},
						{lv = 20, exp = 4116}}
						
explist3 = {{lv = 1, exp = 12},
						{lv = 2, exp = 36},
						{lv = 3, exp = 96},
						{lv = 4, exp = 120},
						{lv = 5, exp = 216},						
						{lv = 6, exp = 288},
						{lv = 7, exp = 408},
						{lv = 8, exp = 504},
						{lv = 9, exp = 648},
						{lv = 10, exp = 888},
						{lv = 11, exp = 1164},
						{lv = 12, exp = 1488},
						{lv = 13, exp = 1848},
						{lv = 14, exp = 2244},
						{lv = 15, exp = 2340},
						{lv = 16, exp = 2448},
						{lv = 17, exp = 2568},
						{lv = 18, exp = 3048},
						{lv = 19, exp = 3708},
						{lv = 20, exp = 4116}}
						
explist4 = {{lv = 1, exp = 12},
						{lv = 2, exp = 36},
						{lv = 3, exp = 96},
						{lv = 4, exp = 120},
						{lv = 5, exp = 216},						
						{lv = 6, exp = 288},
						{lv = 7, exp = 408},
						{lv = 8, exp = 504},
						{lv = 9, exp = 648},
						{lv = 10, exp = 888},
						{lv = 11, exp = 1164},
						{lv = 12, exp = 1488},
						{lv = 13, exp = 1848},
						{lv = 14, exp = 2244},
						{lv = 15, exp = 2340},
						{lv = 16, exp = 2448},
						{lv = 17, exp = 2568},
						{lv = 18, exp = 3048},
						{lv = 19, exp = 3708},
						{lv = 20, exp = 4116}}
						
explist5 = {{lv = 1, exp = 12},
						{lv = 2, exp = 36},
						{lv = 3, exp = 96},
						{lv = 4, exp = 120},
						{lv = 5, exp = 216},						
						{lv = 6, exp = 288},
						{lv = 7, exp = 408},
						{lv = 8, exp = 504},
						{lv = 9, exp = 648},
						{lv = 10, exp = 888},
						{lv = 11, exp = 1164},
						{lv = 12, exp = 1488},
						{lv = 13, exp = 1848},
						{lv = 14, exp = 2244},
						{lv = 15, exp = 2340},
						{lv = 16, exp = 2448},
						{lv = 17, exp = 2568},
						{lv = 18, exp = 3048},
						{lv = 19, exp = 3708},
						{lv = 20, exp = 4116}}
						
explist6 = {{lv = 1, exp = 12},
						{lv = 2, exp = 36},
						{lv = 3, exp = 96},
						{lv = 4, exp = 120},
						{lv = 5, exp = 216},						
						{lv = 6, exp = 288},
						{lv = 7, exp = 408},
						{lv = 8, exp = 504},
						{lv = 9, exp = 648},
						{lv = 10, exp = 888},
						{lv = 11, exp = 1164},
						{lv = 12, exp = 1488},
						{lv = 13, exp = 1848},
						{lv = 14, exp = 2244},
						{lv = 15, exp = 2340},
						{lv = 16, exp = 2448},
						{lv = 17, exp = 2568},
						{lv = 18, exp = 3048},
						{lv = 19, exp = 3708},
						{lv = 20, exp = 4116}}
						
explist7 = {{lv = 1, exp = 12},
						{lv = 2, exp = 36},
						{lv = 3, exp = 96},
						{lv = 4, exp = 120},
						{lv = 5, exp = 216},						
						{lv = 6, exp = 288},
						{lv = 7, exp = 408},
						{lv = 8, exp = 504},
						{lv = 9, exp = 648},
						{lv = 10, exp = 888},
						{lv = 11, exp = 1164},
						{lv = 12, exp = 1488},
						{lv = 13, exp = 1848},
						{lv = 14, exp = 2244},
						{lv = 15, exp = 2340},
						{lv = 16, exp = 2448},
						{lv = 17, exp = 2568},
						{lv = 18, exp = 3048},
						{lv = 19, exp = 3708},
						{lv = 20, exp = 4116}}
						
explist8 = {{lv = 1, exp = 12},
						{lv = 2, exp = 36},
						{lv = 3, exp = 96},
						{lv = 4, exp = 120},
						{lv = 5, exp = 216},						
						{lv = 6, exp = 288},
						{lv = 7, exp = 408},
						{lv = 8, exp = 504},
						{lv = 9, exp = 648},
						{lv = 10, exp = 888},
						{lv = 11, exp = 1164},
						{lv = 12, exp = 1488},
						{lv = 13, exp = 1848},
						{lv = 14, exp = 2244},
						{lv = 15, exp = 2340},
						{lv = 16, exp = 2448},
						{lv = 17, exp = 2568},
						{lv = 18, exp = 3048},
						{lv = 19, exp = 3708},
						{lv = 20, exp = 4116}}
		
function getEXP(input,lv)

	for i, _monstercom in monstercom do
		if lv == _monstercom.lv then
			for i, _v in _monstercom.explist do
				if input == _v.lv then
					return _v.exp
				end
			end
		end
	end
end

--这是所有要说的话,从开始到完成任务的所有。
--目前欠缺的是被怪物杀死的判断以及相应提示

g_strNotice ={{group=1,nc1="马上开始了",nc2="第1关开始了"},
							{group=2,nc1="第1关结束了", nc2="第2关开始了"},
							{group=3,nc1="第2关结束了", nc2="第3关开始了"},
							{group=4,nc1="第3关结束了", nc2="第4关开始了"},
							{group=5,nc1="第4关结束了", nc2="第5关开始了"},
							{group=6,nc1="第5关结束了", nc2="第6关开始了"},
							{group=7,nc1="第6关结束了", nc2="第7关开始了"},
							{group=8,nc1="第7关结束了", nc2="第8关开始了"},
							{group=9,nc1="第8关结束了", nc2="第9关开始了"},
							{group=10,nc1="第9关结束了", nc2="第10关开始了"},
							{group=11,nc1="第10关结束了", nc2="第11关开始了"},
							{group=12,nc1="第11关结束了", nc2="第12关开始了"},
							{group=13,nc1="第12关结束了", nc2="第13关开始了"},
							{group=14,nc1="第13关结束了", nc2="第14关开始了"},
							{group=15,nc1="第14关结束了", nc2="第15关开始了"},
							{group=16,nc1="第15关结束了", nc2="第16关开始了"},
							{group=17,nc1="第16关结束了", nc2="第17关开始了"},
							{group=18,nc1="第17关结束了", nc2="第18关开始了"},
							{group=19,nc1="第18关结束了", nc2="第19关开始了"},
							{group=20,nc1="第19关结束了", nc2="第20关开始了"},
							{group=21,nc1="第20关结束了", nc2="恭喜你完成任务了！"}}

function getNC(group)

	for i,_str in g_strNotice do
		if group == _str.group then
		return _str.nc1, _str.nc2
		end
	end
end

--这里是怪物分布数组。
							
monsterline1 ={{group = 1, monsterid = 200,num = 1},
							{group = 2, monsterid = 200,num = 2},
							{group = 3, monsterid = 200,num = 5},
							{group = 4, monsterid = 201,num = 1},
							{group = 5, monsterid = 201,num = 4},
							{group = 6, monsterid = 200,num = 3},
							{group = 6, monsterid = 202,num = 1},
							{group = 7, monsterid = 201,num = 2},
							{group = 7, monsterid = 202,num = 2},
							{group = 8, monsterid = 200,num = 3},
							{group = 8, monsterid = 201,num = 1},
							{group = 8, monsterid = 202,num = 1},
							{group = 9, monsterid = 202,num = 4},
							{group = 10, monsterid = 203,num = 5},
							{group = 11, monsterid = 203,num = 2},
							{group = 11, monsterid = 204,num = 3},
							{group = 12, monsterid = 204,num = 3},
							{group = 12, monsterid = 220,num = 2},
							{group = 13, monsterid = 220,num = 5},
							{group = 14, monsterid = 220,num = 2},
							{group = 14, monsterid = 221,num = 3},
							{group = 15, monsterid = 222,num = 1},
							{group = 16, monsterid = 223,num = 1},
							{group = 17, monsterid = 224,num = 1},
							{group = 18, monsterid = 220,num = 1},
							{group = 18, monsterid = 221,num = 1},
							{group = 18, monsterid = 222,num = 1},
							{group = 18, monsterid = 223,num = 1},
							{group = 18, monsterid = 224,num = 1},
							{group = 19, monsterid = 260,num = 5},
							{group = 20, monsterid = 280,num = 2}}
							
monsterline2 ={{group = 1, monsterid = 200,num = 1},
							{group = 2, monsterid = 200,num = 2},
							{group = 3, monsterid = 200,num = 5},
							{group = 4, monsterid = 201,num = 1},
							{group = 5, monsterid = 201,num = 4},
							{group = 6, monsterid = 200,num = 3},
							{group = 6, monsterid = 202,num = 1},
							{group = 7, monsterid = 201,num = 2},
							{group = 7, monsterid = 202,num = 2},
							{group = 8, monsterid = 200,num = 3},
							{group = 8, monsterid = 201,num = 1},
							{group = 8, monsterid = 202,num = 1},
							{group = 9, monsterid = 202,num = 4},
							{group = 10, monsterid = 203,num = 5},
							{group = 11, monsterid = 203,num = 2},
							{group = 11, monsterid = 204,num = 3},
							{group = 12, monsterid = 204,num = 3},
							{group = 12, monsterid = 220,num = 2},
							{group = 13, monsterid = 220,num = 5},
							{group = 14, monsterid = 220,num = 2},
							{group = 14, monsterid = 221,num = 3},
							{group = 15, monsterid = 222,num = 1},
							{group = 16, monsterid = 223,num = 1},
							{group = 17, monsterid = 224,num = 1},
							{group = 18, monsterid = 220,num = 1},
							{group = 18, monsterid = 221,num = 1},
							{group = 18, monsterid = 222,num = 1},
							{group = 18, monsterid = 223,num = 1},
							{group = 18, monsterid = 224,num = 1},
							{group = 19, monsterid = 260,num = 5},
							{group = 20, monsterid = 280,num = 2}}
							
monsterline3 ={{group = 1, monsterid = 200,num = 1},
							{group = 2, monsterid = 200,num = 2},
							{group = 3, monsterid = 200,num = 5},
							{group = 4, monsterid = 201,num = 1},
							{group = 5, monsterid = 201,num = 4},
							{group = 6, monsterid = 200,num = 3},
							{group = 6, monsterid = 202,num = 1},
							{group = 7, monsterid = 201,num = 2},
							{group = 7, monsterid = 202,num = 2},
							{group = 8, monsterid = 200,num = 3},
							{group = 8, monsterid = 201,num = 1},
							{group = 8, monsterid = 202,num = 1},
							{group = 9, monsterid = 202,num = 4},
							{group = 10, monsterid = 203,num = 5},
							{group = 11, monsterid = 203,num = 2},
							{group = 11, monsterid = 204,num = 3},
							{group = 12, monsterid = 204,num = 3},
							{group = 12, monsterid = 220,num = 2},
							{group = 13, monsterid = 220,num = 5},
							{group = 14, monsterid = 220,num = 2},
							{group = 14, monsterid = 221,num = 3},
							{group = 15, monsterid = 222,num = 1},
							{group = 16, monsterid = 223,num = 1},
							{group = 17, monsterid = 224,num = 1},
							{group = 18, monsterid = 220,num = 1},
							{group = 18, monsterid = 221,num = 1},
							{group = 18, monsterid = 222,num = 1},
							{group = 18, monsterid = 223,num = 1},
							{group = 18, monsterid = 224,num = 1},
							{group = 19, monsterid = 260,num = 5},
							{group = 20, monsterid = 280,num = 2}}
							
monsterline4 ={{group = 1, monsterid = 200,num = 1},
							{group = 2, monsterid = 200,num = 2},
							{group = 3, monsterid = 200,num = 5},
							{group = 4, monsterid = 201,num = 1},
							{group = 5, monsterid = 201,num = 4},
							{group = 6, monsterid = 200,num = 3},
							{group = 6, monsterid = 202,num = 1},
							{group = 7, monsterid = 201,num = 2},
							{group = 7, monsterid = 202,num = 2},
							{group = 8, monsterid = 200,num = 3},
							{group = 8, monsterid = 201,num = 1},
							{group = 8, monsterid = 202,num = 1},
							{group = 9, monsterid = 202,num = 4},
							{group = 10, monsterid = 203,num = 5},
							{group = 11, monsterid = 203,num = 2},
							{group = 11, monsterid = 204,num = 3},
							{group = 12, monsterid = 204,num = 3},
							{group = 12, monsterid = 220,num = 2},
							{group = 13, monsterid = 220,num = 5},
							{group = 14, monsterid = 220,num = 2},
							{group = 14, monsterid = 221,num = 3},
							{group = 15, monsterid = 222,num = 1},
							{group = 16, monsterid = 223,num = 1},
							{group = 17, monsterid = 224,num = 1},
							{group = 18, monsterid = 220,num = 1},
							{group = 18, monsterid = 221,num = 1},
							{group = 18, monsterid = 222,num = 1},
							{group = 18, monsterid = 223,num = 1},
							{group = 18, monsterid = 224,num = 1},
							{group = 19, monsterid = 260,num = 5},
							{group = 20, monsterid = 280,num = 2}}
							
monsterline5 ={{group = 1, monsterid = 200,num = 1},
							{group = 2, monsterid = 200,num = 2},
							{group = 3, monsterid = 200,num = 5},
							{group = 4, monsterid = 201,num = 1},
							{group = 5, monsterid = 201,num = 4},
							{group = 6, monsterid = 200,num = 3},
							{group = 6, monsterid = 202,num = 1},
							{group = 7, monsterid = 201,num = 2},
							{group = 7, monsterid = 202,num = 2},
							{group = 8, monsterid = 200,num = 3},
							{group = 8, monsterid = 201,num = 1},
							{group = 8, monsterid = 202,num = 1},
							{group = 9, monsterid = 202,num = 4},
							{group = 10, monsterid = 203,num = 5},
							{group = 11, monsterid = 203,num = 2},
							{group = 11, monsterid = 204,num = 3},
							{group = 12, monsterid = 204,num = 3},
							{group = 12, monsterid = 220,num = 2},
							{group = 13, monsterid = 220,num = 5},
							{group = 14, monsterid = 220,num = 2},
							{group = 14, monsterid = 221,num = 3},
							{group = 15, monsterid = 222,num = 1},
							{group = 16, monsterid = 223,num = 1},
							{group = 17, monsterid = 224,num = 1},
							{group = 18, monsterid = 220,num = 1},
							{group = 18, monsterid = 221,num = 1},
							{group = 18, monsterid = 222,num = 1},
							{group = 18, monsterid = 223,num = 1},
							{group = 18, monsterid = 224,num = 1},
							{group = 19, monsterid = 260,num = 5},
							{group = 20, monsterid = 280,num = 2}}							
							
monsterline6 ={{group = 1, monsterid = 200,num = 1},
							{group = 2, monsterid = 200,num = 2},
							{group = 3, monsterid = 200,num = 5},
							{group = 4, monsterid = 201,num = 1},
							{group = 5, monsterid = 201,num = 4},
							{group = 6, monsterid = 200,num = 3},
							{group = 6, monsterid = 202,num = 1},
							{group = 7, monsterid = 201,num = 2},
							{group = 7, monsterid = 202,num = 2},
							{group = 8, monsterid = 200,num = 3},
							{group = 8, monsterid = 201,num = 1},
							{group = 8, monsterid = 202,num = 1},
							{group = 9, monsterid = 202,num = 4},
							{group = 10, monsterid = 203,num = 5},
							{group = 11, monsterid = 203,num = 2},
							{group = 11, monsterid = 204,num = 3},
							{group = 12, monsterid = 204,num = 3},
							{group = 12, monsterid = 220,num = 2},
							{group = 13, monsterid = 220,num = 5},
							{group = 14, monsterid = 220,num = 2},
							{group = 14, monsterid = 221,num = 3},
							{group = 15, monsterid = 222,num = 1},
							{group = 16, monsterid = 223,num = 1},
							{group = 17, monsterid = 224,num = 1},
							{group = 18, monsterid = 220,num = 1},
							{group = 18, monsterid = 221,num = 1},
							{group = 18, monsterid = 222,num = 1},
							{group = 18, monsterid = 223,num = 1},
							{group = 18, monsterid = 224,num = 1},
							{group = 19, monsterid = 260,num = 5},
							{group = 20, monsterid = 280,num = 2}}
							
monsterline7 ={{group = 1, monsterid = 200,num = 1},
							{group = 2, monsterid = 200,num = 2},
							{group = 3, monsterid = 200,num = 5},
							{group = 4, monsterid = 201,num = 1},
							{group = 5, monsterid = 201,num = 4},
							{group = 6, monsterid = 200,num = 3},
							{group = 6, monsterid = 202,num = 1},
							{group = 7, monsterid = 201,num = 2},
							{group = 7, monsterid = 202,num = 2},
							{group = 8, monsterid = 200,num = 3},
							{group = 8, monsterid = 201,num = 1},
							{group = 8, monsterid = 202,num = 1},
							{group = 9, monsterid = 202,num = 4},
							{group = 10, monsterid = 203,num = 5},
							{group = 11, monsterid = 203,num = 2},
							{group = 11, monsterid = 204,num = 3},
							{group = 12, monsterid = 204,num = 3},
							{group = 12, monsterid = 220,num = 2},
							{group = 13, monsterid = 220,num = 5},
							{group = 14, monsterid = 220,num = 2},
							{group = 14, monsterid = 221,num = 3},
							{group = 15, monsterid = 222,num = 1},
							{group = 16, monsterid = 223,num = 1},
							{group = 17, monsterid = 224,num = 1},
							{group = 18, monsterid = 220,num = 1},
							{group = 18, monsterid = 221,num = 1},
							{group = 18, monsterid = 222,num = 1},
							{group = 18, monsterid = 223,num = 1},
							{group = 18, monsterid = 224,num = 1},
							{group = 19, monsterid = 260,num = 5},
							{group = 20, monsterid = 280,num = 2}}							
							
monsterline8 ={{group = 1, monsterid = 200,num = 1},
							{group = 2, monsterid = 200,num = 2},
							{group = 3, monsterid = 200,num = 5},
							{group = 4, monsterid = 201,num = 1},
							{group = 5, monsterid = 201,num = 4},
							{group = 6, monsterid = 200,num = 3},
							{group = 6, monsterid = 202,num = 1},
							{group = 7, monsterid = 201,num = 2},
							{group = 7, monsterid = 202,num = 2},
							{group = 8, monsterid = 200,num = 3},
							{group = 8, monsterid = 201,num = 1},
							{group = 8, monsterid = 202,num = 1},
							{group = 9, monsterid = 202,num = 4},
							{group = 10, monsterid = 203,num = 5},
							{group = 11, monsterid = 203,num = 2},
							{group = 11, monsterid = 204,num = 3},
							{group = 12, monsterid = 204,num = 3},
							{group = 12, monsterid = 220,num = 2},
							{group = 13, monsterid = 220,num = 5},
							{group = 14, monsterid = 220,num = 2},
							{group = 14, monsterid = 221,num = 3},
							{group = 15, monsterid = 222,num = 1},
							{group = 16, monsterid = 223,num = 1},
							{group = 17, monsterid = 224,num = 1},
							{group = 18, monsterid = 220,num = 1},
							{group = 18, monsterid = 221,num = 1},
							{group = 18, monsterid = 222,num = 1},
							{group = 18, monsterid = 223,num = 1},
							{group = 18, monsterid = 224,num = 1},
							{group = 19, monsterid = 260,num = 5},
							{group = 20, monsterid = 280,num = 2}}

--以下是说明，如果玩家等级属于哪个等级段，那么将匹配以不同的monlist(怪物列表数组)，和不同的explist(经验奖励列表)

monstercom = {{lv=1,monlist=monsterline1,explist=explist1},
							{lv=2,monlist=monsterline2,explist=explist2},
							{lv=3,monlist=monsterline3,explist=explist3},
							{lv=4,monlist=monsterline4,explist=explist4},
							{lv=5,monlist=monsterline5,explist=explist5},
							{lv=6,monlist=monsterline6,explist=explist6},
							{lv=7,monlist=monsterline7,explist=explist7},
							{lv=8,monlist=monsterline8,explist=explist8}}
							
function getMonsterCount(group,lv)

CountNum = 0

	for i,_monstercom in monstercom do
		if lv == _monstercom.lv then
			for i, _monsterline in _monstercom.monlist do
				if group == _monsterline.group then
					CountNum = CountNum + _monsterline.num
				end
			end
		end
	end
		return CountNum

end

function exchangeDayCount(data)
	local misCount = floor(data / 100000)
	return misCount, mod(data, 100000)
end

function exchangeDCData(misCount, misDate)
	return misCount * 100000 + misDate
end

misMaxTime = {{week = '0', maxTime = 3},
							{week = '1', maxTime = 3},
							{week = '2', maxTime = 3},
							{week = '3', maxTime = 5},
							{week = '4', maxTime = 3},
							{week = '5', maxTime = 3},
							{week = '6', maxTime = 3}}

function getMissionMaxTime()
	for i, _misMT in misMaxTime do
		if date("%w") == _misMT.week then
			return _misMT.maxTime
		end
	end
end
--MisD11escEnd

--**********************************

--任务入口函数

--**********************************

function x700000_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	--如果已接此任务
	misIndex = GetMissionIndexByID(sceneId,selfId,x700000_g_MissionId)
	
	if IsHaveMission(sceneId,selfId,x700000_g_MissionId) > 0 then

		--发送任务需求的信息
		BeginEvent(sceneId)
			AddText(sceneId,x700000_g_MissionName)
			if (GetName(sceneId,targetId)==x700000_g_Name) then
				AddText(sceneId,x700000_g_ContinueInfo)
			else
				AddText(sceneId,x700000_g_TargetContinueInfo)
			end
		EndEvent()

		bDone = 1--x700000_CheckSubmit( sceneId, selfId, targetId)
	DispatchMissionContinueInfo(sceneId,selfId,targetId,x700000_g_ScriptId,x700000_g_MissionId)
		--DispatchMissionDemandInfo(sceneId,selfId,targetId,x700000_g_ScriptId,x700000_g_MissionId,bDone)
	--满足任务接收条件

	elseif GetMissionData(sceneId, selfId, MD_MONSTERPARTY_STATE) == 1 then

		--发送任务接受时显示的信息

		BeginEvent(sceneId)

			AddText(sceneId,x700000_g_MissionName)

			AddText(sceneId,x700000_g_MissionInfo)

			AddText(sceneId,"#{M_MUBIAO}")

			AddText(sceneId,x700000_g_MissionTarget)

		EndEvent( )

		DispatchMissionInfo(sceneId,selfId,targetId,x700000_g_ScriptId,x700000_g_MissionId)

	elseif GetMissionData(sceneId, selfId, MD_MONSTERPARTY_STATE) == 0 then
		if HaveItem(sceneId, selfId, 30001001) or GetMoney(sceneId, selfId) >= 5 then
		
			BeginEvent(sceneId)

			AddText(sceneId,x700000_g_MissionName)

			AddText(sceneId,x700000_g_MissionInfo.."需要扣除道具或金钱！！！！！！")

			AddText(sceneId,"#{M_MUBIAO}")

			AddText(sceneId,x700000_g_MissionTarget)

			EndEvent( )

			DispatchMissionInfo(sceneId,selfId,targetId,x700000_g_ScriptId,x700000_g_MissionId)
		end
	else
		
		BeginEvent(sceneId)

		AddText(sceneId,"达到上限")

		EndEvent( )

		DispatchMissionInfo(sceneId,selfId,targetId,x700000_g_ScriptId,x700000_g_MissionId)
	end


end



--**********************************

--列举事件

--**********************************

function x700000_OnEnumerate( sceneId, selfId, targetId )
	    --如果玩家完成过这个任务

	    --如果已接此任务
	    --else
	  if IsHaveMission(sceneId,selfId,x700000_g_MissionId) > 0 then
			
				AddNumText(sceneId,x700000_g_ScriptId,x700000_g_MissionName);
	
	    --满足任务接收条件
	
	  elseif x700000_CheckAccept(sceneId,selfId,targetId) > 0 then
	
			AddNumText(sceneId,x700000_g_ScriptId,x700000_g_MissionName);
	
	  end
end



--**********************************

--检测接受条件

--**********************************

function x700000_CheckAccept( sceneId, selfId,targetId )
	--需要10级才能接

    local normalState = 0
	if GetLevel( sceneId, selfId ) >= 10 then

	    local nowDay = GetDayTime()
	    local misData = GetMissionData(sceneId, selfId, MD_MONSTERPARTY_DAYCOUNT)
	    local preCount, preDay = exchangeDayCount(misData)
	    
	    if preDay ~= nowDay then
	    	preCount = 0
		   	SetMissionData(sceneId,selfId,MD_MONSTERPARTY_DAYCOUNT,exchangeDCData(preCount, nowDay))
		   	normalState = 1
		  elseif preCount == 0 then
		  	normalState = 1
	    else
--	   	 if preCount >= getMissionMaxTime() then

--	   	 	normalState = -1
--	   	 else
	   	 	normalState = 0
--	   	 end
			end
	else
			return 0
	end
	SetMissionData(sceneId,selfId,MD_MONSTERPARTY_STATE,normalState)
	
	return normalState+1
end



--**********************************

--接受

--**********************************

function x700000_OnAccept( sceneId, selfId )

	--加入任务到玩家列表
	if GetMissionData(sceneId,selfId,MD_MONSTERPARTY_STATE) < 0 then
		return
	elseif GetMissionData(sceneId,selfId,MD_MONSTERPARTY_STATE) == 0 then
		if HaveItem(sceneId, selfId, 30001001) > 0 then
			DelItem(sceneId,selfId,30001001,1)
			
			BeginEvent(sceneId)
			AddText(sceneId,"扣除小血瓶1级1个")
			EndEvent()
			DispatchMissionTips(sceneId, selfId)
			
		elseif GetMoney(sceneId,selfId) >= 5 then
			local bDone = CostMoney(sceneId, selfId, 5)

			BeginEvent(sceneId)
			AddText(sceneId,"扣除金币5！")
			EndEvent()
			DispatchMissionTips(sceneId, selfId)
			
		else
			BeginEvent(sceneId)
			AddText(sceneId,"你什么都没有！")
			EndEvent()
			DispatchMissionTips(sceneId, selfId)
			return
		end
	end

	AddMission( sceneId,selfId, x700000_g_MissionId, x700000_g_ScriptId, 1, 0, 0 )		--添加任务
	misIndex = GetMissionIndexByID(sceneId,selfId,x700000_g_MissionId)
				--得到任务的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,0,1)						--根据序列号把任务变量的第0位置0 这是记录玩家已经完成的关卡数 v
--	SetMissionByIndex(sceneId,selfId,misIndex,1,0)						--根据序列号把任务变量的第1位置0 这是记录玩家可否正常继续
	SetMissionByIndex(sceneId,selfId,misIndex,2,0)						--杀怪数
	SetMissionByIndex(sceneId,selfId,misIndex,3,0)						--等级段lv

--	NewWorld( sceneId, selfId, copysceneid, x700000_g_Fuben_X, x700000_g_Fuben_Z)
	x700000_MakeCopyScene( sceneId, selfId)

	
--我不管 这是说提示的部分

	BeginEvent(sceneId)
		AddText(sceneId, getNC(1))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId, selfId)

end

function x700000_OnHumanDie(sceneId,selfId,killerId)
			BeginEvent(sceneId)
			AddText(sceneId,"你死翘翘了，任务结束，去找铁木真领取奖励吧！")
			EndEvent()
			DispatchMissionTips(sceneId, selfId)
			
			misIndex = GetMissionIndexByID(sceneId,selfId,x700000_g_MissionId)			
	for i,_monsterline in monstercom[GetMissionParam(sceneId,selfId,misIndex,3)].monlist do
		if GetMissionParam(sceneId,selfId,misIndex,0) == _monsterline.group then
		

			--LuaFnDeleteMonster(sceneId, _monsterline.monsterid)
		end
	end
end

function x700000_OnDie( sceneId, killerId , selfId)
--print(selfId)
	--RemoveMonster(sceneId,killerId)
	
	misIndex = GetMissionIndexByID(sceneId,selfId,x700000_g_MissionId)
	local killmonster = GetMissionParam(sceneId,selfId,misIndex,2)
	local killmonster = killmonster + 1
	local group = GetMissionParam(sceneId,selfId,misIndex,0)
--	Param(sceneId,selfId,misIndex,0)

				lv = GetMissionParam(sceneId,selfId,misIndex,3)
	if getMonsterCount(group,lv) == killmonster then
			group = group + 1
			local nowTickCount = LuaFnGetCopySceneData_Param(sceneId, 2);
			LuaFnSetCopySceneData_Param(sceneId, 7, nowTickCount) ;--
			SetMissionByIndex(sceneId,selfId,misIndex,0,group)
			SetMissionByIndex(sceneId,selfId,misIndex,2,0)
			if group > 20 then
				local oldscene = LuaFnGetCopySceneData_Param(sceneId, 3)
				NewWorld( sceneId, selfId, oldscene, x700000_g_Back_X, x700000_g_Back_Z )
				
			end
	else
		SetMissionByIndex(sceneId,selfId,misIndex,2,killmonster)
	end
				local nc1,nc2 = getNC(group)
				BeginEvent(sceneId)
				
					AddText(sceneId,nc1)
				EndEvent()
				DispatchMissionTips(sceneId, selfId)
				
				BeginEvent(sceneId)
				
					AddText(sceneId,nc2)
				EndEvent()
				DispatchMissionTips(sceneId, selfId)

end



--**********************************

--放弃

--**********************************

function x700000_OnAbandon( sceneId, selfId )

	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x700000_g_MissionId )
end



--**********************************

--继续

--**********************************

function x700000_OnContinue( sceneId, selfId, targetId )

	--提交任务时的说明信息

	BeginEvent(sceneId)
		AddText(sceneId,x700000_g_MissionName)
		AddText(sceneId,x700000_g_MissionComplete)
	EndEvent( )

   DispatchMissionContinueInfo(sceneId,selfId,targetId,x700000_g_ScriptId,x700000_g_MissionId)

end



--**********************************

--检测是否可以提交

--**********************************

function x700000_CheckSubmit( sceneId, selfId, targetId)


	return 1
--	if num>0	then
--		return 1
--	end
	
--	return 0

end


--**********************************

--提交

--**********************************

function x700000_OnSubmit( sceneId, selfId, targetId,selectRadioId )

	if x700000_CheckSubmit( sceneId, selfId, targetId)>0 then

		misIndex = GetMissionIndexByID(sceneId,selfId,x700000_g_MissionId)
		k = GetMissionParam(sceneId,selfId,misIndex,0)
		lv = GetMissionParam(sceneId,selfId,misIndex,3)
		AddExp(sceneId,selfId,getEXP(k-1,lv))
--		SetMissionByIndex(sceneId,selfId,misIndex,1,100)
		DelMission(sceneId, selfId, x700000_g_MissionId)
	end

end



--**********************************

--杀死怪物或玩家

--**********************************

function x700000_OnKillObject( sceneId, selfId, objdataId, objId )
	
--	local killedId = LuaFnGetTargetObjID(sceneId,objdataId)
--	for i,_monsterline in monstercom[lv].monlist do
--		if group == _monsterline.group then
--			for j = 1, _monsterline.num do
--				return _monsterline.monsterid
--			end
--		end
--		RemoveMonster(sceneId,_monsterline.monsterid)
	RemoveMonster(sceneId,objId)
--	end
end



--**********************************

--进入区域事件

--**********************************

function x700000_OnEnterArea( sceneId, selfId, zoneId )

end



--**********************************

--道具改变

--**********************************

function x700000_OnItemChanged( sceneId, selfId, itemdataId )

end


function x700000_OnCopySceneReady( sceneId, destsceneId )

	LuaFnSetCopySceneData_Param(destsceneId, 3, sceneId);--设置副本入口场景号
	selfguid  = LuaFnGetCopySceneData_TeamLeader(destsceneId) ;	
	selfId = LuaFnGuid2ObjId(sceneId,selfguid);
	--取得玩家附近的队友数量（包括自己）
--	local	nearteammembercount = GetNearTeamCount( sceneId, leaderObjId) 
--	local mems = {}
--	for	i=0,nearteammembercount-1 do
--		selfId = GetNearTeamMember(sceneId, leaderObjId, i)
--		misIndex = GetMissionIndexByID(sceneId,selfId,x700000_g_MissionId)
		
		--将任务的第2号数据设置为副本的场景号
--		SetMissionByIndex(sceneId,selfId,misIndex,x700000_g_Param_sceneid,destsceneId)
				
		NewWorld( sceneId, selfId, destsceneId, x700000_g_Fuben_X, x700000_g_Fuben_Z) ;






end


function x700000_OnCopySceneTimer( sceneId, nowTime )

	selfguid  = LuaFnGetCopySceneData_TeamLeader(sceneId) ;	
	selfId = LuaFnGuid2ObjId(sceneId,selfguid);
	--副本时钟读取及设置
	TickCount = LuaFnGetCopySceneData_Param(sceneId, 2) ;--取得已经执行的定时次数
	TickCount = TickCount+1 ;
	LuaFnSetCopySceneData_Param(sceneId, 2, TickCount);--设置新的定时器调用次数

		
	local curTickCount = LuaFnGetCopySceneData_Param(sceneId, 7);		--取得已经执行的定时次数
	
	--副本关闭标志
	leaveFlag = LuaFnGetCopySceneData_Param(sceneId, 4) ;
	
	if leaveFlag == 1 then --需要离开
		
		--离开倒计时间的读取和设置
		leaveTickCount = LuaFnGetCopySceneData_Param(sceneId, 5) ;
		leaveTickCount = leaveTickCount+1 ;
		LuaFnSetCopySceneData_Param(sceneId, 5, leaveTickCount) ;
		
			if leaveTickCount == x700000_g_CloseTick then --倒计时间到，大家都出去吧
			
				oldsceneId = LuaFnGetCopySceneData_Param(sceneId, 3) ;--取得副本入口场景号
					NewWorld( sceneId, selfId, oldsceneId, x700000_g_Back_X, x700000_g_Back_Z )
				
			elseif leaveTickCount < x700000_g_CloseTick then
			
				oldsceneId = LuaFnGetCopySceneData_Param(sceneId, 3) ;--取得副本入口场景号
	
				--通知当前副本场景里的所有人，场景关闭倒计时间
				local remainTime = x700000_g_CloseTick-leaveTickCount*x700000_g_TickTime;
				if remainTime < 60 then
		  			BeginEvent(sceneId)
		  				strText = format("你将在%d秒后离开场景!", remainTime )
		  				AddText(sceneId,strText);
		  			EndEvent(sceneId)
		  			DispatchMissionTips(sceneId,selfId)
		  	end
			end

	elseif TickCount == x700000_g_LimitTimeSuccess then
		--此处设置有时间限制的任务完成处理
  			BeginEvent(sceneId)
  				AddText(sceneId,"任务时间到，完成!");
  			EndEvent(sceneId)
  			DispatchMissionTips(sceneId,selfId)
  			
			misIndex = GetMissionIndexByID(sceneId,selfId,x700000_g_MissionId)--取得任务数据索引值
			--将任务的第1号数据设置为1,表示完成的任务
			SetMissionByIndex(sceneId,selfId,misIndex,x700000_g_Param_ok,1)--设置任务数据
			--完成副本所用时间
			SetMissionByIndex(sceneId,selfId,misIndex,x700000_g_Param_time,TickCount*x700000_g_TickTime)--设置任务数据
--	end

		--设置副本关闭标志
		LuaFnSetCopySceneData_Param(sceneId, 4, 1) ;
		
	elseif TickCount == x700000_g_LimitTotalHoldTime then --副本总时间限制到了
		--此处设置副本任务有时间限制的情况，当时间到后处理...
			DelMission( sceneId, selfId, x700000_g_MissionId );--任务失败,删除之

  			BeginEvent(sceneId)
  				AddText(sceneId,"任务失败，超时!");
  			EndEvent(sceneId)
  			DispatchMissionTips(sceneId,selfId)
		end

		--设置副本关闭标志
		LuaFnSetCopySceneData_Param(sceneId, 4, 1) ;
		

	if curTickCount == LuaFnGetCopySceneData_Param(sceneId, 2) - 2 then
	
--以下是获取玩等级，并且根据其等级，将其分为不同的阶段
--10级29级为第一段，依此类推，150级以上为一段，共计8段

	playerlevel = GetLevel(sceneId,selfId)
	local lv = 0
	if playerlevel >= 10 and playerlevel < 30 then
		lv = 1
	elseif playerlevel >= 30 and playerlevel < 50 then
		lv = 2
	elseif playerlevel >= 50 and playerlevel < 70 then
		lv = 3
	elseif playerlevel >= 70 and playerlevel < 90 then
		lv = 4
	elseif playerlevel >= 90 and playerlevel < 110 then
		lv = 5	
	elseif playerlevel >= 110 and playerlevel < 130 then
		lv = 6	
	elseif playerlevel >= 130 and playerlevel < 150 then
		lv = 7	
	elseif playerlevel >= 150 then
		lv = 8	
	end
--	misIndex = GetMissionParam(sceneId,selfId,misIndex,3)				--GetMissionIndexByID(sceneId,selfId,x700000_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,3,lv)

	group = GetMissionParam(sceneId,selfId,misIndex,0)

	--LuaFnCreateMonster(sceneId,1000,26,217,0,109,900019)
	--LuaFnCreateMonster(sceneId,1000,20,218,0,109,900019)

	if group < 21 then
		for i,_monsterline in monstercom[lv].monlist do
			if group == _monsterline.group then
				for j = 1, _monsterline.num do
					local p = LuaFnCreateMonster(sceneId,_monsterline.monsterid,5,4,0,109,700000)
				end
			end
		end
	end

	local preCount, preDay = exchangeDayCount(GetMissionData(sceneId, selfId, MD_MONSTERPARTY_DAYCOUNT))
	SetMissionData(sceneId, selfId, MD_MONSTERPARTY_DAYCOUNT, exchangeDCData(preCount+1, preDay))

end



end

--开始创建副本	
function x700000_MakeCopyScene( sceneId, selfId )

	leaderguid=LuaFnObjId2Guid(sceneId,selfId)
	LuaFnSetSceneLoad_Map(sceneId, "Fuben_MonsterParty/0.nav"); --地图是必须选取的，而且必须在Config/SceneInfo.ini里配置好
	LuaFnSetCopySceneData_TeamLeader(sceneId, leaderguid);
	LuaFnSetCopySceneData_NoUserCloseTime(sceneId, x700000_g_NoUserTime*1000);
	LuaFnSetCopySceneData_Timer(sceneId, x700000_g_TickTime*1000);
	LuaFnSetCopySceneData_Param(sceneId, 0, x700000_g_CopySceneType);--设置副本数据，这里将0号索引的数据设置为999，用于表示副本号999(数字自定义)
	LuaFnSetCopySceneData_Param(sceneId, 1, x700000_g_ScriptId);--将1号数据设置为副本场景事件脚本号
	LuaFnSetCopySceneData_Param(sceneId, 2, 0);--设置定时器调用次数
	LuaFnSetCopySceneData_Param(sceneId, 3, -1);--设置副本入口场景号, 初始化
	LuaFnSetCopySceneData_Param(sceneId, 4, 0);--设置副本关闭标志, 0开放，1关闭
	LuaFnSetCopySceneData_Param(sceneId, 5, 0);--设置离开倒计时次数
--	LuaFnSetCopySceneData_Param(sceneId, 6, GetTeamId(sceneId,selfId)); --保存队伍号
	local nowTickCount = LuaFnGetCopySceneData_Param(sceneId, 2);
	LuaFnSetCopySceneData_Param(sceneId, 7, nowTickCount) ;--


	local bRetSceneID = LuaFnCreateCopyScene(sceneId); --初始化完成后调用创建副本函数
	BeginEvent(sceneId)
		if bRetSceneID>0 then
			AddText(sceneId,"副本创建成功！");
		else
			AddText(sceneId,"副本数量已达上限，请稍候再试！");
			--删除玩家任务列表中对应的任务
			DelMission( sceneId, selfId, x700000_g_MissionId )
		end
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	
end

function x700000_OnEnterZone( sceneId, selfId, zoneId )
end

function x700000_OnPlayerEnter( sceneId, selfId )
	--设置死亡后复活点位置
	SetPlayerDefaultReliveInfo( sceneId, selfId, "%10", -1, "0", sceneId, x700000_g_Fuben_X, x700000_g_Fuben_Z );
end