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
product_market_fit_val = 0
product_price_val = 100
sales_val = 0
capacity_val = 1
happiness_val = 100
debt_val = 0

-- forward declarations
local new_event = nil

local function initial_state()
	events[2][2] = 0
	events[1][2] = 65
	events[9][2] = 25
	events[12][2] = 100
	events[13][2] = 5
	events[14][2] = 5
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
		local payout_val = (equity_val/100) * shares_val * share_price_val - debt_val
		action(e, payout_obj, '"type": "text", "string": "Payout: $'..payout_val..'"')
		return 8
	elseif choice == 2 then
		-- Nothing
	end
	return 1
end

local function research(e, instance, choice)
	if choice == 1 then
		if capital_val >= 50000 then
			capital_val = capital_val - 50000
			product_market_fit_val = product_market_fit_val + 5
			if events[9][2] > 0 then events[9][2] = events[9][2] - 5 end
		else
			return 9
		end
	elseif choice == 2 then
		-- Nothing
	end
	return 1
end

local function new_customer(e, instance, choice)
	if choice == 1 then
		sales_val = sales_val + 1
	elseif choice == 2 then
		--Nothing
	end
	return 1
end

local function valuation(e, instance, choice)
	if choice == 1 then
		if capital_val >= 20000 then
			capital_val = capital_val - 20000
			if income_val*52 > capital_val then
				valuation_val = math.random(capital_val, income_val*52)
			else
				valuation_val = capital_val
			end
		else
			return 11
		end
	elseif choice == 2 then
		-- Nothing
	end
	return 1
end

local function parents_money(e, instance, choice)
	if choice == 1 then
		capital_val = capital_val + 5000
		debt_val = debt_val + 5000
		events[12][2] = 0
	elseif choice == 2 then
		-- Nothing
	end
	return 1
end

local function angel_money(e, instance, choice)
	if choice == 1 then
		capital_val = capital_val + 500000
		equity_val = equity_val - 5
		if events[13][2] > 0 then
			events[13][2] = events[13][2] - 1
		end
		if events[14][2] > 0 then
			events[14][2] = events[14][2] - 1
		end
	elseif choice == 2 then
		-- Nothing
	end
	return 1
end

local function vc_money(e, instance, choice)
	if choice == 1 or choice == 2 or choice == 3 then
		if choice == 1 then
			capital_val = capital_val + 3250000
			equity_val = equity_val - 30
		elseif choice == 2 then
			capital_val = capital_val + 2000000
			equity_val = equity_val - 20
		elseif choice == 3 then
			capital_val = capital_val + 750000
			equity_val = equity_val - 10
		end

		if events[13][2] > 0 then
			events[13][2] = events[13][2] - 1
		end
		if events[14][2] > 0 then
			events[14][2] = events[14][2] - 1
		end
	elseif choice == 4 then
		-- Nothing
	end
	return 1
end

