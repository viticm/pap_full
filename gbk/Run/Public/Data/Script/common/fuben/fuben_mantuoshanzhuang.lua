--MisDescBegin
-------------------------
--***********************
--Const
--***********************
-------------------------

--x300461_g_TransScriptId = 800019
--x300461_g_TransPos="taohuadao"

x700102_g_ScriptId 								= 700102
x700102_g_MissionId 							= 406
x700102_g_MissionKind 							= 1

x700102_g_FuBenType								= 1

x700102_g_MissionName							= "副本----曼陀山庄"
x700102_g_MissionInfo							= "打怪！"
x700102_g_MissionTarget							= "打怪！杀怪！"

--MisDescEnd

x700102_g_CopySceneName							= "曼陀山庄"
x700102_g_Name									= ""
x700102_g_CopySceneType							= FUBEN_MANTUOSHANZHANG
x700102_g_LimitMembers							= 1																		--可以进副本的最小队伍人数
x700102_g_TickTime								= 5																		--回调脚本的时钟时间（单位：秒/次）
x700102_g_LimitTotalHoldTime					= 720																	--副本可以存活的时间（单位：次数）,如果此时间到了，则任务将会失败
x700102_g_CloseTick								= 6																		--副本关闭前倒计时（单位：次数）
x700102_g_NoUserTime							= 10																	--副本中没有人后可以继续保存的时间（单位：秒）
x700102_g_DeadTrans								= 0																		--死亡转移模式，0：死亡后还可以继续在副本，1：死亡后被强制移出副本
x700102_g_Fuben_X								= 47																	--进入副本的位置X
x700102_g_Fuben_Z								= 164																	--进入副本的位置Z
x700102_g_Back_X								= 142																	--源场景位置X
x700102_g_Back_Z								= 224																	--源场景位置Z

x700102_g_BossType								= 300																	--boss id

x700102_g_LevelLess								= 30																	--最小任务的级别
x700102_g_DayCountUntil							= 100																	--每日可接的任务数

x700102_g_MissionBonusInfo						= "获得经验%d的奖励。"

x700102_g_ContinueInfo							= "你要继续努力啊！"
x700102_g_MissionComplete						= "多谢！"
x700102_g_MissionFuBenOpen						= "传入副本。"

x700102_g_CompleteOutMessage					= "任务完成，将在%d秒后传送到入口位置！"
x700102_g_OpenDoorMessage						= "第%d号门被打开！"

x700102_g_ErrorMessage							= "条件不符！"
x700102_g_ErrorMessage_Country					= "你不是本国人！"
x700102_g_ErrorMessage_Level					= format("你的等级不足%d！", x700102_g_LevelLess)
x700102_g_ErrorMessage_Team						= "你不在队伍中！"
x700102_g_ErrorMessage_TeamNum					= format("队伍不足%d人！", x700102_g_LimitMembers)
x700102_g_ErrorMessage_Captain					= "你不是队长！"
x700102_g_ErrorMessage_DayCount					= "你今天已经做过此任务了！"

x700102_g_ErrorMessage_OtherLevel				= "%s的等级不足%d！"
x700102_g_ErrorMessage_OtherAround				= "%s不在你身边！"

x700102_g_SomeoneInTeam							= "队伍中某人"

x700102_g_FuBenCreateOK							= "副本创建成功！"
x700102_g_FuBenCreateFailed						= "副本已达上限，请稍后再试！"
x700102_g_MissionAbandon						= "任务失败！"
x700102_g_CountDownMessage						= "你将在%d秒后离开场景！"
x700102_g_TimeOutFailedMessage					= "任务失败，超时！30秒后，退出副本"
x700102_g_TimeOutStateFailedMessage1			= "施毒女杀不完，超级施毒女来也"
x700102_g_TimeOutStateFailedMessage1_1			= "施毒女杀完，可以去杀剑婆婆"
x700102_g_TimeOutStateMessage3					= "剑婆婆杀完，可以去杀毒老妇"
x700102_g_TimeOutStateMessage3_1				= "剑婆婆杀不完，超级剑婆婆来也"
x700102_g_TimeOutStateMessage4					= "可以去杀毒老妇"
x700102_g_TimeOutStateMessage5					= "大量杀怪开始了"
x700102_g_TimeOutStateMessage5_1				= "毒老妇杀不完，超级毒老妇来也"
x700102_g_TimeOutStateMessage7					= "大Boss出现了"
x700102_g_TimeOutStateMessage8					= "怪上加怪出现了"
x700102_g_TimeOutStateMessage9					= "任务完成，可以找王语嫣退出副本"
x700102_g_BossMergeMessage						= "精英怪出现！"
x700102_g_SceneMapNavPath						= "mantuoshanzhuang/mantuoshanzhuang.nav"

x700102_g_ExpBonus								= 100																	--奖励经验

x700102_g_MonsterChangeTimer					= 240000																--怪物变身时间。怪如果不死，可以变身

x700102_g_TimeZoneBias							= 8;

x700102_g_Quit_State							 = -1;																	--退出前30秒倒计时



x700102_g_kill_monster_count					=	{}																	--记录杀怪数量

x700102_g_EnterTime								=	{
														{min=8*60+30, max=14*60},
														{min=17*60+30, max=22*60}--临时改为17点开始
													}

x700102_g_RandomBuff							= 	{
														1000,
														1001,
														1002,
														1003,
														1004,
														1005
													}
x700102_g_ChangeModelBuff						=	{
														1000,
														1001
													}

x700102_g_MissionNPCName						= 	{
														{scene = 9, name = "阿朱"},			--指定场景上的NPC为入口NPC
														--{scene = 18, name = "打铁匠"},		--金帐
														--{scene = 21, name = "打铁匠"},		--雪域
														--{scene = 24, name = "打铁匠"},		--大漠
														--{scene = 36, name = "衣凌峰"}			--皇城
													}
x700102_g_Monster_ShiDuNu						=	9130																--施毒女
x700102_g_Monster_ShiDuNu_Gaoji					=	9134																--高级施毒女
x700102_g_Monster_JianPoPo						=	9131																--剑婆婆
x700102_g_Monster_JianPoPo_Gaoji				=	9135																--高级剑婆婆
x700102_g_Monster_DulaoFu						=	9132																--毒老妇
x700102_g_Monster_DulaoFu_Gaoji					=	9136																--高级毒老妇
x700102_g_Monster_Boss							=	9133

x700102_g_Create_ShiDuNu_Gaoji					=	{
														{	hash=1, type=x700102_g_Monster_ShiDuNu_Gaoji, x=44.2693, z=163.8265, ai=0, aiscript=0	},
														{	hash=2, type=x700102_g_Monster_ShiDuNu_Gaoji, x=45.9949, z=164.3921, ai=0, aiscript=0	},
														{	hash=3, type=x700102_g_Monster_ShiDuNu_Gaoji, x=46.6159, z=165.9363, ai=0, aiscript=0	},
														{	hash=4, type=x700102_g_Monster_ShiDuNu_Gaoji, x=47.3872, z=166.408,  ai=0, aiscript=0	}
													}

x700102_g_Create_JianPoPo_Gaoji					=	{
														{	hash=1, type=x700102_g_Monster_JianPoPo_Gaoji, x=58.2693, z=134.8265, ai=0, aiscript=0	},
														{	hash=2, type=x700102_g_Monster_JianPoPo_Gaoji, x=59.9949, z=135.3921, ai=0, aiscript=0	},
														{	hash=3, type=x700102_g_Monster_JianPoPo_Gaoji, x=60.6159, z=136.9363, ai=0, aiscript=0	},
														{	hash=4, type=x700102_g_Monster_JianPoPo_Gaoji, x=61.3872, z=137.408,  ai=0, aiscript=0	}
													}

x700102_g_Create_DulaoFu_Gaoji					=	{
														{	hash=1, type=x700102_g_Monster_DulaoFu_Gaoji, x=102.2693, z=82.8265, ai=0, aiscript=0	},
														{	hash=2, type=x700102_g_Monster_DulaoFu_Gaoji, x=103.9949, z=83.3921, ai=0, aiscript=0	},
														{	hash=3, type=x700102_g_Monster_DulaoFu_Gaoji, x=104.6159, z=83.9363, ai=0, aiscript=0	},
														{	hash=4, type=x700102_g_Monster_DulaoFu_Gaoji, x=105.3872, z=83.408,  ai=0, aiscript=0	}
													}

x700102_g_Create_Last_Gaoji						=	{
														{	hash=1, type=x700102_g_Monster_JianPoPo_Gaoji, x=38.2693, z=65.8265, ai=0, aiscript=0	},
														{	hash=2, type=x700102_g_Monster_JianPoPo_Gaoji, x=39.9949, z=66.3921, ai=0, aiscript=0	},
														{	hash=3, type=x700102_g_Monster_JianPoPo_Gaoji, x=40.6159, z=67.9363, ai=0, aiscript=0	},

														{	hash=4, type=x700102_g_Monster_DulaoFu_Gaoji, x=41.3872, z=68.408,  ai=0, aiscript=0	},
														{	hash=5, type=x700102_g_Monster_DulaoFu_Gaoji, x=42.3872, z=69.408,  ai=0, aiscript=0	},
														{	hash=6, type=x700102_g_Monster_DulaoFu_Gaoji, x=43.3872, z=70.408,  ai=0, aiscript=0	}
													}

x700102_g_Create_Boss							=	{
														{	hash=1, type=x700102_g_Monster_Boss, x=38.2693, z=65.8265, ai=0, aiscript=0	}
													}

x700102_g_MonsterOriType						=	9111
x700102_g_MonsterToType							= 	9121
x700102_g_MonsterBasicAI						= 	0
x700102_g_DoorMonsterType						= 	9124
x700102_g_BossMonsterType						= 	9103
x700102_g_GhostMonsterType						= 	9122
x700102_g_MonsterType							= 	{
														{hash=1, type=x700102_g_DoorMonsterType, num=1},
														{hash=2, type=x700102_g_DoorMonsterType, num=1},
														{hash=3, type=x700102_g_DoorMonsterType, num=1},
														{hash=4, type=x700102_g_DoorMonsterType, num=1},
														{hash=5, type=x700102_g_DoorMonsterType, num=1},
														{hash=6, type=x700102_g_DoorMonsterType, num=1},
														{hash=7, type=x700102_g_DoorMonsterType, num=1},
														{hash=8, type=x700102_g_DoorMonsterType, num=1},

														{hash=9, type=x700102_g_MonsterOriType,  num=30},
														{hash=10, type=x700102_g_MonsterOriType, num=30},
														{hash=11, type=x700102_g_MonsterOriType, num=30},
														{hash=12, type=x700102_g_MonsterOriType, num=30},
														{hash=13, type=x700102_g_MonsterOriType, num=30},
														{hash=14, type=x700102_g_MonsterOriType, num=30},
														{hash=15, type=x700102_g_MonsterOriType, num=30},
														{hash=16, type=x700102_g_MonsterOriType, num=30}
													}

