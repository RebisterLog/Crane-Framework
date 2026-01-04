local Crane = require(game:GetService("ReplicatedStorage"):WaitForChild("shared"):WaitForChild("Crane"))

local PlayerComponent: Crane.Component<Player> = Crane:CreateComponent({
    Name = "PlayerComponent",
    -- Don't adding tag property, we will add component handly
})

function PlayerComponent.onStart(self: Crane.Component<Player>)
	print(`Added player component for {self.instance.DisplayName}`)
end

return PlayerComponent
