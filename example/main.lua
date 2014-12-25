-----------------------------
-- All Includes -------------

Vector2 = require "hump.vector"
lsys = require "l-system"

-----------------------------
-- Locals -------------------
local lg = love.graphics
local lk = love.keyboard
local lw = love.window

-----------------------------
-- Game Stuff ---------------

local actual_object = {}
actual_object.angle = 0.43
actual_object.length = -75

local function table_print(t)
	local result = ""
	for k, v in pairs(t) do
		result = result .. v
	end
	print(result)
end

local function update_data(dt, obj)
	
	if lk.isDown('up') then 
		obj.angle = obj.angle + (0.5*dt)
	elseif lk.isDown('down') then 
		obj.angle = obj.angle - (0.5*dt) 
	end

	if lk.isDown('left') then
		obj.length = obj.length + (10*dt)
	elseif lk.isDown('right') then
		obj.length = obj.length - (10*dt)
	end

end

local function draw_object(obj)
	
	lg.push()
	lg.translate(lw.getWidth()/2, lw.getHeight())
	lg.scale(0.0250, 0.0250)
	
	local pos = Vector2(0, 0)
	local lastpos = Vector2(0, 0)
	local rotvec = Vector2(0, obj.length)

	
	local last
	local stack = {}
	local color = {255, 255, 255}

	for k, v in pairs(obj.state) do

		if v == 'F' then 
			pos = pos + rotvec color[1] = color[1] + 1 
		elseif v == '-' then 
			rotvec = rotvec:rotated(-obj.angle) color[2] = color[2] + 1
		elseif v == '+' then 
			rotvec = rotvec:rotated(obj.angle) color[3] = color[3] + 1
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

local function draw_debug(obj)
	lg.push()
	lg.translate(lw.getWidth() - 128, 16)
	lg.print("FPS: " .. love.timer.getFPS(), 0, 0)
	lg.print("Object Angle: " .. obj.angle, 0, 16)
	lg.print("Segment Size: " .. obj.length, 0, 32)
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

	actual_object.state = plant.state -- used for drawing/updating stuff
	
end

function love.quit()
	
end

function love.update(dt)
	update_data(dt, actual_object)
end

function love.draw()
	draw_debug(actual_object)
	draw_object(actual_object)
end

-- end LÖVE2D Callbacks -----
-----------------------------
