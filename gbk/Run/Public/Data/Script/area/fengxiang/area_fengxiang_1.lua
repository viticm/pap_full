--玩家进入一个 area 时触发
function x930001_OnEnterArea( sceneId, monsterobjid )

end

--玩家在一个 area 呆了一段时间没走则定时触发
function x930001_OnTimer( sceneId, monsterobjid )

end

--玩家离开一个 area 时触发
function x930001_OnLeaveArea( sceneId, monsterobjid )

end


function x930001_OnDefaultEvent( sceneId, monsterobjid )

end

function x930001_OnDie( sceneId, selfId, killerId )
	CallScriptFunction( 920000, "MonsterNum",sceneId, monsterobjid , targetId )
end
