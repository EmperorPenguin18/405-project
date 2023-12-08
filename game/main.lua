capital_obj = nil
capital_val = 5000
income_obj = nil
income_val = 0
costs_obj = nil
costs_val = 100
event_box = nil
week_obj = nil
week_val = 1
equity_obj = nil
equity_val = 100
shares_val = 100
share_price_obj = nil
share_price_val = 1
valuation_obj = nil
valuation_val = 0
market_share_obj = nil
market_share_val = 0
product_market_fit_obj = nil
product_market_fit_val = 0
product_price_val = 100
sales_obj = nil
sales_val = 0
capacity_obj = nil
capacity_val = 1
happiness_obj = nil
happiness_val = 100
happiness_mod_obj = nil
happiness_mod = 0
debt_obj = nil
debt_val = 0
employees_val = 1
hired0 = false
hired1 = false
hired2 = false
hired3 = false
hired4 = false
hired5 = false
hired6 = false
hired7 = false
hired8 = false
hired9 = false
input_obj = nil
exclamation_obj = nil
clock_obj = nil

-- forward declarations
local new_event = nil

local function initial_state()
	events[2][2] = 0 -- tutorial
	events[1][2] = 15 -- nothing
	events[9][2] = 25 -- research
	events[12][2] = 100 -- parents money
	events[13][2] = 5 -- angel money
	events[14][2] = 5 -- vc money
	events[17][2] = 30 -- bank money
	events[18][2] = 10 -- website
	events[19][2] = 10 -- marketing
	events[20][2] = 1 -- disaster
end

local function tutorial0(e, instance, choice)
	if choice == 1 then
		return 4
	elseif choice == 2 then
		input_obj = spawn(e, instance, "input.json", 160, 250, false)
		return 40
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
	input_obj = spawn(e, instance, "input.json", 160, 250, false)
	return 40
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
			events[28][2] = events[28][2] + 1
			events[29][2] = events[29][2] + 1
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
		if equity_val >= 5 then
			capital_val = capital_val + 500000
			equity_val = equity_val - 5
			if events[13][2] > 0 then
				events[13][2] = events[13][2] - 1
			end
			if events[14][2] > 0 then
				events[14][2] = events[14][2] - 1
			end
		else
			return 13
		end
	elseif choice == 2 then
		-- Nothing
	end
	return 1
end

local function vc_money(e, instance, choice)
	if choice == 1 or choice == 2 or choice == 3 then
		if choice == 1 then
			if equity_val >= 30 then
				capital_val = capital_val + 3250000
				equity_val = equity_val - 30
			else
				return 14
			end
		elseif choice == 2 then
			if equity_val >= 20 then
				capital_val = capital_val + 2000000
				equity_val = equity_val - 20
			else
				return 14
			end
		elseif choice == 3 then
			if equity_val >= 10 then
				capital_val = capital_val + 750000
				equity_val = equity_val - 10
			else
				return 14
			end
		end

		if events[13][2] > 0 then
			events[13][2] = events[13][2] - 1
		end
		if events[14][2] > 0 then
			events[14][2] = events[14][2] - 1
		end

		if valuation_obj == nil then
			valuation_obj = spawn(e, instance, "text.json", 50, 104, false)
		end
	elseif choice == 4 then
		-- Nothing
	end
	return 1
end

local function bank_money(e, instance, choice)
	if choice == 1 then
		capital_val = capital_val + 250000
		debt_val = debt_val + 250000
		costs_val = costs_val + 240
		if events[17][2] > 0 then
			events[17][2] = events[17][2] - 10
		end
	elseif choice == 2 then
		-- Nothing
	end
	return 1
end

local function website(e, instance, choice)
	if choice == 1 then
		if capital_val > 1000 then
			capital_val = capital_val - 1000
			product_market_fit_val = product_market_fit_val + 5
			events[18][2] = 0
		else
			return 18
		end
	elseif choice == 2 then
		-- Nothing
	end
	return 1
end

local function marketing(e, instance, choice)
	if choice == 1 then
		if capital_val > 30000 then
			capital_val = capital_val - 30000
			product_market_fit_val = product_market_fit_val + 3
		else
			return 19
		end
	elseif choice == 2 then
		-- Nothing
	end
	return 1
