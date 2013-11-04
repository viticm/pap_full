x950006_g_ScriptId = 950006

--以上是动态**************************************************************

--任务文本描述
x950006_g_MissionName="主手武器"


x950006_g_Items	=	{
										{
											{
												{id=10012201, num=1},
												{id=10012206, num=1},
												{id=10012209, num=1}
											}
										},
										{
											{
												{id=10022201, num=1}
											}
										},
										{
											{
												{id=10032201, num=1}
											}
										},
										{
											{
												{id=10042201, num=1}
											}
										},
										{
											{
												{id=10052201, num=1}
											}
										},
										{
											{
												{id=10062201, num=1}
											}
										}
									}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x950006_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本

	local ret;
	local zhiye = GetMenPai(sceneId, selfId);
	local itemcount = 0;
		
	BeginAddItem(sceneId);
	for i, items in x950006_g_Items[zhiye+1] do
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
function x950006_OnEnumerate( sceneId, selfId, targetId )
	AddNumText(sceneId,x950006_g_ScriptId,x950006_g_MissionName);
end