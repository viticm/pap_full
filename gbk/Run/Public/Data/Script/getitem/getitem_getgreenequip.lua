x950001_g_ScriptId = 950001

--以上是动态**************************************************************

--任务文本描述
x950001_g_MissionName="领取绿装"


x950001_g_Items	=	{
										{
											{id=10232207, num=1},
											{id=10252207, num=1},
											{id=10272207, num=1}
										},
										--重甲01
										{
										 {id=10232208, num=1},
										 {id=10252208, num=1},
										 {id=10272208, num=1}
										--重甲02
										},
										{
											{id=10232209, num=1},
											{id=10252209, num=1},
											{id=10272209, num=1}
										},
										--重甲03
										{
											{id=10232210, num=1},
											{id=10252210, num=1},
											{id=10272210, num=1}
										},
										--重甲04
										{
											{id=10232301, num=1},
											{id=10252301, num=1},
											{id=10272301, num=1}
										--重甲05
										},
										{
											{id=10232307, num=1},
											{id=10252307, num=1},
											{id=10272307, num=1}
										},
										--重甲流光01
										--{
											--{id=10232308, num=1},
											--{id=10252308, num=1},
											--{id=10272308, num=1}
									 --},
									 --重甲流光02
										{
											{id=10232310, num=1},
											{id=10252310, num=1},
											{id=10272310, num=1}
										},
										--重甲流光03
								  {
									    {id=10232401, num=1},
									    {id=10252401, num=1},
									    {id=10272401, num=1}
										},
										--重甲流光04
										{
											{id=10232402, num=1},
											{id=10252402, num=1},
											{id=10272402, num=1}
										},
									--重甲流光05
									{
											{id=10202201, num=1},
											{id=10202202, num=1},
											{id=10202203, num=1}
									}
										--头发
									}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x950001_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本

	local ret;
	local itemcount = 0;
	
	for i, items in pairs(x950001_g_Items) do
		
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
function x950001_OnEnumerate( sceneId, selfId, targetId )
	AddNumText(sceneId,x950001_g_ScriptId,x950001_g_MissionName);
end