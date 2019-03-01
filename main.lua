local Entity = require("entity")
local Component = require("component")
local System = require("system")
local World = require("world")

local world  = World.new()

local Input = { horizontal = 0, vertical = 0}
local Speed = 1

local sys = System.new{"Position", "Rect"}
function sys:update(dt, entity)
     
    -- local pos = entity:get("Position")
    -- pos.x = pos.x + Input.horizontal * Speed 
    -- pos.y = pos.y + Input.vertical * Speed 

end

function sys:draw(entity)
    local pos = entity:get("Position")
    local rect = entity:get("Rect")

    love.graphics.rectangle("fill", pos.x, pos.y, rect.width, rect.height)
end



function love.load()
    local player = Entity.new()
    local cpn1 = Component.new{id = "Position", x = 155, y = 155}
    local cpn2 = Component.new{id = "Rect", width = 20, height = 20}
    local fn = Component.new{id = "Function", fun = function(entity) 
          local pos = entity:get("Position")
          pos.x = pos.x + Input.horizontal * Speed 
          pos.y = pos.y + Input.vertical * Speed 
        
    end}


    player:add(cpn1)
    player:add(cpn2)
    player:add(fn)

    ----------------------------------------
    local left = Entity.new()
    local cp1 = Component.new{id = "Position", x = 80, y = 80}
    local cp2 = Component.new{id = "Rect", width = 10, height = 150}

    left:add(cp1)
    left:add(cp2)
    
     ----------------------------------------
    local right = Entity.new()
    local cp11 = Component.new{id = "Position", x = 230, y = 80}
    local cp22 = Component.new{id = "Rect", width = 10, height = 160}

    right:add(cp11)
    right:add(cp22)
      ----------------------------------------
    local top = Entity.new()
    local cp111 = Component.new{id = "Position", x = 80, y = 80}
    local cp222 = Component.new{id = "Rect", width = 150, height = 10}

    top:add(cp111)
    top:add(cp222)
    ----------------------------------------
    local bottom= Entity.new()
    local cp1111 = Component.new{id = "Position", x = 80, y = 230}
    local cp2222 = Component.new{id = "Rect", width = 150, height = 10}

    bottom:add(cp1111)
    bottom:add(cp2222)

 ------------------------------

    world:add(player)
    world:add(left)
    world:add(right)
    world:add(top)
    world:add(bottom)

    world:register(sys)

end

function love.keypressed(key, scancode, isrepeat)
    if key == 'w' then
        Input.vertical= -1
    elseif key == 's' then
        Input.vertical = 1
    elseif key == 'a' then
        Input.horizontal = -1
    elseif key == 'd' then
        Input.horizontal = 1
    end
end

function love.keyreleased(key)
    if key == 'w' then
        Input.vertical= 0
    elseif key == 's' then
        Input.vertical = 0
    elseif key == 'a' then
        Input.horizontal = 0
    elseif key == 'd' then
        Input.horizontal = 0
    elseif key == 'escape' then
        love.event.quit()
    end

end

function love.update(dt)
    world:update(dt)
end

function love.draw()
    world:draw() 
end