end

local function disruptive_innovation(e, instance, choice)
	if choice == 1 then
		if capital_val > 1000000 then
			capital_val = capital_val - 1000000
			capacity_val = capacity_val / 2
			happiness_val = happiness_val / 2
		else
			return 21
		end
	elseif choice == 2 then
		sales_val = sales_val / 2
	end
	events[21][2] = 1
	return 1
end

local function manufacturing(e, instance, choice)
	if choice == 1 then
		if capital_val > 1000000 then
			capital_val = capital_val - 1000000
			capacity_val = capacity_val + 5
		else
			return 22
		end
	elseif choice == 2 then
		-- Nothing
	end
	return 1
end

local function team_building(e, instance, choice)
	if choice == 1 then
		if capital_val > 2000 then
			capital_val = capital_val - 2000
			happiness_val = happiness_val + 20
		else
			return 23
		end
	elseif choice == 2 then
		-- Nothing
	end
	return 1
end

local function benefits(e, instance, choice)
	if choice == 1 then
		costs_val = costs_val + 100
		happiness_mod = happiness_mod + 1
	elseif choice == 2 then
		-- Nothing
	end
	return 1
end

local function cut_bonus(e, instance, choice)
	if choice == 1 then
		capital_val = capital_val + 2000
		happiness_val = happiness_val - 20
	elseif choice == 2 then
		-- Nothing
	end
	return 1
end

local function reduce_space(e, instance, choice)
	if choice == 1 then
		if costs_val > 100 then
			costs_val = costs_val - 100
		else
			costs_val = 0
		end
		happiness_mod = happiness_mod - 1
	elseif choice == 2 then
		-- Nothing
	end
	return 1
end

local function customer_feedback(e, instance, choice)
	if choice == 1 then
		if capital_val > 100000 then
			capital_val = capital_val - 100000
			product_market_fit_val = product_market_fit_val + 5
		else
			return 27
		end
	elseif choice == 2 then
		-- Nothing
	end
	return 1
end

local function quality_up(e, instance, choice)
	if choice == 1 then
		costs_val = costs_val + 200
		product_market_fit_val = product_market_fit_val + 1
	elseif choice == 2 then
		-- Nothing
	end
	return 1
end

local function quality_down(e, instance, choice)
	if choice == 1 then
		if costs_val > 200 then
			costs_val = costs_val - 200
		else
			costs_val = 0
		end
		if product_market_fit_val > 0 then
			product_market_fit_val = product_market_fit_val - 1
		end
	elseif choice == 2 then
		-- Nothing
	end
	return 1
end

local function hire0(e, instance, choice)
	if choice == 1 or choice == 2 or choice == 3 then
		if choice == 1 then
			costs_val = costs_val + 1500
		elseif choice == 2 then
			if equity_val >= 1 then
				costs_val = costs_val + 750
				equity_val = equity_val - 1
			else 
				return 30
			end
		elseif choice == 3 then
			if equity_val >= 2 then
				equity_val = equity_val - 2
			else 
				return 30
			end
		end
		share_price_obj = spawn(e, instance, "text.json", 20, 700, false)
		capacity_val = capacity_val + 1
		employees_val = employees_val + 1
		hired0 = true
		events[30][2] = 0
	elseif choice == 4 then
		-- Nothing
	end
	return 1
end

local function hire1(e, instance, choice)
	if choice == 1 or choice == 2 or choice == 3 then
		if choice == 1 then
			costs_val = costs_val + 1500
		elseif choice == 2 then
			if equity_val >= 1 then
				costs_val = costs_val + 750
				equity_val = equity_val - 1
			else 
				return 31
			end
		elseif choice == 3 then
			if equity_val >= 2 then
				equity_val = equity_val - 2
			else 
				return 31
			end
		end
		market_share_obj = spawn(e, instance, "text.json", 700, 80, false)
		capacity_val = capacity_val + 1
		employees_val = employees_val + 1
		hired1 = true
		events[31][2] = 0
	elseif choice == 4 then
		-- Nothing
	end
	return 1
end

