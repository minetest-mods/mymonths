local function is_inside(pos)

	if minetest.get_node_light({x=pos.x,y=pos.y+1,z=pos.z}, 0.5) ~= 15 then
		return true
	end

	local temp_node = minetest.get_node_or_nil({x=pos.x,y=pos.y+1,z=pos.z})

	for i = 2,50 do
		if temp_node ~= nil and temp_node.name ~= "air" then
			return true
		end
		temp_node = minetest.get_node_or_nil({x=pos.x,y=pos.y+i,z=pos.z})
	end
	return false
end


--Sets the weather types for each month
local t = 0

minetest.register_globalstep(function(dtime)

	local month = mymonths.month_counter

	t = t + dtime

	if t < 5 then
		return
	end

	t = 0

	if minetest.get_modpath("lightning") then
		if mymonths.weather == "storm" then
		lightning.strike()
		end
	end

	if mymonths.weather ~= "clear" then

		if math.random(1, 100) == 1 then

			mymonths.weather = "clear"
			minetest.chat_send_all("Clear skies!")
		end
	else

		-- January
		if tonumber(month) == 1 then

			if math.random(1, 2000) == 1 then
				mymonths.weather = "snow"
				minetest.chat_send_all("It is Snowing")

			elseif math.random(1, 5000) == 1 then
				mymonths.weather = "snowstorm"
				minetest.chat_send_all("It's a Snow Storm")
			end

		-- February
		elseif tonumber(month) == 2 then

			if math.random(1, 1000) == 1 then
				mymonths.weather = "snow"
				minetest.chat_send_all("It is Snowing")

			elseif math.random(1, 5000) == 1 then
				mymonths.weather = "snowstorm"
				minetest.chat_send_all("It's a Snow storm")

			elseif math.random(1, 5000) == 1 then
				mymonths.weather = "hail"
				minetest.chat_send_all("It is Hailing")
			end

		-- March
		elseif tonumber(month) == 3 then

			if math.random(1, 1000) == 1 then
				mymonths.weather = "rain"
				minetest.chat_send_all("It is Raining")

			elseif math.random(1, 2500) == 2 then
				mymonths.weather = "snow"
				minetest.chat_send_all("It is Snowing")

			elseif math.random(1, 5000) == 1 then
				mymonths.weather = "hail"
				minetest.chat_send_all("It is Hailing")
			end

		-- April
		elseif tonumber(month) == 4 then

			if math.random(1, 1000) == 1 then
				mymonths.weather = "rain"
			end

		-- May
		elseif tonumber(month) == 5 then

			if math.random(1, 1500) == 1 then
				mymonths.weather = "rain"
				minetest.chat_send_all("It is Raining")

			elseif math.random(1, 5000) == 1 then
				mymonths.weather = "storm"
				minetest.chat_send_all("It's a Storm")
			end

		-- June
		elseif 	tonumber(month) == 6 then

			if math.random(1, 5000) == 1 then
				mymonths.weather = "rain"
				minetest.chat_send_all("It is Raining")

			elseif math.random(1, 5000) == 1 then
				mymonths.weather = "storm"
				minetest.chat_send_all("It's a Storm")
			end

		-- July
		elseif tonumber(month) == 7 then

			if math.random(1, 5000) == 1 then
				mymonths.weather = "rain"
				minetest.chat_send_all("It is Raining")

			elseif math.random(1, 5000) == 1 then
				mymonths.weather = "storm"
				minetest.chat_send_all("It's a Storm")
			end

		-- August
		elseif 	tonumber(month) == 8 then

			if math.random(1, 5000) == 1 then
				mymonths.weather = "rain"
				minetest.chat_send_all("It is Raining")

			elseif math.random(1, 5000) == 1 then
				mymonths.weather = "storm"
				minetest.chat_send_all("It's a Storm")
			end

		-- September
		elseif tonumber(month) == 9 then

			if math.random(1, 1500) == 1 then
				mymonths.weather = "rain"
				minetest.chat_send_all("It is Raining")

			elseif math.random(1, 2500) == 1 then
				mymonths.weather = "storm"
				minetest.chat_send_all("It's a Storm")
			end

		-- October
		elseif tonumber(month) == 10 then

			if math.random(1, 1000) == 1 then
				mymonths.weather = "rain"
				minetest.chat_send_all("It is Raining")

			elseif math.random(1, 2500) == 1 then
				mymonths.weather = "storm"
				minetest.chat_send_all("It's a Storm")
			end

		-- November
		elseif tonumber(month) == 11 then

			if math.random(1, 1000) == 1 then
				mymonths.weather = "rain"
				minetest.chat_send_all("It is Raining")

			elseif math.random(1, 2000) == 2 then
				mymonths.weather = "snow"
				minetest.chat_send_all("It is Snowing")
			end

		-- December
		elseif tonumber(month) == 12 then

			if math.random(1, 2500) == 1 then
				mymonths.weather = "rain"
				minetest.chat_send_all("It is Raining")

			elseif math.random(1, 1000) == 1 then
				mymonths.weather = "snow"
				minetest.chat_send_all("It is Snowing")

			elseif math.random(1, 5000) == 1 then
				mymonths.weather = "hail"
				minetest.chat_send_all("It is Hailing")
			end
		end
	end
end)

