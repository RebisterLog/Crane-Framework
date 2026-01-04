local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Crane = require(ReplicatedStorage:WaitForChild("shared"):WaitForChild("Crane"))



Crane:AddServices({ServerScriptService.server.services})
Crane:AddComponents({ServerScriptService.server.components, ReplicatedStorage.shared.components})

Crane:Start()