local function hire2(e, instance, choice)
	if choice == 1 or choice == 2 or choice == 3 then
		if choice == 1 then
			costs_val = costs_val + 1500
		elseif choice == 2 then
			if equity_val >= 1 then
				costs_val = costs_val + 750
				equity_val = equity_val - 1
			else 
				return 32
			end
		elseif choice == 3 then
			if equity_val >= 2 then
				equity_val = equity_val - 2
			else 
				return 32
			end
		end
		product_market_fit_obj = spawn(e, instance, "text.json", 20, 80, false)
		capacity_val = capacity_val + 1
		employees_val = employees_val + 1
		hired2 = true
		events[32][2] = 0
	elseif choice == 4 then
		-- Nothing
	end
	return 1
end

local function hire3(e, instance, choice)
	if choice == 1 or choice == 2 or choice == 3 then
		if choice == 1 then
			costs_val = costs_val + 1500
		elseif choice == 2 then
			if equity_val >= 1 then
				costs_val = costs_val + 750
				equity_val = equity_val - 1
			else 
				return 33
			end
		elseif choice == 3 then
			if equity_val >= 2 then
				equity_val = equity_val - 2
			else 
				return 33
			end
		end
		sales_obj = spawn(e, instance, "text.json", 700, 40, false)
		capacity_val = capacity_val + 1
		employees_val = employees_val + 1
		hired3 = true
		events[33][2] = 0
	elseif choice == 4 then
		-- Nothing
	end
	return 1
end

local function hire4(e, instance, choice)
	if choice == 1 or choice == 2 or choice == 3 then
		if choice == 1 then
			costs_val = costs_val + 1500
		elseif choice == 2 then
			if equity_val >= 1 then
				costs_val = costs_val + 750
				equity_val = equity_val - 1
			else 
				return 34
			end
		elseif choice == 3 then
			if equity_val >= 2 then
				equity_val = equity_val - 2
			else 
				return 34
			end
		end
		capacity_obj = spawn(e, instance, "text.json", 20, 40, false)
		capacity_val = capacity_val + 1
		employees_val = employees_val + 1
		hired4 = true
		events[34][2] = 0
	elseif choice == 4 then
		-- Nothing
	end
	return 1
end

local function hire5(e, instance, choice)
	if choice == 1 or choice == 2 or choice == 3 then
		if choice == 1 then
			costs_val = costs_val + 1500
		elseif choice == 2 then
			if equity_val >= 1 then
				costs_val = costs_val + 750
				equity_val = equity_val - 1
			else 
				return 35
			end
		elseif choice == 3 then
			if equity_val >= 2 then
				equity_val = equity_val - 2
			else 
				return 35
			end
		end
		happiness_obj = spawn(e, instance, "text.json", 700, 120, false)
		capacity_val = capacity_val + 1
		employees_val = employees_val + 1
		hired5 = true
		events[35][2] = 0
	elseif choice == 4 then
		-- Nothing
	end
	return 1
end

local function hire6(e, instance, choice)
	if choice == 1 or choice == 2 or choice == 3 then
		if choice == 1 then
			costs_val = costs_val + 1500
		elseif choice == 2 then
			if equity_val >= 1 then
				costs_val = costs_val + 750
				equity_val = equity_val - 1
			else 
				return 36
			end
		elseif choice == 3 then
			if equity_val >= 2 then
				equity_val = equity_val - 2
			else 
				return 36
			end
		end
		happiness_mod_obj = spawn(e, instance, "text.json", 700, 150, false)
		capacity_val = capacity_val + 1
		employees_val = employees_val + 1
		hired6 = true
		events[36][2] = 0
	elseif choice == 4 then
		-- Nothing
	end
	return 1
end

local function hire7(e, instance, choice)
	if choice == 1 or choice == 2 or choice == 3 then
		if choice == 1 then
			costs_val = costs_val + 1500
		elseif choice == 2 then
			if equity_val >= 1 then
				costs_val = costs_val + 750
				equity_val = equity_val - 1
			else 
				return 37
			end
		elseif choice == 3 then
			if equity_val >= 2 then
				equity_val = equity_val - 2
			else 
				return 37
			end
		end
		debt_obj = spawn(e, instance, "text.json", 20, 120, false)
		capacity_val = capacity_val + 1
		employees_val = employees_val + 1
		hired7 = true
		events[37][2] = 0
	elseif choice == 4 then
		-- Nothing
	end
	return 1