-- Weather vectors and some particles are from jeija's weather mod
addvectors = function (v1, v2)
	return {x = v1.x + v2.x, y = v1.y + v2.y, z = v1.z + v2.z}
end

hp_t = 0

--structure:
--[[
active_particlespawners = {
	[player_name] = {
		pSpawnerId1,
		pSpawnerId2,
		...
		pSpawnerIdn
	}
}
]]--
mymonths.active_particlespawners={}
--used to determine if to remove old and add new particle spawners
mymonths.last_weather2="none"
function mymonths.update_weather_particles(player)

	mymonths.remove_weather_particles(player)

	local name=player:get_player_name()

	local minp = {x = -20, y = 7, z = -20}
	local maxp = {x = 20, y = 7, z = 20}
	local minps = {x =-20, y = 0, z = -20}
	local maxps = {x = 20, y = 3, z = 20}
	local minp_deep = {x = -20, y = 3.2, z = -20}
	local maxp_deep = {x = 20, y = 2.6, z = 20}
	local vel_rain = {x = 0, y = -4, z = 0}
	local acc_rain = {x = 0, y = -9.81, z = 0}
	local vel_snow = {x = 0, y = -0.4, z = 0}
	local acc_snow = {x = 0, y = -0.5, z = 0}
	local vel_sand = {x = 1, y = -0.1, z = 0}
	local acc_sand = {x = 2, y = 0, z = 0}

	local l={}

	if mymonths.weather2 == "storm" then

		l[1] = minetest.add_particlespawner({
			amount = 4000,
			time = 0,
			minpos = minp,
			maxpos = maxp,
			minvel = vel_rain,
			maxvel = vel_rain,
			minacc = acc_rain,
			maxacc = acc_rain,
			minexptime = 0.8,
			maxexptime = 0.8,
			minsize = 25,
			maxsize = 40,
			collisiondetection = false,
			vertical = true,
			texture = "weather_rain_dark.png",
			playername = name,
			attached = player
		})

	elseif mymonths.weather2 == "rain" then

		l[1] = minetest.add_particlespawner({
			amount = 1500,
			time = 0,
			minpos = minp,
			maxpos = maxp,
			minvel = vel_rain,
			maxvel = vel_rain,
			minacc = acc_rain,
			maxacc = acc_rain,
			minexptime = 0.6,
			maxexptime = 0.8,
			minsize = 25,
			maxsize = 25,
			collisiondetection = false,
			vertical = true,
			texture = "weather_rain.png",
			playername = name,
			attached = player
		})

	elseif mymonths.weather2 == "snow" then

		l[1] = minetest.add_particlespawner({
			amount = 400,
			time = 0,
			minpos = minp,
			maxpos = maxp,
			minvel = vel_snow,
			maxvel = vel_snow,
			minacc = acc_snow,
			maxacc = acc_snow,
			minexptime = 4,
			maxexptime = 8,
			minsize = 15,
			maxsize = 25,
			collisiondetection = false,
			vertical = true,
			texture = "weather_snow.png",
			playername = name,
			attached = player
		})

		l[2] = minetest.add_particlespawner({
			amount = 400,
			time = 0,
			minpos = minp_deep,
			maxpos = maxp_deep,
			minvel = vel_snow,
			maxvel = vel_snow,
			minacc = acc_snow,
			maxacc = acc_snow,
			minexptime = 4,
			maxexptime = 6,
			minesize = 15,
			maxsize = 25,
			collisiondetection = false,
			vertical = true,
			texture = "weather_snow.png",
			playername = name,
			attached = player
		})

	elseif mymonths.weather2 == "snowstorm" then

		l[1] = minetest.add_particlespawner({
			amount = 2500,
			time = 0,
			minpos = minp,
			maxpos = maxp,
			minvel = vel_snow,
			maxvel = vel_snow,
			minacc = acc_snow,
			maxacc = acc_snow,
			minexptime = 4,
			maxexptime = 6,
			minesize = 15,
			maxsize = 35,
			collisiondetection = false,
			vertical = true,
			texture = "weather_snow.png",
			playername = name,
			attached = player
		})

		l[2] = minetest.add_particlespawner({
			amount = 2500,
			time = 0,
			minpos = minp_deep,
			maxpos = maxp_deep,
			minvel = vel_snow,
			maxvel = vel_snow,
			minacc = acc_snow,
			maxacc = acc_snow,
			minexptime = 4,
			maxexptime = 6,
			minesize = 15,
			maxsize = 25,
			collisiondetection = false,
			vertical = true,
			texture = "weather_snow.png",
			playername = name,
			attached = player
		})

	elseif mymonths.weather2 == "sandstorm" then

		l[1] = minetest.add_particlespawner({
			amount = 3500,
			time = 0,
			minpos = minps,
			maxpos = maxps,
			minvel = vel_sand,
			maxvel = vel_sand,
			minacc = acc_sand,
			maxacc = acc_sand,
			minexptime = 4,
			maxexptime = 4,
			minesize = 5,
			maxsize = 10,
			collisiondetection = false,
			vertical = true,
			texture = "weather_sand.png",
			playername = name,
			attached = player
		})

	elseif mymonths.weather2 == "hail" then

		l[1] = minetest.add_particlespawner({
			amount = 3500,
			time = 0,
			minpos = minp,
			maxpos = maxp,
			minvel = vel_rain,
			maxvel = vel_rain,
			minacc = acc_rain,
			maxacc = acc_rain,
			minexptime = 1,
			maxexptime = 1,
			minesize = 5,
			maxsize = 10,
			collisiondetection = true,
			vertical = true,
			texture = "weather_hail.png",
			playername = name,
			attached = player
		})
	end
	mymonths.active_particlespawners[name]=l
