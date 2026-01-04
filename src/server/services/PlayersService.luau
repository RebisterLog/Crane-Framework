local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Crane = require(ReplicatedStorage.shared.Crane)

local PlayersService: Crane.Service = Crane:CreateService({
	Name = "PlayersService",
})
PlayersService["Players"] = {}

function PlayersService:onStart()
	Players.PlayerAdded:Connect(function(player)
		local playerComponent = Crane:AddComponent(player, "PlayerComponent")
		PlayersService.Players[player] = playerComponent
	end)
end

function PlayersService:GetPlayer(player: Player)
	return PlayersService.Players[player]:: Crane.Component<Player>?
end

return PlayersService