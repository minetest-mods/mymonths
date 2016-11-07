--Settings
mymonths = {}

--Turn damage on or off. This will make storms and hail cause damage to players
mymonths.damage = false

--You can turn weather off; this will put snow and puddles off too
mymonths.use_weather = true

--Leaves change color in the fall.
mymonths.leaves = true

--Have snow accumulate on the ground
mymonths.snow_on_ground = true

--Puddles appear when raining
mymonths.use_puddles = true

--Flowers die in winter, grown in spring
mymonths.flowers_die = true

--Grass changes color in fall, and spring
mymonths.grass_change = true

if minetest.get_modpath("lightning") then
   lightning.auto = false
end

local modpath = minetest.get_modpath("mymonths")
local input = io.open(modpath .. "/settings.txt", "r")

if input then

   dofile(modpath .. "/settings.txt")
   input:close()
   input = nil

end

dofile(modpath .. "/functions.lua")
dofile(modpath .. "/abms.lua")
dofile(modpath .. "/command.lua")
dofile(modpath .. "/months.lua")

if mymonths.use_weather == true then
   dofile(modpath .. "/weather.lua")
else
   mymonths.snow_on_ground = false
   mymonths.use_puddles = false
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

if mymonths.grass_change == true then
   dofile(modpath .. "/grass.lua")
end

if mymonths.leaves == true then
   dofile(modpath .. "/leaves.lua")
else
   minetest.register_alias("mymonths:leaves_pale_green", "default:leaves")
   minetest.register_alias("mymonths:leaves_orange", "default:leaves")
   minetest.register_alias("mymonths:leaves_red", "default:leaves")
   minetest.register_alias("mymonths:sticks_default", "default:leaves")
   minetest.register_alias("mymonths:sticks_aspen", "default:aspen_leaves")
   minetest.register_alias("mymonths:leaves_yellow_aspen", "default:aspen_leaves")
   minetest.register_alias("mymonths:leaves_orange_aspen", "default:aspen_leaves")
   minetest.register_alias("mymonths:leaves_red_aspen", "default:aspen_leaves")
end

if mymonths.flowers_die == true then
   dofile(modpath  .. '/pre-flowers.lua')
   dofile(modpath .. "/flowers.lua")
else
   minetest.register_alias('mymonths:deadplant', 'air')
end