x700102_g_BossCreate							=	{
														{	hash=1, type=x700102_g_BossMonsterType, x=44.2693, z=163.8265, ai=0, aiscript=0	},
														{	hash=2, type=x700102_g_BossMonsterType, x=45.9949, z=164.3921, ai=0, aiscript=0	},
														{	hash=3, type=x700102_g_BossMonsterType, x=46.6159, z=165.9363, ai=0, aiscript=0	},
														{	hash=4, type=x700102_g_BossMonsterType, x=47.3872, z=166.408, ai=0, aiscript=0	}
													}

x700102_GhostCreate								= 	{
														{type=x700102_g_GhostMonsterType}
													}

x700102_g_MonsterGroup							=	{
														{
															{	hash=1, type=x700102_g_MonsterType[1].type, x=64.136, z=51.1282	}
														},
														{
															{	hash=2, type=x700102_g_MonsterType[2].type, x=73.6606, z=53.9228	}
														},
														{
															{	hash=3, type=x700102_g_MonsterType[3].type, x=77.418, z=62.9634	}
														},
														{
															{	hash=4, type=x700102_g_MonsterType[4].type, x=73.065, z=72.1823	}
														},
														{
															{	hash=5, type=x700102_g_MonsterType[5].type, x=63.8089, z=75.7782	}
														},
														{
															{	hash=6, type=x700102_g_MonsterType[6].type, x=54.8653, z=71.6017	}
														},
														{
															{	hash=7, type=x700102_g_MonsterType[7].type, x=50.7731, z=63.2077	}
														},
														{
															{	hash=8, type=x700102_g_MonsterType[8].type, x=54.9799, z=54.0791	}
														},

														{
															{	hash=9, type=x700102_g_MonsterType[9].type, x=62.3598, z=27.7447	},
															{	hash=9, type=x700102_g_MonsterType[9].type, x=63.63, z=28.7537	},
															{	hash=9, type=x700102_g_MonsterType[9].type, x=65.3307, z=28.7099	},
															{	hash=9, type=x700102_g_MonsterType[9].type, x=66.1843, z=27.6602	},
															{	hash=9, type=x700102_g_MonsterType[9].type, x=63.5998, z=26.9506	},
															{	hash=9, type=x700102_g_MonsterType[9].type, x=65.1317, z=26.9861	},
															{	hash=9, type=x700102_g_MonsterType[9].type, x=62.5715, z=17.888	},
															{	hash=9, type=x700102_g_MonsterType[9].type, x=64.8207, z=17.8545	},
															{	hash=9, type=x700102_g_MonsterType[9].type, x=61.2303, z=19.506	},
															{	hash=9, type=x700102_g_MonsterType[9].type, x=63.1008, z=20.5481	},
															{	hash=9, type=x700102_g_MonsterType[9].type, x=65.2848, z=20.3564	},
															{	hash=9, type=x700102_g_MonsterType[9].type, x=66.2317, z=18.8982	},
															{	hash=9, type=x700102_g_MonsterType[9].type, x=69.4365, z=23.3183	},
															{	hash=9, type=x700102_g_MonsterType[9].type, x=71.1823, z=23.1047	},
															{	hash=9, type=x700102_g_MonsterType[9].type, x=68.6021, z=24.3845	},
															{	hash=9, type=x700102_g_MonsterType[9].type, x=70.1628, z=25.2593	},
															{	hash=9, type=x700102_g_MonsterType[9].type, x=71.6213, z=24.9943	},
															{	hash=9, type=x700102_g_MonsterType[9].type, x=72.1324, z=23.839	},
															{	hash=9, type=x700102_g_MonsterType[9].type, x=67.081, z=12.0985	},
															{	hash=9, type=x700102_g_MonsterType[9].type, x=69.0411, z=12.0244	},
															{	hash=9, type=x700102_g_MonsterType[9].type, x=66.5746, z=13.4974	},
															{	hash=9, type=x700102_g_MonsterType[9].type, x=67.577, z=14.6532	},
															{	hash=9, type=x700102_g_MonsterType[9].type, x=69.2464, z=14.489	},
															{	hash=9, type=x700102_g_MonsterType[9].type, x=69.8557, z=13.1946	},
															{	hash=9, type=x700102_g_MonsterType[9].type, x=55.2115, z=18.2896	},
															--{	hash=9, type=x700102_g_MonsterType[9].type, x=57.3661, z=18.0178	},
															--{	hash=9, type=x700102_g_MonsterType[9].type, x=54.4868, z=19.9828	},
															--{	hash=9, type=x700102_g_MonsterType[9].type, x=58.5165, z=19.5932	},
															--{	hash=9, type=x700102_g_MonsterType[9].type, x=56.0177, z=21.0042	},
															--{	hash=9, type=x700102_g_MonsterType[9].type, x=57.4247, z=20.8556	}
														},
														{
															{	hash=10, type=x700102_g_MonsterType[10].type, x=89.0049, z=37.6407	},
															{	hash=10, type=x700102_g_MonsterType[10].type, x=90.2389, z=38.7736	},
															{	hash=10, type=x700102_g_MonsterType[10].type, x=90.5322, z=37.3458	},
															{	hash=10, type=x700102_g_MonsterType[10].type, x=88.3604, z=38.7831	},
															{	hash=10, type=x700102_g_MonsterType[10].type, x=89.2288, z=39.6128	},
															{	hash=10, type=x700102_g_MonsterType[10].type, x=95.9308, z=39.0146	},
															{	hash=10, type=x700102_g_MonsterType[10].type, x=97.4061, z=39.6197	},
															{	hash=10, type=x700102_g_MonsterType[10].type, x=95.2604, z=40.3827	},
															{	hash=10, type=x700102_g_MonsterType[10].type, x=97.3196, z=40.7598	},
															{	hash=10, type=x700102_g_MonsterType[10].type, x=96.0411, z=41.1227	},
															{	hash=10, type=x700102_g_MonsterType[10].type, x=89.8472, z=31.6107	},
															{	hash=10, type=x700102_g_MonsterType[10].type, x=89.2651, z=30.0028	},
															{	hash=10, type=x700102_g_MonsterType[10].type, x=88.6128, z=32.5675	},
															{	hash=10, type=x700102_g_MonsterType[10].type, x=88.0165, z=29.5441	},
															{	hash=10, type=x700102_g_MonsterType[10].type, x=87.5716, z=31.3935	},
															{	hash=10, type=x700102_g_MonsterType[10].type, x=94.9389, z=24.1484	},
															{	hash=10, type=x700102_g_MonsterType[10].type, x=93.3098, z=25.5171	},
															{	hash=10, type=x700102_g_MonsterType[10].type, x=96.4197, z=25.5949	},
															{	hash=10, type=x700102_g_MonsterType[10].type, x=93.9506, z=26.8838	},
															{	hash=10, type=x700102_g_MonsterType[10].type, x=95.6157, z=26.6763	},
															{	hash=10, type=x700102_g_MonsterType[10].type, x=101.5495, z=31.058	},
															{	hash=10, type=x700102_g_MonsterType[10].type, x=103.0633, z=31.3823	},
															{	hash=10, type=x700102_g_MonsterType[10].type, x=100.8014, z=32.1599	},
															{	hash=10, type=x700102_g_MonsterType[10].type, x=101.3106, z=33.7497	},
															{	hash=10, type=x700102_g_MonsterType[10].type, x=103.2033, z=33.1547	},
															--{	hash=10, type=x700102_g_MonsterType[10].type, x=93.9975, z=31.5718	},
															--{	hash=10, type=x700102_g_MonsterType[10].type, x=95.2556, z=32.4214	},
															--{	hash=10, type=x700102_g_MonsterType[10].type, x=96.8239, z=33.2935	},
															--{	hash=10, type=x700102_g_MonsterType[10].type, x=94.2409, z=34.217	},
															--{	hash=10, type=x700102_g_MonsterType[10].type, x=95.9156, z=30.5115	}
														},
														{
															{	hash=11, type=x700102_g_MonsterType[11].type, x=100.9645, z=63.2891	},
															{	hash=11, type=x700102_g_MonsterType[11].type, x=99.7494, z=63.2857	},
															{	hash=11, type=x700102_g_MonsterType[11].type, x=99.8592, z=62.3106	},
															{	hash=11, type=x700102_g_MonsterType[11].type, x=99.757, z=64.444	},
															{	hash=11, type=x700102_g_MonsterType[11].type, x=98.6482, z=63.363	},
															{	hash=11, type=x700102_g_MonsterType[11].type, x=97.4608, z=63.4212	},
															{	hash=11, type=x700102_g_MonsterType[11].type, x=111.8603, z=62.9013	},
															{	hash=11, type=x700102_g_MonsterType[11].type, x=114.048, z=62.7645	},
															{	hash=11, type=x700102_g_MonsterType[11].type, x=113.8744, z=61.4594	},
															{	hash=11, type=x700102_g_MonsterType[11].type, x=113.6089, z=64.025	},
															{	hash=11, type=x700102_g_MonsterType[11].type, x=115.8281, z=62.8166	},
															{	hash=11, type=x700102_g_MonsterType[11].type, x=117.3021, z=62.8168	},
															{	hash=11, type=x700102_g_MonsterType[11].type, x=107.0764, z=68.3736	},
															{	hash=11, type=x700102_g_MonsterType[11].type, x=107.062, z=69.6849	},
															{	hash=11, type=x700102_g_MonsterType[11].type, x=107.0983, z=71.0827	},
															{	hash=11, type=x700102_g_MonsterType[11].type, x=107.2045, z=72.3744	},
															{	hash=11, type=x700102_g_MonsterType[11].type, x=105.5631, z=70.1314	},
															{	hash=11, type=x700102_g_MonsterType[11].type, x=108.5623, z=70.2673	},
															{	hash=11, type=x700102_g_MonsterType[11].type, x=107.0409, z=53.5109	},
															{	hash=11, type=x700102_g_MonsterType[11].type, x=107.1, z=54.8416	},
															{	hash=11, type=x700102_g_MonsterType[11].type, x=107.1305, z=56.0224	},
															{	hash=11, type=x700102_g_MonsterType[11].type, x=107.1682, z=57.4655	},
															{	hash=11, type=x700102_g_MonsterType[11].type, x=108.8497, z=56.0779	},
															{	hash=11, type=x700102_g_MonsterType[11].type, x=105.6171, z=56.0449	},
															{	hash=11, type=x700102_g_MonsterType[11].type, x=108.9207, z=62.8961	},
														--	{	hash=11, type=x700102_g_MonsterType[11].type, x=106.9137, z=63.0178	},
														--	{	hash=11, type=x700102_g_MonsterType[11].type, x=105.0952, z=63.1094	},
														--{	hash=11, type=x700102_g_MonsterType[11].type, x=103.8634, z=63.1832	},
															--{	hash=11, type=x700102_g_MonsterType[11].type, x=106.9915, z=61.4845	},
															--{	hash=11, type=x700102_g_MonsterType[11].type, x=106.9543, z=64.5664	}
														},
														{
															{	hash=12, type=x700102_g_MonsterType[12].type, x=89.4559, z=89.114	},
															{	hash=12, type=x700102_g_MonsterType[12].type, x=89.6517, z=87.9753	},
															{	hash=12, type=x700102_g_MonsterType[12].type, x=88.0973, z=89.444	},
															{	hash=12, type=x700102_g_MonsterType[12].type, x=87.1472, z=86.9939	},
															{	hash=12, type=x700102_g_MonsterType[12].type, x=88.4701, z=88.2753	},
															{	hash=12, type=x700102_g_MonsterType[12].type, x=97.8809, z=96.2212	},
															{	hash=12, type=x700102_g_MonsterType[12].type, x=99.5334, z=96.1533	},
															{	hash=12, type=x700102_g_MonsterType[12].type, x=98.07, z=97.9655	},
															{	hash=12, type=x700102_g_MonsterType[12].type, x=99.5976, z=97.8477	},
															{	hash=12, type=x700102_g_MonsterType[12].type, x=101.3326, z=99.1697	},
															{	hash=12, type=x700102_g_MonsterType[12].type, x=90.4638, z=97.4087	},
															{	hash=12, type=x700102_g_MonsterType[12].type, x=90.7386, z=99.1474	},
															{	hash=12, type=x700102_g_MonsterType[12].type, x=88.9563, z=97.6529	},
															{	hash=12, type=x700102_g_MonsterType[12].type, x=89.2504, z=99.1653	},
															{	hash=12, type=x700102_g_MonsterType[12].type, x=88.3861, z=100.3577	},
															{	hash=12, type=x700102_g_MonsterType[12].type, x=95.4514, z=88.5742	},
															{	hash=12, type=x700102_g_MonsterType[12].type, x=93.7979, z=87.9573	},
															{	hash=12, type=x700102_g_MonsterType[12].type, x=96.635, z=87.6215	},
															{	hash=12, type=x700102_g_MonsterType[12].type, x=95.4133, z=87.1494	},
															{	hash=12, type=x700102_g_MonsterType[12].type, x=95.3255, z=86.1944	},
															{	hash=12, type=x700102_g_MonsterType[12].type, x=99.3709, z=91.7384	},
															{	hash=12, type=x700102_g_MonsterType[12].type, x=99.6929, z=90.838	},
															{	hash=12, type=x700102_g_MonsterType[12].type, x=100.7836, z=92.5815	},
															{	hash=12, type=x700102_g_MonsterType[12].type, x=101.1206, z=91.6304	},
															{	hash=12, type=x700102_g_MonsterType[12].type, x=102.4583, z=91.2656	},
															--{	hash=12, type=x700102_g_MonsterType[12].type, x=95.9191, z=93.8822	},
															--{	hash=12, type=x700102_g_MonsterType[12].type, x=94.9649, z=95.2041	},
															--{	hash=12, type=x700102_g_MonsterType[12].type, x=93.1755, z=95.3241	},
															--{	hash=12, type=x700102_g_MonsterType[12].type, x=94.5205, z=92.3987	},
															--{	hash=12, type=x700102_g_MonsterType[12].type, x=92.9986, z=93.4909	}
														},
														{
															{	hash=13, type=x700102_g_MonsterType[13].type, x=63.7375, z=97.0688	},
															{	hash=13, type=x700102_g_MonsterType[13].type, x=64.6891, z=97.9998	},
															{	hash=13, type=x700102_g_MonsterType[13].type, x=62.9205, z=98.0571	},
															{	hash=13, type=x700102_g_MonsterType[13].type, x=65.4272, z=98.9787	},
															{	hash=13, type=x700102_g_MonsterType[13].type, x=63.8385, z=99.2897	},
															{	hash=13, type=x700102_g_MonsterType[13].type, x=62.2363, z=99.1254	},
															{	hash=13, type=x700102_g_MonsterType[13].type, x=66.2034, z=110.8532	},
															{	hash=13, type=x700102_g_MonsterType[13].type, x=64.1821, z=111.0997	},
															{	hash=13, type=x700102_g_MonsterType[13].type, x=62.3026, z=110.8438	},
															{	hash=13, type=x700102_g_MonsterType[13].type, x=65.3114, z=112.072	},
															{	hash=13, type=x700102_g_MonsterType[13].type, x=63.0187, z=112.1694	},
															{	hash=13, type=x700102_g_MonsterType[13].type, x=64.2484, z=113.5868	},
															{	hash=13, type=x700102_g_MonsterType[13].type, x=58.5148, z=108.2306	},
															{	hash=13, type=x700102_g_MonsterType[13].type, x=58.2363, z=106.5527	},
															{	hash=13, type=x700102_g_MonsterType[13].type, x=58.2085, z=104.8985	},
															{	hash=13, type=x700102_g_MonsterType[13].type, x=57.0977, z=107.7163	},
															{	hash=13, type=x700102_g_MonsterType[13].type, x=56.9553, z=106.0284	},
															{	hash=13, type=x700102_g_MonsterType[13].type, x=55.657, z=107.0409	},
															{	hash=13, type=x700102_g_MonsterType[13].type, x=69.4605, z=107.9484	},
															{	hash=13, type=x700102_g_MonsterType[13].type, x=69.4385, z=106.1859	},
															{	hash=13, type=x700102_g_MonsterType[13].type, x=69.0446, z=104.4048	},
															{	hash=13, type=x700102_g_MonsterType[13].type, x=70.807, z=107.1347	},
															{	hash=13, type=x700102_g_MonsterType[13].type, x=70.7787, z=105.2607	},
															{	hash=13, type=x700102_g_MonsterType[13].type, x=72.1766, z=106.3084	},
															{	hash=13, type=x700102_g_MonsterType[13].type, x=64.03, z=107.9268	},
														--	{	hash=13, type=x700102_g_MonsterType[13].type, x=63.8798, z=104.6772	},
															--{	hash=13, type=x700102_g_MonsterType[13].type, x=65.8612, z=106.2946	},
															--{	hash=13, type=x700102_g_MonsterType[13].type, x=61.9608, z=106.1673	},
															--{	hash=13, type=x700102_g_MonsterType[13].type, x=64.353, z=106.7381	},
															--{	hash=13, type=x700102_g_MonsterType[13].type, x=63.389, z=106.1211	}
														},
														{
															{	hash=14, type=x700102_g_MonsterType[14].type, x=40.2908, z=88.0599	},
															{	hash=14, type=x700102_g_MonsterType[14].type, x=38.6585, z=86.5226	},
															{	hash=14, type=x700102_g_MonsterType[14].type, x=38.3853, z=88.0967	},
															{	hash=14, type=x700102_g_MonsterType[14].type, x=38.8109, z=89.3643	},
															{	hash=14, type=x700102_g_MonsterType[14].type, x=37.0036, z=87.4209	},
															{	hash=14, type=x700102_g_MonsterType[14].type, x=34.7381, z=101.8136	},
															{	hash=14, type=x700102_g_MonsterType[14].type, x=32.8933, z=100.5485	},
															{	hash=14, type=x700102_g_MonsterType[14].type, x=34.4995, z=100.4395	},
															{	hash=14, type=x700102_g_MonsterType[14].type, x=35.9091, z=100.4317	},
															{	hash=14, type=x700102_g_MonsterType[14].type, x=34.4011, z=99.1162	},
															{	hash=14, type=x700102_g_MonsterType[14].type, x=26.0633, z=95.8897	},
															{	hash=14, type=x700102_g_MonsterType[14].type, x=24.6632, z=94.5084	},
															{	hash=14, type=x700102_g_MonsterType[14].type, x=26.1209, z=94.5733	},
															{	hash=14, type=x700102_g_MonsterType[14].type, x=27.5718, z=94.5551	},
															{	hash=14, type=x700102_g_MonsterType[14].type, x=26.0566, z=92.9914	},
															{	hash=14, type=x700102_g_MonsterType[14].type, x=30.5776, z=86.3133	},
															{	hash=14, type=x700102_g_MonsterType[14].type, x=29.1974, z=86.1497	},
															{	hash=14, type=x700102_g_MonsterType[14].type, x=29.4664, z=84.8969	},
															{	hash=14, type=x700102_g_MonsterType[14].type, x=29.0085, z=87.1663	},
															{	hash=14, type=x700102_g_MonsterType[14].type, x=27.7507, z=85.7544	},
															{	hash=14, type=x700102_g_MonsterType[14].type, x=41.1434, z=94.3947	},
															{	hash=14, type=x700102_g_MonsterType[14].type, x=40.2886, z=92.9025	},
															{	hash=14, type=x700102_g_MonsterType[14].type, x=39.9104, z=94.3133	},
															{	hash=14, type=x700102_g_MonsterType[14].type, x=40.0237, z=95.5131	},
															{	hash=14, type=x700102_g_MonsterType[14].type, x=38.8016, z=93.7766	},
														--	{	hash=14, type=x700102_g_MonsterType[14].type, x=33.3216, z=93.6405	},
															--{	hash=14, type=x700102_g_MonsterType[14].type, x=34.9268, z=93.9511	},
															--{	hash=14, type=x700102_g_MonsterType[14].type, x=31.4254, z=93.3417	},
															--{	hash=14, type=x700102_g_MonsterType[14].type, x=33.5362, z=91.6779	},
															--{	hash=14, type=x700102_g_MonsterType[14].type, x=33.182, z=95.4866	}
														},
														{
															{	hash=15, type=x700102_g_MonsterType[15].type, x=29.266, z=64.0957	},
															{	hash=15, type=x700102_g_MonsterType[15].type, x=27.8024, z=64.1277	},
															{	hash=15, type=x700102_g_MonsterType[15].type, x=26.5032, z=64.0326	},
															{	hash=15, type=x700102_g_MonsterType[15].type, x=26.3512, z=62.7233	},
															{	hash=15, type=x700102_g_MonsterType[15].type, x=27.5761, z=62.528	},
															{	hash=15, type=x700102_g_MonsterType[15].type, x=29.0905, z=62.4868	},
															{	hash=15, type=x700102_g_MonsterType[15].type, x=23.1152, z=57.8379	},
															{	hash=15, type=x700102_g_MonsterType[15].type, x=23.1699, z=56.2305	},
															{	hash=15, type=x700102_g_MonsterType[15].type, x=23.2729, z=54.5853	},
															{	hash=15, type=x700102_g_MonsterType[15].type, x=20.8671, z=57.4516	},
															{	hash=15, type=x700102_g_MonsterType[15].type, x=20.8948, z=55.9782	},
															{	hash=15, type=x700102_g_MonsterType[15].type, x=20.9288, z=54.1874	},
															{	hash=15, type=x700102_g_MonsterType[15].type, x=13.198, z=64.5162	},
															{	hash=15, type=x700102_g_MonsterType[15].type, x=12.8623, z=62.9307	},
															{	hash=15, type=x700102_g_MonsterType[15].type, x=14.4305, z=64.2343	},
															{	hash=15, type=x700102_g_MonsterType[15].type, x=15.9689, z=64.1741	},
															{	hash=15, type=x700102_g_MonsterType[15].type, x=14.31, z=62.7691	},
															{	hash=15, type=x700102_g_MonsterType[15].type, x=16.0243, z=62.7597	},
															{	hash=15, type=x700102_g_MonsterType[15].type, x=20.444, z=71.8293	},
															{	hash=15, type=x700102_g_MonsterType[15].type, x=20.3114, z=70.7513	},
															{	hash=15, type=x700102_g_MonsterType[15].type, x=20.2373, z=69.2348	},
															{	hash=15, type=x700102_g_MonsterType[15].type, x=22.8481, z=68.9635	},
															{	hash=15, type=x700102_g_MonsterType[15].type, x=23.0417, z=70.1618	},
															{	hash=15, type=x700102_g_MonsterType[15].type, x=23.1326, z=71.6676	},
															{	hash=15, type=x700102_g_MonsterType[15].type, x=19.4508, z=64.1868	},
														--	{	hash=15, type=x700102_g_MonsterType[15].type, x=19.3253, z=62.5877	},
															--{	hash=15, type=x700102_g_MonsterType[15].type, x=19.1465, z=61.0049	},
															--{	hash=15, type=x700102_g_MonsterType[15].type, x=21.3556, z=63.8925	},
															--{	hash=15, type=x700102_g_MonsterType[15].type, x=21.1916, z=62.0609	},
															--{	hash=15, type=x700102_g_MonsterType[15].type, x=21.0433, z=60.6697	}
														},
														{
															{	hash=16, type=x700102_g_MonsterType[16].type, x=38.0373, z=38.4226	},
															{	hash=16, type=x700102_g_MonsterType[16].type, x=39.6595, z=36.6852	},
															{	hash=16, type=x700102_g_MonsterType[16].type, x=38.0984, z=36.778	},
															{	hash=16, type=x700102_g_MonsterType[16].type, x=36.9305, z=37.3003	},
															{	hash=16, type=x700102_g_MonsterType[16].type, x=38.4376, z=35.4819	},
															{	hash=16, type=x700102_g_MonsterType[16].type, x=32.6354, z=40.4872	},
															{	hash=16, type=x700102_g_MonsterType[16].type, x=30.3596, z=40.23	},
															{	hash=16, type=x700102_g_MonsterType[16].type, x=30.7199, z=37.7343	},
															{	hash=16, type=x700102_g_MonsterType[16].type, x=32.9148, z=37.9713	},
															{	hash=16, type=x700102_g_MonsterType[16].type, x=31.1185, z=39.007	},
															{	hash=16, type=x700102_g_MonsterType[16].type, x=24.5319, z=33.4057	},
															{	hash=16, type=x700102_g_MonsterType[16].type, x=24.1777, z=30.2515	},
															{	hash=16, type=x700102_g_MonsterType[16].type, x=26.9869, z=30.3042	},
															{	hash=16, type=x700102_g_MonsterType[16].type, x=27.29, z=33.1373	},
															{	hash=16, type=x700102_g_MonsterType[16].type, x=25.6691, z=31.5657	},
															{	hash=16, type=x700102_g_MonsterType[16].type, x=31.4251, z=32.7082	},
															{	hash=16, type=x700102_g_MonsterType[16].type, x=33.3058, z=30.1069	},
															{	hash=16, type=x700102_g_MonsterType[16].type, x=32.6842, z=34.2069	},
															{	hash=16, type=x700102_g_MonsterType[16].type, x=35.242, z=33.1523	},
															{	hash=16, type=x700102_g_MonsterType[16].type, x=35.1447, z=30.8388	},
															{	hash=16, type=x700102_g_MonsterType[16].type, x=31.1505, z=25.4688	},
															{	hash=16, type=x700102_g_MonsterType[16].type, x=32.2612, z=22.3874	},
															{	hash=16, type=x700102_g_MonsterType[16].type, x=33.3262, z=26.0961	},
															{	hash=16, type=x700102_g_MonsterType[16].type, x=32.7258, z=24.0055	},
															{	hash=16, type=x700102_g_MonsterType[16].type, x=34.8109, z=23.5705	},
														--	{	hash=16, type=x700102_g_MonsterType[16].type, x=39.2062, z=30.4829	},
														--	{	hash=16, type=x700102_g_MonsterType[16].type, x=39.6806, z=27.993	},
														--	{	hash=16, type=x700102_g_MonsterType[16].type, x=41.4739, z=28.2622	},
														--	{	hash=16, type=x700102_g_MonsterType[16].type, x=41.2757, z=30.6513	},
														--	{	hash=16, type=x700102_g_MonsterType[16].type, x=40.1814, z=29.2664	}
														}
													}

