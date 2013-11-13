--;护送测试时对话

function x211052_OnDefaultEvent( sceneId, selfId,targetId )
	local PosX,PosZ=LuaFnGetWorldPos(sceneId, targetId)
	if  (PosX-70)*(PosX-70)+(PosZ-41)*(PosZ-41)<=2 then
		str="我们这就出发吧！"
	elseif(PosX-76)*(PosX-76)+(PosZ-52)*(PosZ-52)<=2 then
		str="第一次说话"
	elseif	(PosX-80)*(PosX-80)+(PosZ-64)*(PosZ-64)<=2 then
		str="第二次说话"
	elseif	(PosX-81)*(PosX-81)+(PosZ-80)*(PosZ-80)<=2 then
		str="第三次说话"
	elseif	(PosX-88)*(PosX-88)+(PosZ-110)*(PosZ-110)<=2 then
		str="你快点，怎么比我还慢！"	
	elseif	(PosX-113)*(PosX-113)+(PosZ-134)*(PosZ-134)<=2 then
		str="哈哈，我到了，就在那呢。谢谢你。好不容易溜出来，我趁机在外玩会，一会就回去，嘿嘿。"	
	end
	BeginEvent(sceneId)
		AddText(sceneId,str)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end


