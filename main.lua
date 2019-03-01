local Entity = require("entity")
local Component = require("component")
local System = require("system")
local World = require("world")

local world  = World.new()

local Input = { horizontal = 0, vertical = 0}
local PhysicsWorld = love.physics.newWorld(0, 0) 
local Speed = 100

local sys = System.new{"Position", "Rect"}
function sys:update(dt, entity)
     
    -- local pos = entity:get("Position")
    -- pos.x = pos.x + Input.horizontal * Speed 
    -- pos.y = pos.y + Input.vertical * Speed 

end

function sys:draw(entity)
    local pos = entity:get("Position")
    local rect = entity:get("Rect")
    local physics = entity:get("Physics")

    if (physics ~= nil) then
        love.graphics.setColor(1, 0, 0) -- set the drawing color to green for the ground
        love.graphics.polygon("fill", physics.body:getWorldPoints(physics.shape:getPoints())) 
    else
        love.graphics.rectangle("fill", pos.x, pos.y, rect.width, rect.height)
    end
end

local physics = System.new{"Physics", "Rect", "Position"}
function physics:load(entity)
    local physics = entity:get("Physics")
    local rect = entity:get("Rect")
    local pos = entity:get("Position")

    physics.body = love.physics.newBody(PhysicsWorld, pos.x + rect.width / 2, pos.y + rect.height / 2, physics.config.body.type)
    physics.shape = love.physics.newRectangleShape(rect.width, rect.height)
    physics.fixture = love.physics.newFixture(physics.body, physics.shape)
end

function physics:update(dt, entity)
end

function physics:draw(entity)
  love.graphics.setColor(0.28, 0.63, 0.05) -- set the drawing color to green for the ground
  local physics = entity:get('Physics')
  love.graphics.polygon("line", physics.body:getWorldPoints(physics.shape:getPoints())) 
  love.graphics.setColor(1, 0, 0) -- set the drawing color to green for the ground
end

function love.load()

    local player = Entity.new()
    local cpn1 = Component.new{id = "Position", x = 155, y = 155}
    local cpn2 = Component.new{id = "Rect", width = 20, height = 20}
    local fn = Component.new{id = "Function", fun = function(entity) 
          local physics = entity:get("Physics")
          if (Input.horizontal ~= 0) then 
            print(Input.horizontal, Input.vertical)
            print(physics.body)
            physics.body:setLinearVelocity(Input.horizontal * Speed , 0)
          else  
            physics.body:applyForce(0, 0)
          end

          if (Input.vertical ~= 0) then
            physics.body:setLinearVelocity(0, Input.vertical * Speed)
          else 
            physics.body:applyForce(0, 0)
            --physics.body:setLinearVelocity(0, 4000)
          end
    end}


    player:add(cpn1)
    player:add(cpn2)
    player:add(fn)
    player:add(Component.new{id = "Physics", config = {body = { type = "dynamic"}}})

    ----------------------------------------
    local left = Entity.new()
    local cp1 = Component.new{id = "Position", x = 80, y = 80}
    local cp2 = Component.new{id = "Rect", width = 10, height = 150}

    left:add(cp1)
    left:add(cp2)
    left:add(Component.new{id = "Physics", config = {body = { type = "static"}}})
    
     ----------------------------------------
    local right = Entity.new()
    local cp11 = Component.new{id = "Position", x = 230, y = 80}
    local cp22 = Component.new{id = "Rect", width = 10, height = 160}

    right:add(cp11)
    right:add(cp22)
    right:add(Component.new{id = "Physics", config = {body = { type = "static"}}})
    ----------------------------------------
    local top = Entity.new()
    local cp111 = Component.new{id = "Position", x = 80, y = 80}
    local cp222 = Component.new{id = "Rect", width = 150, height = 10}

    top:add(cp111)
    top:add(cp222)
    top:add(Component.new{id = "Physics", config = { body = { type = "static"}}})
    ----------------------------------------
    local bottom= Entity.new()
    local cp1111 = Component.new{id = "Position", x = 80, y = 230}
    local cp2222 = Component.new{id = "Rect", width = 150, height = 10}

    bottom:add(cp1111)
    bottom:add(cp2222)
    bottom:add(Component.new{id = "Physics", config = {body = { type = "static"}}})

    ------------------------------

    world:add(player)
    world:add(left)
    world:add(right)
    world:add(top)
    world:add(bottom)

    world:register(sys)
    world:register(physics)

    world:load()
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
    PhysicsWorld:update(dt) 
    world:update(dt)
end

function love.draw()
    world:draw() 
end
