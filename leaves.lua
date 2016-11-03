
--Nodes #################

local leaves_table = {
	'pale_green', 'orange', 'red', 'blooms', 'acacia_blooms',
	'orange_aspen', 'red_aspen', 'aspen_blooms', 'yellow_aspen'}

local sticks_table = {'default', 'aspen'}

for i, name in pairs(leaves_table) do

	minetest.register_node('mymonths:leaves_' .. name, {
		description = name .. ' leaves',
		drawtype = 'allfaces_optional',
		waving = 1,
		visual_scale = 1.3,
		tiles = {'mymonths_leaves_' .. name .. '.png'},
		paramtype = 'light',
		is_ground_content = false,
		groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
		sounds = default.node_sound_leaves_defaults(),
		after_place_node = default.after_place_leaves,
	})
end

for i, name in pairs(sticks_table) do
	
minetest.register_node('mymonths:sticks_' .. name, {
	description = 'Sticks',
	drawtype = 'allfaces_optional',
	waving = 1,
	visual_scale = 1.3,
	tiles = {'mymonths_sticks.png'},
	paramtype = 'light',
	is_ground_content = false,
	drop = 'default:stick 2',
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
})
end

--ABMs and LBMs ##################

--leaves changing in September and October.
minetest.register_abm({
	nodenames = {'group:leaves'},
	interval = 60,
	chance = 40,
	action = function (pos, node, active_object_count, active_object_count_wider)

		if mymonths.month_counter == 9
		or mymonths.month_counter == 10 then

			if node.name == 'default:leaves' then

				minetest.set_node(pos, {name = 'mymonths:leaves_pale_green'})

			elseif node.name == 'mymonths:leaves_pale_green' then

				minetest.set_node(pos, {name = 'mymonths:leaves_orange'})

			elseif node.name == 'mymonths:leaves_orange' then

				minetest.set_node(pos, {name = 'mymonths:leaves_red'})

			elseif node.name == 'mymonths:leaves_red' then

				minetest.set_node(pos, {name = 'mymonths:sticks_default'})

			elseif node.name == 'default:aspen_leaves' then

				minetest.set_node(pos, {name = 'mymonths:leaves_yellow_aspen'})

			elseif node.name == 'mymonths:leaves_yellow_aspen' then

				minetest.set_node(pos, {name = 'mymonths:leaves_orange_aspen'})

			elseif node.name == 'mymonths:leaves_orange_aspen' then

				minetest.set_node(pos, {name = 'mymonths:leaves_red_aspen'})
			end
		end
	end
})

--leaves 'falling/dying' in October
minetest.register_abm({
	nodenames = {'mymonths:leaves_red', 'mymonths:leaves_red_aspen'},
	interval = 60, 
	chance = 40,

	action = function (pos, node, active_object_count, active_object_count_wider)

		if mymonths.month_counter == 10 then

			if node.name == 'mymonths:leaves_red' then

				minetest.set_node(pos, {name = 'mymonths:sticks_default'})

			elseif node.name == 'mymonths:leaves_red_aspen' then

				minetest.set_node(pos, {name = 'mymonths:sticks_aspen'})
			end
		end
	end
})

--New growth in spring
minetest.register_abm({
	nodenames = {'mymonths:sticks_default', 'mymonths:leaves_blooms', 'mymonths:sticks_aspen', 'mymonths:leaves_aspen_blooms'},
	interval = 60, 
	chance = 40,

	action = function (pos, node, active_object_count, active_object_count_wider)

		if mymonths.month_counter == 3
		or mymonths.month_counter == 4 then

			if node.name == 'mymonths:sticks_default' then

				minetest.set_node(pos, {name = 'mymonths:leaves_blooms'})

			elseif node.name == 'mymonths:leaves_blooms' then

				minetest.set_node(pos, {name = 'default:leaves'})

			elseif node.name == 'mymonths:sticks_aspen' then

				minetest.set_node(pos, {name = 'mymonths:leaves_aspen_blooms'})

			elseif node.name == 'mymonths:leaves_aspen_blooms' then

				minetest.set_node(pos, {name = 'default:aspen_leaves'})
			end
		end
	end
})