-------------------------
--***********************
--Define
--***********************
-------------------------

x700102_OK							= 0
x700102_OK_RETURN				= 1
x700102_ERROR_UNKNOWN		= -1

x700102_FAILED_COUNTRY	= 10
x700102_FAILED_LEVEL		= 11
x700102_FAILED_DAYCOUNT	= 12
x700102_FAILED_TEAM			= 13
x700102_FAILED_TEAMNUM	= 14
x700102_FAILED_CAPTAIN	= 15

x700102_FAILED_OTHERLEVEL			= 20
x700102_FAILED_OTHERDAYCOUNT	= 21
x700102_FAILED_OTHERMISSION		= 22
x700102_FAILED_OTHERAROUND		= 23

x700102_MP_AIMSCENE			= 0
x700102_MP_TEAMID				= 1
x700102_MP_KILLMONSTER	= 2
x700102_MP_ISCOMPLETE		= 7

x700102_CSP_FUBENTYPE							= 0																		--参数位置
x700102_CSP_SCRIPTID							= 1
x700102_CSP_TICKCOUNT							= 2
x700102_CSP_FROMSCENEID							= 3
x700102_CSP_ISCLOSING							= 4
x700102_CSP_LEAVECOUNTDOWN						= 5
x700102_CSP_TEAMID								= 6
x700102_CSP_NALLMONSTER							= 7
x700102_CSP_NKILLMONSTER						= 8
x700102_CSP_MONSTERSTATE						= 9
x700102_CSP_BOSSSTATE							= 10
x700102_CSP_DOORMONSTER_1						= 11
x700102_CSP_DOORMONSTER_2						= 12
x700102_CSP_DOORMONSTER_3						= 13
x700102_CSP_DOORMONSTER_4						= 14
x700102_CSP_DOORMONSTER_5						= 15
x700102_CSP_DOORMONSTER_6						= 16
x700102_CSP_DOORMONSTER_7						= 17
x700102_CSP_DOORMONSTER_8						= 18
x700102_CSP_TIMEOUT_STATE						= 19                                                                    --超时所处于的阶段
x700102_CSP_TIMEOUT_STATE_BEGIN					= 20                                                                    --每个阶段的开始时间
x700102_CSP_KILLMONSTER_SHIDUNV					= 21																	--杀死施毒女数量
x700102_CSP_KILLMONSTER_JIANPOPO				= 22																	--杀死剑婆婆数量
x700102_CSP_KILLMONSTER_DULAOFU					= 23																	--杀死毒老妇数量
x700102_CSP_KILLMONSTER_SHIDUNV_GAOJI			= 24																	--杀死高级施毒女数量
x700102_CSP_KILLMONSTER_JIANPOPO_GAOJI			= 25																	--杀死高级剑婆婆数量
x700102_CSP_KILLMONSTER_DULAOFU_GAOJI			= 26																	--杀死高级毒老妇数量

