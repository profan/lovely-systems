local l_system = {}

local function concat_tables(t1, t2)
	for i=1, #t2 do
		t1[#t1+1] = t2[i]
	end
	return t1
end

local function str_split(str)
	local t = {}
	for i=1, str:len() do
		t[#t+1] = str:sub(i, i)
	end
	return t
end

local function nthstep(state, n)

	if n == 0 then return state end
	
	local new_state = {state={}, rules=state.rules}
	for k, v in pairs(state.state) do
		concat_tables(new_state.state, state.rules[v] or {v})
	end

	return l_system.nthstep(new_state, n-1)

end

function l_system.nthstep(state, n)
	local fixed_rules = {}
	
	for k, v in pairs(state.rules) do
		if type(v) == 'string' then
			state.rules[k] = str_split(v)
		end
	end

	return nthstep(state, n)

end

return l_system
