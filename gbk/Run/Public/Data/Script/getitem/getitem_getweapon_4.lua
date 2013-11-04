x950009_g_ScriptId = 950009

--以上是动态**************************************************************

--任务文本描述
x950009_g_MissionName="其他副手武器"


x950009_g_Items	=	{
										{
											{
											}
										},
										{
											{
											}
										},
										{
											{
											}
										},
										{
											{
											}
										},
										{
											{
											}
										},
										{
											{
											}
										}
									}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x950009_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本

	local ret;
	local zhiye = GetMenPai(sceneId, selfId);
	local itemcount = 0;
		
	BeginAddItem(sceneId);
	for i, items in x950009_g_Items[zhiye+1] do
		for j, item in items do
			AddItem( sceneId, item.id, item.num );
			itemcount = itemcount + 1;
		end
	end
	ret = EndAddItem(sceneId,selfId);
	if ret > 0 and itemcount > 0 then
		AddItemListToHuman(sceneId,selfId);
	end
	
end

--**********************************
--列举事件
--**********************************
function x950009_OnEnumerate( sceneId, selfId, targetId )
	AddNumText(sceneId,x950009_g_ScriptId,x950009_g_MissionName);
end