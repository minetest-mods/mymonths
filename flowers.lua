minetest.register_abm({ --Flowers die in late fall
	nodenames = {'group:flower'},
	interval = 10, 
	chance = 10,
	action = function (pos)
		if mymonths.month == 'October' or mymonths.month == 'November' then
			minetest.set_node(pos, {name = 'air'})
		end
	end
})

minetest.register_abm({ --Flowers grow in spring, flower spread ABM is in flower mod, this just gives initial population as that ABM won't grow flowers where there are none.
	nodenames = {'group:soil'},
	interval = 240,
	chance = 100,
	action = function (pos)
		if mymonths.month == 'March' or mymonths.month == 'April' then
			local pos0 = {x=pos.x-4,y=pos.y-4,z=pos.z-4}
			local pos1 = {x=pos.x+4,y=pos.y+4,z=pos.z+4}
			local flowers = minetest.find_nodes_in_area(pos0, pos1, "group:flower")
			if #flowers > 2 then
				return
			end
			pos.y = pos.y+1
			if minetest.get_node(pos).name == 'air' then
				local key = math.random(1,6)
					if key == 1 then
						minetest.set_node(pos, {name = 'flowers:dandelion_white'})
					elseif key == 2 then
						minetest.set_node(pos, {name = "flowers:dandelion_yellow"})
					elseif key == 3 then
						minetest.set_node(pos, {name = "flowers:geranium"})
					elseif key == 4 then
						minetest.set_node(pos, {name = "flowers:rose"})
					elseif key == 5 then
						minetest.set_node(pos, {name = "flowers:tulip"})
					elseif key == 6 then
						minetest.set_node(pos, {name = "flowers:viola"})
					end
			end
		end
	end
})
