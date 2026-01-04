local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Crane = require(ReplicatedStorage:WaitForChild("shared"):WaitForChild("Crane"))
local SharedComponent = require(ReplicatedStorage:WaitForChild("shared"):WaitForChild("shared-components"):WaitForChild("SharedComponent"))

local ServerComponent = Crane:CreateComponent({
    Name = "ServerComponent",
    Tag = "SharedComponent",
    BaseComponent = SharedComponent
})

function ServerComponent.onStart(self: typeof(ServerComponent))
	self.SendMessage.listen(function(data: {message: string}, player: Player)
		self:PrintMessage(`[{player.Name}] {data.message}`)

		self.SendMessage.sendTo({message = `Hello from server, {player.Name}!`}, player)
	end)
end

return ServerComponent
