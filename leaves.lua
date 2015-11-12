--Nodes #################
local leaves_table = {--name, tex
{'pale_green', 'pale_green'}, --first stage
{'orange', 'orange'}, --second stage
{'red', 'red'}, --third stage
{'sticks', 'sticks'}, --after leaves fall
{'blooms', 'blooms'}, --Spring!!!
}

for i in ipairs (leaves_table) do
	local name = leaves_table[i][1]
	local tex = leaves_table[i][2]
	
minetest.register_node('mymonths:leaves_'..name, {
	description = name..' leaves',
	drawtype = 'allfaces_optional',
	waving = 1,
	visual_scale = 1.3,
	tiles = {'mymonths_leaves_'..tex..'.png'},
	paramtype = 'light',
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves,
})
end

--ABMs ##################
minetest.register_abm({ --leaves changing in September
	nodenames = {'group:leaves'},
	interval = 10.0, 
	chance = 10,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.month == 'September' then
			if node.name == 'default:leaves' then
				minetest.swap_node(pos, {name = 'mymonths:leaves_pale_green'})
			elseif node.name == 'mymonths:leaves_pale_green' then
				minetest.swap_node(pos, {name = 'mymonths:leaves_orange'})
			elseif node.name == 'mymonths:leaves_orange' then
				minetest.swap_node(pos, {name = 'mymonths:leaves_red'})
			end
		end
	end
})

minetest.register_abm({ --All leaves should be red in October
	nodenames = {'default:leaves', 'mymonths:leaves_pale_green','mymonths:leaves_orange'},
	interval = 5,
	chance = 1,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.month == 'October' then
			minetest.swap_node(pos, {name = 'mymonths:leaves_red'})
		end
	end
})

minetest.register_abm({ --leaves 'falling/dying' in October
	nodenames = {'mymonths:leaves_red'},
	interval = 10.0, 
	chance = 10,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.month == 'October' then
			minetest.swap_node(pos, {name = 'mymonths:leaves_sticks'})
		end
	end
})

minetest.register_abm({ --All leaves should be sticks in November
	nodenames = {'default:leaves', 'mymonths:leaves_pale_green', 'mymonths:leaves_orange', 'mymonths:leaves_red'},
	interval = 5,
	chance = 1,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.month == 'November' then
			minetest.swap_node(pos, {name = 'mymonths:leaves_sticks'})
		end
	end
})

minetest.register_abm({ --New growth in spring
	nodenames = {'mymonths:leaves_sticks', 'mymonths:leaves_blooms'},
	interval = 10.0, 
	chance = 10,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.month == 'March' then
			if node.name == 'mymonths:leaves_sticks' then
				minetest.swap_node(pos, {name = 'mymonths:leaves_blooms'})
			elseif node.name == 'mymonths:leaves_blooms' then
				minetest.swap_node(pos, {name = 'default:leaves'})
			end
		end
	end
})

minetest.register_abm({ --By April all trees should be back to normal
	nodenames = {'mymonths:leaves_sticks', 'mymonths:leaves_blooms'},
	interval = 5,
	chance = 1,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.month == 'April' then
			minetest.swap_node(pos, {name = 'default:leaves'})
		end
	end
})

minetest.register_abm({ --apples die in November
	nodenames = {'default:apple'},
	interval = 15,
	chance = 10,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.month == 'November' then
			minetest.set_node(pos,{name = 'air'})
		end
	end
})

minetest.register_abm({ --apples grow in spring
	nodenames = {'default:leaves'},
	interval = 15,
	chance = 20,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.month == 'July' or 'August' or 'September' then
			local posbelow = {x=pos.x, y=pos.y-1, z=pos.z}
			local below = minetest.get_node(posbelow)
			if below.name == 'air' then
				local a = minetest.find_node_near(pos, 3, 'default:apple')
				if a == nil then
					minetest.set_node(posbelow,{name = 'default:apple'})
				end
			end
		end
	end
})
