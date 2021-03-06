x950010_g_ScriptId = 950010

--以上是动态**************************************************************

--任务文本描述
x950010_g_MissionName="领取道具"


x950010_g_Items	=	{
										{
										},
										{
										},
										{
										}
									}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x950010_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本

	local ret;
	local itemcount = 0;
	
	for i, items in pairs(x950010_g_Items) do
		
		BeginAddItem(sceneId);
		for j, item in pairs(items) do
			AddItem( sceneId, item.id, item.num );
			itemcount = itemcount + 1;
		end
		ret = EndAddItem(sceneId,selfId);
		if ret > 0 and itemcount > 0 then
			AddItemListToHuman(sceneId,selfId);
		end
	end
	
end

--**********************************
--列举事件
--**********************************
function x950010_OnEnumerate( sceneId, selfId, targetId )
	AddNumText(sceneId,x950010_g_ScriptId,x950010_g_MissionName);
end