end
function mymonths.remove_weather_particles(player)
	local pname=player:get_player_name()
	if not mymonths.active_particlespawners[pname] then return end
	for _,pid in ipairs(mymonths.active_particlespawners[pname]) do
		minetest.delete_particlespawner(pid)
	end
	mymonths.active_particlespawners[pname]={}
end
minetest.register_on_joinplayer(function()
	--enforce weather particle re-initialization on next step
	mymonths.last_weather2=""
end)


minetest.register_globalstep(function(dtime)

	hp_t = hp_t + dtime

	if hp_t <= 0.2 then
		return
	end

	mymonths.weather2 = mymonths.weather

	for _, player in ipairs(minetest.get_connected_players()) do

		local ppos = player:get_pos()
		local hp = player:get_hp()
		local name = player:get_player_name()
		local nodein = minetest.get_node(ppos)
		local nodeu = minetest.get_node({x = ppos.x, y = ppos.y - 1, z = ppos.z})

		local biome_jungle = minetest.find_node_near(ppos, 8, "default:jungletree", "default:junglegrass")
		local biome_desert = minetest.find_node_near(ppos, 8, "default:desert_sand", "default:desert_stone")
		local biome_snow = minetest.find_node_near(ppos, 8, "default:snow", "default:snowblock", "default:dirt_with_snow",
					 "default:ice", "default:pine_tree", "mymonths:snow_cover_5")

		-- slows players walk in snow
		if nodein.name == "mymonths:snow_cover_1" then

			player:set_physics_override(0.95, 1, 1, true, false)

		elseif nodein.name == "mymonths:snow_cover_2" then

			player:set_physics_override(0.8, 1, 1, true, false)

		elseif nodein.name == "mymonths:snow_cover_3" then

			player:set_physics_override(0.65, 1, 1, true, false)

		elseif nodein.name == "mymonths:snow_cover_4" then

			player:set_physics_override(0.5, 1, 1, true, false)

		elseif nodein.name == "mymonths:snow_cover_5" then

			player:set_physics_override(0.35, 1, 1, true, false)
		else
			player:set_physics_override(1, 1, 1, true, false)
		end

		-- checks if there is any weather
		if mymonths.weather2 == "none" then
			return
		end

		-- check light to make sure player is outside
		if is_inside(ppos) then
			return
		end

		-- changes weather based on biome

		-- Jungle
		if biome_jungle ~= nil then

			if mymonths.weather == "snow" then

				mymonths.weather2 = "rain"

			elseif mymonths.weather == "snowstorm"
			or mymonths.weather == "hail" then

				mymonths.weather2 = "storm"
			end

		-- Desert
		elseif biome_desert ~= nil then

			if mymonths.weather == "snow"
			or mymonths.weather == "rain" then

				mymonths.weather2 = "clear"

			elseif mymonths.weather == "snowstorm"
			or mymonths.weather == "hail"
			or mymonths.weather == "storm" then

				mymonths.weather2 = "sandstorm"
			end

		-- Snow
		elseif biome_snow ~= nil then

			if mymonths.weather == "rain" then

				mymonths.weather2 = "snow"

			elseif mymonths.weather == "storm" then

				mymonths.weather2 = "snowstorm"
			end
		else
			mymonths.weather2 = mymonths.weather
		end

		if mymonths.weather2 ~= mymonths.last_weather2 then
			mymonths.update_weather_particles(player)
			mymonths.last_weather2 = mymonths.weather2
		end

		if mymonths.weather2 == "storm" then

			if not is_inside(ppos) and mymonths.damage == true then

				if hp_t >= 15 then
					player:set_hp(hp - 1)
					hp_t = 0
				end
			end

			if math.random(1, 200) == 1 then

				minetest.sound_play("mymonths_thunder", {
					pos = ppos,
					max_hear_distance = 10,
					gain = 10.0,
				})
			end

		elseif mymonths.weather2 == "snowstorm" then

			if not is_inside(ppos) and mymonths.damage == true then
				if hp_t >= 15 then
					player:set_hp(hp - 1)
					hp_t = 0
				end
			end

		elseif mymonths.weather2 == "sandstorm" then

			if not is_inside(ppos) and mymonths.damage == true then
				if hp_t >= 15 then
					player:set_hp(hp - 1)
					hp_t = 0
				end
			end

		elseif mymonths.weather2 == "hail" then

			if not is_inside(ppos) and mymonths.damage == true then
				if hp_t >= 15 then
					player:set_hp(hp - 1)
					hp_t = 0
				end
			end
		end

		biome_jungle = nil
		biome_snow = nil
		biome_desert = nil

	end
end)

local t2 = 0

minetest.register_globalstep(function(dtime)

	for _, player in ipairs(minetest.get_connected_players()) do

		local ppos = player:get_pos()

		t2 = t2 + dtime

		if t2 < 1 then
			return
		end

		t2 = 0

		if mymonths.weather2 == "rain"
		or mymonths.weather2 == "storm" then

			minetest.sound_play("mymonths_rain1", {
				pos = ppos,
				max_hear_distance = 10,
				gain = 2.0,
			})
		end
	end
end)

--Puddle node
local puddle_box = {
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
	drop = "",
})

--Snow Nodes
local snow = {
	{"mymonths:snow_cover_1","1", -0.4},
	{"mymonths:snow_cover_2","2", -0.2},
	{"mymonths:snow_cover_3","3", 0},
	{"mymonths:snow_cover_4","4", 0.2},
	{"mymonths:snow_cover_5","5", 0.5},
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
		walkable = false,
		node_box = {
			type  = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, box, 0.5}
		},
		selection_box = {
			type  = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, box, 0.5}
		},
		groups = {not_in_creative_inventory = 0, crumbly = 3, attached_node = 0, falling_node = 1},
		drop = "default:snow " .. num,
	})
end
