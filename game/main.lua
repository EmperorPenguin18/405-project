capital_obj = nil
capital_val = 5000
income_obj = nil
income_val = 0
costs_obj = nil
costs_val = 100
event_box = nil

local function choice_customer(choice)
	if choice == 1 then
		income_val = income_val + 100
	elseif choice == 2 then
		--Nothing
	end
end

-- # of choices, weight, function, any # of lines of text
events = {
	{0, 1, nil}, -- no event
	{2, 1, choice_customer, "Accept customer?", "", "1. Yes", "2. No"},
}
event_num = 1

lines = {}

local function update(e)
	action(e, capital_obj, '"type": "text", "string": "Capital: $'..capital_val..'"')
	action(e, income_obj, '"type": "text", "string": "Income: $'..income_val..'"')
	action(e, costs_obj, '"type": "text", "string": "Costs: $'..costs_val..'"')
	for i = 1, #lines, 1
	do
		action(e, lines[i], '"type": "text", "string": "'..events[event_num][i+3]..'"')
	end
end

function create_main(e, instance)
	math.randomseed(os.time())
	action(e, instance, '"type": "window", "w": 768, "h": 768')
	--action(e, instance, '"type": "music", "file": "music.ogg"')
	capital_obj = spawn(e, instance, "text.json", 300, 20, false)
	income_obj = spawn(e, instance, "text.json", 590, 20, false)
	costs_obj = spawn(e, instance, "text.json", 20, 20, false)
	local enter_next = spawn(e, instance, "text.json", 375, 720, false)
	action(e, enter_next, '"type": "text", "string": "Press Enter to go to next month"')
	event_box = spawn(e, instance, "box.json", 134, 134, false)
	update(e)
end

local function close_event(e)
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

function next_month(e, instance)
	if #lines > 0 then return end --dont progress until choice made
	capital_val = capital_val + income_val - costs_val
	close_event(e)
	event_num = get_num()
	for i = 4, #events[event_num], 1
	do
		local line = spawn(e, event_box, "text.json", 170, 80+(i*28), false)
		table.insert(lines, line)
	end
	update(e)
end

local function make_choice(e, num)
	if num <= events[event_num][1] and #lines > 0 then
		events[event_num][3](num)
		close_event(e)
	end
end

function one(e, instance)
	make_choice(e, 1)
end

function two(e, instance)
	make_choice(e, 2)
end

function three(e, instance)
	make_choice(e, 3)
end

function four(e, instance)
	make_choice(e, 4)
end