x700102_g_area_monster_info						=	{}

x700102_g_area_monster_info[x700102_g_Monster_ShiDuNu] 			= {DataParamIndex = x700102_CSP_KILLMONSTER_SHIDUNV}
x700102_g_area_monster_info[x700102_g_Monster_ShiDuNu_Gaoji] 	= {DataParamIndex = x700102_CSP_KILLMONSTER_SHIDUNV_GAOJI}
x700102_g_area_monster_info[x700102_g_Monster_JianPoPo] 		= {DataParamIndex = x700102_CSP_KILLMONSTER_JIANPOPO}
x700102_g_area_monster_info[x700102_g_Monster_JianPoPo_Gaoji] 	= {DataParamIndex = x700102_CSP_KILLMONSTER_JIANPOPO_GAOJI}
x700102_g_area_monster_info[x700102_g_Monster_DulaoFu] 			= {DataParamIndex = x700102_CSP_KILLMONSTER_DULAOFU}
x700102_g_area_monster_info[x700102_g_Monster_DulaoFu_Gaoji] 	= {DataParamIndex = x700102_CSP_KILLMONSTER_DULAOFU_GAOJI}

x700102_g_area_kill_monster_info								=
																	{
																		{hash=1, desc="杀死施毒女%d/8", pos1=x700102_CSP_KILLMONSTER_SHIDUNV, pos2 = 0},
																		{hash=2, desc="杀死施毒女%d/8, 高级施毒女%d/4", pos1=x700102_CSP_KILLMONSTER_SHIDUNV,pos2=x700102_CSP_KILLMONSTER_SHIDUNV_GAOJI},
																		{hash=3, desc="杀死剑婆婆%d/10", pos1=x700102_CSP_KILLMONSTER_JIANPOPO, pos2 = 0},
																		{hash=4, desc="杀死剑婆婆%d/10, 高级剑婆婆%d/4", pos1=x700102_CSP_KILLMONSTER_JIANPOPO,pos2=x700102_CSP_KILLMONSTER_JIANPOPO_GAOJI},
																		{hash=5, desc="杀死毒老妇%d/6", pos1=x700102_CSP_KILLMONSTER_DULAOFU, pos2 = 0},
																		{hash=6, desc="杀死毒老妇%d/6, 高级毒老妇%d/4", pos1=x700102_CSP_KILLMONSTER_DULAOFU, pos2=x700102_CSP_KILLMONSTER_DULAOFU_GAOJI},
																		{hash=7, desc="杀死剑婆婆%d/3, 杀死毒老妇%d/3", pos1=x700102_CSP_KILLMONSTER_JIANPOPO, pos2=x700102_CSP_KILLMONSTER_DULAOFU},
																	}


-------------------------
--***********************
--OnDefaultEvent
--***********************
-------------------------

function x700102_OnDefaultEvent(sceneId, selfId, NPCId)

	local safeCheckRet, otherRet = x700102_SafeNPCCheck(sceneId, selfId, NPCId);
	local bHaveMission = IsHaveMission(sceneId, selfId, x700102_g_MissionId);
	local misIndex;
	local str = x700102_g_MissionName.."\n";
	local dispatchType = 0;
	local bDone = 0;

	--PrintStr('x700102_OnDefaultEvent' .. tostring(safeCheckRet));

	if bHaveMission > 0 then
		--PrintStr('x700102_OnDefaultEvent' .. tostring(bHaveMission));
		misIndex = GetMissionIndexByID(sceneId, selfId, x700102_g_MissionId);
		bDone = x700102_CheckSubmit(sceneId, selfId);

		if bDone > 0 then
			str = str..x700102_g_MissionComplete;
			dispatchType = 2;
		else
			str = str..x700102_g_ContinueInfo;
			dispatchType = 1;
		end
	elseif safeCheckRet == x700102_OK or safeCheckRet == x700102_OK_RETURN then
		str = str..x700102_g_MissionInfo;
		dispatchType = 1;
	else
		dispatchType = 4;
		if safeCheckRet == x700102_FAILED_CAPTAIN then
			str = x700102_g_ErrorMessage_Captain;
		elseif safeCheckRet == x700102_FAILED_TEAM then
			str = x700102_g_ErrorMessage_Team;
		elseif safeCheckRet == x700102_FAILED_TEAMNUM then
			str = x700102_g_ErrorMessage_TeamNum;
		elseif safeCheckRet == x700102_FAILED_COUNTRY then
			str = x700102_g_ErrorMessage_Country;
		elseif safeCheckRet == x700102_FAILED_LEVEL then
			str = x700102_g_ErrorMessage_Level;
		elseif safeCheckRet == x700102_FAILED_DAYCOUNT then
			str = x700102_g_ErrorMessage_DayCount;
		else
			local otherName = x700102_g_SomeoneInTeam;
			if otherRet >= 0 then
				otherName = GetName(sceneId, otherRet);
			end
			if safeCheckRet == x700102_FAILED_OTHERLEVEL then
				str = format(x700102_g_ErrorMessage_OtherLevel, otherName, x700102_g_LevelLess);
			elseif safeCheckRet == x700102_FAILED_OTHERMISSION then
				str = format(x700102_g_ErrorMessage_OtherMission, otherName);
			elseif safeCheckRet == x700102_FAILED_OTHERAROUND then
				str = format(x700102_g_ErrorMessage_OtherAround, otherName);
			elseif safeCheckRet == x700102_FAILED_OTHERDAYCOUNT then
				str = format(x700102_g_ErrorMessage_OtherDayCount, otherName);
			end
		end
	end

	BeginEvent(sceneId);
		AddText(sceneId, str);
	EndEvent();

	if dispatchType == 1 then
		DispatchMissionInfo(sceneId, selfId, NPCId, x700102_g_ScriptId, x700102_g_MissionId);
	elseif dispatchType == 2 then
		if bDone > 0 then
			DispatchMissionContinueInfo(sceneId, selfId, NPCId, x700102_g_ScriptId, x700102_g_MissionId);
		else
			DispatchEventList(sceneId, selfId, NPCId);
		end
	elseif dispatchType == 3 then
		DispatchEventList(sceneId, selfId, NPCId);
	else
		DispatchMissionTips(sceneId, selfId);
	end

