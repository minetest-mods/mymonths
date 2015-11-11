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
		if param == "1" or "January" or "january" or "jan" then 
			mymonths.month = "January"
		elseif param == "2" or "Febuary" or "febuary" or "feb" then 
			mymonths.month = "Febuary"
		elseif param == "3" or "March" or "march" or "mar" then 
			mymonths.month = "March"
		elseif param == "4" or "April" or "april" or "apr" then 
			mymonths.month = "April"
		elseif param == "5" or "May" or "may" then 
			mymonths.month = "May"
		elseif param == "6" or "June" or "june" or "jun" then 
			mymonths.month = "June"
		elseif param == "7" or "July" or "july" or "jul" then 
			mymonths.month = "July"
		elseif param == "8" or "Augest" or "augest" or "aug" then 
			mymonths.month = "Augest"
		elseif param == "9" or "September" or "september" or "sept" then 
			mymonths.month = "September"
		elseif param == "10" or "October" or "october" or "oct" then 
			mymonths.month = "October"
		elseif param == "11" or "November" or "november" or "nov" then 
			mymonths.month = "November"
		elseif param == "12" or "December" or "december" or "dec"then 
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
	else
		ampm = "am"
		print(th)
		if th == 0 or th == "" then th = 12 end
	end
	--
	minetest.chat_send_player(name,"The time is "..th..":"..mi.." "..ampm.." on "..mymonths.month.." "..mymonths.day_counter)

	end
	
})
