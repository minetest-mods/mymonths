minetest.register_node("mymonths:deadplant", {
	description = "Dead Plant",
	drawtype = "plantlike",
	tiles = {"mymonths_deadplant.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true,
	sunlight_propagates = true,
	inventory_image = "mymonths_deadplant.png",
	visual_scale = 1.2,
	wield_scale = {x=0.5, y=0.5, z=0.5},
	groups = {snappy=3, flammable=1, attatched_node=1,},
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, -0.1, 0.2}
	},
	walkable = false,
   on_punch = function(pos)
      leaves_fall(pos)
   end
})

-- Flowers die in late fall
minetest.register_abm({
	nodenames = {'group:flower'},
	interval = 60,
	chance = 100,

	action = function (pos)

		if mymonths.month_counter == 10
		or mymonths.month_counter == 11 then

			minetest.set_node(pos, {name = 'mymonths:deadplant'})
		end
	end
})

minetest.register_abm({
	nodenames = {'mymonths:deadplant'},
	interval = 60,
	chance = 100,

	action = function (pos)

		if mymonths.month_counter == 12
		or mymonths.month_counter == 1 then

			minetest.set_node(pos, {name = 'air'})
		end
	end
})

-- Flowers grow in spring, flower spread ABM is in flower mod, this just gives
-- initial population as that ABM won't grow flowers where there are none.
minetest.register_abm({
	nodenames = {'group:soil'},
	interval = 10,
	chance = 300,

	action = function (pos, node)
      if node.name == 'default:desert_sand' or node.name == 'default:dirth_with_snow' then
         return
      end

		-- return if not march or april
		if mymonths.month_counter ~= 3
		and mymonths.month_counter ~= 4 then
			return
		end

		local pos0 = {x = pos.x - 4, y = pos.y - 2, z = pos.z - 4}
		local pos1 = {x = pos.x + 4, y = pos.y + 2, z = pos.z + 4}
		local flowers = minetest.find_nodes_in_area(pos0, pos1, "group:flower")

		if #flowers > 1 then
			return
		end

		pos.y = pos.y + 1

		if minetest.get_node(pos).name == 'air' then
         local key = math.random(1, mymonths.flower_number)
         local placed_flower = mymonths.flowers[key]
         minetest.set_node(pos, {name = placed_flower})
		end
	end
})
