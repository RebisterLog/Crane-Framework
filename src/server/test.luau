-- For part component test
local part = Instance.new("Part")
part.Position = Vector3.new(math.random(0, 5), math.random(0, 5), math.random(0, 5))
part.Name = "TestPartComponent"
part:AddTag("Part")
part.Parent = workspace

-- For shared component test
local sharedPart = Instance.new("Part")
sharedPart.Position = Vector3.new(-5, 1, -5)
sharedPart.Name = "TestSharedComponent"
sharedPart:AddTag("SharedComponent")
sharedPart.Parent = workspace


return nil