end

local function hire8(e, instance, choice)
	if choice == 1 or choice == 2 or choice == 3 then
		if choice == 1 then
			costs_val = costs_val + 1500
		elseif choice == 2 then
			if equity_val >= 1 then
				costs_val = costs_val + 750
				equity_val = equity_val - 1
			else 
				return 38
			end
		elseif choice == 3 then
			if equity_val >= 2 then
				equity_val = equity_val - 2
			else 
				return 38
			end
		end
		capacity_val = capacity_val + 2
		employees_val = employees_val + 1
		hired8 = true
		events[38][2] = 0
	elseif choice == 4 then
		-- Nothing
	end
	return 1
end

local function hire9(e, instance, choice)
	if choice == 1 or choice == 2 or choice == 3 then
		if choice == 1 then
			costs_val = costs_val + 1500
		elseif choice == 2 then
			if equity_val >= 1 then
				costs_val = costs_val + 750
				equity_val = equity_val - 1
			else 
				return 39
			end
		elseif choice == 3 then
			if equity_val >= 2 then
				equity_val = equity_val - 2
			else 
				return 39
			end
		end
		employees_val = employees_val + 1
		hired9 = true
		events[39][2] = 0
	elseif choice == 4 then
		-- Nothing
	end
	return 1
end

local function input_name(e, instance, choice)
	if string.len(product_name) < 1 then return 40 end
	action(e, input_obj, '"type": "move", "x": 200, "y": 680, "relative": false')
	action(e, input_obj, '"type": "text", "string": "Name: '..product_name..'"')
	initial_state()
	return 1
end