--apples die in November
minetest.register_abm({
	nodenames = {'default:apple'},
	interval = 15,
	chance = 10,

	action = function (pos, node, active_object_count, active_object_count_wider)

		local nodeu1 = minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z})
		local nodeu2 = minetest.get_node({x = pos.x, y = pos.y - 2, z = pos.z})
		local nodeu3 = minetest.get_node({x = pos.x, y = pos.y - 3, z = pos.z})
		local nodeu4 = minetest.get_node({x = pos.x, y = pos.y - 4, z = pos.z})

		if mymonths.month_counter == 11 then

			if nodeu1.name == "air" then

				minetest.spawn_item({
					x = pos.x,
					y = pos.y - 1,
					z = pos.z}, 'default:apple')

				minetest.set_node(pos,{name = 'mymonths:sticks_default'})

			elseif nodeu2.name == "air" then

				minetest.spawn_item({
					x = pos.x,
					y = pos.y - 2,
					z = pos.z}, 'default:apple')

				minetest.set_node(pos,{name = 'mymonths:sticks_default'})

			elseif nodeu3.name == "air" then

				minetest.spawn_item({
					x = pos.x,
					y = pos.y - 3,
					z = pos.z}, 'default:apple')

				minetest.set_node(pos,{name = 'mymonths:sticks_default'})

			elseif nodeu4.name == "air" then

				minetest.spawn_item({
					x = pos.x,
					y = pos.y - 4,
					z = pos.z}, 'default:apple')

				minetest.set_node(pos,{name = 'mymonths:sticks_default'})

			else
				minetest.set_node(pos,{name = 'mymonths:sticks_default'})
			end
		end
	end
})


minetest.register_abm({
	nodenames = {'default:leaves','default:acacia_leaves'},
	interval = 60,
	chance = 15,

	action = function (pos, node, active_object_count, active_object_count_wider)

	local n = node.name

		if n == 'default:leaves' then

			if mymonths.month_counter == 6
			or mymonths.month_counter == 7
			or mymonths.month_counter == 8
			or mymonths.month_counter == 9 then

				local a = minetest.find_node_near(pos, 3, 'default:apple')

				if a == nil then
					minetest.set_node(pos,{name = 'default:apple'})
				end
			end

		end

		if n == 'default:acacia_leaves' then

			if mymonths.month_counter == 1 then
				minetest.set_node(pos,{name = 'mymonths:leaves_acacia_blooms'})
			end

		end

	end
})

