x950004_g_ScriptId = 950004

--以上是动态**************************************************************

--任务文本描述
x950004_g_MissionName="领取金装"


x950004_g_Items	=	{
										{
										 {id=10232302, num=1},
										 {id=10252302, num=1},
										 {id=10272302, num=1}
											--重甲06
										},
										{
											{id=10232303, num=1},
											{id=10252303, num=1},
											{id=10272303, num=1},
											--重甲07
											{id=10232304, num=1},
											{id=10252304, num=1},
											{id=10272304, num=1}
										--重甲08
										},
										 {
											{id=10232305, num=1},
											{id=10252305, num=1},
											{id=10272305, num=1}
										--重甲09
										},
										{
											{id=10232306, num=1},
										        {id=10252306, num=1},
											{id=10272306, num=1}
										--重甲10
										},
									
										{
											{id=10232403, num=1},
											{id=10252403, num=1},
											{id=10272403, num=1}
										--重甲流光06
										},
										{											
											{id=10232404, num=1},
											{id=10252404, num=1},
											{id=10272404, num=1}
										--重甲流光07
										},
									        {
											{id=10232405, num=1},
											{id=10252405, num=1},
											{id=10272405, num=1}
										
										--重甲流光08
									        },
									        {
											{id=10232406, num=1},
											{id=10252406, num=1},
											{id=10272406, num=1}
										},
										--重甲流光09
										{
											{id=10232407, num=1},
											{id=10252407, num=1},
											{id=10272407, num=1}
										}
										--重甲流光10
									}
									
									
									

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x950004_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本

	local ret;
	local itemcount = 0;
	
	for i, items in pairs(x950004_g_Items) do
		
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
function x950004_OnEnumerate( sceneId, selfId, targetId )
	AddNumText(sceneId,x950004_g_ScriptId,x950004_g_MissionName);
end