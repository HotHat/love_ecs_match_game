
local entity = {}

function entity.new()
    local en = {}

    setmetatable(en, {__index = entity})

    en.active = true
    en.component = {}
    en.tags = {}


    return en
end

function entity:add(component)
    assert(component.id)
    self.component[component.id] = component;
end

function entity:get(id)
    return self.component[id]
end

function entity:destory()
    self.active = false
end

return entity
