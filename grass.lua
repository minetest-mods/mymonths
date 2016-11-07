minetest.register_node("mymonths:fall_grass", {
	description = "Dirt with Grass",
	tiles = {"default_grass.png^[colorize:brown:50", "default_dirt.png",
		{name = "default_dirt.png^(default_grass_side.png^[colorize:brown:50)",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
   soil = {
		base = "default:dirt_with_dry_grass",
		dry = "farming:soil",
		wet = "farming:soil_wet"
	}
})

minetest.register_abm({
	nodenames = {'default:dirt_with_grass'},
	interval = 60,
	chance = 40,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.month_counter == 9
		or mymonths.month_counter == 10 then
				minetest.set_node(pos, {name = 'mymonths:fall_grass'})
	end
end
})

minetest.register_abm({
	nodenames = {'mymonths:fall_grass'},
	interval = 60,
	chance = 40,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.month_counter == 3 then
			minetest.set_node(pos, {name = 'default:dirt_with_grass'})
	end
end
})

minetest.register_lbm({
	name = "mymonths:change_grass",
	nodenames = {'default:dirt_with_grass', 'mymonths:fall_grass'},
	run_at_every_load = true,
	action = function (pos, node)
		local n = node.name
		local month = tonumber(mymonths.month_counter)
		local day = tonumber(mymonths.day_counter)

		if month == 11
		or month == 12
		or month == 1
		or month == 2 then
			if n == 'default:dirt_with_grass' then
				minetest.set_node(pos, {name = 'mymonths:fall_grass'})
			end

		elseif month == 4
		or month == 5
		or month == 6
		or month == 7
		or month == 8
		or month == 9
		or month == 10 then
			if n == 'mymonths:fall_grass' then
				minetest.set_node(pos, {name = 'default:dirt_with_grass'})
			end
		end
	end
})
