function love.load(arg)
  logo           = love.graphics.newImage("assets/menu_logo.png")
  icon_play      = {love.graphics.newImage("assets/icons/icon_play.png"),200,80,200,80,1} --asset, xpos, ypos, xscaled, yscaled, scale value
  icon_difficuly = {love.graphics.newImage("assets/icons/icon_difficuly.png"),200,80,200,80,1} -- [2]/[4], [3]/[5] should ALWAYS start equal
  icon_exit      = {love.graphics.newImage("assets/icons/icon_exit.png"),200,80,200,80,1}

  sine_counter = 0
  sine         = 0
  logo_ypos    = 0

  menu_ypos_offset = 380
  menu_ypos_gap    = 100

  alpha_main = {0,0} --video, UI, timer

  menu = {}
  updateMenu("default")
end

function love.update(dt)
  sine_counter = sine_counter + 6 * dt
  sine = math.sin(sine_counter)
  logo_ypos = (sine * 10) + 30
  if alpha_main[1] < 255 then
    alpha_main[1] = alpha_main[1] + 180 * dt
  else
    alpha_main[1] = 255
  end

  if alpha_main[2] < 255 then
    alpha_main[2] = alpha_main[2] + 90 * dt
  else
    alpha_main[2] = 255
  end

  mx = love.mouse.getX()
  my = love.mouse.getY()

  checkBackgroundVideo()
  menuGetClicked(dt)
  menuUpdateButtons(dt)
end

function love.draw()
  love.graphics.setColor(255, 255, 255, alpha_main[1])
  love.graphics.draw(background)
  menuDrawButtons()
  love.graphics.setColor(255, 255, 255, alpha_main[2])
  love.graphics.draw(logo, 390, logo_ypos)
end

function updateMenu(mode)
  if mode == "default" then
    menu = {
      {icon_play, 'loadState("game")'}, --'updateMenu("songs")'
      {icon_difficuly, 'updateMenu("difficulty")'},
      {icon_exit, 'love.event.quit()'},
      backbutton = false }
  end
end

function menuDrawButtons()
  for i = 1, table.getn(menu) do
    if alpha_main[2] < 155 then
      love.graphics.setColor(255, 255, 255, alpha_main[2])
    else
      love.graphics.setColor(255,255,255,155+((menu[i][1][6]-0.9)*450))
    end
    love.graphics.draw(menu[i][1][1], 720 - (menu[i][1][4]) - (menu[i][1][2]/2 - menu[i][1][4]/2), menu_ypos_offset + (menu_ypos_gap * (i - 1)) - (menu[i][1][5]/2 - menu[i][1][3]/2),0, menu[i][1][6], menu[i][1][6])
  end
end

function menuGetClicked(dt)
  for i = 1, table.getn(menu) do
    if mx > 520 and mx < 720 then
      if my > menu_ypos_offset + (menu_ypos_gap * (i - 1)) and my < menu_ypos_offset + (menu_ypos_gap * (i - 1)) + menu[i][1][3] then
        menuActiveHover(i, dt)
        if love.mouse.isDown(1) then
          loadstring(menu[i][2])()
        end
      end
    end
  end
end

function menuActiveHover(i, dt)
  if menu[i][1][6] < 1.2 then
    menu[i][1][6] = menu[i][1][6] + 2 * dt
  else
    menu[i][1][6] = 1.2
  end
end

function menuUpdateButtons(dt)
  for i = 1, table.getn(menu) do
    menu[i][1][4] = menu[i][1][2] * menu[i][1][6]
    menu[i][1][5] = menu[i][1][3] * menu[i][1][6]
    if menu[i][1][6] > 1 then
      menu[i][1][6] = menu[i][1][6] - 1 * dt
    else
      menu[i][1][6] = 1
    end
  end
end