end

-------------------------
--***********************
--OnEnumerate
--***********************
-------------------------

function x700102_OnEnumerate(sceneId, selfId, NPCId)
    --PrintNum(sceneId);
	if x700102_SafeDisplayCheck(sceneId, selfId, NPCId) > 0 then
		AddNumText(sceneId, x700102_g_ScriptId, x700102_g_MissionName);
	end

end

-------------------------
--***********************
--SafeDisplayCheck
--***********************
-------------------------

function x700102_SafeDisplayCheck(sceneId, selfId, NPCId)

	local bHaveMission = IsHaveMission(sceneId, selfId, x700102_g_MissionId);

	if bHaveMission > 0 then
		return 1;
	end

	local bIsMissionNPC = x700102_IsMissionNPC(sceneId, selfId, x700102_g_MissionId, NPCId);

	--PrintStr('x700102_SafeDisplayCheck bIsMissionNPC=' .. tostring(bIsMissionNPC));

	if  bIsMissionNPC > 0 then
		return 1;

	--
	--	local nowtime = LuaFnGetCurrentTime();
	--	nowtime = nowtime - floor(nowtime / 86400) * 86400;
	--	nowtime = floor(nowtime / 60) + 60 * x700102_g_TimeZoneBias;
	--	for i, item in pairs(x700102_g_EnterTime) do
	--		if nowtime >= item.min and nowtime < item.max then
	--			return 1;
	--		end
	--	end
	--
	end

	return 0;

end

-------------------------
--***********************
--IsMissionNPC
--***********************
-------------------------

function x700102_IsMissionNPC(sceneId, selfId, missionId, NPCId)
	for i, item in pairs(x700102_g_MissionNPCName) do
		if item.scene == sceneId then
			if GetName(sceneId, NPCId) == item.name then
				return 1;
			end
		end
	end

	return 0;

end

-------------------------
--***********************
--CheckAllMemberLevel
--***********************
-------------------------

function x700102_CheckAllMemberLevel(sceneId, selfId, teamnum)

	for i = 0, teamnum - 1 do
		local memberId = GetNearTeamMember(sceneId, selfId, i);
		if GetLevel(sceneId, memberId) < x700102_g_LevelLess then
			return 0, memberId;
		end
	end

	return 1;

end

-------------------------
--***********************
--CheckAllMemberHaveMission
--***********************
-------------------------

function x700102_CheckAllMemberHaveMission(sceneId, selfId, teamnum)

	for i = 0, teamnum - 1 do
		local memberId = GetNearTeamMember(sceneId, selfId, i);
		if IsHaveMission(sceneId, memberId, x700102_g_MissionId) <= 0 then
--			return 0, memberId;
		end
	end

	return 1;

end

-------------------------
--***********************
--CheckAllMemberAround
--***********************
-------------------------

function x700102_CheckAllMemberAround(sceneId, selfId, teamnum)

	if GetNearTeamCount(sceneId, selfId) == teamnum then
		return 1;
	end

	return 0, -1;

end

-------------------------
--***********************
--CheckAllMemberDayCount
--***********************
-------------------------

--function x700102_CheckAllMemberDayCount(sceneId, selfId, teamnum)
--	for i = 0, teamnum - 1 do
--		local memberId = GetNearTeamMember(sceneId, selfId, i);
--		if x700102_GetDayCount(sceneId, memberId) > x700102_g_DayCountUntil then
--			return 0, memberId;
--		end
--	end
--	return 1;
--end

-------------------------
--***********************
--GetDayCount
--***********************
-------------------------

--function x700102_GetDayCount(sceneId, selfId)
--	local nowtime = LuaFnGetCurrentTime();
--	local today = floor(nowtime / 86400);
--  PrintNum(today)
--  PrintNum(GetMissionData(sceneId, selfId, MD_JUNYAOYAOKOU_DAYCOUNT))
--	if GetMissionData(sceneId, selfId, MD_JUNYAOYAOKOU_DAYCOUNT) ~= today then
--		return 0;
--	end
--	return 1;
--end

-------------------------
--***********************
--SetDayCount
--***********************
-------------------------

--function x700102_SetDayCount(sceneId, selfId)
--	local nowtime = LuaFnGetCurrentTime();
--	local today = floor(nowtime / 86400);
--	SetMissionData(sceneId, selfId, MD_JUNYAOYAOKOU_DAYCOUNT, today);
--end

-------------------------
--***********************
--SafeNPCCheck
--***********************
-------------------------

function x700102_SafeNPCCheck(sceneId, selfId, NPCId)

	bHaveMission = IsHaveMission(sceneId, selfId, x700102_g_MissionId);
	--PrintStr('bHaveMission ' .. tostring(bHaveMission));
    local teamid = GetTeamId(sceneId, selfId);
	if bHaveMission > 0 then

		misIndex = GetMissionIndexByID(sceneId, selfId, x700102_g_MissionId);
		aimsceneid = GetMissionParam(sceneId, selfId, misIndex, x700102_MP_AIMSCENE);
		aimteamid = GetMissionParam(sceneId, selfId, misIndex, x700102_MP_TEAMID);
		--PrintStr('aimsceneid ' .. tostring(aimsceneid));
        --PrintStr('teamid ' .. tostring(teamid));
        --PrintStr('aimteamid ' .. tostring(aimteamid));
		if aimsceneid >= 0 and teamid == aimteamid then
			return x700102_OK_RETURN;
		else
			return x700102_ERROR_UNKNOWN;
		end

	else

		local teamnum = GetTeamSize(sceneId, selfId);
		if GetLevel(sceneId, selfId) < x700102_g_LevelLess then
			return x700102_FAILED_LEVEL;
		--elseif x700102_GetDayCount(sceneId, selfId) > 0 then
		--	return x700102_FAILED_DAYCOUNT;
		elseif LuaFnIsTeamLeader(sceneId, selfId) <= 0 then
			return x700102_FAILED_CAPTAIN;
		elseif teamid < 0 then
			return x700102_FAILED_TEAM;
		elseif teamnum < x700102_g_LimitMembers then
			return x700102_FAILED_TEAMNUM;
		else

			local nearteamnum = GetNearTeamCount(sceneId, selfId);
			local ret, otherId;

			ret, otherId = x700102_CheckAllMemberLevel(sceneId, selfId, nearteamnum);
			if ret <= 0 then
				return x700102_FAILED_OTHERLEVEL, otherId;
			end
			--ret, otherId = x700102_CheckAllMemberDayCount(sceneId, selfId, nearteamnum);
			--if ret <= 0 then
			--	return x700102_FAILED_DAYCOUNT, otherId;
			--end
			ret, otherId = x700102_CheckAllMemberHaveMission(sceneId, selfId, nearteamnum);
			if ret <= 0 then
				return x700102_FAILED_OTHERMISSION, otherId;
			end
			ret, otherId = x700102_CheckAllMemberAround(sceneId, selfId, nearteamnum);
			if ret <= 0 then
				return x700102_FAILED_OTHERAROUND, otherId;
			end
			return x700102_OK;

		end
	end

	return x700102_ERROR_UNKNOWN;

end

-------------------------
--***********************
--CheckAccept
--***********************
-------------------------

function x700102_CheckAccept(sceneId, selfId, NPCId)

	--PrintStr('x700102_CheckAccept x700102_g_Monster_ShiDuNu=' .. tostring(x700102_g_area_monster_info[x700102_g_Monster_ShiDuNu].DataParamIndex));
	--PrintStr('x700102_g_area_monster_info[x700102_g_Monster_ShiDuNu]' ..  tostring(x700102_g_area_monster_info[x700102_g_Monster_ShiDuNu].DataParamIndex));

    local safeCheckRet = x700102_SafeNPCCheck(sceneId, selfId, NPCId);
   	--PrintStr('safeCheckRet ' .. tostring(safeCheckRet));
	if safeCheckRet == x700102_OK or safeCheckRet == x700102_OK_RETURN then
		return 1;
	end

	return 0;

end

-------------------------
--***********************
--OnAccept
--***********************
-------------------------

function x700102_OnAccept(sceneId, selfId, NPCId)

	bHaveMission = IsHaveMission(sceneId, selfId, x700102_g_MissionId);
	--PrintStr('bHaveMission ' .. tostring(bHaveMission));

	local teamId = GetTeamId(sceneId, selfId);

	if bHaveMission > 0 then

		local safeCheckRet = x700102_SafeNPCCheck(sceneId, selfId, NPCId);
		--PrintStr("safeCheckRet " .. tostring(safeCheckRet) .. " x700102_OK_RETURN " .. tostring(x700102_OK_RETURN))
		if safeCheckRet == x700102_OK_RETURN then
		    misIndex = GetMissionIndexByID(sceneId, selfId, x700102_g_MissionId);
		    --PrintStr("misIndex " .. tostring(misIndex))
			aimsceneid = GetMissionParam(sceneId, selfId, misIndex, x700102_MP_AIMSCENE);
			--PrintStr("aimsceneid " .. tostring(aimsceneid))
			--SCENE_STATUS_RUNNING
			--PrintNum(LuaFnGetSceneStatue(aimsceneid));
			if LuaFnGetSceneStatue(aimsceneid) == 4  then
			    NewWorld(sceneId, selfId, aimsceneid, x700102_g_Fuben_X, x700102_g_Fuben_Z);
			else
			    x700102_CancelMission(sceneId, selfId);
			end
		else
			BeginEvent(sceneId);
				AddText(x700102_g_ErrorMessage);
			EndEvent();
			DispatchMissionTips(sceneId, selfId);
			return 0;
		end

	else

		local memberNum = GetNearTeamCount(sceneId, selfId);
		for i = 0, memberNum - 1 do
			local memberId = GetNearTeamMember(sceneId, selfId, i);
			AddMission(sceneId, memberId, x700102_g_MissionId, x700102_g_ScriptId, 1, 0, 0);
			local misIndex = GetMissionIndexByID(sceneId, memberId, x700102_g_MissionId);
			SetMissionByIndex(sceneId, memberId, misIndex, x700102_MP_AIMSCENE, -1);
			SetMissionByIndex(sceneId, memberId, misIndex, x700102_MP_TEAMID, teamId);
			SetMissionByIndex(sceneId, memberId, misIndex, x700102_MP_ISCOMPLETE, 0);
			--x700102_SetDayCount(sceneId, selfId);
		end
        --PrintNum(1);
		x700102_MakeCopyScene(sceneId, selfId, memberNum);

	end

