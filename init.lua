function save_table() -- Save table to file
	local data = mymonths
	local f, err = io.open(minetest.get_worldpath().."/mymonths_data", "w")
    if err then return err end
	f:write(minetest.serialize(data))
	f:close()
end
local function read_mymonths() -- Reads saved file
	local f, err = io.open(minetest.get_worldpath().."/mymonths_data", "r")
	local data = minetest.deserialize(f:read("*a"))
	f:close()
	return data
end
local tmr = 0

-- Saves the table every 10 seconds
minetest.register_globalstep(function(dtime)
	tmr = tmr + dtime;
	if tmr >= 10 then
		tmr = 0
		save_table()
	end
end)

mymonths = {}

local morn = 6000
local night = 22000
local daychange = 1
local tseconds = 3
local t1 = 52 -- 14 min set to 52
local t2 = 60 -- 12 min set to 60
local t3 = 72 -- 10 min set to 72
local t4 = 90 -- 8 min set to 90
local t5 = 120 -- 6 min set to 120

--Check to see if file exists and if not sets default values. 
local f, err = io.open(minetest.get_worldpath().."/mymonths_data", "r")
if f == nil then
mymonths.day_speed = 72
mymonths.night_speed = 72
mymonths.day_counter = 1
mymonths.month_counter = 6
mymonths.month = "June"
mymonths.weather = "none"
mymonths.weather2 = "none"
mymonths.days_per_month = 14 --Should be 7,14,21 or 28. One week is 7 days. Weeks start on Monday
mymonths.day_name = "Monday"
else
mymonths.day_speed = read_mymonths().day_speed
mymonths.night_speed = read_mymonths().night_speed
mymonths.day_counter = read_mymonths().day_counter
mymonths.month_counter = read_mymonths().month_counter
mymonths.month = read_mymonths().month
mymonths.weather = read_mymonths().weather
mymonths.weather2 = read_mymonths().weather2
mymonths.days_per_month = read_mymonths().days_per_month
mymonths.day_name = read_mymonths().day_name
end


--Sets Month and length of day
local timer = 0
minetest.register_globalstep(function(dtime)
local month = mymonths.month
local monthn = mymonths.month_counter
local day = mymonths.day_counter
-- Checks every X seconds
	timer = timer + dtime
	if timer < 3 then
		return
	end
	timer = 0
--Checks for morning
	local time_in_seconds = minetest.get_timeofday() * 24000
	if time_in_seconds >= daychange  and
		time_in_seconds <= daychange + 200 then
		mymonths.day_counter = mymonths.day_counter + 1
		if mymonths.day_counter >= mymonths.days_per_month +1 then 
			mymonths.month_counter = mymonths.month_counter + 1
		end
		if mymonths.month_counter >= "13" then
			mymonths.month_counter = "1"
			mymonths.day_counter = 1
		end
	end
--Sets time speed in the morning
	if time_in_seconds >= morn  and
		time_in_seconds <= morn + 200 then
		minetest.setting_set("time_speed", mymonths.day_speed)
		minetest.set_timeofday(0.259)
		minetest.chat_send_all("Good Morning! It is "..mymonths.day_name.." "..month.." "..day)

--Sets holidays
		if 		monthn == "12" and
				day == 14 then
				minetest.chat_send_all("It is New Years Eve!")
		elseif 	monthn == "1" and
				day == 1 then
				minetest.chat_send_all("It is New Years Day!")
		elseif 	monthn == "3" and
				day == 12 then
				minetest.chat_send_all("It is Friendship Day!")
		elseif 	monthn == "6" and
				day == 5 then
				minetest.chat_send_all("It is Minetest Day!")
		elseif 	monthn == "4" and
				day == 10 then
				minetest.chat_send_all("It is Miners Day!")
		elseif 	monthn == "8" and
				day == 12 then
				minetest.chat_send_all("It is Builders Day!")
		elseif 	monthn == "10" and
				day == 8 then
				minetest.chat_send_all("It is Harvest Day!")
		end

	
--January
		if mymonths.month_counter == 1 then
			mymonths.month = "January"
			mymonths.day_speed = t5
			mymonths.night_speed = t1
--Febuary
		elseif mymonths.month_counter == 2 then
			mymonths.month = "February"
			mymonths.day_speed = t5
			mymonths.night_speed = t1
--March
		elseif mymonths.month_counter == 3 then
			mymonths.month = "March"
			mymonths.day_speed = t4
			mymonths.night_speed = t2
--April
		elseif mymonths.month_counter == 4 then
			mymonths.month = "April"
			mymonths.day_speed = t4
			mymonths.night_speed = t2
--May
		elseif mymonths.month_counter == 5 then
			mymonths.month = "May"
			mymonths.day_speed = t3
			mymonths.night_speed = t3
--June
		elseif mymonths.month_counter == 6 then
			mymonths.month = "June"
			mymonths.day_speed = t3
			mymonths.night_speed = t3
--July
		elseif mymonths.month_counter == 7 then
			mymonths.month = "July"
			mymonths.day_speed = t1
			mymonths.night_speed = t5
--Augest
		elseif mymonths.month_counter == 8 then
			mymonths.month = "August"
			mymonths.day_speed = t1
			mymonths.night_speed = t5
--September
		elseif mymonths.month_counter == 9 then
			mymonths.month = "September"
			mymonths.day_speed = t3
			mymonths.night_speed = t3
--October
		elseif mymonths.month_counter == 10 then
			mymonths.month = "October"
			mymonths.day_speed = t3
			mymonths.night_speed = t3
--November
		elseif mymonths.month_counter == 11 then
			mymonths.month = "November"
			mymonths.day_speed = t4
			mymonths.night_speed = t2
--December
		elseif mymonths.month_counter == 12 then
			mymonths.month = "December"
			mymonths.day_speed = t4
			mymonths.night_speed = t2
		end
   elseif time_in_seconds >= night and
		time_in_seconds <= night + 200 then
		minetest.setting_set("time_speed", mymonths.night_speed)
		minetest.set_timeofday(0.925)
   end
--Set the name of the day
   local days = {{1,8,"Monday"},{2,9,"Tuesday"},{3,10,"Wednesday"},{4,11,"Thursday"},{5,12,"Friday"},{6,13,"Saturday"},{7,14,"Sunday"},}
	for i in ipairs(days) do
		local w1 = days[i][1]
		local w2 = days[i][2]
		local dy = days[i][3]
		if mymonths.day_counter == w1 or
			mymonths.day_counter == w2 then
			mymonths.day_name = dy
		end
	end
end)



dofile(minetest.get_modpath("mymonths").."/weather.lua")
dofile(minetest.get_modpath("mymonths").."/abms.lua")
dofile(minetest.get_modpath("mymonths").."/leaves.lua")
dofile(minetest.get_modpath("mymonths").."/command.lua")
