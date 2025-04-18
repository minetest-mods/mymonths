minetest.register_tool("mymonths:snow_blower", {
description = "Snow Blower",
inventory_image = "mymonths_snow_blower.png",
wield_image = "mymonths_snow_blower.png",
wield_scale = {x = 1, y = 1, z = 1},
on_use = function(itemstack, user, pointed_thing)
if not pointed_thing or not pointed_thing.above then
return
end

local pos = pointed_thing.above
local nodes_to_check = {
{x = pos.x + 1, y = pos.y - 1, z = pos.z + 1},
{x = pos.x + 1, y = pos.y - 1, z = pos.z},
{x = pos.x + 1, y = pos.y - 1, z = pos.z - 1},
{x = pos.x, y = pos.y - 1, z = pos.z + 1},
{x = pos.x, y = pos.y - 1, z = pos.z},
{x = pos.x, y = pos.y - 1, z = pos.z - 1},
{x = pos.x - 1, y = pos.y - 1, z = pos.z + 1},
{x = pos.x - 1, y = pos.y - 1, z = pos.z},
{x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},

{x = pos.x + 1, y = pos.y, z = pos.z + 1},
{x = pos.x + 1, y = pos.y, z = pos.z},
{x = pos.x + 1, y = pos.y, z = pos.z - 1},
{x = pos.x, y = pos.y, z = pos.z + 1},
{x = pos.x, y = pos.y, z = pos.z},
{x = pos.x, y = pos.y, z = pos.z - 1},
{x = pos.x - 1, y = pos.y, z = pos.z + 1},
{x = pos.x - 1, y = pos.y, z = pos.z},
{x = pos.x - 1, y = pos.y, z = pos.z - 1}
}

local snow_nodes = {
"mymonths:snow_cover_1",
"mymonths:snow_cover_2",
"mymonths:snow_cover_3",
"mymonths:snow_cover_4",
"mymonths:snow_cover_5"
}

local function table_contains(tbl, value)
for _, v in ipairs(tbl) do
if v == value then
return true
end
end
return false
end
for _, check_pos in ipairs(nodes_to_check) do
local node = minetest.get_node(check_pos)
--minetest.chat_send_all("Checking node at: " .. minetest.pos_to_string(check_pos) .. " - Name: " .. node.name)

if node and node.name and table_contains(snow_nodes, node.name) then
minetest.remove_node(check_pos)
--minetest.chat_send_all("Removed snow node at: " .. minetest.pos_to_string(check_pos))
end
end
end
})

--Craft
minetest.register_craft({
	output = "myores:slate_tile 4",
	recipe = {
    		{"default:steel_ingot","",""},
			{"","default:copper_ingot","default:steel_ingot"},
			{"","default:steel_ingot","default:steel_ingot"},
	}
})
