capital_obj = nil
capital_val = 5100
income_obj = nil
income_val = 0
costs_obj = nil
costs_val = 100
event_box = nil
week_obj = nil
week_val = 0
equity_val = 100
shares_val = 100
share_price_val = 1
valuation_val = 0
market_share_val = 0

-- forward declarations
local new_event = nil

local function choice_customer(e, instance, choice)
	if choice == 1 then
		income_val = income_val + 100
	elseif choice == 2 then
		--Nothing
	end
	return 1
end

local function initial_state()
	-- TODO
	events[2][2] = 0
	events[1][2] = 50
end

local function tutorial0(e, instance, choice)
	if choice == 1 then
		return 4
	elseif choice == 2 then
		initial_state()
	end
	return 1
end

local function tutorial1(e, instance, choice)
	return 5
end

local function tutorial2(e, instance, choice)
	return 6
end

local function tutorial3(e, instance, choice)
	initial_state()
	return 1
end

local function failure(e, instance, choice)
	if choice == 1 then
		action(e, instance, '"type": "reload"')
	elseif choice == 2 then
		action(e, instance, '"type": "close"')
	end
	return 1
end

local function acq_offer(e, instance, choice)
	if choice == 1 then
		local payout_obj = spawn(e, instance, "text.json", 300, 680, false)
		local payout_val = (equity_val/100) * shares_val * share_price_val
		action(e, payout_obj, '"type": "text", "string": "Payout: $'..payout_val..'"')
		return 8
	elseif choice == 2 then
		-- Nothing
	end
	return 1
end

-- # of choices, weight, function, any # of lines of text
events = {
	{0, 0, nil}, -- no event
	{2, 1, tutorial0, "Welcome to the COMM 405", "Entrepreneurship Simulator! Would you", "like to go through the tutorial?", "(Press 1 on your keyboard for Yes)", "", "1. Yes", "2. No"}, -- tutorial
	{2, 0, failure, "You have run out of funding and your", "business venture has unfortunately", "failed. Don't worry, most entrepreneurs", "fail before they succeed. If you learn", "from your mistakes, maybe you will be", "successful next time!", "Would like to try again?", "", "1. Yes! I can do it!", "2. No, maybe some other time"}, -- failure
	{1, 0, tutorial1, "The time has finally arrived! After", "quitting your well-paying, stable job", "and moving to sunny Widget Valley, now", "you will be able to achieve your dream", "of starting a successful business. You", "already have your idea, a widget that", "will revolutionize the entire industry.", "But after that well... you're not really sure.", "Will you become like the great", "entrepreneurs who came before you?", "Will your skill and talent be enough for", "this challenging path? Let's find out!", "", "1. Continue"},
	{1, 0, tutorial2, "If you look to the top, you'll see three", "numbers. As you can see from the labels,", "these are your current capital, income", "and operating costs. You have some", "savings from your last job, so you start", "with $5000. Income is zero because", "you aren't selling anything yet. Costs is", "$100 because even founders have to eat.", "Each week, your income will be added", "to your capital, and costs subtracted.", "Other statistics about the business will", "be revealed later.", "", "1. Continue"},
	{1, 0, tutorial3, "In real life lots of people just want a", "lifestyle business, but not you. Your", "goal is to exit the business either from", "acquisition or I.P.O. Good luck!", "", "1. Let's go!"},
	{2, 0, acq_offer, 'You are getting a phone call. "Hello, we represent Alphanumeric Inc. and would like to make an acquisition offer. We see how successful you have been in the widget market, and we think you are a great fit for us. We\'ll buy all your equity and run the business from now on. How does that sound?"', "", "1. Retirement baby!", "2. No thanks"}, -- acquisition
	{2, 0, failure, "Congratulations! You have successfully exited your venture. Now you can try to get an even bigger payout. Would you like to play again?", "", "1. Yes! The next one will be even better!", "2. No, I'd like to enjoy my retirement"}, -- victory
}
event_num = -1

lines = {}

local function update(e)
	action(e, capital_obj, '"type": "text", "string": "Capital: $'..capital_val..'"')
	action(e, income_obj, '"type": "text", "string": "Income: $'..income_val..'"')
	action(e, costs_obj, '"type": "text", "string": "Costs: $'..costs_val..'"')
	action(e, week_obj, '"type": "text", "string": "Week: '..week_val..'"')
	for i = 1, #lines, 1
	do
		action(e, lines[i], '"type": "text", "string": "'..events[event_num][i+3]..'"')
	end
end

local function close_event(e)
	if event_box ~= nil then
		action(e, event_box, '"type": "destroy"')
		event_box = nil
	end
	for i = 1, #lines, 1
	do
		local line = table.remove(lines)
		action(e, line, '"type": "destroy"')
	end
end

local function get_num()
	local sum = 0
	for i = 1, #events, 1
	do
		sum = sum + events[i][2]
	end
	local rand = math.random() + math.random(0, sum-1)
	sum = 0
	for i = 1, #events, 1
	do
		sum = sum + events[i][2]
		if rand < sum then
			return i
		end
	end
	os.exit(1)
end

new_event = function(e, instance, num)
	close_event(e)
	event_num = num
	for i = 4, #events[event_num], 1
	do
		local line = spawn(e, instance, "text.json", 160, 80+(i*28), false)
		table.insert(lines, line)
	end
	if #lines > 0 then
		event_box = spawn(e, instance, "box.json", 134, 134, false)
	end
	update(e)
end

function create_main(e, instance)
	math.randomseed(os.time())
	action(e, instance, '"type": "window", "w": 768, "h": 768')
	--action(e, instance, '"type": "music", "file": "music.ogg"')
	capital_obj = spawn(e, instance, "text.json", 300, 20, false)
	income_obj = spawn(e, instance, "text.json", 590, 20, false)
	costs_obj = spawn(e, instance, "text.json", 20, 20, false)
	local enter_next = spawn(e, instance, "text.json", 375, 720, false)
	action(e, enter_next, '"type": "text", "string": "Press Enter to go to next week"')
	week_obj = spawn(e, instance, "text.json", 20, 720, false)
	next_week(e, instance)
end

function next_week(e, instance)
	if #lines > 0 then return end --dont progress until choice made
	capital_val = capital_val + income_val - costs_val
	week_val = week_val + 1
	if valuation_val > 1000000 then
		events[7][2] = events[7][2] + 1
	end
	if market_share_val > 33 then
		events[7][2] = events[7][2] + 1
	end

	if capital_val <= 0 then -- failure
		new_event(e, instance, 3)
	else -- default random event
		new_event(e, instance, get_num())
	end
end

local function make_choice(e, instance, num)
	if num <= events[event_num][1] and #lines > 0 then
		local n = events[event_num][3](e, instance, num)
		if n == 0 then
			print("Index 1 silly")
			exit(1)
		end
		new_event(e, instance, n)
	end
end

function one(e, instance)
	make_choice(e, instance, 1)
end

function two(e, instance)
	make_choice(e, instance, 2)
end

function three(e, instance)
	make_choice(e, instance, 3)
end

function four(e, instance)
	make_choice(e, instance, 4)
end

