addvectors = function (v1, v2)
	return {x=v1.x+v2.x, y=v1.y+v2.y, z=v1.z+v2.z}
end

local t = 0
minetest.register_globalstep(function(dtime)

	t = t + dtime
	if t >= 1 then
	
	mymonths.weather2 = mymonths.weather
	for _, player in ipairs(minetest.get_connected_players()) do
		local ppos = player:getpos()
		local nodeu = minetest.get_node({x=ppos.x,y=ppos.y-1,z=ppos.z})
		local biome_jungle = minetest.find_node_near(ppos, 5, "default:jungletree","default:junglegrass")
		local biome_desert = minetest.find_node_near(ppos, 5, "default:desert_sand","default:desert_stone")
		local biome_snow = minetest.find_node_near(ppos, 5, "default:snow","default:snowblock","default:dirt_with_snow","default:ice")
		
	
		local minp = addvectors(ppos, {x=-7, y=7, z=-7})
		local maxp = addvectors(ppos, {x= 7, y=7, z= 7})
		local minp_deep = addvectors(ppos, {x=-10, y=3.2, z=-10})
		local maxp_deep = addvectors(ppos, {x= 10, y=2.6, z= 10})
		local vel_rain = {x=0, y=   -4, z=0}
		local acc_rain = {x=0, y=-9.81, z=0}
		local vel_snow = {x=0, y=   -0.4, z=0}
		local acc_snow = {x=0, y=   -0.5, z=0}

	if minetest.get_node_light(ppos, 0.5) ~= 15 then return end	

	if mymonths.weather2 == "none" then return end

	if biome_jungle ~= nil and
		mymonths.weather == "snow" then
		mymonths.weather2 = "rain"
	elseif biome_desert ~= nil and
		mymonths.weather == "snow" then
		mymonths.weather2 = "none"
	elseif biome_desert ~= nil and
		mymonths.weather == "rain" then
		mymonths.weather2 = "none"
	elseif biome_snow ~= nil and
		mymonths.weather == "rain" then
		mymonths.weather2 = "snow"
	else
		mymonths.weather2 = mymonths.weather
	end
	
	if mymonths.weather2 == "rain" then
		minetest.add_particlespawner({amount=15, time=0.5,
			minpos=minp, maxpos=maxp,
			minvel=vel_rain, maxvel=vel_rain,
			minacc=acc_rain, maxacc=acc_rain,
			minexptime=0.6, maxexptime=0.8,
			minsize=25, maxsize=25,
			collisiondetection=false, vertical=true, texture="weather_rain.png", player:get_player_name()})
	end
			
	if mymonths.weather2 == "snow" then
			minetest.add_particlespawner(4, 0.5,
			minp, maxp,
			vel_snow, vel_snow,
			acc_snow, acc_snow,
			4, 6,
			15, 25,
			false, "weather_snow.png", player:get_player_name())
		minetest.add_particlespawner(4, 0.5,
			minp_deep, maxp_deep,
			vel_snow, vel_snow,
			acc_snow, acc_snow,
			4, 6,
			15, 25,
			false, "weather_snow.png", player:get_player_name())
	end
	biome_jungle = nil
	biome_snow = nil
	biome_desert = nil
	end
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

--Snow Nodes
local snow_box ={type  = "fixed",fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}}
local snow = {
	{"mymonths:snow_cover_1","1",-0.4},
	{"mymonths:snow_cover_2","2",-0.2},
	{"mymonths:snow_cover_3","3",0},
	{"mymonths:snow_cover_4","4",0.2},
	{"mymonths:snow_cover_5","5",0.5},
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












