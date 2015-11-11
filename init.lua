function save_table()
	local data = mymonths
	local f, err = io.open(minetest.get_worldpath().."/mymonths_data", "w")
    if err then return err end
	f:write(minetest.serialize(data))
	f:close()
end
local function read_mymonths()
	local f, err = io.open(minetest.get_worldpath().."/mymonths_data", "r")
	local data = minetest.deserialize(f:read("*a"))
	f:close()
	return data
end
local tmr = 0
minetest.register_globalstep(function(dtime)
	tmr = tmr + dtime;
	if tmr >= 10 then
		tmr = 0
		save_table()
	end
end)
mymonths = {}
local days_per_month = 15
local morn = 6000
local night = 22000
local tseconds = 3
local t1 = 52 -- 14 min set to 52
local t2 = 60 -- 12 min set to 60
local t3 = 72 -- 10 min set to 72
local t4 = 90 -- 8 min set to 90
local t5 = 120 -- 6 min set to 120
local f, err = io.open(minetest.get_worldpath().."/mymonths_data", "r")
if f == nil then
mymonths.day_speed = 72
mymonths.night_speed = 72
mymonths.day_counter = 1
mymonths.month_counter = 6
mymonths.month = "June"
mymonths.weather = "none"
mymonths.weather2 = "none"
else
mymonths.day_speed = read_mymonths().day_speed
mymonths.night_speed = read_mymonths().night_speed
mymonths.day_counter = read_mymonths().day_counter
mymonths.month_counter = read_mymonths().month_counter
mymonths.month = read_mymonths().month
mymonths.weather = read_mymonths().weather
mymonths.weather2 = "none"
end



