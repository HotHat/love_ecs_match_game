local world = {}

function world.new()
    local wl = {
        entity = {},
        system = {}
    }
    setmetatable(wl, {__index = world})
    return wl
end

function world:register(sys)
    table.insert(self.system, sys)
end

function world:add(entity)
    table.insert(self.entity, entity)
end

function world:load()
    for i, sys in ipairs(self.system) do
        for i = 1, #self.entity do
            if (sys:match(self.entity[i])) then
                sys:load(self.entity[i])
            end
        end
    end

end


function world:update(dt)
    for i, sys in ipairs(self.system) do
        for i = 1, #self.entity do
            if (sys:match(self.entity[i])) then
                sys:update(dt, self.entity[i])
            end
        end
    end
    for i = 1, #self.entity do
        local fn = self.entity[i]:get("Function")
        if fn ~= nil then
            fn.fun(self.entity[i])
        end
    end

end

function world:draw()
    for i, sys in ipairs(self.system) do
        for i = 1, #self.entity do
            if (sys:match(self.entity[i])) then
                sys:draw(self.entity[i])
            end
        end
    end
end

return world
