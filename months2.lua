local daychange = 1
local tseconds = 3
local t1 = 52 -- 14 min set to 52
local t2 = 60 -- 12 min set to 60
local t3 = 72 -- 10 min set to 72
local t4 = 90 -- 8 min set to 90
local t5 = 120 -- 6 min set to 120
local timechange = 0
local gm = 0
local gn = 0

--Sets Month and length of day
local timer = 0
minetest.register_globalstep(function(dtime)
local month = mymonths.month
local monthn = mymonths.month_counter
local day = mymonths.day_counter
--Day Night Speeds
	local x = tonumber(mymonths.day_counter)
	local ratio = ((math.cos((x / 168) * 2 * math.pi) * 0.4) / 2.0) + 0.5
	local nightratio = 72/(ratio*2)
	local dayratio =  72*(ratio*2)
-- Checks every X seconds
	timer = timer + dtime
	if timer < 3 then --do not change because it will effect other  values
		return
	end
	timer = 0
--Checks for morning
	local time_in_seconds = minetest.get_timeofday() * 24000
	if time_in_seconds >= 12001 and
		timechange == 0 then
		timechange = 1
		gm = 1
	end
	if time_in_seconds <= 12000 and
		timechange == 1 then
		timechange = 0
		mymonths.day_counter = mymonths.day_counter + 1
	end

	if mymonths.day_counter >= 15 then 
			mymonths.month_counter = mymonths.month_counter + 1
			mymonths.day_counter = 1
	end
	if tonumber(mymonths.month_counter) == nil then 
	mymonths.monthcounter = 6 
	elseif tonumber(mymonths.month_counter) >= 13 then
			mymonths.month_counter = 1
			mymonths.day_counter = 1
	end

--Sets time speed in the morning
	if time_in_seconds >= 6000 and
		time_in_seconds <= 12000 and
		gm == 1 then
		minetest.setting_set("time_speed", dayratio)--mymonths.day_speed)
		minetest.chat_send_all("Good Morning! It is "..mymonths.day_name.." "..month.." "..day)
		minetest.chat_send_all("Time speed is "..dayratio.." and "..nightratio)

---Holidays
		local hol = {
			{"12",	14,	"It is New Years Eve!"},
			{"1",	1,	"It is New Years Day!"},
			{"3",	12,	"It is Friendship Day!"},
			{"6",	5,	"It is Minetest Day!"},
			{"4",	10,	"It is Miners Day!"},
			{"8",	12,	"It is Builders Day!"},
			{"3",	8,	"Spring has sprung!"},
			{"6",	10,	"Summer Time!"},
			{"9",	10,	"Autum is here!"},
			{"12",	10,	"Winter has come!"},
			{"10",	10,	"It is Harvest Day!"},
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
		gm = 0
		gn = 1
	end

--function season(day)
-- return  (((day - 35) % 168) / (168/4)) + 1
-- end
--Months
		local mon = {
			{1,		"January",		t5,t1,.9},
			{2,		"February",		t5,t1,.9},
			{3,		"March",		t4,t2,1},
			{4,		"April",		t4,t2,1},
			{5,		"May",			t3,t3,1},
			{6,		"June",			t3,t3,1.1},
			{7,		"July",			t1,t5,1.2},
			{8,		"Augest",		t1,t5,1.5},
			{9,		"September",	t3,t3,1},
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
--					if thirst == true then
--						for _,player in ipairs(minetest.get_connected_players()) do
--							local players_names = player:get_player_name()
--							thirsty.set_thirst_factor(players_names, m5)
--						end
--					end
				end
			end

   if time_in_seconds >= 22000 and
		time_in_seconds <= 24000 and
		gn == 1 then
		minetest.setting_set("time_speed", nightratio)--mymonths.night_speed)
		gn = 0
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


