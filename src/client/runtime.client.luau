local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Crane = require(ReplicatedStorage:WaitForChild("shared"):WaitForChild("Crane"))

Crane:AddServices({ReplicatedStorage.shared.services, script.Parent.services})
Crane:AddComponents({ReplicatedStorage.shared.components, script.Parent.components})

Crane:Start()
