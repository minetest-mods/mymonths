--Places Snow on ground
if mymonths.snow_on_ground == true then
minetest.register_abm({
	nodenames = {"group:leaves","default:dirt","default:dirt_with_grass"},
	neighbors = {"air","mymonths:puddle"},
	interval = 5.0, 
	chance = 40,
	action = function (pos, node, active_object_count, active_object_count_wider)
		local na = minetest.get_node({x=pos.x,y=pos.y+1,z=pos.z})
		if mymonths.weather2 == "snow" and
			math.random(1,4) == 1 then
			if 		minetest.get_node_light({x=pos.x,y=pos.y+1,z=pos.z}, 0.5) == 15 and na.name == "air" then
					minetest.set_node({x=pos.x,y=pos.y+1,z=pos.z}, {name="mymonths:snow_cover_1"})
			elseif 	minetest.get_node({x=pos.x,y=pos.y+1,z=pos.z}) == "mymonths:puddle" then
					minetest.set_node({x=pos.x,y=pos.y+1,z=pos.z}, {name="mymonths:snow_cover_1"})
			end
		elseif mymonths.weather2 == "snowstorm" then
			if 		minetest.get_node_light({x=pos.x,y=pos.y+1,z=pos.z}, 0.5) == 15 and na.name == "air" then
					minetest.set_node({x=pos.x,y=pos.y+1,z=pos.z}, {name="mymonths:snow_cover_1"})
			elseif 	minetest.get_node({x=pos.x,y=pos.y+1,z=pos.z}) == "mymonths:puddle" then
					minetest.set_node({x=pos.x,y=pos.y+1,z=pos.z}, {name="mymonths:snow_cover_1"})
			end
		end
	end
})
-- Changes snow to larger snow
minetest.register_abm({
	nodenames = {"mymonths:snow_cover_1","mymonths:snow_cover_2","mymonths:snow_cover_3","mymonths:snow_cover_4"},
	neighbors = {"default:dirt","default:dirt_with_grass"},
	interval = 5.0, 
	chance = 40,
	action = function (pos, node, active_object_count, active_object_count_wider)
			if mymonths.weather2 == "snow" and
				math.random(1,4) == 1 then
				if node.name == "mymonths:snow_cover_1" then
					minetest.set_node(pos,{name = "mymonths:snow_cover_2"})
				elseif node.name == "mymonths:snow_cover_2" then
					minetest.set_node(pos,{name = "mymonths:snow_cover_3"})
				elseif node.name == "mymonths:snow_cover_3" then
					minetest.set_node(pos,{name = "mymonths:snow_cover_4"})
				elseif node.name == "mymonths:snow_cover_4" then
					minetest.set_node(pos,{name = "mymonths:snow_cover_5"})
				end
			elseif mymonths.weather2 == "snowstorm" then
				if node.name == "mymonths:snow_cover_1" then
					minetest.set_node(pos,{name = "mymonths:snow_cover_2"})
				elseif node.name == "mymonths:snow_cover_2" then
					minetest.set_node(pos,{name = "mymonths:snow_cover_3"})
				elseif node.name == "mymonths:snow_cover_3" then
					minetest.set_node(pos,{name = "mymonths:snow_cover_4"})
				elseif node.name == "mymonths:snow_cover_4" then
					minetest.set_node(pos,{name = "mymonths:snow_cover_5"})
				end
			end
	end
})
--Snow Melting
minetest.register_abm({
	nodenames = {"mymonths:snow_cover_1","mymonths:snow_cover_2","mymonths:snow_cover_3","mymonths:snow_cover_4","mymonths:snow_cover_5"},
	interval = 10.0, 
	chance = 1,
	action = function (pos, node, active_object_count, active_object_count_wider)
		local ran = math.random(1,100)
		if ran == 1 then
		if mymonths.month_counter ~= "12" or
		   mymonths.month_counter ~= "1" or
		   mymonths.month_counter ~= "2" then
			if node.name == "mymonths:snow_cover_2" then
				minetest.set_node(pos,{name = "mymonths:snow_cover_1"})
			elseif node.name == "mymonths:snow_cover_3" then
				minetest.set_node(pos,{name = "mymonths:snow_cover_2"})
			elseif node.name == "mymonths:snow_cover_4" then
				minetest.set_node(pos,{name = "mymonths:snow_cover_3"})
			elseif node.name == "mymonths:snow_cover_5" then
				minetest.set_node(pos,{name = "mymonths:snow_cover_4"})
			elseif node.name == "mymonths:snow_cover_1" then
				local nu = minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z})
				if ran == 1 and nu.name == "default:dirt_with_grass" then
				minetest.set_node(pos,{name = "mymonths:puddle"})
				else minetest.remove_node(pos)
				end
			end
		end
		end
		if mymonths.month_counter == "6" then --removes snow if month is june
			minetest.remove_node(pos)
		end
	end
})
end

if mymonths.use_puddles == true then
--Makes Puddles when raining
minetest.register_abm({
	nodenames = {"default:dirt","default:dirt_with_grass"},
	neighbors = {"default:air"},
	interval = 10.0, 
	chance = 50,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.weather2 == "rain" then
				local na = minetest.get_node({x=pos.x,y=pos.y+1,z=pos.z})
				local nn = minetest.find_node_near(pos, 20, "mymonths:puddle")
				if nn == nil then
					if 	minetest.get_node_light({x=pos.x,y=pos.y+1,z=pos.z}, 0.5) == 15 and na.name == "air" then
						minetest.set_node({x=pos.x,y=pos.y+1,z=pos.z}, {name="mymonths:puddle"})
					end
				end
		end
	end
})
--Makes puddles dry up when not raining
minetest.register_abm({
	nodenames = {"mymonths:puddle"},
	neighbors = {},
	interval = 5.0, 
	chance = 10,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.weather == "none" then
			minetest.remove_node(pos)
		elseif mymonths.weather2 == "snow" or
				mymonths.weather2 == "snowstorm" then
			minetest.set_node(pos,{name = "mymonths:snow_cover_1"})
		end
	end
})
end