-- # of choices, weight, function, any # of lines of text
events = {
	{0, 0, nil}, -- 1: no event
	{2, 1, tutorial0, "Welcome to the COMM 405 Entrepreneurship Simulator! Would you like to go through the tutorial? (Press 1 on your keyboard for Yes)", "", "1. Yes", "2. No"}, -- tutorial
	{2, 0, failure, "You have run out of funding and your business venture has unfortunately failed. Don't worry, most entrepreneurs fail before they succeed. If you learn from your mistakes, maybe you will be successful next time! Would you like to try again?", "", "1. Yes! I can do it!", "2. No, maybe some other time"}, -- failure
	{1, 0, tutorial1, "The time has finally arrived! After quitting your well-paying, stable job and moving to sunny Widget Valley, now you will be able to achieve your dream of starting a successful business. You already have your idea, a widget that will revolutionize the entire industry. But after that well... you're not really sure. Will you become like the great entrepreneurs who came before you? Will your skill and talent be enough for this challenging path? Let's find out!", "", "1. Continue"},
	{1, 0, tutorial2, "If you look to the top, you'll see three numbers. As you can see from the labels, these are your current capital, income and operating costs. You have some savings from your last job, so you start with $5000. Income is zero because you aren't selling anything yet. Costs is $100 because even founders have to eat. Each week, your income will be added to your capital, and costs subtracted. Other statistics about the business will be revealed later.", "", "1. Continue"},
	{1, 0, tutorial3, "In real life lots of people just want a lifestyle business, but not you. Your goal is to exit the business either from acquisition or I.P.O. Good luck!", "", "1. Let's go!"},
	{2, 0, acq_offer, 'You are getting a phone call. "Hello, we represent Alphanumeric Inc. and would like to make an acquisition offer. We see how successful you have been in the widget market, and we think you are a great fit for us. We\'ll buy all your equity and run the business from now on. How does that sound?"', "", "1. Retirement baby!", "2. No thanks"}, -- acquisition
	{2, 0, failure, "Congratulations! You have successfully exited your venture. Now you can try to get an even bigger payout. Would you like to play again?", "", "1. Yes! The next one will be even better!", "2. No, I'd like to enjoy my retirement"}, -- victory
	{2, 0, research, "A company that uses widgets has agreed to help you test drive your widget idea. This will help refine your product, but will cost you to create an M.V.P. Would you like to proceed?", "", "1. What a great opportunity! (-$50 000)", "2. Maybe next time"}, -- 9: research
	{2, 0, new_customer, "A company that uses widgets has heard of your new product, and thinks it will improve their business. This will increase your income, but requires manufacturing capacity.", "", "1. We'll do great things together.", "2. Sorry, but not at this time"}, -- 10: new customer
	{2, 0, valuation, "You have approached a business valuation firm to determine how much your company is worth. Knowing this is useful, but it will cost you a fee.", "", "1. Works for me. (-$20 000)", "2. I don't need it"}, -- 11: valuation
	{2, 0, parents_money, "You are getting a phone call from your parents. \"Hi honey! We just wanted to call to say that we miss you. Hopefully your business is going well! And... umm... we thought you might want some help, so we've put together a little something for you. Don't worry about paying it back anytime soon. Should we just send it to your new address?\"", "", "1. Thanks family!", "2. Well... I was hoping to try and make it on my own"}, -- 12: parents money
	{2, 0, angel_money, "You have met with someone who has once in your shoes, starting their own business. Now this person is willing to invest in your idea, but wants some equity in return.", "", "1. Sounds like a great idea. (+$500 000 capital) (-5% equity)", "2. That doesn't work for me"}, -- 13: angel money
	{4, 0, vc_money, "You have been having conversations with many different venture capital firms, and three have come back to you with term sheets. Which do you go with, if any?", "", "1. EliteVC (+$3 250 000 capital) (-30% equity)", "2. FundTech (+$2 000 000 capital) (-20% equity)", "3. CapitalEdge (+$750 000 capital) (-10% equity)", "4. None for me"}, -- 14: vc money
	{2, 0, failure, "Your employees have become incredibly unhappy and your", "business venture has unfortunately", "failed. Don't worry, most entrepreneurs", "fail before they succeed. If you learn", "from your mistakes, maybe you will be", "successful next time!", "Would you like to try again?", "", "1. Yes! I can do it!", "2. No, maybe some other time"}, -- 15: employees unhappy
	{2, 0, acq_offer, "Your business is now at the size where it would make sense to become publicly traded. Would you like to?", "", "1. Retirement baby!", "2. No thanks"}, -- 16: ipo
	{2, 0, bank_money, "After meeting with some different banks, one has agreed to give you a loan as part of their startups assistance program. If you take it, you'll be paying them back for a while. Do you take the loan?", "", "1. Just what I needed. (+$250 000 capital) (5% interest per year)", "2. Too risky for me"}, -- 17: bank money
	{2, 0, website, "You've done some research and think you could put together a professional website for yourself with a little help. This will get more attention on your product.", "", "1. How hard can it be? ($1 000)", "2. I'll just go door to door"}, -- 18: website
	{2, 0, marketing, "You think it could be worth it to spend some money marketing your product. A social media campaign, advertisements to businesses, a podcast about widgets, whatever works. What do you think?", "", "1. They're going to learn how great my idea is. (-$30 000)", "2. The product speaks for itself"}, -- 19: marketing
	{2, 0, failure, "You turn on today's news. \"Due to dwindling natural deposits of Widgium, the government has outlawed all mining of the substance. Further, they have urged all businesses in the widget industry to look to an alternative.\" Starting a business is inherently risky, and it seems you have gotten unlucky this time.", "Would you like to try again?", "", "1. Yes! I can do it!", "2. No, maybe some other time"}, -- 20: disaster
	{2, 0, disruptive_innovation, "One day at work one of your employees approaches you. \"Hey, I heard about this cool new widget from my friend, he was saying it can do all this stuff that ours can't. Were you thinking of incorporating those ideas into our product?\" You think about this proposal, and realize that it would take up a lot of your manufacturing capacity, and your employees might not like the direction of the company. Do you invest in this new idea?", "", "1. Sure, sounds interesting. (-$1 000 000)", "2. No, our customers love our product as it is"}, -- 21: disruptive innovation
	{2, 0, manufacturing, "You're currently using all your manufacturing capacity to meet the demands of your customers. It might makes sense to plan ahead and expand your production capabilities now.", "", "1. Expanding sounds great! (-$1 000 000)", "2. Don't want to expand just yet"}, -- 22: manufacturing
	{2, 0, team_building, "You get the idea to run a team-building event. A fun day of activities should hopefully improve the company morale.", "", "1. Good idea, me. (-$2 000)", "2. Bad idea!"}, -- 23: team building
	{2, 0, benefits, "You get the idea to increase the compensation benefits for your employees. This should make them happy and healthy for each day of work, but will increase your costs.", "", "1. Good idea, me", "2. Bad idea!"}, -- 24: benefits
	{2, 0, cut_bonus, "You get the idea to cut Christmas bonuses this year, and instead give everyone subscriptions to the jelly of the month club. That will give you some capital back, but you risk getting kidnapped and tied up with a ribbon.", "", "1. Good idea, me. (+$2 000)", "2. Bad idea!"}, -- 25: cut bonus
	{2, 0, reduce_space, "You get the idea to cut costs by reducing the amount of office space you use up. You will have to spend less on equipment and rent, but your employees might not enjoy the work environment as much.", "", "1. Good idea, me", "2. Bad idea!"}, -- 26: reduce space
	{2, 0, customer_feedback, "Now that you've done some initial market research, it might be beneficial to get some feedback from your customer base. You could survey them about what made them buy your product, how do they use it, and how could it be improved. It would cost some money to run the survey, but should give you an idea on how to improve your product.", "", "1. Feedback is useful. (-$100 000)", "2. I know what I'm doing"}, -- 27: customer feedback
	{2, 0, quality_up, "After some research and development, it's been determined that using a different manufacturing process will lead to a better widget. However, this new process also costs more. Do you want to switch over?", "", "1. Of course!", "2. No way"}, -- 28: quality_up
	{2, 0, quality_down, "To reduce the rising cost of manufacturing widgets, you could source your materials from a lower quality supplier. However, your customers may not appreciate the change. Do you want to switch over?", "", "1. Of course!", "2. No way"}, -- 29: quality_down
	{4, 0, hire0, "After a few rounds of interviews, you have found someone who you think is a good fit for the company.", "Name: Wojciech Mayo", "Role: Lawyer", "What compensation package do you offer them, if any?", "", "1. All salary", "2. Half and half. (-1% equity)", "3. All equity. (-2% equity)", "4. Don't hire"}, -- 30: hire 0
	{4, 0, hire1, "After a few rounds of interviews, you have found someone who you think is a good fit for the company.", "Name: Ronald Norman", "Role: Industry Specialist", "What compensation package do you offer them, if any?", "", "1. All salary", "2. Half and half. (-1% equity)", "3. All equity. (-2% equity)", "4. Don't hire"}, -- 31: hire 1
	{4, 0, hire2, "After a few rounds of interviews, you have found someone who you think is a good fit for the company.", "Name: Azaan Higgins", "Role: CTO", "What compensation package do you offer them, if any?", "", "1. All salary", "2. Half and half. (-1% equity)", "3. All equity. (-2% equity)", "4. Don't hire"}, -- 32: hire 2
	{4, 0, hire3, "After a few rounds of interviews, you have found someone who you think is a good fit for the company.", "Name: Chanel Wang", "Role: Head of Sales", "What compensation package do you offer them, if any?", "", "1. All salary", "2. Half and half. (-1% equity)", "3. All equity. (-2% equity)", "4. Don't hire"}, -- 33: hire 3
	{4, 0, hire4, "After a few rounds of interviews, you have found someone who you think is a good fit for the company.", "Name: Yash Mason", "Role: Production Manager", "What compensation package do you offer them, if any?", "", "1. All salary", "2. Half and half. (-1% equity)", "3. All equity. (-2% equity)", "4. Don't hire"}, -- 34: hire 4
	{4, 0, hire5, "After a few rounds of interviews, you have found someone who you think is a good fit for the company.", "Name: Mary Summers", "Role: Head of HR", "What compensation package do you offer them, if any?", "", "1. All salary", "2. Half and half. (-1% equity)", "3. All equity. (-2% equity)", "4. Don't hire"}, -- 35: hire 5
	{4, 0, hire6, "After a few rounds of interviews, you have found someone who you think is a good fit for the company.", "Name: Taylor Willis", "Role: Project Manager", "What compensation package do you offer them, if any?", "", "1. All salary", "2. Half and half. (-1% equity)", "3. All equity. (-2% equity)", "4. Don't hire"}, -- 36: hire 6
	{4, 0, hire7, "After a few rounds of interviews, you have found someone who you think is a good fit for the company.", "Name: Olly Fuentes", "Role: CFO", "What compensation package do you offer them, if any?", "", "1. All salary", "2. Half and half. (-1% equity)", "3. All equity. (-2% equity)", "4. Don't hire"}, -- 37: hire 7
	{4, 0, hire8, "After a few rounds of interviews, you have found someone who you think is a good fit for the company.", "Name: Margaret Harmon", "Role: CEO", "What compensation package do you offer them, if any?", "", "1. All salary", "2. Half and half. (-1% equity)", "3. All equity. (-2% equity)", "4. Don't hire"}, -- 38: hire 8
	{4, 0, hire9, "After a few rounds of interviews, you have found someone who you think might be a good fit for the company.", "Name: Wight Schute", "Role: Assistant to the Manager", "What compensation package do you offer them, if any?", "", "1. All salary", "2. Half and half. (-1% equity)", "3. All equity. (-2% equity)", "4. Don't hire"}, -- 39: hire 9
	{1, 0, input_name, "Name your company:", "", "", "", "1. Done"}, -- 40: input name
}
event_num = 1

