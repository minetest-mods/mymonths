local morn = 6000
local night = 22000
local daychange = 1
local tseconds = 3
local t1 = 52 -- 14 min set to 52
local t2 = 60 -- 12 min set to 60
local t3 = 72 -- 10 min set to 72
local t4 = 90 -- 8 min set to 90
local t5 = 120 -- 6 min set to 120
local day_changed = 0

--Sets Month and length of day
local timer = 0
minetest.register_globalstep(function(dtime)
local month = mymonths.month
local monthn = mymonths.month_counter
local day = mymonths.day_counter
-- Checks every X seconds
	timer = timer + dtime
	if timer < 3 then --do not change because it will effect other  values
		return
	end
	timer = 0
--Checks for morning
	local time_in_seconds = minetest.get_timeofday() * 24000
	if time_in_seconds >= daychange  and
		time_in_seconds <= daychange + 200 then
		day_changed = day_changed + 1
			if day_changed == 1 then
				mymonths.day_counter = mymonths.day_counter + 1
			end
		if mymonths.day_counter >= mymonths.days_per_month +1 then 
			mymonths.month_counter = mymonths.month_counter + 1
		end
		if tonumber(mymonths.month_counter) >= 13 then
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
--Holidays
		local hol = {
			{"12",	14,	"It is New Years Eve!"},
			{"1",	1,	"It is New Years Day!"},
			{"3",	12,	"It is Friendship Day!"},
			{"6",	5,	"It is Minetest Day!"},
			{"4",	10,	"It is Miners Day!"},
			{"8",	12,	"It is Builders Day!"},
			{"10",	8,	"It is Harvest Day!"},
			}
		for i in ipairs(hol) do
			local h1 = hol[i][1]
			local h2 = hol[i][2]
			local h3 = hol[i][3]
			if 	monthn == h1 and
				day == h2 then
				minetest.chat_send_all(h3)
			end
		end

--Months
		local mon = {
			{1,	"January",		t5,t1,.9},
			{2,	"February",		t5,t1,.9},
			{3,	"March",		t4,t2,1},
			{4,	"April",		t4,t2,1},
			{5,	"May",			t3,t3,1},
			{6,	"June",			t3,t3,1.1},
			{7,	"July",			t1,t5,1.2},
			{8,	"Augest",		t1,t5,1.5},
			{9,	"September",		t3,t3,1},
			{10,	"October",		t3,t3,1},
			{11,	"November",		t4,t2,.9},
			{12,	"December",		t4,t2,.9},
			}
			for i in ipairs(mon) do
				local m1 = mon[i][1]
				local m2 = mon[i][2]
				local m3 = mon[i][3]
				local m4 = mon[i][4]
				local m5 = mon[i][5]
				if mymonths.month_counter == m1 then
					mymonths.month = m2
					mymonths.day_speed = m3
					mymonths.night_speed = m4
					if thirst == true then --This effects the players thirst speed.
						thirsty.set_thirst_factor(player, m5) --I'm assuming that a faster factor means getting thirsty faster???
					end
				end
			end

   elseif time_in_seconds >= night and
		time_in_seconds <= night + 200 then
		minetest.setting_set("time_speed", mymonths.night_speed)
		minetest.set_timeofday(0.925)
		day_changed = 0
   end

--Set the name of the day
   local days = {	{1,8,"Monday"},
			{2,9,"Tuesday"},
			{3,10,"Wednesday"},
			{4,11,"Thursday"},
			{5,12,"Friday"},
			{6,13,"Saturday"},
			{7,14,"Sunday"},}
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


