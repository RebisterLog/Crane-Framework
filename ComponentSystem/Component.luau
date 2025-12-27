local ClassSystem = require(script.Parent.ClassSystem)
local Signal = require(script.Parent.Signal)
local types = require(script.Parent.types)

local Component = ClassSystem.CreateAbstract("Component"):: types.ComponentClass<Instance>

function Component:constructor(instance: Instance)
    self.Destroyed = Signal.new()
    self.instance = instance

    if self.onStart then
        self:onStart()
    end
end

function Component:destroy()
    self.Destroyed:Fire()

    if self.onDestroy then
        self:onDestroy()
    end
end

return Component