lines = {}

local function get_break(line, str)
	local prev = 1
	local first = 1
	local last = 1
	repeat
		last = first + 1
		local px = measure_text(line, str:sub(1, first))
		if px > 460 then
			return prev
		end
		prev = first
		first = str:find(" ", last)
	until first == nil
	return str:len()
end

local function wrap_text(e)
	local j = 1
	for i = 4, #events[event_num], 1
	do
		local str = events[event_num][i]
		repeat
			local n = get_break(lines[j], str)
			action(e, lines[j], '"type": "text", "string": "'..str:sub(1, n)..'"')
			str = str:sub(n+1, -1)
			j = j + 1
		until str:len() == 0
	end
end

local function update(e)
	action(e, capital_obj, '"type": "text", "string": "Capital: $'..capital_val..'"')
	action(e, income_obj, '"type": "text", "string": "Income: $'..income_val..'"')
	action(e, costs_obj, '"type": "text", "string": "Costs: $'..costs_val..'"')
	action(e, week_obj, '"type": "text", "string": "Week: '..week_val..'"')
	action(e, equity_obj, '"type": "text", "string": "Equity: '..equity_val..'%"')
	wrap_text(e)
	if valuation_obj ~= nil then
		action(e, valuation_obj, '"type": "text", "string": "Valuation: $'..valuation_val..'"')
	end
	if share_price_obj ~= nil then
		action(e, share_price_obj, '"type": "text", "string": "Share price: $'..share_price_val..'"')
	end
	if market_share_obj ~= nil then
		action(e, market_share_obj, '"type": "text", "string": "Market share: '..market_share_val..'%"')
	end
	if product_market_fit_obj ~= nil then
		action(e, product_market_fit_obj, '"type": "text", "string": "Quality: '..product_market_fit_val..'%"')
	end
	if sales_obj ~= nil then
		action(e, sales_obj, '"type": "text", "string": "Sales: '..sales_val..'"')
	end
	if capacity_obj ~= nil then
		action(e, capacity_obj, '"type": "text", "string": "Capacity: '..capacity_val..'"')
	end
	if happiness_obj ~= nil then
		action(e, happiness_obj, '"type": "text", "string": "Happiness: '..happiness_val..'%"')
	end
	if happiness_mod_obj ~= nil then
		local symbol = ""
		if happiness_mod_val > 0 then
			symbol = "+"
		elseif happiness_mod_val < 0 then
			symbol = "-"
		end
		action(e, happiness_mod_obj, '"type": "text", "string": "Happiness Mod: '..symbol..happiness_mod_val..'"')
	end
	if debt_obj ~= nil then
		action(e, debt_obj, '"type": "text", "string": "Debt: $'..debt_val..'"')
	end
