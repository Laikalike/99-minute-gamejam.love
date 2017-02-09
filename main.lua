function love.load()
  buttonPos1 = 190
  buttonPos2 = 390
  buttonPos3 = 590
  buttonPos4 = 790
  buttonPos5 = 990
  buttonY = 570
  buttonSpeed = 1000

  pattern = {{1,0},{2,0},{3,0},{2,0},{1,0},{2,0},{3,0},{4,0},{3,0},{2,0},{3,0},{4,0},{5,0},{4,0},{3,0},{4,0},{5,0.5},
             {1,0},{1,0.2},{3,0},{3,0.2},{2,0},{2,0.2},{4,0},{4,0.2},{3,0},{3,0.2},{5,0},{5,0.2},{4,0},{3,0},{2,0},{1,0},{2,0},{1,0}}

  position = 1
  default = 0.2
  timer = 4
  score = 0
  gameOver = false
  hit = 0
  miss = 0
  scoreTimer = {0,0}
  buttons = {}

  keyDown = false
  imgNums = {
    love.graphics.newImage("assets/text_0.png"),
    love.graphics.newImage("assets/text_1.png"),
    love.graphics.newImage("assets/text_2.png"),
    love.graphics.newImage("assets/text_3.png"),
    love.graphics.newImage("assets/text_4.png"),
    love.graphics.newImage("assets/text_5.png"),
    love.graphics.newImage("assets/text_6.png"),
    love.graphics.newImage("assets/text_7.png"),
    love.graphics.newImage("assets/text_8.png"),
    love.graphics.newImage("assets/text_9.png")}


 scoreImg = love.graphics.newImage("assets/text_score_small.png")
 dots     = love.graphics.newImage("assets/text_dots.png")
end

function love.update(dt)
  if love.keyboard.isDown('d') then
    keyDown = 1
    getPosButton(buttonPos1, dt)
  elseif love.keyboard.isDown('f') then
    keyDown = 2
    getPosButton(buttonPos2, dt)
  elseif love.keyboard.isDown('g') then
    keyDown = 3
    getPosButton(buttonPos3, dt)
  elseif love.keyboard.isDown('h') then
    keyDown = 4
    getPosButton(buttonPos4, dt)
  elseif love.keyboard.isDown('j') then
    keyDown = 5
    getPosButton(buttonPos5, dt)
  else
    keyDown = false
  end

  updateButtons(dt)
  timer = timer - dt
  if timer < 0 then
    if position < table.getn(pattern)+1 then
      table.insert(buttons,constructButton(pattern, position))
      position = position + 1
    end
    if scoreTimer[1] > 0 then
      scoreTimer[1] = scoreTimer[1] - 600 * dt
    elseif scoreTimer[1] < 0 then
      scoreTimer[1] = 0
    end
  end
  if score < 0 then score = 0 end
end

function love.draw()
  love.graphics.print("MUNT HERO",500,20,0.2,10,10)
  love.graphics.print("Hits:", 825, 60)
  love.graphics.print(hit, 850, 0, 0, 10, 10)
  love.graphics.print("Misses:", 1000, 60)
  love.graphics.print(miss, 1050, 0, 0, 10, 10)

  drawRiffs()
  drawUI()
  drawButtons()

  love.graphics.setColor(255,255,255)
  love.graphics.print("D",235,buttonY+110)
  love.graphics.print("F",435,buttonY+110)
  love.graphics.print("G",635,buttonY+110)
  love.graphics.print("H",835,buttonY+110)
  love.graphics.print("J",1035,buttonY+110)

end

function constructButton(pattern, position)
  timer = pattern[position][2] + default
  button = {}
  button.destroyed = false
  button.pointAwarded = false
  button.rgb = {}
  button.rgb.alpha = 255
  button.pos = {}
  button.pos.y = -100
  id = pattern[position][1]
  button.id = id
  if id == 1 then
    button.pos.x = buttonPos1
    button.rgb.red = 255
    button.rgb.blue = 0
    button.rgb.green = 0
  elseif id == 2 then
    button.pos.x = buttonPos2
    button.rgb.red = 0
    button.rgb.blue = 255
    button.rgb.green = 0
  elseif id == 3 then
    button.pos.x = buttonPos3
    button.rgb.red = 0
    button.rgb.blue = 0
    button.rgb.green = 255
  elseif id == 4 then
    button.pos.x = buttonPos4
    button.rgb.red = 255
    button.rgb.blue = 0
    button.rgb.green = 255
  elseif id == 5 then
    button.pos.x = buttonPos5
    button.rgb.red = 255
    button.rgb.blue = 255
    button.rgb.green = 0
  else
    return False
  end
  return button
