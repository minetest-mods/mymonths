local function level_snow(pos, node, depth)

	local sides = {
		{x=pos.x - 1, y=pos.y, z=pos.z},
		{x=pos.x - 1, y=pos.y, z=pos.z + 1},
		{x=pos.x, y=pos.y, z=pos.z + 1},
		{x=pos.x + 1, y=pos.y, z=pos.z + 1},
		{x=pos.x + 1, y=pos.y, z=pos.z},
		{x=pos.x + 1, y=pos.y, z=pos.z - 1},
		{x=pos.x, y=pos.y, z=pos.z - 1},
		{x=pos.x - 1, y=pos.y, z=pos.z - 1},
	}
	local snow_level = {}
	snow_level["air"] = {"mymonths:snow_cover_1", 0}
	snow_level["default:snow"] = {"mymonths:snow_cover_3", 2}
	snow_level["mymonths:snow_cover_1"] = {"mymonths:snow_cover_2", 1}
	snow_level["mymonths:snow_cover_2"] = {"mymonths:snow_cover_3", 2}
	snow_level["mymonths:snow_cover_3"] = {"mymonths:snow_cover_4", 3}
	snow_level["mymonths:snow_cover_4"] = {"mymonths:snow_cover_5", 4}
	snow_level["mymonths:snow_cover_5"] = {"default:snowblock", 5}

	for i = 1,8 do
		local temp_node = minetest.get_node_or_nil(sides[i])
		-- check if node exsists and block is solid
		if temp_node ~= nil and snow_level[temp_node.name] ~= nil then
			-- check the difference in snow heights
			if snow_level[node.name][2] - snow_level[temp_node.name][2] > 2 then
				-- shift the node down till it can be filled
				if temp_node.name == "air" then
					while minetest.get_node_or_nil({x=sides[i].x, y=sides[i].y - 1, z=sides[i].z}) ~= nil and
							snow_level[minetest.get_node_or_nil({x=sides[i].x, y=sides[i].y - 1, z=sides[i].z}).name] ~= nil do
						sides[i].y = sides[i].y - 1
					end
					if depth > 4 or level_snow(sides[i], temp_node, depth + 1) then
						temp_node = minetest.get_node_or_nil(sides[i])
					end
				end
				minetest.set_node(sides[i], {name = snow_level[temp_node.name][1]})
				return false
			end
		end
	end
	return true
end

local function is_inside(pos)

	if minetest.get_node_light({x=pos.x,y=pos.y+1,z=pos.z}, 0.5) ~= 15 then
		return true
	end

	local temp_node = minetest.get_node_or_nil({x=pos.x,y=pos.y+1,z=pos.z})

	for i = 2,50 do
		if temp_node ~= nil and temp_node.name ~= "air" then
			return true
		end
		temp_node = minetest.get_node_or_nil({x=pos.x,y=pos.y+i,z=pos.z})
	end
	return false
end

local function get_melt_prob(pos)
	local list1 = minetest.find_nodes_in_area({x=pos.x-3,y=pos.y-2,z=pos.z-3},
		{x=pos.x+3,y=pos.y+1,z=pos.z+3},{"default:ice", "default:snowblock"})
	local list2 = minetest.find_nodes_in_area({x=pos.x-3,y=pos.y-2,z=pos.z-3},
		{x=pos.x+3,y=pos.y+1,z=pos.z+3},{"mymonths:snow_cover_5",
		"mymonths:snow_cover_4","mymonths:snow_cover_3","mymonths:snow_cover_2","mymonths:snow_cover_1"})
	local list3 = minetest.find_nodes_in_area({x=pos.x-3,y=pos.y-2,z=pos.z-3},
		{x=pos.x+3,y=pos.y+1,z=pos.z+3},{"default:dirt_with_snow", "default:pine_tree"})
	-- list1 is snow blocks and ice, list 2 is snow cover nodes, list3 is snow dirt and pine trees
	local count = 2.25 * table.getn(list1) + table.getn(list2) + 2 * table.getn(list3)
	local prob = 1 - count/196
	prob = math.max(tonumber(string.format("%.2f", prob * 10)), 0.01)
	prob = 1 / (prob / 200)
	prob = math.min(tonumber(string.format("%04d", prob)), 1000)
	return prob
end


--Places Snow on ground
if mymonths.snow_on_ground == true then

minetest.register_abm({
	nodenames = {"group:leaves", "group:soil", "default:snowblock"},
	neighbors = {"air"},
	interval = 8,
	chance = 20,

	action = function (pos, node)

		local biome_jungle = minetest.find_node_near(pos, 5, "default:jungletree", "default:junglegrass")

		pos.y = pos.y + 1 -- check above node

		local na = minetest.get_node(pos)

		if (mymonths.weather == "snow" or mymonths.weather == "snowstorm")
		and biome_jungle == nil then

			if not is_inside(pos) and na.name == "air" then

				minetest.set_node(pos, {name = "mymonths:snow_cover_1"})

			end
		end
	end
})

--Replace grass and flowers with snow
minetest.register_abm({
	nodenames = {"group:flora", "mymonths:puddle", "group:plant"},
	neighbors = {"air"},
	interval = 8,
	chance = 20,

	action = function (pos, node)

		local biome_jungle = minetest.find_node_near(pos, 5, "default:jungletree","default:junglegrass")

		if mymonths.weather == "snow" or mymonths.weather == "snowstorm"
		and biome_jungle == nil then

				if not is_inside(pos) then
					minetest.set_node(pos, {name="mymonths:snow_cover_1"})
				end
		end
	end
})

