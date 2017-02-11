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
  background = love.graphics.newVideo("assets/menu_background.ogv", false)
  background:play()
	loadState("menu")
end


function checkBackgroundVideo()
  if background:isPlaying() == false then
    background:rewind()
    background:play()
  end
end
