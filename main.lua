function clearLoveCallbacks()
	love.draw = nil
	love.joystickpressed = nil
	love.joystickreleased = nil
	love.keypressed = nil
	love.keyreleased = nil
	love.load = nil
	love.mousepressed = nil
	love.mousereleased = nil
	love.update = nil
end

state = {}

function loadState(name)
	state = {}
	clearLoveCallbacks()
	local path = name
	require(path)
	love.load()
end

function love.load()
	loadState("menu")
end