end

-------------------------
--***********************
--CalculateLevel
--***********************
-------------------------

function x700102_CalculateLevel(sceneId, selfId, memberNum)

	local totalLevel = 0;
	for i = 0, memberNum - 1 do
		local memberId = GetNearTeamMember(sceneId, selfId, i);
		totalLevel = totalLevel + GetLevel(sceneId, memberId);
	end

	return floor(totalLevel / memberNum);

end

-------------------------
--***********************
--MakeCopyScene
--***********************
-------------------------

function x700102_MakeCopyScene(sceneId, selfId, memberNum)

	local level = x700102_CalculateLevel(sceneId, selfId, memberNum);

	local leaderguid = LuaFnObjId2Guid(sceneId, selfId);
	LuaFnSetSceneLoad_Map(sceneId, x700102_g_SceneMapNavPath); --地图是必须选取的，而且必须在Config/SceneInfo.ini里配置好
	LuaFnSetCopySceneData_TeamLeader(sceneId, leaderguid);
	LuaFnSetCopySceneData_NoUserCloseTime(sceneId, x700102_g_NoUserTime * 1000);
	LuaFnSetCopySceneData_Timer(sceneId, x700102_g_TickTime * 1000);
	LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_FUBENTYPE, x700102_g_CopySceneType);--设置副本数据，这里将0号索引的数据设置为999，用于表示副本号999(数字自定义)
	LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_SCRIPTID, x700102_g_ScriptId);--将1号数据设置为副本场景事件脚本号
	LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TICKCOUNT, 0);--设置定时器调用次数
	LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_FROMSCENEID, -1);--设置副本入口场景号, 初始化
	LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_ISCLOSING, 0);--设置副本关闭标志, 0开放，1关闭
	LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_LEAVECOUNTDOWN, 0);--设置离开倒计时次数
	LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TEAMID, GetTeamId(sceneId, selfId)); --保存队伍号
	LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_NALLMONSTER, 0) ;--全部怪数量
	LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_NKILLMONSTER, 0) ;--杀死怪的数量
	LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_MONSTERSTATE, 0) ;
	LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_BOSSSTATE, 0) ;
	LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE, 1) ;        --默认的超时阶段设计为1
	LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE_BEGIN, LuaFnGetTickCount()) ;  --记录阶段开始时间

	x700102_ClearKillMonsterCount(sceneId);

	local bRetSceneID = LuaFnCreateCopyScene(sceneId); --初始化完成后调用创建副本函数
		BeginEvent(sceneId);
		if bRetSceneID > 0 then
			AddText(sceneId, x700102_g_FuBenCreateOK);
		else
			AddText(sceneId, x700102_g_FuBenCreateFailed);
			for i = 0, memberNum - 1 do
				local memberId = GetNearTeamMember(sceneId, selfId, i);
				x700102_CancelMission(sceneId, memberId);
			end
		end
	EndEvent();
	DispatchMissionTips(sceneId, selfId);

end

-------------------------
--***********************
--OnCopySceneReady
--***********************
-------------------------

function x700102_OnCopySceneReady(sceneId, destsceneId)

	LuaFnSetCopySceneData_Param(destsceneId, x700102_CSP_FROMSCENEID, sceneId);--设置副本入口场景号
	leaderguid = LuaFnGetCopySceneData_TeamLeader(destsceneId);
	leaderObjId = LuaFnGuid2ObjId(sceneId, leaderguid);

	local	memberNum = GetNearTeamCount(sceneId, leaderObjId);

	for i = 0, memberNum - 1 do
		local memberId = GetNearTeamMember(sceneId, leaderObjId, i);

		misIndex = GetMissionIndexByID(sceneId, memberId, x700102_g_MissionId);
		SetMissionByIndex(sceneId, memberId, misIndex, x700102_MP_AIMSCENE, destsceneId);
		NewWorld(sceneId, memberId, destsceneId, x700102_g_Fuben_X, x700102_g_Fuben_Z);
	end

	--for i=1, 8 do
	--	local monobjId = x700102_CreateMonster(destsceneId, i);
	--	LuaFnSetCopySceneData_Param(destsceneId, x700102_CSP_DOORMONSTER_1 + i - 1, monobjId);
	--end

end

-------------------------
--***********************
--OnPlayerEnter
--***********************
-------------------------

function x700102_OnPlayerEnter(sceneId, selfId)

	SetPlayerDefaultReliveInfo(sceneId, selfId, "%10", "%10", "%10", sceneId, x700102_g_Fuben_X, x700102_g_Fuben_Z);

end

-------------------------
--***********************
--CreateMonster
--***********************
-------------------------

function x700102_CreateMonster(sceneId, teamIndex)

	local lastobjId;
	for i, item in pairs(x700102_g_MonsterGroup[teamIndex]) do
		lastobjId = LuaFnCreateMonster(sceneId, item.type, item.x, item.z, x700102_g_MonsterBasicAI, 0, -1);
	end
	return lastobjId;

end

-------------------------
--***********************
--CreateBoss
--***********************
-------------------------

function x700102_CreateBoss(sceneId)

	for i, item in pairs(x700102_g_BossCreate) do
		LuaFnCreateMonster(sceneId, item.type, item.x, item.z, item.ai, item.aiscript, -1);
	end

end

-------------------------
--***********************
--CreateBoss2 指定Table
--***********************
-------------------------

function x700102_CreateBoss2(sceneId, MonsterTable)
	for i, item in pairs(MonsterTable) do
		LuaFnCreateMonster(sceneId, item.type, item.x, item.z, item.ai, item.aiscript, -1);
	end
end

-------------------------
--***********************
--CreateGhost
--***********************
-------------------------

function x700102_CreateGhost(sceneId, x, z)

	for i, item in pairs(x700102_GhostCreate) do
		LuaFnCreateMonster(sceneId, item.type, x, z, 0, 0, -1);
	end

end

-------------------------
--***********************
--CancelMission
--***********************
-------------------------

function x700102_CancelMission(sceneId, selfId)

	misIndex = GetMissionIndexByID(sceneId, selfId, x700102_g_MissionId);
	--PrintNum(misIndex);
	local aimsceneid = GetMissionParam(sceneId, selfId, misIndex, x700102_MP_AIMSCENE);

	DelMission(sceneId, selfId, x700102_g_MissionId);
    --PrintStr('sceneId ' .. tostring(sceneId) .. ' aimsceneid ' .. tostring(aimsceneid));
	if sceneId == aimsceneid then --如果在副本里删除任务，则直接传送回

		BeginEvent(sceneId);
			AddText(sceneId, x700102_g_MissionAbandon);
		EndEvent();
		DispatchMissionTips(sceneId, selfId);
		oldsceneId = LuaFnGetCopySceneData_Param(sceneId, x700102_CSP_FROMSCENEID);--取得副本入口场景号

		NewWorld(sceneId, selfId, oldsceneId, x700102_g_Back_X, x700102_g_Back_Z);
		return oldsceneId;
	end

	return -1;

end

-------------------------
--***********************
--CheckSubmit
--***********************
-------------------------

function x700102_CheckSubmit(sceneId, selfId, NPCId)

	misIndex = GetMissionIndexByID(sceneId, selfId, x700102_g_MissionId);
	return GetMissionParam(sceneId, selfId, misIndex, x700102_MP_ISCOMPLETE);

end

-------------------------
--***********************
--OnSubmit
--***********************
-------------------------

function x700102_OnSubmit(sceneId, selfId, NPCId)

	local exp = x700102_GetExp(sceneId, selfId, NPCId);
	GetExp(sceneId, selfId, exp);

	BeginEvent(sceneId);
		AddText(sceneId, format(x700102_g_MissionBonusInfo, exp));
	EndEvent();

	DispatchMissionTips(sceneId, selfId);
	DelMission(sceneId, selfId, x700102_g_MissionId);

end

-------------------------
--***********************
--CheckTeamLeader
--***********************
-------------------------

function x700102_CheckTeamLeader(sceneId, selfId)
	if GetTeamId(sceneId, selfId) < 0 then	--判断是否有队伍
		return x700102_FAILED_TEAM;
	end

	local	memberNum = GetNearTeamCount(sceneId, selfId);

	if memberNum < x700102_g_LimitMembers then
		return x700102_FAILED_TEAMNUMBER;
	end

	if LuaFnIsTeamLeader(sceneId, selfId) == 0 then	--只有队长才能接任务
		return x700102_FAILED_CAPTAIN;
	end

	return x700102_OK;
end

-------------------------
--***********************
--OnAbandon
--***********************
-------------------------

function x700102_OnAbandon(sceneId, selfId)

	x700102_CancelMission(sceneId, selfId);

end

-------------------------
--***********************
--x700102_CancelAllMemberMission
--***********************
-------------------------
function x700102_CancelAllMemberMission(sceneId)
	local humancount = LuaFnGetCopyScene_HumanCount(sceneId);
	for i = 0, humancount - 1 do
		humanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);
		x700102_CancelMission(sceneId, humanId);
	end
end

-------------------------
--***********************
--NotifySceneHuman
--***********************
-------------------------
function x700102_NotifySceneHuman(sceneId, message)

	local humancount = LuaFnGetCopyScene_HumanCount(sceneId);
	for i = 0, humancount - 1 do
		humanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);
		BeginEvent(sceneId);
			AddText(sceneId, message);
		EndEvent();
		DispatchMissionTips(sceneId, humanId);
	end
end

-------------------------
--***********************
--GetKillMonsterCount
--***********************
-------------------------
function x700102_GetKillMonsterCount(sceneId, MonsterType)
	--PrintStr('x700102_GetKillMonsterCount MonsterType=' .. tostring(MonsterType));
	local MonsterParamIndex = x700102_g_area_monster_info[MonsterType].DataParamIndex;
	--PrintStr('x700102_GetKillMonsterCount MonsterParamIndex=' .. tostring(MonsterParamIndex));
	local MonsterKillCount = LuaFnGetCopySceneData_Param(sceneId, MonsterParamIndex);
	--PrintStr('x700102_GetKillMonsterCount MonsterKillCount=' .. tostring(MonsterKillCount));
	if MonsterKillCount == nil then
		return 0;
	else
		return MonsterKillCount;
	end
end


