--Nodes #################
local leaves_table = {'pale_green', 'orange', 'red', 'sticks', 'blooms', 'acacia_blooms'}

for i, name in pairs (leaves_table) do
	
minetest.register_node('mymonths:leaves_'..name, {
	description = name..' leaves',
	drawtype = 'allfaces_optional',
	waving = 1,
	visual_scale = 1.3,
	tiles = {'mymonths_leaves_'..name..'.png'},
	paramtype = 'light',
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves,
})
end

--ABMs ##################
minetest.register_abm({ --leaves changing in September and October
	nodenames = {'group:leaves'},
	interval = 60, 
	chance = 40,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.month == 'September' or mymonths.month == 'October' then
			if node.name == 'default:leaves' then
				minetest.set_node(pos, {name = 'mymonths:leaves_pale_green'})
			elseif node.name == 'mymonths:leaves_pale_green' then
				minetest.set_node(pos, {name = 'mymonths:leaves_orange'})
			elseif node.name == 'mymonths:leaves_orange' then
				minetest.set_node(pos, {name = 'mymonths:leaves_red'})
			end
		end
	end
})

minetest.register_abm({ --All leaves should be red in November
	nodenames = {'default:leaves', 'mymonths:leaves_pale_green','mymonths:leaves_orange'},
	interval = 5,
	chance = 1,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.month == 'November' then
			minetest.set_node(pos, {name = 'mymonths:leaves_red'})
		end
	end
})

minetest.register_abm({ --leaves 'falling/dying' in October
	nodenames = {'mymonths:leaves_red'},
	interval = 60, 
	chance = 40,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.month == 'October' then
			minetest.set_node(pos, {name = 'mymonths:leaves_sticks'})
		end
	end
})

minetest.register_abm({ --All leaves should be sticks in November and December
	nodenames = {'default:leaves', 'mymonths:leaves_pale_green', 'mymonths:leaves_orange', 'mymonths:leaves_red'},
	interval = 5,
	chance = 1,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.month == 'November' or mymonths.month == 'December'then
			minetest.set_node(pos, {name = 'mymonths:leaves_sticks'})
		end
	end
})

minetest.register_abm({ --New growth in spring
	nodenames = {'mymonths:leaves_sticks', 'mymonths:leaves_blooms'},
	interval = 60, 
	chance = 40,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.month == 'March' or mymonths.month == 'April' then
			if node.name == 'mymonths:leaves_sticks' then
				minetest.set_node(pos, {name = 'mymonths:leaves_blooms'})
			elseif node.name == 'mymonths:leaves_blooms' then
				minetest.set_node(pos, {name = 'default:leaves'})
			end
		end
	end
})

minetest.register_abm({ --By April all trees should be back to normal
	nodenames = {'mymonths:leaves_sticks', 'mymonths:leaves_blooms'},
	interval = 5,
	chance = 1,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.month == 'May' then
			minetest.set_node(pos, {name = 'default:leaves'})
		end
	end
})

minetest.register_abm({ --apples die in November
	nodenames = {'default:apple'},
	interval = 15,
	chance = 10,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.month == 'November' then
			minetest.set_node(pos,{name = 'mymonths:leaves_sticks'})
		end
	end
})

minetest.register_abm({ --apples grow in fall
	nodenames = {'default:leaves'},
	interval = 60,
	chance = 15,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.month == 'July' or mymonths.month == 'August' or mymonths.month == 'September' then
			local a = minetest.find_node_near(pos, 3, 'default:apple')
			if a == nil then
				minetest.set_node(pos,{name = 'default:apple'})
			end
		end
	end
})

minetest.register_abm ({ --Acacia blooming
	nodenames = {'default:acacia_leaves'},
	interval = 60,
	chance = 15,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.month == 'January' then
				minetest.set_node(pos,{name = 'mymonths:leaves_acacia_blooms'})
			end
		end
})

minetest.register_abm ({ --Acacia blooming
	nodenames = {'mymonths:leaves_acacia_blooms'},
	interval = 15,
	chance = 1,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.month == 'Febuary' then
				minetest.set_node(pos,{name = 'default:acacia_leaves'})
			end
		end
})
