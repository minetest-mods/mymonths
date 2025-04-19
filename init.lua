local setting_weather = core.settings:get_bool("mymonths.use_weather", true)
local setting_damage = core.settings:get_bool("mymonths.use_damage", false)
local setting_leaves = core.settings:get_bool("mymonths.use_leaves", true)
local setting_snow = core.settings:get_bool("mymonths.use_snow", true)
local setting_puddles = core.settings:get_bool("mymonths.use_puddles", true)
local setting_flowers = core.settings:get_bool("mymonths.use_flowers", true)

--Settings
mymonths = {}

--Turn damage on or off. This will make storms and hail cause damage
mymonths.damage = setting_damage

--You can turn weather off 
mymonths.use_weather = setting_weather

--Leaves change color in the fall.
mymonths.leaves = setting_leaves

--Have snow accumulate on the ground
mymonths.snow_on_ground = setting_snow

--Puddles appear when raining
mymonths.use_puddles = setting_puddles

--Flowers die in winter, grown in spring
mymonths.flowers_die = setting_flowers

if minetest.get_modpath("lightning") then 
	lightning.auto = false 
end

--[[
local modpath = minetest.get_modpath("mymonths")
local input = io.open(modpath.."/settings.txt", "r")

if input then

	dofile(modpath.."/settings.txt")
	input:close()
	input = nil
else
	mymonths.damage = false
	mymonths.use_weather = true
	mymonths.leaves = true
	mymonths.snow_on_ground = false
	mymonths.use_puddles = true
end
--]]
dofile(minetest.get_modpath("mymonths") .. "/functions.lua")
dofile(minetest.get_modpath("mymonths") .. "/abms.lua")
dofile(minetest.get_modpath("mymonths") .. "/command.lua")
dofile(minetest.get_modpath("mymonths") .. "/months.lua")
dofile(minetest.get_modpath("mymonths") .. "/snow_blower.lua")
dofile(minetest.get_modpath("mymonths") .. "/grass.lua")
--dofile(minetest.get_modpath("mymonths") .. "/roofs.lua")

if mymonths.use_weather == true then
	dofile(minetest.get_modpath("mymonths").."/weather.lua")
end

if mymonths.use_weather == false then
	minetest.register_alias("mymonths:puddle", "air")
	minetest.register_alias("mymonths:snow_cover_1", "air")
	minetest.register_alias("mymonths:snow_cover_2", "air")
	minetest.register_alias("mymonths:snow_cover_3", "air")
	minetest.register_alias("mymonths:snow_cover_4", "air")
	minetest.register_alias("mymonths:snow_cover_5", "air")
end

if mymonths.snow_on_ground == false then

	minetest.register_alias("mymonths:snow_cover_1", "air")
	minetest.register_alias("mymonths:snow_cover_2", "air")
	minetest.register_alias("mymonths:snow_cover_3", "air")
	minetest.register_alias("mymonths:snow_cover_4", "air")
	minetest.register_alias("mymonths:snow_cover_5", "air")
end

if mymonths.use_puddles == false then
	minetest.register_alias("mymonths:puddle", "air")
end

if mymonths.leaves == true then
	dofile(minetest.get_modpath("mymonths") .. "/leaves.lua")
end

if mymonths.leaves == false then

	minetest.register_alias("mymonths:leaves_pale_green", "default:leaves")
	minetest.register_alias("mymonths:leaves_orange", "default:leaves")
	minetest.register_alias("mymonths:leaves_red", "default:leaves")
	minetest.register_alias("mymonths:sticks_default", "default:leaves")
	minetest.register_alias("mymonths:sticks_aspen", "default:aspen_leaves")
end

if mymonths.flowers_die == true then
	dofile(minetest.get_modpath("mymonths") .. "/pre-flowers.lua")
	dofile(minetest.get_modpath("mymonths") .. "/flowers.lua")
end

if minetest.get_modpath("thirsty") then
	thirst = true
end
