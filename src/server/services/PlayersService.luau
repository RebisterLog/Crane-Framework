local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Crane = require(ReplicatedStorage.shared.Crane)

local PlayersService = Crane:CreateService({
	Name = "PlayersService" :: "PlayersService",
})
PlayersService["Players"] = {}

function PlayersService.onStart(self: typeof(PlayersService))
	Players.PlayerAdded:Connect(function(player)
		local playerComponent = Crane:AddComponent(player, "PlayerComponent")
		self.Players[player] = playerComponent
	end)
end

function PlayersService:GetPlayer(player: Player)
	return PlayersService.Players[player]
end

return PlayersService