-------------------------
--***********************
--ClearKillMonsterCount
--***********************
-------------------------
function x700102_ClearKillMonsterCount(sceneId)
	LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_KILLMONSTER_SHIDUNV, 0);
	LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_KILLMONSTER_JIANPOPO, 0);
	LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_KILLMONSTER_DULAOFU, 0);

	LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_KILLMONSTER_SHIDUNV_GAOJI, 0);
	LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_KILLMONSTER_JIANPOPO_GAOJI, 0);
	LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_KILLMONSTER_DULAOFU_GAOJI, 0);
end

-------------------------
--***********************
--OnTimeOutState
--***********************
-------------------------
function x700102_OnTimeOutState(sceneId, nowTime)
    local TimeOutState = LuaFnGetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE);
	local StateBeginTime = LuaFnGetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE_BEGIN);

	--PrintStr('x700102_OnTimeOutState TimeOutState=' .. tostring(TimeOutState));
	--PrintStr('x700102_OnTimeOutState StateBeginTime=' .. tostring(StateBeginTime));
	--PrintStr('x700102_OnTimeOutState nowTime=' .. tostring(nowTime));
	--PrintStr('x700102_OnTimeOutState LuaFnGetTickCount()=' .. tostring(LuaFnGetTickCount()));
	--PrintStr('x700102_OnTimeOutState nowTime - StateBeginTime=' .. tostring(nowTime - StateBeginTime));

    if TimeOutState == 1 then
		--PrintStr('x700102_g_kill_monster_count[x700102_g_Monster_ShiDuNu]' .. tostring(x700102_g_kill_monster_count[x700102_g_Monster_ShiDuNu]));
		if x700102_GetKillMonsterCount(sceneId, x700102_g_Monster_ShiDuNu) >= 8 then
			--PrintStr(x700102_g_TimeOutStateFailedMessage1_1);
			x700102_NotifySceneHuman(sceneId, x700102_g_TimeOutStateFailedMessage1_1);
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE_BEGIN, LuaFnGetTickCount()) ;  					--记录阶段开始时间
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE, 3) ;        									--超时阶段改为2
		elseif nowTime - StateBeginTime > (1000 * 60 * 2) then
			--PrintStr(x700102_g_TimeOutStateFailedMessage1);
			x700102_NotifySceneHuman(sceneId, x700102_g_TimeOutStateFailedMessage1);
			--放出大怪
			x700102_CreateBoss2(sceneId, x700102_g_Create_ShiDuNu_Gaoji);
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE_BEGIN, LuaFnGetTickCount()) ;  					--记录阶段开始时间
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE, 2) ;        									--超时阶段改为2
		end
    elseif TimeOutState == 2 then
		if  x700102_GetKillMonsterCount(sceneId, x700102_g_Monster_ShiDuNu_Gaoji) >= 4 and 									--这个情况下需要打小怪8个，大怪4个
		    x700102_GetKillMonsterCount(sceneId, x700102_g_Monster_ShiDuNu) >= 8 then
			x700102_NotifySceneHuman(sceneId, x700102_g_TimeOutStateFailedMessage1_1);
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE_BEGIN, LuaFnGetTickCount()) ;  					--记录阶段开始时间
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE, 3) ;        									--超时阶段改为2
		elseif nowTime - StateBeginTime > (1000 * 60 * 2) then
			x700102_NotifySceneHuman(sceneId, x700102_g_TimeOutFailedMessage);
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE_BEGIN, LuaFnGetTickCount()) ;  					--记录阶段开始时间
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE, x700102_g_Quit_State) ;							--超时阶段改为x700102_g_Quit_State
		end
    elseif TimeOutState == 3 then
		if x700102_GetKillMonsterCount(sceneId, x700102_g_Monster_JianPoPo) >=10 then
			--PrintStr(x700102_g_TimeOutStateMessage3);
			x700102_NotifySceneHuman(sceneId, x700102_g_TimeOutStateMessage3);
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE_BEGIN, LuaFnGetTickCount()) ;  					--记录阶段开始时间
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE, 5) ;        									--超时阶段改为2
		elseif nowTime - StateBeginTime > (1000 * 60 * 2) then
			x700102_NotifySceneHuman(sceneId, x700102_g_TimeOutStateMessage3_1);
			x700102_CreateBoss2(sceneId, x700102_g_Create_JianPoPo_Gaoji);
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE_BEGIN, LuaFnGetTickCount()) ;  					--记录阶段开始时间
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE, 4) ;        									--超时阶段改为2
		end
    elseif TimeOutState == 4 then
		if  x700102_GetKillMonsterCount(sceneId, x700102_g_Monster_JianPoPo_Gaoji) >= 4 and 								--这个情况下需要打小怪10个，大怪4个
		    x700102_GetKillMonsterCount(sceneId, x700102_g_Monster_JianPoPo) >= 10 then
			x700102_NotifySceneHuman(sceneId, x700102_g_TimeOutStateMessage4);
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE_BEGIN, LuaFnGetTickCount()) ;  					--记录阶段开始时间
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE, 5) ;        									--超时阶段改为2
		elseif nowTime - StateBeginTime > (1000 * 60 * 2) then
			x700102_NotifySceneHuman(sceneId, x700102_g_TimeOutFailedMessage);
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE_BEGIN, LuaFnGetTickCount()) ;  					--记录阶段开始时间
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE, x700102_g_Quit_State) ;							--超时阶段改为x700102_g_Quit_State
		end
    elseif TimeOutState == 5 then
		if x700102_GetKillMonsterCount(sceneId, x700102_g_Monster_DulaoFu) >=6 then
			x700102_NotifySceneHuman(sceneId, x700102_g_TimeOutStateMessage5);
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE_BEGIN, LuaFnGetTickCount()) ;  					--记录阶段开始时间
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE, 7) ;        									--超时阶段改为2
			x700102_ClearKillMonsterCount(sceneId);
		elseif nowTime - StateBeginTime > (1000 * 60 * 2) then
			x700102_NotifySceneHuman(sceneId, x700102_g_TimeOutStateMessage5_1);
			x700102_CreateBoss2(sceneId, x700102_g_Create_DulaoFu_Gaoji);
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE_BEGIN, LuaFnGetTickCount()) ;  					--记录阶段开始时间
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE, 6) ;        									--超时阶段改为2
		end
    elseif TimeOutState == 6 then
		if  x700102_GetKillMonsterCount(sceneId, x700102_g_Monster_DulaoFu) >= 6 and 								--这个情况下需要打小怪10个，大怪4个
		    x700102_GetKillMonsterCount(sceneId, x700102_g_Monster_DulaoFu_Gaoji) >= 3 then
			x700102_NotifySceneHuman(sceneId, x700102_g_TimeOutStateMessage5);
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE_BEGIN, LuaFnGetTickCount()) ;  					--记录阶段开始时间
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE, 7) ;        									--超时阶段改为2
			x700102_ClearKillMonsterCount(sceneId);
		elseif nowTime - StateBeginTime > (1000 * 60 * 2) then
			x700102_NotifySceneHuman(sceneId, x700102_g_TimeOutFailedMessage);
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE_BEGIN, LuaFnGetTickCount()) ;  					--记录阶段开始时间
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE, x700102_g_Quit_State) ;							--超时阶段改为x700102_g_Quit_State
		end
	elseif TimeOutState == 7 then
		if  x700102_GetKillMonsterCount(sceneId, x700102_g_Monster_JianPoPo) >=3 and
		    x700102_GetKillMonsterCount(sceneId, x700102_g_Monster_DulaoFu) >=3 then
			x700102_NotifySceneHuman(sceneId, x700102_g_TimeOutStateMessage7);
			x700102_CreateBoss2(sceneId, x700102_g_Create_Boss);
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE_BEGIN, LuaFnGetTickCount()) ;  					--记录阶段开始时间
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE, 9) ;        									--超时阶段改为2
		elseif nowTime - StateBeginTime > (1000 * 60 * 2) then
			x700102_NotifySceneHuman(sceneId, x700102_g_TimeOutStateMessage8);
			x700102_CreateBoss2(sceneId, x700102_g_Create_Last_Gaoji);
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE_BEGIN, LuaFnGetTickCount()) ;  					--记录阶段开始时间
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE, 8) ;        									--超时阶段改为2
		end
	elseif TimeOutState == 8 then
		if  x700102_GetKillMonsterCount(sceneId, x700102_g_Monster_JianPoPo) >=3 and
		    x700102_GetKillMonsterCount(sceneId, x700102_g_Monster_DulaoFu) >=3 and
			x700102_GetKillMonsterCount(sceneId, x700102_g_Monster_JianPoPo_Gaoji) >=3 and
			x700102_GetKillMonsterCount(sceneId, x700102_g_Monster_DulaoFu_Gaoji) >=3 then
			x700102_NotifySceneHuman(sceneId, x700102_g_TimeOutStateMessage7);
			x700102_CreateBoss2(sceneId, x700102_g_Create_Boss);
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE_BEGIN, LuaFnGetTickCount()) ;  					--记录阶段开始时间
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE, 9) ;        									--超时阶段改为2
		elseif nowTime - StateBeginTime > (1000 * 60 * 2) then
			x700102_NotifySceneHuman(sceneId, x700102_g_TimeOutFailedMessage);
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE_BEGIN, LuaFnGetTickCount()) ;  					--记录阶段开始时间
			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE, x700102_g_Quit_State) ;							--超时阶段改为x700102_g_Quit_State
		end
	elseif TimeOutState == 9 then

	elseif TimeOutState == x700102_g_Quit_State then
		if nowTime - StateBeginTime > (1000 * 30) then
			x700102_CancelAllMemberMission(sceneId);
		end
    else
    end
end

-------------------------
--***********************
--OnCopySceneTimer
--***********************
-------------------------

function x700102_OnCopySceneTimer(sceneId, nowTime)


    --PrintStr('x700102_g_area_monster_info nowTime=' ..  tostring(nowTime));

	local nowTickCount = LuaFnGetCopySceneData_Param(sceneId, x700102_CSP_TICKCOUNT) + 1;
	LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_TICKCOUNT, nowTickCount);
	--PrintNum(nowTickCount);

	local leaveFlag = LuaFnGetCopySceneData_Param(sceneId, x700102_CSP_ISCLOSING);

	if leaveFlag > 0 then

		local leaveCountDown = LuaFnGetCopySceneData_Param(sceneId, x700102_CSP_LEAVECOUNTDOWN) + 1;
		LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_LEAVECOUNTDOWN, leaveCountDown);

		if leaveCountDown == x700102_g_CloseTick then
			local oldsceneId = LuaFnGetCopySceneData_Param(sceneId, x700102_CSP_FROMSCENEID);
			local humancount = LuaFnGetCopyScene_HumanCount(sceneId);
			for	i = 0, humancount - 1 do
				local humanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);
				NewWorld(sceneId, humanId, oldsceneId, x700102_g_Back_X, x700102_g_Back_Z);
			end
		elseif leaveCountDown < x700102_g_CloseTick then
			local humancount = LuaFnGetCopyScene_HumanCount(sceneId);
			for	i = 0, humancount - 1 do
				local humanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);
 				local str = format(x700102_g_CountDownMessage, (x700102_g_CloseTick - leaveCountDown) * x700102_g_TickTime);
  			BeginEvent(sceneId);
  				AddText(sceneId, str);
  			EndEvent(sceneId);
  			DispatchMissionTips(sceneId, humanId);
			end
		end

	else

		x700102_OnTimeOutState(sceneId, nowTime);

		local humancount = LuaFnGetCopyScene_HumanCount(sceneId);

		for i = 0, humancount - 1 do
			humanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);

			if nowTickCount == x700102_g_LimitTotalHoldTime then
				local oldsceneId = x700102_CancelMission(sceneId, humanId);
				BeginEvent(oldsceneId);
					AddText(sceneId, x700102_g_TimeOutFailedMessage);
				EndEvent();
				DispatchMissionTips(oldsceneId, humanId);
			end
			local kickout = 0;
			if IsHaveMission(sceneId, humanId, x700102_g_MissionId) > 0 then
				if GetTeamId(sceneId, humanId) ~= LuaFnGetCopySceneData_Param(sceneId, x700102_CSP_TEAMID) then
					kickout = 1;
				end
			else
				kickout = 1;
			end
			if kickout == 1 then
				x700102_CancelMission(sceneId, humanId);
			end
		end

		local monsternum = GetMonsterCount(sceneId);

		for i=0, monsternum-1 do
			local monobjId = GetMonsterObjID(sceneId, i);
			local moncreatetime = GetObjCreateTime(sceneId, monobjId);
			local difftime = nowTime - moncreatetime;
			if GetMonsterDataID(sceneId, monobjId) == x700102_g_MonsterOriType and difftime >= x700102_g_MonsterChangeTimer and	GetHp(sceneId, monobjId) > 0 then
				local xpos, zpos = GetWorldPos(sceneId, monobjId);
				LuaFnDeleteMonster(sceneId, monobjId);
				x700102_CreateSp(sceneId, selfId, xpos, zpos);
			end
		end

	end

