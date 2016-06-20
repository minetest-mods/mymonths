minetest.register_node("mymonths:fall_grass", {
	description = "Dirt with Grass",
	tiles = {"default_grass.png^[colorize:brown:50", "default_dirt.png",
		{name = "default_dirt.png^default_grass_side.png^[colorize:brown:50",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
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
	nodename = {'mymonths:fall_grass'},
	interval = 60,
	chance = 40,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.month_counter == 4 then
			minetest.set_node(pos, {name = 'default:dirt_with_grass'})
	end
end
})