local timer = 0
minetest.register_globalstep(function(dtime)
-- Checks every X seconds
	timer = timer + dtime
	if timer < 3 then
		return
	end
	timer = 0
--Checks for morning
	local time_in_seconds = minetest.get_timeofday() * 24000
	if time_in_seconds >= morn  and
		time_in_seconds <= morn + 200 then
		minetest.setting_set("time_speed", mymonths.day_speed)
		mymonths.day_counter = mymonths.day_counter + 1
		minetest.set_timeofday(0.259)
		if mymonths.day_counter >= days_per_month +1 then 
			mymonths.month_counter = mymonths.month_counter + 1
			if mymonths.month_counter >= 13 then
				mymonths.month_counter = 1
			end
			mymonths.day_counter = 1
		end
--January
		if mymonths.month_counter == 1 then
			mymonths.month = "January"
			mymonths.day_speed = t5
			mymonths.night_speed = t1
			minetest.chat_send_all("The date is "..mymonths.month.." "..mymonths.day_counter)
--February
		elseif mymonths.month_counter == 2 then
			mymonths.month = "February"
			mymonths.day_speed = t5
			mymonths.night_speed = t1
			minetest.chat_send_all("The date is "..mymonths.month.." "..mymonths.day_counter)
--March
		elseif mymonths.month_counter == 3 then
			mymonths.month = "March"
			mymonths.day_speed = t4
			mymonths.night_speed = t2
			minetest.chat_send_all("The date is "..mymonths.month.." "..mymonths.day_counter)
--April
		elseif mymonths.month_counter == 4 then
			mymonths.month = "April"
			mymonths.day_speed = t4
			mymonths.night_speed = t2
			minetest.chat_send_all("The date is "..mymonths.month.." "..mymonths.day_counter)
--May
		elseif mymonths.month_counter == 5 then
			mymonths.month = "May"
			mymonths.day_speed = t3
			mymonths.night_speed = t3
			minetest.chat_send_all("The date is "..mymonths.month.." "..mymonths.day_counter)
--June
		elseif mymonths.month_counter == 6 then
			mymonths.month = "June"
			mymonths.day_speed = t3
			mymonths.night_speed = t3
			minetest.chat_send_all("The date is "..mymonths.month.." "..mymonths.day_counter)
--July
		elseif mymonths.month_counter == 7 then
			mymonths.month = "July"
			mymonths.day_speed = t1
			mymonths.night_speed = t5
			minetest.chat_send_all("The date is "..mymonths.month.." "..mymonths.day_counter)
--August
		elseif mymonths.month_counter == 8 then
			mymonths.month = "August"
			mymonths.day_speed = t1
			mymonths.night_speed = t5
			minetest.chat_send_all("The date is "..mymonths.month.." "..mymonths.day_counter)
--September
		elseif mymonths.month_counter == 9 then
			mymonths.month = "September"
			mymonths.day_speed = t3
			mymonths.night_speed = t3
			minetest.chat_send_all("The date is "..mymonths.month.." "..mymonths.day_counter)
--October
		elseif mymonths.month_counter == 10 then
			mymonths.month = "October"
			mymonths.day_speed = t3
			mymonths.night_speed = t3
			minetest.chat_send_all("The date is "..mymonths.month.." "..mymonths.day_counter)
--November
		elseif mymonths.month_counter == 11 then
			mymonths.month = "November"
			mymonths.day_speed = t4
			mymonths.night_speed = t2
			minetest.chat_send_all("The date is "..mymonths.month.." "..mymonths.day_counter)
--December
		elseif mymonths.month_counter == 12 then
			mymonths.month = "December"
			mymonths.day_speed = t4
			mymonths.night_speed = t2
			minetest.chat_send_all("The date is "..mymonths.month.." "..mymonths.day_counter)
		end
   elseif time_in_seconds >= night and
		time_in_seconds <= night + 200 then
		minetest.setting_set("time_speed", mymonths.night_speed)
		minetest.set_timeofday(0.925)
   end
   
end)
minetest.register_globalstep(function(dtime)
   	if mymonths.weather == "rain" or mymonths.weather == "snow" then
		if math.random(1, 10000) == 1 then
			mymonths.weather = "none"
			save_table()
		end
	else
		if mymonths.month_counter == 1 then--January
				if math.random(1, 10000) == 1 then
				mymonths.weather = "snow"
				minetest.chat_send_all("Looks like snow is on it's way")
				save_table()
				end
		elseif mymonths.month_counter == 2 then--February
				if math.random(1, 10000) == 1 then
				mymonths.weather = "snow"
				minetest.chat_send_all("Looks like snow is on it's way")
				save_table()
				end
		elseif mymonths.month_counter == 3 then --March
				if math.random(1, 10000) == 1 then
				mymonths.weather = "rain"
				minetest.chat_send_all("Might be a rainy day")
				save_table()
				elseif math.random(1, 25000) == 2 then
				mymonths.weather = "snow"
				minetest.chat_send_all("Looks like snow is on it's way")
				save_table()
				end
		elseif mymonths.month_counter == 4 then --April
				if math.random(1, 10000) == 1 then
				mymonths.weather = "rain"
				minetest.chat_send_all("Might be a rainy day")
				save_table()
				end
		elseif mymonths.month_counter == 5 then --May
				if math.random(1, 15000) == 1 then
				mymonths.weather = "rain"
				minetest.chat_send_all("Might be a rainy day")
				save_table()
				end
		elseif mymonths.month_counter == 6 then --June
				if math.random(1, 20000) == 1 then
				mymonths.weather = "rain"
				elseif math.random(1, 50000) == 1 then
				mymonths.weather = "storm"
				minetest.chat_send_all("Might be a rainy day")
				save_table()
				end
		elseif mymonths.month_counter == 7 then --July
				if math.random(1, 50000) == 1 then
				mymonths.weather = "rain"
				minetest.chat_send_all("Might be a rainy day")
				save_table()
				end
		elseif mymonths.month_counter == 8 then --August
				if math.random(1, 50000) == 1 then
				mymonths.weather = "rain"
				minetest.chat_send_all("Might be a rainy day")
				save_table()
				end
		elseif mymonths.month_counter == 9 then --September
				if math.random(1, 15000) == 1 then
				mymonths.weather = "rain"
				minetest.chat_send_all("Might be a rainy day")
				save_table()
				end
		elseif mymonths.month_counter == 10 then --October
				if math.random(1, 10000) == 1 then
				mymonths.weather = "rain"
				minetest.chat_send_all("Might be a rainy day")
				save_table()
				end
		elseif mymonths.month_counter == 11 then --November
				if math.random(1, 10000) == 1 then
				mymonths.weather = "rain"
				minetest.chat_send_all("Might be a rainy day")
				save_table()
				elseif math.random(1, 20000) == 2 then
				mymonths.weather = "snow"
				minetest.chat_send_all("Looks like snow is on it's way")
				save_table()
				end
		elseif mymonths.month_counter == 12 then --December
				if math.random(1, 25000) == 1 then
				mymonths.weather = "rain"
				minetest.chat_send_all("Might be a rainy day")
				save_table()
				elseif math.random(1, 10000) == 1 then
				mymonths.weather = "snow"
				minetest.chat_send_all("Looks like snow is on it's way")
				save_table()
				end
		end
	end
end)

dofile(minetest.get_modpath("mymonths").."/weather.lua")
dofile(minetest.get_modpath("mymonths").."/abms.lua")
dofile(minetest.get_modpath("mymonths").."/leaves.lua")
dofile(minetest.get_modpath("mymonths").."/command.lua")