end

-------------------------
--***********************
--CreateSp
--***********************
-------------------------

function x700102_CreateSp(sceneId, selfId, x, z)

	local monobjId = LuaFnCreateMonster(sceneId, x700102_g_MonsterToType, x, z, 0, 0, -1);
	for i, item in pairs(x700102_g_ChangeModelBuff) do
		LuaFnSendSpecificImpactToUnit(sceneId, monobjId, monobjId, monobjId, item, 0);
	end


end

-------------------------
--***********************
--GetExp
--***********************
-------------------------

function x700102_GetExp(sceneId, selfId, NPCId)
	local ret = x700102_g_ExpBonus;
	return ret;
end

-------------------------
--***********************
--OpenDoor
--***********************
-------------------------

function x700102_OpenDoor(sceneId, selfId, humancount, teamId)

	x700102_CreateMonster(sceneId, teamId + 8);

	for i = 0, humancount - 1 do

		humanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);	--取得当前场景里人的objId

		str = format(x700102_g_OpenDoorMessage, teamId);
		BeginEvent(sceneId);
			AddText(sceneId, str);
		EndEvent();
		DispatchMissionTips(sceneId, humanId);

	end

end

-------------------------
--***********************
--KillOpposite
--***********************
-------------------------

function x700102_KillOpposite(sceneId, selfId, objId)

	--local objId = LuaFnGetCopySceneData_Param(sceneId, x700102_CSP_DOORMONSTER_1 + teamId - 1);
	LuaFnDeleteMonster(sceneId, objId);

end

-------------------------
--***********************
--OnKillObject
--***********************
-------------------------

function x700102_CauseRandomBuff(sceneId, selfId)

	local rand = random(1, 6);
	local buffId = x700102_g_RandomBuff[rand];
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, buffId, 0);

end

-------------------------
--***********************
--PrintKillMonsterInfo
--***********************
-------------------------
function x700102_PrintKillMonsterInfo(sceneId)
	local State = LuaFnGetCopySceneData_Param(sceneId, x700102_CSP_TIMEOUT_STATE);
	--PrintStr('x700102_PrintKillMonsterInfo State=' .. tostring(State));
	local NotifyMsg;
	if State <= 7 then
		local killinfo = x700102_g_area_kill_monster_info[State];
		--PrintStr('x700102_PrintKillMonsterInfo killinfo.pos1=' .. tostring(killinfo.pos1));
		local MonsterKill1 = LuaFnGetCopySceneData_Param(sceneId, killinfo.pos1);
		--PrintStr('x700102_PrintKillMonsterInfo MonsterKill1=' .. tostring(MonsterKill1));
		if killinfo.pos2 > 0 then
			local MonsterKill2 = LuaFnGetCopySceneData_Param(sceneId, killinfo.pos2);
			--PrintStr('x700102_PrintKillMonsterInfo killinfo.desc=' .. killinfo.desc);
			NotifyMsg = format(killinfo.desc, MonsterKill1, MonsterKill2);
		else
			--PrintStr('x700102_PrintKillMonsterInfo killinfo.desc=' .. killinfo.desc);
			NotifyMsg = format(killinfo.desc, MonsterKill1);
		end
	else

	end
	x700102_NotifySceneHuman(sceneId, NotifyMsg);
end


-------------------------
--***********************
--OnKillObject
--***********************
-------------------------

function x700102_OnKillObject(sceneId, selfId, objdataId ,objId)

    --PrintStr('sceneId=' .. tostring(sceneId));
    --PrintStr('selfId=' .. tostring(selfId));
    --PrintStr('objdataId=' .. tostring(objdataId));
    --PrintStr('objId=' .. tostring(objId));
	local MonsterParamIndex = x700102_g_area_monster_info[objdataId].DataParamIndex;
	local MonsterKillCount = LuaFnGetCopySceneData_Param(sceneId, MonsterParamIndex);
	if MonsterKillCount == nil then
		MonsterKillCount = 1;
	else
		MonsterKillCount = MonsterKillCount + 1;
	end
	LuaFnSetCopySceneData_Param(sceneId, MonsterParamIndex, MonsterKillCount);
	x700102_PrintKillMonsterInfo(sceneId);
	--PrintStr('MonsterKillCount=' .. tostring(MonsterKillCount));


	local sceneType = LuaFnGetSceneType(sceneId);
	if sceneType ~= x700102_g_FuBenType then
		return 0;
	end
    --PrintStr('x700102_CSP_FUBENTYPE ' .. tostring(x700102_CSP_FUBENTYPE));
	local fubenType = LuaFnGetCopySceneData_Param(sceneId, x700102_CSP_FUBENTYPE);
	if fubenType ~= x700102_g_CopySceneType then
		return 0;
	end
    --PrintStr('x700102_CSP_LEAVECOUNTDOWN ' .. tostring(x700102_CSP_LEAVECOUNTDOWN));
	local leaveFlag = LuaFnGetCopySceneData_Param(sceneId, x700102_CSP_LEAVECOUNTDOWN);

	if leaveFlag == 1 then --如果副本已经被置成关闭状态，则杀怪无效
		return 0;
	end

    --PrintStr('End KillObject 111');
	local humancount = LuaFnGetCopyScene_HumanCount(sceneId);

	local misIndex;

	local isboss = -1;
	local notcount = 0;
	local ti = 0;

	for i=1, 8 do
		if objId == LuaFnGetCopySceneData_Param(sceneId, x700102_CSP_DOORMONSTER_1 + i - 1) then
			notcount = 1;
			local iopp;
			if i > 4 then
				iopp = i - 4;
			else
				iopp = i + 4;
			end
			x700102_OpenDoor(sceneId, selfId, humancount, i);
			--x700102_KillOpposite(sceneId, selfId, objId);
			x700102_OpenDoor(sceneId, selfId, humancount, iopp);
		end
	end

	--PrintStr('End KillObject 222');

	--if 1 == 1 then
	--    return 0;
	--end

	for i, item in pairs(x700102_g_MonsterType) do
		if item.type == objdataId then
			isboss = 0;
		end
	end

	--PrintStr('End KillObject 333');

	if isboss == -1 then
		for i, item in pairs(x700102_g_BossCreate) do
			if item.type == objdataId then
				isboss = 1;
				notcount = 1;
				local humanId;
				local leaderId;
				for i = 0, humancount - 1 do
					humanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);--取得当前场景里人的objId
					if LuaFnIsTeamLeader(sceneId, humanId) then
						leaderId = humanId;
					end
					x700102_CauseRandomBuff(sceneId, selfId);
				end
				local xpos, zpos = GetWorldPos(sceneId, humanId);
				x700102_CreateGhost(sceneId, xpos, zpos);
			end
		end
	end

	--PrintStr('End KillObject 444');

	LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_NKILLMONSTER, killmonster);

	local monsternum = GetMonsterCount(sceneId);
	local deadmonsternum = 0;
	for i=0, monsternum-1 do
		local monobjId = GetMonsterObjID(sceneId, i);
		if GetHp(sceneId, monobjId) <= 0 then
			deadmonsternum = deadmonsternum + 1;
		end
	end
	local monsterstate = LuaFnGetCopySceneData_Param(sceneId, x700102_CSP_MONSTERSTATE);

	--PrintStr('End KillObject 555');

	if monsternum == deadmonsternum then

		if monsterstate == 0 then
			for i = 0, humancount - 1 do
				BeginEvent(sceneId);
					AddText(sceneId, x700102_g_BossMergeMessage);
				EndEvent();
				DispatchMissionTips(sceneId, humanId);
			end
			x700102_CreateBoss(sceneId);
			monsterstate = 1;

		elseif monsterstate == 1 then
			for i = 0, humancount - 1 do

				humanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);	--取得当前场景里人的objId
				misIndex = GetMissionIndexByID(sceneId, humanId, x700102_g_MissionId);
				SetMissionByIndex(sceneId, humanId, misIndex, x700102_MP_ISCOMPLETE, 1);

				str = format(x700102_g_CompleteOutMessage, x700102_g_CloseTick * x700102_g_TickTime);
				BeginEvent(sceneId);
					AddText(sceneId, str);
				EndEvent();
				DispatchMissionTips(sceneId, humanId);
			end
			monsterstate = 2;

			LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_ISCLOSING, 1);
		end
	end

	LuaFnSetCopySceneData_Param(sceneId, x700102_CSP_MONSTERSTATE, monsterstate);

	--PrintStr('End KillObject');

end

-------------------------
--***********************
--OnHumanDie
--***********************
-------------------------

function x700102_OnHumanDie(sceneId, selfId, killerId)
end
----------------------------------------------------------------------------------------------------------
--区域脚本  开始
----------------------------------------------------------------------------------------------------------
--玩家进入一个 area 时触发
function x700102_OnEnterArea( sceneId, selfId , areaId)
	--CallScriptFunction(x300461_g_TransScriptId, "TransferToWorld",sceneId,selfId,x300461_g_TransPos)
	--PrintStr('x700102_OnEnterArea');
	--PrintStr('x700102_OnEnterArea areaId=' .. tostring(areaId));
	--PrintStr('x700102_OnEnterArea selfId=' .. tostring(selfId));
end

--玩家在一个 area 呆了一段时间没走则定时触发
function x700102_OnTimer( sceneId, monsterobjid )
    --PrintStr('x700102_OnTimer');
end

--玩家离开一个 area 时触发
function x700102_OnLeaveArea( sceneId, monsterobjid )
    --PrintStr('x700102_OnLeaveArea');
end
----------------------------------------------------------------------------------------------------------
--区域脚本  结束
----------------------------------------------------------------------------------------------------------
