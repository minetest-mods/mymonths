-- Rain partical
minetest.register_globalstep(function(dtime)
	if mymonths.weather ~= "rain" then return end
	for _, player in ipairs(minetest.get_connected_players()) do
		local ppos = player:getpos()
		-- Make sure player is not in a cave/house...
		if minetest.env:get_node_light(ppos, 0.5) ~= 15 then return end
		local minp = addvectors(ppos, {x=-9, y=7, z=-9})
		local maxp = addvectors(ppos, {x= 9, y=7, z= 9})
		local vel = {x=0, y=   -4, z=0}
		local acc = {x=0, y=-9.81, z=0}
		minetest.add_particlespawner({amount=25, time=0.5,
			minpos=minp, maxpos=maxp,
			minvel=vel, maxvel=vel,
			minacc=acc, maxacc=acc,
			minexptime=0.8, maxexptime=0.8,
			minsize=25, maxsize=25,
			collisiondetection=false, vertical=true, texture="weather_rain.png", player=player:get_player_name()})
	end
end)
--Puddle node
local puddle_box =
{
	type  = "fixed",
	fixed = {
			{-0.1875, -0.5, -0.375, 0.125, -0.4875, 0.3125},
			{-0.25, -0.5, -0.3125, 0.3125, -0.4925, 0.25},
			{-0.3125, -0.5, -0.1875, 0.375, -0.4975, 0.1875},
			}
}
minetest.register_node("mymonths:puddle", {
	tiles = {"weather_puddle.png"},
	drawtype = "nodebox",
	paramtype = "light",
	pointable = false,
	buildable_to = true,
	alpha = 50,
	node_box = puddle_box,
	selection_box = puddle_box,
	groups = {not_in_creative_inventory = 1, crumbly = 3, attached_node = 0, falling_node = 1},
	drop = {""}
})
