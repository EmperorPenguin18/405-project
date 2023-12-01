capital_obj = nil
capital_val = 5000
income_obj = nil
income_val = 0
costs_obj = nil
costs_val = 100
event_box = nil
event_description = nil
option1 = nil
option2 = nil

event = {"test0", "test1", "test2"}

local function update(e)
	action(e, capital_obj, '"type": "text", "string": "Capital: $'..capital_val..'"')
	action(e, income_obj, '"type": "text", "string": "Income: $'..income_val..'"')
	action(e, costs_obj, '"type": "text", "string": "Costs: $'..costs_val..'"')
	action(e, event_description, '"type": "text", "string": "'..event[1]..'"')
	action(e, option1, '"type": "text", "string": "1. '..event[2]..'"')
	action(e, option2, '"type": "text", "string": "2. '..event[3]..'"')
end

function create_main(e, instance)
	math.randomseed(os.time())
	action(e, instance, '"type": "window", "w": 768, "h": 768')
	--action(e, instance, '"type": "music", "file": "music.ogg"')
	capital_obj = spawn(e, instance, "text.json", 380, 20, false)
	income_obj = spawn(e, instance, "text.json", 700, 20, false)
	costs_obj = spawn(e, instance, "text.json", 20, 20, false)
	local enter_next = spawn(e, instance, "text.json", 20, 700, false)
	action(e, enter_next, '"type": "text", "string": "Press Enter to go to next month')
	event_box = spawn(e, instance, "box.json", 300, 300, false)
	event_description = spawn(e, instance, "text.json", 300, 300, false)
	option1 = spawn(e, instance, "text.json", 300, 350, false)
	option2 = spawn(e, instance, "text.json", 300, 400, false)
	update(e)
end

function next_month(e, instance)
	print('next')
end