-- Changes snow to larger snow
minetest.register_abm({
	nodenames = {"mymonths:snow_cover_1", "mymonths:snow_cover_2", "mymonths:snow_cover_3", "mymonths:snow_cover_4", "mymonths:snow_cover_5", "default:snow"},
	neighbors = {"group:soil", "default:snowblock"},
	interval = 20,
	chance = 40,

	action = function (pos, node)

			if mymonths.weather2 == "snow"
			or mymonths.weather2 == "snowstorm" then

				if mymonths.weather2 == "snow"
				and math.random(1, 4) ~= 1 then
					return
				end

				if node.name == "mymonths:snow_cover_1" then

					minetest.set_node(pos, {name = "mymonths:snow_cover_2"})

				elseif node.name == "mymonths:snow_cover_2" or node.name == "default:snow" then

					minetest.set_node(pos, {name = "mymonths:snow_cover_3"})

				elseif node.name == "mymonths:snow_cover_3" then

					minetest.set_node(pos, {name = "mymonths:snow_cover_4"})

				elseif node.name == "mymonths:snow_cover_4" then

					minetest.set_node(pos, {name = "mymonths:snow_cover_5"})

				elseif node.name == "mymonths:snow_cover_5" then

					local depth = 2

					local snow_biome = minetest.find_node_near(pos, 5, {"default:ice"})

					-- checks the number of snow blocks below to determine if snow is too deep
					local count = 0
					for i = 1, depth do
						local new_pos_y = pos.y - i
						local temp_node = minetest.get_node_or_nil({x=pos.x, y=new_pos_y, z=pos.z})
						if temp_node ~= nil then
							if temp_node.name == "default:snowblock" then
								count = count + 1
							end
						end
					end

					if level_snow(pos, node, 0) and (count ~= depth or snow_biome) then
						minetest.set_node(pos, {name = "default:snowblock"})
					end
				end
			end
	end
})

-- Snow Melting
minetest.register_abm({
	nodenames = {"mymonths:snow_cover_1", "mymonths:snow_cover_2", "mymonths:snow_cover_3", "mymonths:snow_cover_4", "mymonths:snow_cover_5", "default:snowblock", "default:snow"},
	neighbors = {"air"},
	interval = 10,
	chance = 1,

	action = function (pos, node)

		if mymonths.month_counter == 12
		or mymonths.month_counter == 1
		or mymonths.month_counter == 2 then
			return
		end

		local melt_prob = get_melt_prob(pos)

		if melt_prob == 1000 then
			return
		end

		if math.random(1, melt_prob) == 1 then

			-- check if there is any blocks above it
			while minetest.get_node_or_nil({x=pos.x, y=pos.y + 1, z=pos.z}) and
				 minetest.get_node_or_nil({x=pos.x, y=pos.y + 1, z=pos.z}).name ~= "air" do
				pos.y = pos.y + 1
				node = minetest.get_node_or_nil(pos)
			end

			if node.name == "mymonths:snow_cover_2" or node.name == "default:snow" then

				minetest.set_node(pos, {name = "mymonths:snow_cover_1"})

			elseif node.name == "mymonths:snow_cover_3" then

				minetest.set_node(pos, {name = "mymonths:snow_cover_2"})

			elseif node.name == "mymonths:snow_cover_4" then

				minetest.set_node(pos, {name = "mymonths:snow_cover_3"})

			elseif node.name == "mymonths:snow_cover_5" then

				minetest.set_node(pos, {name = "mymonths:snow_cover_4"})

			elseif node.name == "default:snowblock" then

				minetest.set_node(pos, {name = "mymonths:snow_cover_5"})

			elseif node.name == "mymonths:snow_cover_1" then

				local nu = minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z})

				if nu.name == "default:dirt_with_grass"
				or nu.name == "default:dirt" then

					minetest.set_node(pos, {name = "mymonths:puddle"})
				else
					minetest.remove_node(pos)
				end
			end
		end
	end
})

end -- END IF

if mymonths.use_puddles == true then

-- Makes Puddles when raining
minetest.register_abm({
	nodenames = {"group:soil"},
	neighbors = {"default:air"},
	interval = 10,
	chance = 50,

	action = function (pos, node)

		if mymonths.weather == "rain" then

			-- return if puddle found nearby
			if minetest.find_node_near(pos, 20, "mymonths:puddle") then
				return
			end

			pos.y = pos.y + 1

			-- otherwise place puddle in empty space
			if minetest.get_node_light(pos, 0.5) == 15
			and minetest.get_node(pos).name == "air" then

				minetest.set_node(pos, {name = "mymonths:puddle"})
			end
		end
	end
})

-- Makes puddles dry up when not raining
minetest.register_abm({
	nodenames = {"mymonths:puddle"},
	neighbors = {"air"},
	interval = 5,
	chance = 5,

	action = function (pos, node)

		if mymonths.weather == "clear" then

			minetest.remove_node(pos)

		elseif mymonths.weather == "snow"
		or mymonths.weather == "snowstorm" then

			minetest.set_node(pos, {name = "mymonths:snow_cover_1"})

		end
	end
})

end -- END IF
