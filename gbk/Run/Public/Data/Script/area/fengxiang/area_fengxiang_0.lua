--玩家进入一个 area 时触发
function x930000_OnEnterArea( sceneId, monsterobjid )

end

--玩家在一个 area 呆了一段时间没走则定时触发
function x930000_OnTimer( sceneId, monsterobjid )

end

--玩家离开一个 area 时触发
function x930000_OnLeaveArea( sceneId, monsterobjid )

end


function x930000_OnDefaultEvent( sceneId, monsterobjid )
	local ret = LuaFnDeleteMonster(sceneId, monsterobjid)
	if(ret==1) then 
		CallScriptFunction( 920000, "MonsterNum",sceneId, monsterobjid , targetId )
	end
end