end

function updateButtons(dt)
  for i, v in ipairs(buttons) do
    i = i or 3
    buttons[i].pos.y = buttons[i].pos.y + buttonSpeed * dt
    if buttons[i].destroyed == true then
      if buttons[i].pointAwarded == false then
        buttons[i].pointAwarded = true
        hit = hit + 1
      end
      buttons[i].rgb.alpha = buttons[i].rgb.alpha - 2500 * dt
    end
    if buttons[i].pos.y > 720 then
      if buttons[i].destroyed == false then
        miss = miss + 1
        if score < 50 then
          score = 0
        else
          score = score - 50
        end
      table.remove(buttons, i)
      end
    end
  end
end

function drawButtons()
  for i = 1, table.getn(buttons) do
    love.graphics.setColor(buttons[i].rgb.red, buttons[i].rgb.green, buttons[i].rgb.blue, buttons[i].rgb.alpha)
    love.graphics.rectangle("fill", buttons[i].pos.x, buttons[i].pos.y, 100, 100)
  end
end

function drawRiffs()
  if keyDown == 1 then
    love.graphics.setColor(0, 255, 255)
  else
    love.graphics.setColor(0,100,100)
  end
  love.graphics.rectangle("fill", buttonPos1, buttonY, 100, 100)
  if keyDown == 2 then
    love.graphics.setColor(0, 255, 255)
  else
    love.graphics.setColor(0,100,100)
  end
  love.graphics.rectangle("fill", buttonPos2, buttonY, 100, 100)
  if keyDown == 3 then
    love.graphics.setColor(0, 255, 255)
  else
    love.graphics.setColor(0,100,100)
  end
  love.graphics.rectangle("fill", buttonPos3, buttonY, 100, 100)
  if keyDown == 4 then
    love.graphics.setColor(0, 255, 255)
  else
    love.graphics.setColor(0,100,100)
  end
  love.graphics.rectangle("fill", buttonPos4, buttonY, 100, 100)
  if keyDown == 5 then
    love.graphics.setColor(0, 255, 255)
  else
    love.graphics.setColor(0,100,100)
  end
  love.graphics.rectangle("fill", buttonPos5, buttonY, 100, 100)
end

function drawUI()
  love.graphics.setColor(255,255,255)
  love.graphics.draw(scoreImg, 10, 14)
  love.graphics.draw(dots, 130, 14)
  stringScore = tostring(math.ceil(score))
  if string.len(stringScore) == 4 then
    stringScore = "0"..stringScore
  elseif string.len(stringScore) == 3 then
    stringScore = "00"..stringScore
  elseif string.len(stringScore) == 2 then
    stringScore = "000"..stringScore
  elseif string.len(stringScore) == 1 then
    stringScore = "0000"..stringScore
  end
  val = tonumber(tostring(stringScore):sub(1,1))
  love.graphics.draw(imgNums[val+1],160,4)
  val = tonumber(tostring(stringScore):sub(2,2))
  love.graphics.draw(imgNums[val+1],210,4)
  val = tonumber(tostring(stringScore):sub(3,3))
  love.graphics.draw(imgNums[val+1],260,4)
  val = tonumber(tostring(stringScore):sub(4,4))
  love.graphics.draw(imgNums[val+1],310,4)
  val = tonumber(tostring(stringScore):sub(5,5))
  love.graphics.draw(imgNums[val+1],360,4)
end

function getPosButton(pos, dt)
  for i = 1, table.getn(buttons) do
    if buttons[i].pos.x == pos then
      if buttons[i].pos.y > buttonY-50 then
        if buttons[i].pos.y < buttonY+50 then
          if buttons[i].destroyed == false then
            buttons[i].destroyed = true
            scoreTimer = {1, buttons[i].id}
            score = score + 100
          end
        end
      end
    end
  end
  if scoreTimer[1] == 0 or scoreTimer[2] ~= keyDown and score > 0 then
    score = score - 500 * dt
  end
end