end

local function close_event(e)
	if exclamation_obj ~= nil then
		action(e, exclamation_obj, '"type": "destroy"')
		exclamation_obj = nil
	end
	if event_box ~= nil then
		action(e, event_box, '"type": "destroy"')
		event_box = nil
	end
	for i = 1, #lines, 1
	do
		action(e, lines[i], '"type": "text", "string": ""')
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
	if event_num ~= 1 then
		event_box = spawn(e, instance, "box.json", 134, 134, false)
		exclamation_obj = spawn(e, instance, "exclamation.json", 358, 152, false)
	end
	update(e)
end

function create_main(e, instance)
	math.randomseed(os.time())
	action(e, instance, '"type": "window", "w": 768, "h": 768')
	action(e, instance, '"type": "music", "file": "music.ogg"')
	capital_obj = spawn(e, instance, "text.json", 300, 20, false)
	income_obj = spawn(e, instance, "text.json", 590, 20, false)
	costs_obj = spawn(e, instance, "text.json", 20, 20, false)
	local enter_next = spawn(e, instance, "text.json", 375, 720, false)
	action(e, enter_next, '"type": "text", "string": "Press Enter to go to next week"')
	week_obj = spawn(e, instance, "text.json", 20, 720, false)
	equity_obj = spawn(e, instance, "text.json", 300, 50, false)
	for i = 1, 15, 1
	do
		local line = spawn(e, instance, "text.json", 160, 164+(i*28), false)
		table.insert(lines, line)
	end
	timer_end(e, instance)
