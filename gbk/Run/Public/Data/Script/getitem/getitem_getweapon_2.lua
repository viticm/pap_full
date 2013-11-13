x950007_g_ScriptId = 950007

--以上是动态**************************************************************

--任务文本描述
x950007_g_MissionName="副手武器"


x950007_g_Items	=	{
										{
											{
												{id=10072201, num=1},
												{id=10072209, num=1}
											}
										},
										{
											{
												{id=10082201, num=1}
											}
										},
										{
											{
												{id=10092201, num=1}
											}
										},
										{
											{
												{id=10102201, num=1}
											}
										},
										{
											{
												{id=10112201, num=1}
											}
										},
										{
											{
												{id=10122201, num=1}
											}
										}
									}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x950007_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本

	local ret;
	local zhiye = GetMenPai(sceneId, selfId);
	local itemcount = 0;
		
	BeginAddItem(sceneId);
	for i, items in pairs(x950007_g_Items[zhiye+1]) do
		for j, item in pairs(items) do
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
function x950007_OnEnumerate( sceneId, selfId, targetId )
	AddNumText(sceneId,x950007_g_ScriptId,x950007_g_MissionName);
end