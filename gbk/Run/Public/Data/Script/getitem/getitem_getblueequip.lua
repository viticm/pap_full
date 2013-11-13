x950002_g_ScriptId = 950002

--以上是动态**************************************************************

--任务文本描述
x950002_g_MissionName="领取蓝装"


x950002_g_Items	=	{
										{
											{id=10202201, num=1},
											{id=10202202, num=1},
											{id=10202203, num=1},
											{id=10222201, num=1},
											{id=10222202, num=1},
											{id=10222203, num=1}
										},
										{
											{id=10232201, num=1},
											{id=10232202, num=1},
											{id=10232203, num=1},
											{id=10252201, num=1},
											{id=10252202, num=1},
											{id=10252203, num=1}
										},
										{
											{id=10272201, num=1},
											{id=10272202, num=1},
											{id=10272203, num=1}
										}
									}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x950002_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本

	local ret;
	local itemcount = 0;
	
	for i, items in pairs(x950002_g_Items) do
		
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
function x950002_OnEnumerate( sceneId, selfId, targetId )
	AddNumText(sceneId,x950002_g_ScriptId,x950002_g_MissionName);
end