end

timer_on = false
function next_week(e, instance)
	if event_num ~= 1 then return end --dont progress until choice made

	if timer_on == false then
		clock_obj = spawn(e, instance, "clock.json", 250, 250, false)

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
		if valuation_val > 10000000 then
			events[16][2] = events[16][2] + 1
			events[7][2] = events[7][2] - 1
		end
		if market_share_val > 66 then
			events[16][2] = events[16][2] + 1
			events[7][2] = events[7][2] - 1
		end
		if market_share_val > 50 and employees_val > 1 and events[21][2] == 0 then
			events[21][2] = 25 -- disruptive innovation
		end
		if sales_val >= capacity_val then -- manufacturing
			events[22][2] = 50
		else
			events[22][2] = 0
		end
		if employees_val > 1 then -- culture
			events[23][2] = 5
			events[24][2] = 5
			events[25][2] = 5
			events[26][2] = 5
		end
		if sales_val > 1 then -- feedback
			events[27][2] = (25 - events[9][2]) / 2.5
		end
		if sales_val >= capacity_val / 2 then -- hiring
			if hired0 == false then events[30][2] = 1 end
			if hired1 == false then events[31][2] = 1 end
			if hired2 == false then events[32][2] = 1 end
			if hired3 == false then events[33][2] = 1 end
			if hired4 == false then events[34][2] = 1 end
			if hired5 == false then events[35][2] = 1 end
			if hired6 == false then events[36][2] = 1 end
			if hired7 == false then events[37][2] = 1 end
			if hired8 == false then events[38][2] = 1 end
			if hired9 == false then events[39][2] = 1 end
		end

		share_price_val = valuation_val / shares_val
		happiness_val = happiness_val - employees_val + happiness_mod
		income_val = product_price_val * sales_val
		capital_val = capital_val + income_val - costs_val
		week_val = week_val + 1

		timer_on = true
		action(e, instance, '"type": "timer", "num": 0, "time": 2.5')
	end
end

function timer_end(e, instance)
	timer_on = false
	if clock_obj ~= nil then
		action(e, clock_obj, '"type": "destroy"')
		clock_obj = nil
	end

	if capital_val <= 0 then -- failure
		new_event(e, instance, 3)
	elseif happiness_val <= 0 then
		new_event(e, instance, 15)
	else -- default random event
		new_event(e, instance, get_num())
	end
end

local function make_choice(e, instance, num)
	if num <= events[event_num][1] and event_num ~= 1 then
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

