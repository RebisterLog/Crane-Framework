--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Crane = require(ReplicatedStorage:WaitForChild("shared"):WaitForChild("Crane"))

local SharedComponent = {}
SharedComponent.SendMessage = Crane:GetPacket("SendMessage")

function SharedComponent:PrintMessage(message: string)
	print(message)
end

return SharedComponent