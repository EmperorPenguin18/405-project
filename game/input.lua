product_name = ""
caps = false

local function input_update(e, instance)
	action(e, instance, '"type": "text", "string": "'..product_name..'"')
end

local function newchar(lower, upper)
	if string.len(product_name) < 31 then
		if caps == true then
			product_name = product_name..upper
		else
			product_name = product_name..lower
		end
	end
end

function input_q(e, instance)
	newchar('q', 'Q')
	input_update(e, instance)
end

function input_w(e, instance)
	newchar('w', 'W')
	input_update(e, instance)
end

function input_e(e, instance)
	newchar('e', 'E')
	input_update(e, instance)
end

function input_r(e, instance)
	newchar('r', 'R')
	input_update(e, instance)
end

function input_t(e, instance)
	newchar('t', 'T')
	input_update(e, instance)
end

function input_y(e, instance)
	newchar('y', 'Y')
	input_update(e, instance)
end

function input_u(e, instance)
	newchar('u', 'U')
	input_update(e, instance)
end

function input_i(e, instance)
	newchar('i', 'I')
	input_update(e, instance)
end

function input_o(e, instance)
	newchar('o', 'O')
	input_update(e, instance)
end

function input_p(e, instance)
	newchar('p', 'P')
	input_update(e, instance)
end

function input_a(e, instance)
	newchar('a', 'A')
	input_update(e, instance)
end

function input_s(e, instance)
	newchar('s', 'S')
	input_update(e, instance)
end

function input_d(e, instance)
	newchar('d', 'D')
	input_update(e, instance)
end

function input_f(e, instance)
	newchar('f', 'F')
	input_update(e, instance)
end

function input_g(e, instance)
	newchar('g', 'G')
	input_update(e, instance)
end

function input_h(e, instance)
	newchar('h', 'H')
	input_update(e, instance)
end

function input_j(e, instance)
	newchar('j', 'J')
	input_update(e, instance)
end

function input_k(e, instance)
	newchar('k', 'K')
	input_update(e, instance)
end

function input_l(e, instance)
	newchar('l', 'L')
	input_update(e, instance)
end

function input_z(e, instance)
	newchar('z', 'Z')
	input_update(e, instance)
end

function input_x(e, instance)
	newchar('x', 'X')
	input_update(e, instance)
end

function input_c(e, instance)
	newchar('c', 'C')
	input_update(e, instance)
end

function input_v(e, instance)
	newchar('v', 'V')
	input_update(e, instance)
end

function input_b(e, instance)
	newchar('b', 'B')
	input_update(e, instance)
end

function input_n(e, instance)
	newchar('n', 'N')
	input_update(e, instance)
end

function input_m(e, instance)
	newchar('m', 'M')
	input_update(e, instance)
end

function input_shift(e, instance)
	caps = true
end

function input_shift_release(e, instance)
	caps = false
end

function input_back(e, instance)
	product_name = product_name:sub(1, -2)
	input_update(e, instance)
end

function input_space(e, instance)
	product_name = product_name.." "
	input_update(e, instance)
end
