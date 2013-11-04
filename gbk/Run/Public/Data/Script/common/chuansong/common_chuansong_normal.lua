--传送模块

x800019_g_ScriptId = 800019

--**********************************

function x800019_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

end



--**********************************

--列举事件

--**********************************

function x800019_OnEnumerate(sceneId, selfId, targetId)

	x800019_TransferFunc(sceneId, selfId, 1, 100, 120)
	
end
--组队跟随状态下，队长传送时整个组队也将被传送
function	x800019_TransferFunc(sceneId, selfId, newSceneId, PosX, PosZ)
	--如果玩家没有处于组队状态,则直接传送
	local life=LuaFnIsCharacterLiving( sceneId,selfId)
	if	life==0	then
		return
	else
		if	GetTeamId( sceneId, selfId)<0	then
			if sceneId == newSceneId then
				SetPos(sceneId, selfId,PosX,PosZ)
			else
				NewWorld(sceneId, selfId, newSceneId, PosX, PosZ)
			end
		--如果玩家处于组队状态但不处于组队跟随状态,则直接传送
		elseif	IsTeamFollow(sceneId, selfId)~=1	then
			if sceneId == newSceneId then
				SetPos(sceneId, selfId,PosX,PosZ)
			else
				NewWorld(sceneId, selfId, newSceneId, PosX, PosZ)
			end
		--如果玩家处于组队跟随状态,且玩家是队长,则小队传送
		elseif	LuaFnIsTeamLeader(sceneId,selfId)==1	 then
			num=LuaFnGetFollowedMembersCount( sceneId, selfId)
			local mems = {}
			for	i=0,num-1 do
				mems[i] = GetFollowedMember(sceneId, selfId, i)
				if mems[i] == -1 then
					return
				end
			end
			
			if sceneId == newSceneId then
				for	i=0,num-1 do
					SetPos(sceneId, selfId,PosX,PosZ)
				end
			else			
				for	i=0,num-1 do
					NewWorld(sceneId, mems[i], newSceneId, PosX, PosZ)
				end
			end
		--如果玩家处于组队跟随状态,且不是队长,则……可以发条消息也好啊
		end
	end
end

--用一个数组记录游戏里面所有用到的传送点
WXSJ_WorldPos= {
				xinshoucun_02={newSceneId=4,PosX=60,PosZ=30},
				yangliucun={newSceneId=2,PosX=60,PosZ=30},
				taohuadao={newSceneId=1,PosX=60,PosZ=30},
				
				}
--sceneid   scenename    country
--  11       楼兰王城       0 
--  18       莱茵王城       1
--  21       昆仑王城       2
--  24       敦煌王城       3
--  36         大都         



function	x800019_TransferToWorld(sceneId, selfId, Pos)
	if WXSJ_WorldPos[Pos].newSceneId == 11 then
		local country = GetCurCountry(sceneId,selfId)
		local countryscene={11,18,21,24}
		if country == 0 then
			x800019_TransferFunc(sceneId, selfId, countryscene[country+1], WXSJ_WorldPos[Pos].PosX, WXSJ_WorldPos[Pos].PosZ)
		elseif country == 1 then
			x800019_TransferFunc(sceneId, selfId, countryscene[country+1], WXSJ_WorldPos[Pos].PosX, WXSJ_WorldPos[Pos].PosZ)
		elseif country == 2 then
			x800019_TransferFunc(sceneId, selfId, countryscene[country+1], WXSJ_WorldPos[Pos].PosX, WXSJ_WorldPos[Pos].PosZ)
		elseif country == 3 then
			x800019_TransferFunc(sceneId, selfId, countryscene[country+1], WXSJ_WorldPos[Pos].PosX, WXSJ_WorldPos[Pos].PosZ)
		else
			return
		end
	elseif  WXSJ_WorldPos[Pos].newSceneId == 99 then
		local country = GetCurCountry(sceneId,selfId)
		local bianjingscene={99,99,99,99}
		if country == 0 then
			x800019_TransferFunc(sceneId, selfId, bianjingscene[country+1], WXSJ_WorldPos[Pos].PosX, WXSJ_WorldPos[Pos].PosZ)
		elseif country == 1 then
			x800019_TransferFunc(sceneId, selfId, bianjingscene[country+1], WXSJ_WorldPos[Pos].PosX, WXSJ_WorldPos[Pos].PosZ)
		elseif country == 2 then
			x800019_TransferFunc(sceneId, selfId, bianjingscene[country+1], WXSJ_WorldPos[Pos].PosX, WXSJ_WorldPos[Pos].PosZ)
		elseif country == 3 then
			x800019_TransferFunc(sceneId, selfId, bianjingscene[country+1], WXSJ_WorldPos[Pos].PosX, WXSJ_WorldPos[Pos].PosZ)
		else
			return
		end
	else
		x800019_TransferFunc(sceneId, selfId, WXSJ_WorldPos[Pos].newSceneId, WXSJ_WorldPos[Pos].PosX, WXSJ_WorldPos[Pos].PosZ)
	end
end
