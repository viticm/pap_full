--生长点

--脚本号 301019

--动态变量初始化方法

x301019_g_ScriptId							= 700104
x301019_g_MissionId							= 444
x301019_g_Message_OK						= "击鼓成功！"
x301019_g_ErrorMessage_Mission	= "您不能这样做！"


--生成函数开始************************************************************************

function x301019_OnCreate(sceneId, growPointType, x, z)
	
	CallScriptFunction(x301019_g_ScriptId, "_OnCreate", sceneId, growPointType, x, z);

end






--生成函数结束**********************************************************************


--打开前函数开始&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
function x301019_OnOpen(sceneId, selfId, targetId)

	if IsHaveMission(sceneId,selfId, x301019_g_MissionId) > 0 then
		
		return CallScriptFunction(x301019_g_ScriptId, "_OnOpen", sceneId, selfId, targetId);
	
	else
		BeginEvent(sceneId);        
		AddText(sceneId, x301019_g_ErrorMessage_Mission);
		EndEvent(sceneId);
		DispatchMissionTips(sceneId,selfId);
		return 1;
	end

end
--打开前函数结束&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


--回收函数开始########################################################################
function x301019_OnRecycle(sceneId, selfId, targetId)

	BeginEvent(sceneId);
		AddText(sceneId, x301019_g_Message_OK);
  EndEvent();
	DispatchMissionTips(sceneId, selfId);
	CallScriptFunction(x301019_g_ScriptId, "_OnRecycle", sceneId, selfId, targetId);
	return 1;
	
end
--回收函数结束########################################################################



--打开后函数开始@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
function x301019_OnProcOver(sceneId, selfId, targetId)

end
--打开后函数结束@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@



function x301019_OpenCheck(sceneId, selfId, AbilityId, AblityLevel)

end
