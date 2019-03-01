
local system = {}

function system.new(requires)
    local sys = {}
    setmetatable(sys, {__index = system})
    sys.req = requires 
        
    return sys
end

function system:match(entity) 
    for i, v in ipairs(self.req) do
        if (entity:get(v) == nil) then
            return false
        end
    end

    return true
end

function system:load()

end

function system:update(dt)

end

function system:draw(entity)

end

return system
