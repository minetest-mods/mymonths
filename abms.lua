--Places Snow on ground
minetest.register_abm({
	nodenames = {"group:leaves","default:dirt","default:dirt_with_grass"},
	neighbors = {"air"},
	interval = 10.0, 
	chance = 80,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.weather == "snow" then
			local na = minetest.get_node({x=pos.x,y=pos.y+1,z=pos.z})
			if minetest.get_node_light({x=pos.x,y=pos.y+1,z=pos.z}, 0.5) == 15
			and na.name == "air" then
				minetest.set_node({x=pos.x,y=pos.y+1,z=pos.z}, {name="mymonths:snow_cover_1"})
			end
		end
	end
})
-- Changes snow to larger snow
minetest.register_abm({
	nodenames = {"mymonths:snow_cover_1","mymonths:snow_cover_2","mymonths:snow_cover_3","mymonths:snow_cover_4"},
	neighbors = {"group:crumbly", "group:snappy", "group:cracky", "group:choppy"},
	interval = 10.0, 
	chance = 80,
	action = function (pos, node, active_object_count, active_object_count_wider)
			if mymonths.weather == "snow" then
				if node.name == "mymonths:snow_cover_1" then
					minetest.set_node(pos,{name = "mymonths:snow_cover_2"})
				elseif node.name == "mymonths:snow_cover_2" then
					minetest.set_node(pos,{name = "mymonths:snow_cover_3"})
				elseif node.name == "mymonths:snow_cover_3" then
					minetest.set_node(pos,{name = "mymonths:snow_cover_4"})
				elseif node.name == "mymonths:snow_cover_4" then
					minetest.set_node(pos,{name = "default:snowblock"})
				end
			end
	end
})
--Snow Melting
minetest.register_abm({
	nodenames = {"default:snowblock","mymonths:snow_cover_1","mymonths:snow_cover_2","mymonths:snow_cover_3","mymonths:snow_cover_4"},
	--neighbors = {"group:crumbly", "group:snappy", "group:cracky", "group:choppy"},
	interval = 10.0, 
	chance = 80,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.month_counter ~= 12 or
		   mymonths.month_counter ~= 1 or
		   mymonths.month_counter ~= 2 then
			if node.name == "mymonths:snow_cover_2" then
				minetest.set_node(pos,{name = "mymonths:snow_cover_1"})
			elseif node.name == "mymonths:snow_cover_3" then
				minetest.set_node(pos,{name = "mymonths:snow_cover_2"})
			elseif node.name == "mymonths:snow_cover_4" then
				minetest.set_node(pos,{name = "mymonths:snow_cover_3"})
			elseif node.name == "default:snowblock" then
				minetest.set_node(pos,{name = "mymonths:snow_cover_4"})
			elseif node.name == "mymonths:snow_cover_1" then
				local nu = minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z})
				local ran = math.random(1,10)
				if ran == 1 and nu.name == "default:dirt_with_grass" then
				minetest.set_node(pos,{name = "mymonths:puddle"})
				else minetest.remove_node(pos)
				end
			end
		end
	end
})
--Makes Puddles when raining
minetest.register_abm({
	nodenames = {"group:leaves","default:dirt","default:dirt_with_grass"},
	neighbors = {"default:air"},
	interval = 10.0, 
	chance = 5000,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.weather == "rain" then
				local na = minetest.get_node({x=pos.x,y=pos.y+1,z=pos.z})
				if minetest.get_node_light({x=pos.x,y=pos.y+1,z=pos.z}, 0.5) == 15
				and na.name == "air" then
					minetest.set_node({x=pos.x,y=pos.y+1,z=pos.z}, {name="mymonths:puddle"})
				end
		end
	end
})
--Makes puddles dry up when not raining
minetest.register_abm({
	nodenames = {"mymonths:puddle"},
	neighbors = {},
	interval = 10.0, 
	chance = 10,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.weather == "none" then
			minetest.remove_node(pos)
		end
	end
})
--Makes puddles turn into snow if weather is snow
minetest.register_abm({
	nodenames = {"mymonths:puddle"},
	neighbors = {},
	interval = 10.0, 
	chance = 5,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.weather == "snow" then
			minetest.set_node(pos,{name = "mymonths:snow_cover_1"})
		end
	end
})
