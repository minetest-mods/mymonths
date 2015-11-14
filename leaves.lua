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

minetest.register_abm({ --All leaves should be pale green by mid September
	nodenames = {'default:leaves'},
	interval = 5,
	chance = 1,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.month == 'September' and
			mymonths.day_counter >= 8 then
			minetest.set_node(pos, {name = 'mymonths:leaves_pale_green'})
		end
	end
})
minetest.register_abm({ --All leaves should be orange by October
	nodenames = {'default:leaves', 'mymonths:leaves_pale_green'},
	interval = 5,
	chance = 1,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if  mymonths.month == 'October' and
			tonumber(mymonths.day_counter) >= 1 and
			tonumber(mymonths.day_counter) <= 7 then
			minetest.set_node(pos, {name = 'mymonths:leaves_orange'})
		end
	end
})
minetest.register_abm({ --All leaves should be red by mid October
	nodenames = {'default:leaves', 'mymonths:leaves_pale_green','mymonths:leaves_orange'},
	interval = 5,
	chance = 1,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.month == 'October' and
			mymonths.day_counter >= 8 then
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
		local nodeu1 = minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z})
		local nodeu2 = minetest.get_node({x=pos.x,y=pos.y-2,z=pos.z})
		local nodeu3 = minetest.get_node({x=pos.x,y=pos.y-3,z=pos.z})
		local nodeu4 = minetest.get_node({x=pos.x,y=pos.y-4,z=pos.z})
		if mymonths.month == 'November' then
			if nodeu1.name == "air" then
				minetest.spawn_item({x=pos.x,y=pos.y-1,z=pos.z}, 'default:apple')
				minetest.set_node(pos,{name = 'mymonths:leaves_sticks'})
			elseif nodeu2.name == "air" then
				minetest.spawn_item({x=pos.x,y=pos.y-2,z=pos.z}, 'default:apple')
				minetest.set_node(pos,{name = 'mymonths:leaves_sticks'})
			elseif nodeu3.name == "air" then
				minetest.spawn_item({x=pos.x,y=pos.y-3,z=pos.z}, 'default:apple')
				minetest.set_node(pos,{name = 'mymonths:leaves_sticks'})
			elseif nodeu4.name == "air" then
				minetest.spawn_item({x=pos.x,y=pos.y-4,z=pos.z}, 'default:apple')
				minetest.set_node(pos,{name = 'mymonths:leaves_sticks'})
			else
				minetest.set_node(pos,{name = 'mymonths:leaves_sticks'})
			end
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

minetest.register_abm({ --apples change to leaves or sticks is not in season
	nodenames = {'default:apple'},
	interval = 1,
	chance = 1,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if mymonths.month == 'December' or mymonths.month == 'January' or mymonths.month == 'February' then
				minetest.set_node(pos,{name = 'mymonths:leaves_sticks'})
		elseif mymonths.month == 'March' or mymonths.month == 'April' then
				minetest.set_node(pos,{name = 'mymonths:leaves_blooms'})
		elseif mymonths.month == 'May' or mymonths.month == 'June' then
				minetest.set_node(pos,{name = 'default:leaves'})
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
