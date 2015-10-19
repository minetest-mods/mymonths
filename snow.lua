-- Snow partical
minetest.register_globalstep(function(dtime)
	if mymonths.weather ~= "snow" then return end
	for _, player in ipairs(minetest.get_connected_players()) do
		local ppos = player:getpos()
		-- Make sure player is not in a cave/house...
		if minetest.env:get_node_light(ppos, 0.5) ~= 15 then return end
		local minp = addvectors(ppos, {x=-9, y=7, z=-9})
		local maxp = addvectors(ppos, {x= 9, y=7, z= 9})
		local minp_deep = addvectors(ppos, {x=-10, y=3.2, z=-10})
		local maxp_deep = addvectors(ppos, {x= 10, y=2.6, z= 10})
		local vel = {x=0, y=   -0.5, z=0}
		local acc = {x=0, y=   -0.5, z=0}
		minetest.add_particlespawner(5, 0.5,
			minp, maxp,
			vel, vel,
			acc, acc,
			5, 5,
			25, 25,
			false, "weather_snow.png", player:get_player_name())
		minetest.add_particlespawner(4, 0.5,
			minp_deep, maxp_deep,
			vel, vel,
			acc, acc,
			4, 4,
			25, 25,
			false, "weather_snow.png", player:get_player_name())
	end
end)
--Snow Nodes
local snow_box ={type  = "fixed",fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}}
local snow = {
	{"mymonths:snow_cover_1","1",-0.4},
	{"mymonths:snow_cover_2","2",-0.2},
	{"mymonths:snow_cover_3","3",0},
	{"mymonths:snow_cover_4","4",0.2},
	}
for i in ipairs(snow) do
local itm = snow[i][1]
local num = snow[i][2]
local box = snow[i][3]
minetest.register_node(itm, {
	tiles = {"weather_snow_cover.png"},
	drawtype = "nodebox",
	paramtype = "light",
	buildable_to = true,
	node_box = {type  = "fixed",fixed = {-0.5, -0.5, -0.5, 0.5, box, 0.5}},
	selection_box = {type  = "fixed",fixed = {-0.5, -0.5, -0.5, 0.5, box, 0.5}},
	groups = {not_in_creative_inventory = 0, crumbly = 3, attached_node = 1},
	drop = "default:snow "..num
})
end
