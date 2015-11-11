minetest.register_privilege("weather", {
	description = "Change the weather",
	give_to_singleplayer = false
})
minetest.register_privilege("mymonths", {
	description = "Change the weather",
	give_to_singleplayer = false
})
-- Set weather
minetest.register_chatcommand("setweather", {
	params = "<weather>",
	description = "Set weather to rain, snow, wind or none",
	privs = {mymonths = true},
	func = function(name, param)
		mymonths.weather = param
		save_table()
	end
})
--Set month
minetest.register_chatcommand("setmonth", {
	params = "",
	description = "Set the month. Use the number 1-12",
	privs = {mymonths = true},
	func = function(name, param)
		if param == "1" then 
			mymonths.month = "January"
		elseif param == "2" then 
			mymonths.month = "Febuary"
		elseif param == "3" then 
			mymonths.month = "March"
		elseif param == "4" then 
			mymonths.month = "April"
		elseif param == "5" then 
			mymonths.month = "May"
		elseif param == "6" then 
			mymonths.month = "June"
		elseif param == "7" then 
			mymonths.month = "July"
		elseif param == "8" then 
			mymonths.month = "Augest"
		elseif param == "9" then 
			mymonths.month = "September"
		elseif param == "10" then 
			mymonths.month = "October"
		elseif param == "11" then 
			mymonths.month = "November"
		elseif param == "12" then 
			mymonths.month = "December"
		end
		mymonths.month_counter = param
		save_table()
	end
})
--Time and Date
minetest.register_chatcommand("date", {
	params = "",
	description = "Say the date in chat",
	--privs = {mymonths = true},
	func = function(name, param)
	local t = tostring(minetest.get_timeofday() * 2400)
	local tt = string.find(t, "%p",1)
	local th = string.sub(t, tt-4,tt-3)
	local tm = string.sub(t, tt-2,tt-1)
	local m = (tm/100)*60
	local mx = m+1000
	local my = ".00"
	local mz = mx..my
	local mf = string.find(mz, "%p",1)
	local mi = string.sub(mx,mf-2,mf-1) 
	local ampm = "am"
	if th == nil then th = 0 end
	if tonumber(th..tm) >= 1201 and tonumber(th) <= 2400 then 
		ampm = "pm"
		th = th - 12
		if th == 0 then th = 12 end
	elseif tonumber(th..tm) >=2401 or tonumber(th) <= 1200 then
		ampm = "am"
	end
	--
	minetest.chat_send_player(name,"The time is "..th..":"..mi.." "..ampm.." on "..mymonths.month.." "..mymonths.day_counter)

	end
	
})