--Leaf changing LBM
minetest.register_lbm({
	name = "mymonths:change_leaves",

	nodenames = {'default:leaves', 'mymonths:leaves_pale_green','mymonths:leaves_orange',
				'mymonths:leaves_red', 'mymonths:sticks_default', 'mymonths:leaves_blooms',
				'default:aspen_leaves', 'mymonths:leaves_aspen_blooms', 'mymonths:leaves_orange_aspen',
				'mymonths:leaves_red_aspen', 'mymonths:sticks_aspen',
				'default:acacia_leaves', 'mymonths:leaves_acacia_blooms'},

	run_at_every_load = true,

	action = function (pos, node)

		local n = node.name
		local month = tonumber(mymonths.month_counter)
		local day = tonumber(mymonths.day_counter)

-- January
		if month == 1 then

			-- Default Leaves
			if n == 'default:leaves'
			or n == 'mymonths:leaves_blooms'
			or n == 'mymonths:leaves_pale_green'
			or n == 'mymonths:leaves_orange'
			or n == 'mymonths:leaves_red' then

				minetest.set_node(pos, {name = 'mymonths:sticks_default'})

			end

			-- Aspen Leaves
			if n == 'default:aspen_leaves'
			or n == 'mymonths:leaves_aspen_blooms'
			or n == 'mymonths:leaves_yellow_aspen'
			or n == 'mymonths:leaves_orange_aspen'
			or n == 'mymonths:leaves_red_aspen' then

				minetest.set_node(pos, {name = 'mymonths:sticks_aspen'})

			end

			-- Acacia Leaves
			if n == 'default:acacia_leaves' then

				minetest.set_node(pos,{name = 'mymonths:leaves_acacia_blooms'})

			end

			-- Apples
			if n == 'default:apple' then

				minetest.set_node(pos,{name = 'mymonths:sticks_default'})

			end

		end

-- Feburary
		if month == 2 then

			-- Default Leaves
			if n == 'default:leaves'
			or n == 'mymonths:leaves_blooms'
			or n == 'mymonths:leaves_pale_green'
			or n == 'mymonths:leaves_orange'
			or n == 'mymonths:leaves_red' then

				minetest.set_node(pos, {name = 'mymonths:sticks_default'})

			end

			-- Aspen Leaves
			if n == 'default:aspen_leaves'
			or n == 'mymonths:leaves_aspen_blooms'
			or n == 'mymonths:leaves_yellow_aspen'
			or n == 'mymonths:leaves_orange_aspen'
			or n == 'mymonths:leaves_red_aspen' then

				minetest.set_node(pos, {name = 'mymonths:sticks_aspen'})

			end

			-- Acacia Leaves
			if n == 'default:acacia_leaves' then

				minetest.set_node(pos,{name = 'mymonths:leaves_acacia_blooms'})

			end

			-- Apples
			if n == 'default:apple' then

				minetest.set_node(pos,{name = 'mymonths:sticks_default'})

			end

		end

-- March
		if month == 3 then

			-- Default Leaves
			if n == 'default:leaves'
			or n == 'mymonths:leaves_pale_green'
			or n == 'mymonths:leaves_orange'
			or n == 'mymonths:leaves_red' then

				minetest.set_node(pos, {name = 'mymonths:sticks_default'})

			end

			-- Aspen Leaves
			if n == 'default:aspen_leaves'
			or n == 'mymonths:leaves_aspen_blooms'
			or n == 'mymonths:leaves_yellow_aspen'
			or n == 'mymonths:leaves_orange_aspen'
			or n == 'mymonths:leaves_red_aspen' then

				minetest.set_node(pos, {name = 'mymonths:sticks_aspen'})

			end

			-- Acacia Leaves
			if n == 'mymonths:leaves_acacia_blooms' then

				minetest.set_node(pos,{name = 'default:acacia_leaves'})

			end

			-- Apples
			if n == 'default:apple' then

				minetest.set_node(pos,{name = 'mymonths:leaves_blooms'})

			end

		end

-- April
		if month == 4 then

			-- Default Leaves
			if n == 'mymonths:sticks_default'
			or n == 'mymonths:leaves_pale_green'
			or n == 'mymonths:leaves_orange'
			or n == 'mymonths:leaves_red' then

				minetest.set_node(pos, {name = 'default:leaves'})

			end

			-- Aspen Leaves
			if n == 'default:aspen_leaves'
			or n == 'mymonths:sticks_aspen'
			or n == 'mymonths:leaves_yellow_aspen'
			or n == 'mymonths:leaves_orange_aspen'
			or n == 'mymonths:leaves_red_aspen' then

				minetest.set_node(pos, {name = 'mymonths:leaves_aspen_blooms'})

			end

			-- Acacia Leaves
			if n == 'mymonths:leaves_acacia_blooms' then

				minetest.set_node(pos,{name = 'default:acacia_leaves'})

			end

			-- Apples
			if n == 'default:apple' then

				minetest.set_node(pos,{name = 'mymonths:leaves_blooms'})

			end

		end

-- May
		if month == 5 then

			-- Default Leaves
			if n == 'mymonths:sticks_default'
			or n == 'mymonths:leaves_pale_green'
			or n == 'mymonths:leaves_orange'
			or n == 'mymonths:leaves_red' then

				minetest.set_node(pos, {name = 'default:leaves'})

			end

			-- Aspen Leaves
			if n == 'mymonths:leaves_aspen_blooms'
			or n == 'mymonths:sticks_aspen'
			or n == 'mymonths:leaves_yellow_aspen'
			or n == 'mymonths:leaves_orange_aspen'
			or n == 'mymonths:leaves_red_aspen' then

				minetest.set_node(pos, {name = 'default:aspen_leaves'})

			end

			-- Acacia Leaves
			if n == 'mymonths:leaves_acacia_blooms' then

				minetest.set_node(pos,{name = 'default:acacia_leaves'})

			end

			-- Apples
			if n == 'default:apple' then

				minetest.set_node(pos,{name = 'default:leaves'})

			end

		end

-- June
		if month == 6 then

			-- Default Leaves
			if n == 'mymonths:sticks_default'
			or n == 'mymonths:leaves_pale_green'
			or n == 'mymonths:leaves_orange'
			or n == 'mymonths:leaves_red' then

				minetest.set_node(pos, {name = 'default:leaves'})

			end

			-- Aspen Leaves
			if n == 'mymonths:leaves_aspen_blooms'
			or n == 'mymonths:sticks_aspen'
			or n == 'mymonths:leaves_yellow_aspen'
			or n == 'mymonths:leaves_orange_aspen'
			or n == 'mymonths:leaves_red_aspen' then

				minetest.set_node(pos, {name = 'default:aspen_leaves'})

			end

			-- Acacia Leaves
			if n == 'mymonths:leaves_acacia_blooms' then

				minetest.set_node(pos,{name = 'default:acacia_leaves'})

			end

			-- Apples
			-- Nothing Happens

		end

-- July
		if month == 7 then

			-- Default Leaves
			if n == 'mymonths:sticks_default'
			or n == 'mymonths:leaves_pale_green'
			or n == 'mymonths:leaves_orange'
			or n == 'mymonths:leaves_red' then

				minetest.set_node(pos, {name = 'default:leaves'})

			end

			-- Aspen Leaves
			if n == 'mymonths:leaves_aspen_blooms'
			or n == 'mymonths:sticks_aspen'
			or n == 'mymonths:leaves_yellow_aspen'
			or n == 'mymonths:leaves_orange_aspen'
			or n == 'mymonths:leaves_red_aspen' then

				minetest.set_node(pos, {name = 'default:aspen_leaves'})

			end

			-- Acacia Leaves
			if n == 'mymonths:leaves_acacia_blooms' then

				minetest.set_node(pos,{name = 'default:acacia_leaves'})

			end

			-- Apples
			-- Nothing Happens

		end

-- Augest
		if month == 8 then

			-- Default Leaves
			if n == 'mymonths:sticks_default'
			or n == 'mymonths:leaves_pale_green'
			or n == 'mymonths:leaves_orange'
			or n == 'mymonths:leaves_red' then

				minetest.set_node(pos, {name = 'default:leaves'})

			end

			-- Aspen Leaves
			if n == 'mymonths:leaves_aspen_blooms'
			or n == 'mymonths:sticks_aspen'
			or n == 'mymonths:leaves_yellow_aspen'
			or n == 'mymonths:leaves_orange_aspen'
			or n == 'mymonths:leaves_red_aspen' then

				minetest.set_node(pos, {name = 'default:aspen_leaves'})

			end

			-- Acacia Leaves
			if n == 'mymonths:leaves_acacia_blooms' then

				minetest.set_node(pos,{name = 'default:acacia_leaves'})

			end

			-- Apples
			-- Nothing Happens

		end

-- September
		if month == 9 then

			-- Default Leaves
			if day >= 1
			and day <= 7 then

				if n == 'mymonths:sticks_default' then

					minetest.set_node(pos, {name = 'default:leaves'})

				end

			end

			if day >=8
			and day <=14 then

				if n == 'mymonths:sticks_default'
				or n == 'default:leaves' then

					minetest.set_node(pos, {name = 'mymonths:leaves_pale_green'})

				end

			end

			-- Aspen Leaves
			if day >= 1
			and day <=7 then

				if n == 'mymonths:sticks_aspen'
				or n == 'mymonths:leaves_aspen_blooms' then

					minetest.set_node(pos, {name = 'default:aspen_leaves'})

				end

			end

			if day >=8
			and day <=14 then

				if n == 'mymonths:sticks_aspen'
				or n == 'mymonths:leaves_aspen_blooms'
				or n == 'default:aspen_leaves' then

					minetest.set_node(pos, {name = 'mymonths:leaves_yellow_aspen'})

				end

			end

			-- Acacia Leaves
			if n == 'mymonths:leaves_acacia_blooms' then

				minetest.set_node(pos,{name = 'default:acacia_leaves'})

			end

			-- Acacia Leaves
			if n == 'mymonths:leaves_acacia_blooms' then

				minetest.set_node(pos,{name = 'default:acacia_leaves'})

			end

			-- Apples
			-- Nothing Happens

		end

-- October
		if month == 10 then

			-- Default Leaves
			if day >= 1
			and day <=7 then

				if n == 'mymonths:sticks_default' 
				or n == 'default:leaves'
				or n == 'mymonths:leaves_pale_green' then

					minetest.set_node(pos, {name = 'mymonths:leaves_orange'})

				end

			end

			if day >=8
			and day <=14 then

				if n == 'default:leaves'
				or n == 'mymonths:leaves_pale_green'
				or n == 'mymonths:leaves_orange' then

					minetest.set_node(pos, {name = 'mymonths:leaves_red'})

				end

			end

			-- Aspen Leaves
			if day >= 1
			and day <=7 then

				if n == 'mymonths:sticks_aspen' 
				or n == 'mymonths:leaves_yellow_aspen'
				or n == 'mymonths:leaves_aspen_blooms'
				or n == 'default:aspen_leaves' then

					minetest.set_node(pos, {name = 'mymonths:leaves_orange_aspen'})

				end

			end

			if day >=8
			and day <=14 then

				if n == 'mymonths:sticks_aspen'
				or n == 'mymonths:leaves_yellow_aspen'
				or n == 'mymonths:leaves_orange_aspen'
				or n == 'mymonths:leaves_aspen_blooms'
				or n == 'default:aspen_leaves' then

					minetest.set_node(pos, {name = 'mymonths:leaves_red_aspen'})

				end

			end

			-- Acacia Leaves
			if n == 'mymonths:leaves_acacia_blooms' then

				minetest.set_node(pos,{name = 'default:acacia_leaves'})

			end

			-- Apples
			-- Nothing Happens

		end

-- November
		if month == 11 then

			-- Default Leaves
			if n == 'default:leaves'
			or n == 'mymonths:leaves_blooms'
			or n == 'mymonths:leaves_pale_green'
			or n == 'mymonths:leaves_orange'
			or n == 'mymonths:leaves_red' then

				minetest.set_node(pos, {name = 'mymonths:sticks_default'})

			end

			-- Aspen Leaves
			if n == 'default:aspen_leaves'
			or n == 'mymonths:leaves_aspen_blooms'
			or n == 'mymonths:leaves_yellow_aspen'
			or n == 'mymonths:leaves_orange_aspen'
			or n == 'mymonths:leaves_red_aspen' then

				minetest.set_node(pos, {name = 'mymonths:sticks_aspen'})

			end

			-- Acacia Leaves
			if n == 'mymonths:leaves_acacia_blooms' then

				minetest.set_node(pos,{name = 'default:acacia_leaves'})

			end

			-- Apples
			-- Nothing Happens

		end

-- December
		if month == 12 then

			-- Default Leaves
			if n == 'default:leaves'
			or n == 'mymonths:leaves_blooms'
			or n == 'mymonths:leaves_pale_green'
			or n == 'mymonths:leaves_orange'
			or n == 'mymonths:leaves_red' then

				minetest.set_node(pos, {name = 'mymonths:sticks_default'})

			end

			-- Aspen Leaves
			if n == 'default:aspen_leaves'
			or n == 'mymonths:leaves_aspen_blooms'
			or n == 'mymonths:leaves_yellow_aspen'
			or n == 'mymonths:leaves_orange_aspen'
			or n == 'mymonths:leaves_red_aspen' then

				minetest.set_node(pos, {name = 'mymonths:sticks_aspen'})

			end

			-- Acacia Leaves
			if n == 'mymonths:leaves_acacia_blooms' then

				minetest.set_node(pos,{name = 'default:acacia_leaves'})

			end

			-- Apples
			if n == 'default:apple' then

				minetest.set_node(pos,{name = 'mymonths:sticks_default'})

			end

		end

	end -- ends function
})
