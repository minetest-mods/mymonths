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
	description = "Set the month. Use the number 1-12 or the name",
	privs = {mymonths = true},
	func = function(name, param)
		if param == "1" or param == "January" or param == "january" or param == "jan" then 
			mymonths.month = "January"
		elseif param == "2" or param == "Febuary" or param == "febuary" or param == "feb" then 
			mymonths.month = "Febuary"
		elseif param == "3" or param == "March" or param == "march" or param == "mar" then 
			mymonths.month = "March"
		elseif param == "4" or param == "April" or param == "april" or param == "apr" then 
			mymonths.month = "April"
		elseif param == "5" or param == "May" or param == "may" then 
			mymonths.month = "May"
		elseif param == "6" or param == "June" or param == "june" or param == "jun" then 
			mymonths.month = "June"
		elseif param == "7" or param == "July" or param == "july" or param == "jul" then 
			mymonths.month = "July"
		elseif param == "8" or param == "Augest" or param == "augest" or param == "aug" then 
			mymonths.month = "Augest"
		elseif param == "9" or param == "September" or param == "september" or param == "sept" then 
			mymonths.month = "September"
		elseif param == "10" or param == "October" or param == "october" or param == "oct" then 
			mymonths.month = "October"
		elseif param == "11" or param == "November" or param == "november" or param == "nov" then 
			mymonths.month = "November"
		elseif param == "12" or param == "December" or param == "december" or param == "dec"then 
			mymonths.month = "December"
		end
		mymonths.month_counter = param
		save_table()
	end
})
--Set Days

minetest.register_chatcommand("setday", {
	params = "",
	description = "Set the day of the month",
	privs = {mymonths = true},
	func = function(name, param)
	for day = 1,mymonths.days_per_month do
	if param == ""..day then mymonths.day_counter = day end
	end
	end
})
--Weather
-- Set weather
minetest.register_chatcommand("w", {
	params = "",
	description = "Set weather to rain, snow, wind or none",
	func = function(name, param)
		minetest.chat_send_player(name,"The weather is "..mymonths.weather)
	end
})
minetest.register_chatcommand("w2", {
	params = "",
	description = "Set weather to rain, snow, wind or none",
	func = function(name, param)
		minetest.chat_send_player(name,"The weather is "..mymonths.weather2)
	end
})
--Time and Date
minetest.register_chatcommand("date", {
	params = "",
	description = "Say the date in chat",
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
	else
		ampm = "am"
		print(th)
		if th == 0 or th == "" then th = 12 end
	end
	--
	minetest.chat_send_player(name,"The time is "..th..":"..mi.." "..ampm.." on "..mymonths.month.." "..mymonths.day_counter)

	end
	
})