-- # of choices, weight, function, any # of lines of text
events = {
	{0, 0, nil}, -- 1: no event
	{2, 1, tutorial0, "Welcome to the COMM 405", "Entrepreneurship Simulator! Would you", "like to go through the tutorial?", "(Press 1 on your keyboard for Yes)", "", "1. Yes", "2. No"}, -- tutorial
	{2, 0, failure, "You have run out of funding and your", "business venture has unfortunately", "failed. Don't worry, most entrepreneurs", "fail before they succeed. If you learn", "from your mistakes, maybe you will be", "successful next time!", "Would you like to try again?", "", "1. Yes! I can do it!", "2. No, maybe some other time"}, -- failure
	{1, 0, tutorial1, "The time has finally arrived! After", "quitting your well-paying, stable job", "and moving to sunny Widget Valley, now", "you will be able to achieve your dream", "of starting a successful business. You", "already have your idea, a widget that", "will revolutionize the entire industry.", "But after that well... you're not really sure.", "Will you become like the great", "entrepreneurs who came before you?", "Will your skill and talent be enough for", "this challenging path? Let's find out!", "", "1. Continue"},
	{1, 0, tutorial2, "If you look to the top, you'll see three", "numbers. As you can see from the labels,", "these are your current capital, income", "and operating costs. You have some", "savings from your last job, so you start", "with $5000. Income is zero because", "you aren't selling anything yet. Costs is", "$100 because even founders have to eat.", "Each week, your income will be added", "to your capital, and costs subtracted.", "Other statistics about the business will", "be revealed later.", "", "1. Continue"},
	{1, 0, tutorial3, "In real life lots of people just want a", "lifestyle business, but not you. Your", "goal is to exit the business either from", "acquisition or I.P.O. Good luck!", "", "1. Let's go!"},
	{2, 0, acq_offer, 'You are getting a phone call. "Hello, we represent Alphanumeric Inc. and would like to make an acquisition offer. We see how successful you have been in the widget market, and we think you are a great fit for us. We\'ll buy all your equity and run the business from now on. How does that sound?"', "", "1. Retirement baby!", "2. No thanks"}, -- acquisition
	{2, 0, failure, "Congratulations! You have successfully exited your venture. Now you can try to get an even bigger payout. Would you like to play again?", "", "1. Yes! The next one will be even better!", "2. No, I'd like to enjoy my retirement"}, -- victory
	{2, 0, research, "A company that uses widgets has agreed to help you test drive your widget idea. This will help refine your product, but will cost you to create an M.V.P. Would you like to proceed?", "", "1. What a great opportunity! ($50 000)", "2. Maybe next time"}, -- 9: research
	{2, 0, new_customer, "A company that uses widgets has heard of your new product, and thinks it will improve their business. This will increase your income, but requires manufacturing capacity.", "", "1. We'll do great things together.", "2. Sorry, but not at this time"}, -- 10: new customer
	{2, 0, valuation, "You have approached a business valuation firm to determine how much your company is worth. Knowing this is useful, but it will cost you a fee.", "", "1. Works for me. ($20 000)", "2. I don't need it"}, -- 11: valuation
	{2, 0, parents_money, "You are getting a phone call from your parents. \"Hi honey! We just wanted to call to say that we miss you. Hopefully your business is going well! And... umm... we thought you might want some help, so we've put together a little something for you. Don't worry about paying it back anytime soon. Should we just send it to your new address?\"", "", "1. Thanks family!", "2. Well... I was hoping to try and make it on my own"}, -- 12: parents money
	{2, 0, angel_money, "You have met with someone who has once in your shoes, starting their own business. Now this person is willing to invest in your idea, but wants some equity in return.", "", "1. Sounds like a great idea. (+$500 000 capital) (-5% equity)", "2. That doesn't work for me"}, -- 13: angel money
	{4, 0, vc_money, "You have been having conversations with many different venture capital firms, and three have come back to you with term sheets. Which do you go with, if any?", "", "1. EliteVC (+$3 250 000 capital) (-30% equity)", "2. FundTech (+$2 000 000 capital) (-20% equity)", "3. CapitalEdge (+$750 000 capital) (-10% equity)", "4. None for me"}, -- 14: vc money
	{2, 0, failure, "Your employees have become incredibly unhappy and your", "business venture has unfortunately", "failed. Don't worry, most entrepreneurs", "fail before they succeed. If you learn", "from your mistakes, maybe you will be", "successful next time!", "Would you like to try again?", "", "1. Yes! I can do it!", "2. No, maybe some other time"}, -- 15: employees unhappy
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

	if valuation_val > 1000000 then
		events[7][2] = events[7][2] + 1
	end
	market_share_val = sales_val / (60 + sales_val)
	if market_share_val > 33 then
		events[7][2] = events[7][2] + 1
	end
	events[10][2] = product_market_fit_val
	if sales_val > capacity_val then
		happiness_val = happiness_val - 5
	end
	events[11][2] = sales_val

	happiness_val = happiness_val - 1
	income_val = product_price_val * sales_val
	capital_val = capital_val + income_val - costs_val
	week_val = week_val + 1

	if capital_val <= 0 then -- failure
		new_event(e, instance, 3)
	elseif happiness_val <= 0 then
		new_event(e, instance, 15)
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

