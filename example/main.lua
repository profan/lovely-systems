-----------------------------
-- All Includes -------------

Vector2 = require "hump.vector"
lsys = require "l-system"

-----------------------------
-- Locals -------------------
local lg = love.graphics
local lw = love.window

-----------------------------
-- Game Stuff ---------------

local tree = {}
local plant = {}

local function table_print(t)
	local result = ""
	for k, v in pairs(t) do
		result = result .. v
	end
	print(result)
end

local function draw_fractal(obj)

	lg.push()
	lg.translate(lw.getWidth() / 2, lw.getHeight() / 2)

	local pos = Vector2(0, 0)
	local lastpos = Vector2(0, 0)
	local mov_vector = Vector2(10, 0)
	for k, v in pairs(obj.state) do
		if v == 'F' or v == 'G' then pos = pos + mov_vector
		elseif v == '+' then mov_vector = mov_vector:rotated(1.04)
		elseif v == '-' then mov_vector = mov_vector:rotated(-1.04) end
		lg.line(lastpos.x, lastpos.y, pos.x, pos.y)
		lastpos = pos
	end

	lg.pop()

end

local function draw_plant(obj)
	
	lg.push()
	lg.translate(lw.getWidth()/2, lw.getHeight())
	lg.scale(0.0250, 0.0250)
	
	local pos = Vector2(0, 0)
	local lastpos = Vector2(0, 0)
	local rotvec = Vector2(0, -75)

	
	local last
	local stack = {}
	local color = {255, 255, 255}

	for k, v in pairs(obj.state) do
		if v == 'F' then pos = pos + rotvec color[1] = color[1] + 1 
		elseif v == '-' then rotvec = rotvec:rotated(-0.43) color[2] = color[2] + 1
		elseif v == '+' then rotvec = rotvec:rotated(0.43) color[3] = color[3] + 1
		elseif v == '[' then 
			stack[#stack+1] = {pos,rotvec, lastpos, color}
		elseif v == ']' then
			pos, rotvec, lastpos, color = unpack(stack[#stack])
			stack[#stack] = nil
		end
		lg.setColor(color)
		lg.line(lastpos.x, lastpos.y, pos.x, pos.y)
		lastpos = pos
	end

	lg.setColor(255, 255, 255)
	lg.pop()
end

local function draw_debug()
	lg.push()
	lg.translate(lw.getWidth() - 64, 16)
	lg.print("FPS: " .. love.timer.getFPS(), 0, 0)
	lg.pop()
end

-- End Game Stuff -----------
-----------------------------

-----------------------------
-- LÖVE2D Callbacks ---------

function love.load()
	state1 = {state = {'F'}, rules = {['F'] = 'G-F-G', ['G'] = 'F+G+F'} }
	tree = lsys.nthstep(state1, 2)

	state2 = {state = {'A'}, rules = {['A'] = 'AB', ['B'] = 'A'} }
	algae = lsys.nthstep(state2, 7)

	state3 = {state = {0}, rules = {[1] = '1, 1', [0] = '1[0]0'} }
	pythagoras = lsys.nthstep(state3, 2)

	state4 = {state = {'X'}, rules = {['X'] = 'F-[[X]+X]+F[+FX]-X', ['F'] = 'FF'} } -- pretty
	plant = lsys.nthstep(state4, 6)

	state5 = {state = {'F'}, rules={['F'] = 'F[+F]F[-F][F]'} } -- fluffy
	state6 = {state = {'F'}, rules={['F'] = 'F[+F]F[[-F][-F]F][+F]'} } -- christmas tree
	
end

function love.quit()
	
end

function love.update(dt)
	
end

function love.draw()
	draw_debug()
	--draw_fractal(tree)
	draw_plant(plant)
end

-- end LÖVE2D Callbacks -----
-----------------------------
